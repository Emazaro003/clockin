import 'dart:developer';

import 'package:clockin/models/historico_mes_dto.dart';
import 'package:clockin/api/call_api.dart';
import 'package:clockin/dataBase/db_login.dart';

class DataUtils {
  static Future<String> buscarESomarSaldoTotal(String matricula) async {
    final dbHelper = DatabaseHelper();
    final callApi = CallApi();

    try {
      Map<String, dynamic> user = await dbHelper.isLoggedIn();
      matricula = user['matricula'];
      var historicoMesFuture = callApi.buscarEOrganizarPontos(matricula);
      var historicoMes = await fetchAndProcessData(matricula, historicoMesFuture);
      var saldoTotal = somarSaldos(historicoMes);
      return formatarDuracao(saldoTotal);
    } catch (e) {
      log("Erro ao buscar e processar dados: $e");
      throw Exception("Erro ao buscar e processar dados");
    }
  }

  static Future<List<HistoricoMesDTO>> fetchAndProcessData(String matricula, Future<Map<String, List<HistoricoMesDTO>>> historicoMesFuture) async {
    List<HistoricoMesDTO> listaTemporaria = [];

    try {
      var resultado = await historicoMesFuture;

      resultado.forEach((data, listaHistorico) {
        Map<String, Duration?> saldoPorData = {};

        for (int i = 0; i < listaHistorico.length; i += 2) {
          if (i + 1 < listaHistorico.length) {
            Duration entrada = converterDuracao(listaHistorico[i].hora!);
            Duration saida = converterDuracao(listaHistorico[i + 1].hora!);
            Duration intervalo = saida - entrada;

            saldoPorData[listaHistorico[i].data!] ??= Duration.zero;
            saldoPorData[listaHistorico[i].data!] =
                saldoPorData[listaHistorico[i].data]! + intervalo;
          }
        }

        saldoPorData.forEach((data, saldo) {
          if (saldo != null) {
            listaTemporaria.add(HistoricoMesDTO(
              data: data,
              diaDaSemana: listaHistorico.first.diaDaSemana,
              funcionarioId: listaHistorico.first.funcionarioId,
              hora: formatarDuracao(saldo),
              matricula: listaHistorico.first.matricula,
            ));
          }
        });
      });

      return listaTemporaria;
    } catch (e) {
      log("Erro ao buscar e processar dados: $e");
      throw Exception("Erro ao buscar e processar dados");
    }
  }

  static Duration somarSaldos(List<HistoricoMesDTO> historicoMes) {
    if (historicoMes.isEmpty) {
      return Duration.zero;
    }

    return historicoMes
        .map((historico) => converterDuracao(calcularSaldo(historico.hora!)))
        .reduce((value, element) => value + element);
  }

  static String calcularSaldo(String hora) {
    Duration cargaHoraria = converterDuracao('09:00:00');
    Duration horasRegistradas = converterDuracao(hora);
    Duration saldo = horasRegistradas - cargaHoraria;

    return formatarDuracao(saldo);
  }

  static Duration converterDuracao(String tempo) {
    List<String> partes = tempo.split(':');
    return Duration(
      hours: int.parse(partes[0]),
      minutes: int.parse(partes[1]),
      seconds: int.parse(partes[2]),
    );
  }

  static String formatarDuracao(Duration duracao) {
    return '${duracao.inHours.toString().padLeft(2, '0')}:${(duracao.inMinutes % 60).toString().padLeft(2, '0')}:${(duracao.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}
