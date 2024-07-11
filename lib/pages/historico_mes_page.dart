import 'dart:developer';
import 'package:clockin/dataBase/db_login.dart';
import 'package:clockin/models/pontos_mes.dart';
import 'package:clockin/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clockin/components/colors.dart';
import 'package:clockin/api/call_api.dart';
import 'package:clockin/models/historico_mes_dto.dart';

class HistoricoMes extends StatefulWidget {
  final Duration cargaHoraria;
  final String matricula;

  HistoricoMes({Key? key, required this.cargaHoraria, required this.matricula})
      : super(key: key);

  @override
  State<HistoricoMes> createState() => _HistoricoMesState();
}

class _HistoricoMesState extends State<HistoricoMes> {
  DatabaseHelper dbHelper = DatabaseHelper();
  final CallApi callApi = CallApi();

  Duration cargaHoraria = Duration.zero;
  Duration saldoTotalD = Duration.zero;
  String saldoTotal = "";
  String saldoTotaltxt = "00:00:00";
  String matricula = "";

  late Future<List<PontosDoMesDTO>> _pontosDoMesFuture;

  @override
  void initState() {
    super.initState();
    matricula = widget.matricula;
    cargaHoraria = widget.cargaHoraria;
    _pontosDoMesFuture = callApi.getSaldoDoMes(widget.matricula);
    calculaSaldo();
  }

  void calculaSaldo() async {
    saldoTotal = await callApi.saldo(matricula);
    saldoTotalD = _parseDuration(saldoTotal);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        return false;
      },
      child: ScreenUtilInit(
        designSize: const Size(450, 900),
        builder: (context, child) => SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: corBase,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 45.sp,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: FutureBuilder<List<PontosDoMesDTO>>(
              future: _pontosDoMesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child:
                          Text('Erro ao carregar os dados: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Nenhum ponto histórico encontrado.'));
                } else {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            height: 140.h,
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
                            height: MediaQuery.of(context).size.height - 250.h,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 420.w,
                                        height: 540.h,
                                        margin: EdgeInsets.fromLTRB(
                                            15.w, 60.h, 15.w, 0.h),
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 18, 5, 0),
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
                                        child: Column(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'SALDO',
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                                Text(
                                                  saldoTotal,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: saldoTotalD <
                                                            Duration.zero
                                                        ? Colors.red
                                                        : corTextoVerde,
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      8.w, 10.h, 8.w, 0.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              "Data",
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              "H.T",
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              "SALDO",
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              "DESCRIÇÃO",
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Divider(
                                                        thickness: 1.5,
                                                      ),
                                                      SizedBox(
                                                        height: 380.h,
                                                        child: ListView.builder(
                                                          itemCount: snapshot
                                                              .data!.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            PontosDoMesDTO
                                                                ponto =
                                                                snapshot.data![
                                                                    index];
                                                            String descricao =
                                                                calcularDescricao(
                                                                    ponto
                                                                        .horasTrabalhadas);
                                                            Duration convertHoraTrabalhada = converterDuracao(ponto.horasTrabalhadas);
                                                            String horaTrabalhada = formatarDuracao(convertHoraTrabalhada);

                                                            return Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8.h),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          ponto
                                                                              .data,
                                                                          style:
                                                                              TextStyle(fontSize: 14.sp),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      horaTrabalhada ,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      ponto
                                                                          .saldo,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child: Text(
                                                                      descricao,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 125.h,
                        left: 90.w,
                        child: Container(
                          width: 300.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2.r,
                                blurRadius: 5.r,
                                offset: Offset(0, 2.h),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Histórico mensal',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: corTextoPrincipal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  String calcularDescricao(String hora) {
    Duration diferenca = converterDuracao(hora) - cargaHoraria;
    return diferenca >= Duration.zero ? 'Concluído' : 'Saldo pendente';
  }

  Duration converterDuracao(String tempo) {
    List<String> partes = tempo.split(':');

    // Separar os segundos e a parte decimal
    List<String> secondsParts = partes[2].split('.');
    int seconds = int.parse(secondsParts[0]); // Pegar os segundos inteiros e ignorar os milissegundos

    return Duration(
      hours: int.parse(partes[0]),
      minutes: int.parse(partes[1]),
      seconds: seconds,
    );
  }

  String formatarDuracao(Duration duracao) {
    bool isNegative = duracao.isNegative;
    duracao = duracao.abs();

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitHours = twoDigits(duracao.inHours);
    String twoDigitMinutes = twoDigits(duracao.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duracao.inSeconds.remainder(60));

    String formatted = "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";

    return isNegative ? '-$formatted' : formatted;
  }

  Duration _parseDuration(String duration) {
    List<String> parts = duration.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    List<String> secondsParts = parts[2].split('.');
    int seconds = int.parse(secondsParts[0]);

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }
}
