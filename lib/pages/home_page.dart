import 'dart:developer';

import 'package:clockin/api/url.dart';
import 'package:http/http.dart' as http;
import 'package:clockin/models/historico_mes_dto.dart';
import 'package:clockin/models/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:clockin/api/call_api.dart';
import 'package:clockin/components/alert.dart';
import 'package:clockin/components/colors.dart';
import 'package:clockin/dataBase/db_login.dart';
import 'package:clockin/pages/detalhes_dia_page.dart';
import 'package:clockin/pages/historico_mes_page.dart';
import 'package:clockin/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  CallApi callApi = CallApi();

  FuncionarioRequestDTO? funcionario;
  String matricula = '';
  String _tempoRestante = '';
  final DateTime _dataAtual = DateTime.now();
  late String ultimoPontoRegistrado = "";
  late String totalBalance = "";
  late HistoricoMesDTO ultimoPonto = HistoricoMesDTO();
  late Duration tempoTrabalhado = Duration.zero;
  late Duration cargaHoraria;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarFuncionarios();
  }

  Duration parseDuration(String duration, {bool isCargaHoraria = false}) {
    List<String> parts = duration.split(':');
    if (parts.length < 2 || parts.length > 3) {
      throw const FormatException(
          "Invalid duration format. Expected format: HH:MM or HH:MM:SS");
    }

    try {
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      int seconds = parts.length == 3 ? int.parse(parts[2]) : 0;
      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    } catch (e) {
      throw FormatException(
          "Invalid duration format. Unable to parse: $duration");
    }
  }

  Future<void> _carregarFuncionarios() async {
    try {
      Map<String, dynamic> user = await dbHelper.isLoggedIn();
      matricula = user['matricula'];

      funcionario = await callApi.fetchFuncionario(matricula);
      _tempoRestante = await tempoRestante(matricula);
      tempoTrabalhado = _parseTime(_tempoRestante);
      totalBalance = await callApi.saldo(matricula);
      _carregarETratarHistoricoDiaAtual();

      if (funcionario != null &&
          funcionario!.saida != null &&
          funcionario!.entrada != null &&
          funcionario!.intervaloSaida != null &&
          funcionario!.intervaloEntrada != null) {
        Duration saida = _parseTime(funcionario!.saida!);
        Duration entrada = _parseTime(funcionario!.entrada!);
        Duration intervaloSaida = _parseTime(funcionario!.intervaloSaida!);
        Duration intervaloEntrada = _parseTime(funcionario!.intervaloEntrada!);

        cargaHoraria = (saida - entrada) - (intervaloSaida - intervaloEntrada);
        tempoTrabalhado = cargaHoraria - tempoTrabalhado;
      } else {
        throw Exception('Dados do funcionário incompletos');
      }

      setState(() {
        log("${funcionario!.nome}");
        log("${totalBalance}");
        isLoading = false;
      });
    } catch (e) {
      log("$e");
      Alert.showToast("Erro ao carregar dados do funcionário: $e", Colors.red,
          ToastGravity.BOTTOM);
      isLoading = false;
    }
  }

  Duration _parseTime(String timeStr) {
    List<String> parts = timeStr.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    List<String> secondsParts = parts[2].split('.');
    int seconds = int.parse(secondsParts[0]);

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }


  Future<String> tempoRestante(String matricula) async {
    final response = await http
        .get(Uri.parse('$urlApi/funcionarios/calculos/dia/$matricula'));

    if (response.statusCode == 200) {
      return response.body.replaceAll('"', '');
    } else {
      throw Exception('Falha ao carregar o tempo restante');
    }
  }

  Duration stringToDuration(String timeString) {
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    List<String> secondsParts = parts[2].split('.');
    int seconds = int.parse(secondsParts[0]);
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  void _logout() async {
    await dbHelper.deleteAllUsers();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
    log('Deslogado');
  }

  void _carregarETratarHistoricoDiaAtual() async {
    try {
      Map<String, List<HistoricoMesDTO>> historico =
          await callApi.buscarEOrganizarPontos(matricula);

      List<HistoricoMesDTO> historicoDiaAtual =
          _filtrarHistoricoDiaAtual(historico);

      if (historicoDiaAtual.isNotEmpty) {
        ultimoPontoRegistrado = "${ultimoPonto.hora}";
        if (funcionario != null && funcionario!.saida != null) {
          HistoricoMesDTO ultimoPonto = historicoDiaAtual.last;
          setState(() {
            ultimoPontoRegistrado = ultimoPonto.hora!;
          });
        } else {
          log('Dados de funcionário ou hora de saída não disponíveis.');
        }
      } else {
        log('Nenhum ponto registrado hoje.');
      }
    } catch (e) {
      log("Erro ao carregar e tratar histórico do dia atual: $e");
    }
  }

  List<HistoricoMesDTO> _filtrarHistoricoDiaAtual(
      Map<String, List<HistoricoMesDTO>> historico) {
    List<HistoricoMesDTO> historicoDiaAtual = [];
    DateTime hoje = DateTime.now();
    String dia = hoje.day.toString().padLeft(2, '0');
    String mes = hoje.month.toString().padLeft(2, '0');
    String dataHoje = "${hoje.year}-$mes-$dia";

    historico.forEach((data, listaHistorico) {
      listaHistorico.forEach((historico) {
        if (historico.data == dataHoje) {
          historicoDiaAtual.add(historico);
        }
      });
    });

    return historicoDiaAtual;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 900),
      builder: (context, child) => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: corBase,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  _logout();
                },
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                  size: 42,
                ),
              )
            ],
          ),
          body: isLoading
              ? Center(
                  child:
                      CircularProgressIndicator()) // Indicador de carregamento
              : LayoutBuilder(builder: (context, constraints) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      // Lógica para atualizar os dados
                      await _carregarFuncionarios(); // Exemplo de chamada para carregar funcionários
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      // Garante que o SingleChildScrollView seja rolável
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                height: 150.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: corBase,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(18.r),
                                    bottomRight: Radius.circular(18.r),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5.r,
                                      blurRadius: 7.r,
                                      offset: Offset(0, 3.h),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height - 320.h,
                                color: Colors.white,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 360.w,
                                        height: 70.h,
                                        margin: EdgeInsets.fromLTRB(
                                            15.w, 65.h, 15.w, 15.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.r)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5.r,
                                              blurRadius: 7.r,
                                              offset: Offset(0, 3.h),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            totalBalance,
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: totalBalance.compareTo(
                                                          '00:00:00') <
                                                      0
                                                  ? Colors.red
                                                  : corTextoVerde,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 360.w,
                                        height: 30.h,
                                        margin: EdgeInsets.fromLTRB(
                                            15.w, 0, 15.w, 0),
                                        child: Text(
                                          'Status de hoje',
                                          style: TextStyle(
                                            fontSize: 24.sp,
                                            color: corTextoPrincipal,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetalhesDia(
                                                diaDaSemana:
                                                    _traduzirDiaDaSemana(
                                                  DateFormat.EEEE()
                                                      .format(DateTime.now()),
                                                ),
                                                dataAtual:
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(_dataAtual),
                                                tempoRestante: stringToDuration(
                                                    _tempoRestante),
                                                cargahoraria: cargaHoraria,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 360.w,
                                          height: 140.h,
                                          margin: EdgeInsets.fromLTRB(
                                              15.w, 10.h, 15.w, 10.h),
                                          padding: EdgeInsets.fromLTRB(
                                              8.w, 0, 5.w, 0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.r)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5.r,
                                                blurRadius: 7.r,
                                                offset: Offset(0, 3.h),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${_traduzirDiaDaSemana(DateFormat.EEEE().format(DateTime.now()))}, ${DateFormat('dd/MM/yyyy').format(_dataAtual)}',
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                ultimoPontoRegistrado != null
                                                    ? 'Último ponto registrado: $ultimoPontoRegistrado'
                                                    : 'Último ponto registrado: ${ultimoPontoRegistrado = "00:00"}',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'Tempo restante: ${formatDuration(tempoTrabalhado)}',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoricoMes(matricula:matricula,
                                                cargaHoraria: cargaHoraria,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 360.w,
                                          height: 55.h,
                                          margin: EdgeInsets.fromLTRB(
                                              15.w, 15.h, 15.w, 10.h),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.r)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5.r,
                                                blurRadius: 7.r,
                                                offset: Offset(0, 3.h),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.query_builder_outlined,
                                                  color: corTextoPrincipal,
                                                  size: 30.sp,
                                                ),
                                                SizedBox(width: 8.w),
                                                Text(
                                                  'Ver histórico de ponto',
                                                  style: TextStyle(
                                                    fontSize: 20.sp,
                                                    color: corTextoPrincipal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 360.w,
                                        height: 30.h,
                                        margin: EdgeInsets.fromLTRB(
                                            15.w, 10.h, 15.w, 0),
                                        child: Text(
                                          'Avisos',
                                          style: TextStyle(
                                            fontSize: 24.sp,
                                            color: corTextoPrincipal,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 360.w,
                                        height: 110.h,
                                        margin: EdgeInsets.fromLTRB(
                                            15.w, 10.h, 15.w, 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.r)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5.r,
                                              blurRadius: 7.r,
                                              offset: Offset(0, 3.h),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Você não possui nenhum aviso',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 125.h,
                            left: (MediaQuery.of(context).size.width - 300.w) /
                                1.3,
                            child: Container(
                              width: 300.w,
                              height: 45.h,
                              padding: EdgeInsets.fromLTRB(32.w, 12.h, 0, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15.r),
                                  bottomRight: Radius.circular(15.r),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2.r,
                                    blurRadius: 5.r,
                                    offset: Offset(0, 2.h),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    funcionario?.nome != null
                                        ? funcionario!.nome!
                                        : 'Nome não encontrado',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: corTextoPrincipal,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 160.h,
                            left: (MediaQuery.of(context).size.width - 300.w) /
                                1.3,
                            child: Container(
                              width: 200.w,
                              height: 25.h,
                              padding: EdgeInsets.fromLTRB(32.w, 3.h, 0, 0),
                              decoration: BoxDecoration(
                                color: corBase,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.r),
                                  bottomRight: Radius.circular(10.r),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2.r,
                                    blurRadius: 5.r,
                                    offset: Offset(0, 2.h),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    funcionario?.cargo != null
                                        ? funcionario!.cargo!
                                        : 'Cargo não encontrado',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 105.h,
                            left: (MediaQuery.of(context).size.width - 300.w) /
                                3.2,
                            child: Container(
                              width: 100.w,
                              height: 100.h,
                              padding: EdgeInsets.all(2.5.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 40.r,
                                backgroundColor: Colors.white,
                                backgroundImage: const NetworkImage(
                                  'https://img.freepik.com/fotos-gratis/fundo-texturizado-abstrato_1258-30461.jpg?t=st=1716012630~exp=1716016230~hmac=70399f2396de5461f7cc4f60ea536acb59ba8c2b9fee569cf1e837f614975be9',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 210.h,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                color: Colors.white,
                                child: Text(
                                  'SALDO',
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _traduzirDiaDaSemana(String diaSemana) {
    log(diaSemana);
    switch (diaSemana) {
      case 'Sunday':
        return 'Domingo';
      case 'Monday':
        return 'Segunda-feira';
      case 'Tuesday':
        return 'Terça-feira';
      case 'Wednesday':
        return 'Quarta-feira';
      case 'Thursday':
        return 'Quinta-feira';
      case 'Friday':
        return 'Sexta-feira';
      case 'Saturday':
        return 'Sábado';
      default:
        return '';
    }
  }
}
