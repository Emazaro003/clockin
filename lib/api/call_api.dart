import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:clockin/api/url.dart';
import 'package:clockin/dataBase/db_login.dart';
import 'package:clockin/models/historico_mes_dto.dart';
import 'package:clockin/models/pontos_mes.dart';
import 'package:clockin/models/usuarios.dart';
import 'package:duration/duration.dart';
import 'package:http/http.dart' as http;

class CallApi {
  DatabaseHelper dbHelper = DatabaseHelper();

  Future<FuncionarioRequestDTO?> fetchFuncionario(String matricula) async {
    final response =
        await http.get(Uri.parse('$urlApi/funcionarios/detalhes/$matricula'));

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonResponse =
            json.decode(utf8.decode(response.bodyBytes));
        print('JSON Response: $jsonResponse');

        FuncionarioRequestDTO funcionario =
            FuncionarioRequestDTO.fromJson(jsonResponse);
        return funcionario;
      } catch (e) {
        print('Error decoding JSON: $e');
        throw Exception('Failed to decode JSON');
      }
    } else {
      print('Funcionario not found for matricula: $matricula');
      return null;
    }
  }

  Future<Map<String, dynamic>> validarLogin(
      String matricula, String senha) async {
    final url = Uri.parse('$urlApi/usuarios');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'matricula': matricula, 'senha': senha});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        await dbHelper.insertUser({
          'id': responseData['id'],
          'matricula': responseData['matricula'],
          'tipoUsuario': responseData['tipoUsuario'],
        });
        log('Login bem-sucedido: $responseData');
        return responseData;
      } else if (response.statusCode == 401) {
        throw Exception('Usuário ou senha incorretos');
      } else {
        throw Exception('Erro ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erro $error');
    }
  }

  Future<String> registrarPontoComMatricula(String matricula) async {
    String data = DateTime.now().toIso8601String().split('T')[0];
    String hora =
        DateTime.now().toIso8601String().split('T')[1].substring(0, 8);

    Map<String, dynamic> pontoPayload = {
      'matricula': matricula,
      'data': data,
      'hora': hora,
    };

    try {
      final responsePonto = await http.post(
        Uri.parse('$urlApi/funcionarios/ponto'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(pontoPayload),
      );

      if (responsePonto.statusCode == 201) {
        Map<String, dynamic> pontoJson = json.decode(responsePonto.body);
        String nomeFuncionario = pontoJson['funcionario']['nome'];
        String nomeDecodificado = utf8.decode(nomeFuncionario.runes.toList());
        log(nomeDecodificado);
        return 'Ponto de $nomeDecodificado registrado com sucesso às $hora.';
      } else {
        log(responsePonto.body);
        String responseBody = utf8.decode(responsePonto.bodyBytes);
        return 'Falha ao registrar ponto $responseBody';
      }
    } on SocketException catch (e) {
      return 'Falha ao registrar ponto verifique sua conexão com a internet.';
    } catch (e) {
      return 'Erro desconhecido ao tentar registrar ponto: $e';
    }
  }

  Future<String> saldo(String matricula) async {
    final response = await http.get(Uri.parse('$urlApi/funcionarios/calculos/$matricula'));

    log("Status code: ${response.statusCode}");
    log("Response body: ${response.body}");

    if (response.statusCode == 200) {
      try {
        String saldoTotalString = response.body.trim();

        Duration saldoTotal = stringToDuration(saldoTotalString);

        return formatDuration(saldoTotal);
      } catch (e) {
        log("Erro ao converter saldo: $e");
        throw FormatException("Erro ao converter saldo: $e");
      }
    } else {
      log("Falha ao carregar os cálculos");
      throw Exception('Falha ao carregar os cálculos');
    }
  }

  Duration stringToDuration(String timeString) {
    log("Convertendo tempo: $timeString");
    timeString = timeString.trim();
    bool isNegative = timeString.startsWith('-');
    if (isNegative) {
      timeString = timeString.substring(1);
    }

    List<String> parts = timeString.split(':');
    if (parts.length != 3) {
      throw FormatException("Formato inválido para a string de tempo: $timeString");
    }

    int? hours = int.tryParse(parts[0]);
    int? minutes = int.tryParse(parts[1]);
    int? seconds = int.tryParse(parts[2]);

    if (hours == null || minutes == null || seconds == null) {
      throw FormatException("Erro ao converter partes da string de tempo para inteiro: $timeString");
    }

    Duration duration = Duration(hours: hours, minutes: minutes, seconds: seconds);
    return isNegative ? -duration : duration;
  }

  String twoDigits(int n) {
    String absValue = n.abs().toString();
    return n.isNegative ? absValue.padLeft(2, "0") : absValue.padLeft(2, "0");
  }

  String formatDuration(Duration duration) {
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    int hours = duration.inHours;
    bool isNegative = hours < 0;

    String hoursStr = isNegative ? (-hours).toString() : hours.toString();
    String formattedDuration = "${isNegative ? '-' : ''}$hoursStr:$twoDigitMinutes:$twoDigitSeconds";

    return formattedDuration;
  }


  Future<Map<String, List<HistoricoMesDTO>>> buscarEOrganizarPontos(
      String matricula) async {
    final response =
    await http.get(Uri.parse('$urlApi/funcionarios/$matricula'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<HistoricoMesDTO> pontos =
      jsonList.map((json) => HistoricoMesDTO.fromJson(json)).toList();
      return organizePontosByDate(pontos);
    } else {
      throw Exception('Falha ao carregar os pontos');
    }
  }

  Map<String, List<HistoricoMesDTO>> organizePontosByDate(
      List<HistoricoMesDTO> pontos) {
    Map<String, List<HistoricoMesDTO>> pontosByDate = {};

    for (var ponto in pontos) {
      String dateKey = ponto.data!;

      if (!pontosByDate.containsKey(dateKey)) {
        pontosByDate[dateKey] = [];
      }
      pontosByDate[dateKey]!.add(ponto);
    }

    return pontosByDate;
  }

  Future<List<PontosDoMesDTO>> getSaldoDoMes(String matricula) async {
    final response = await http.get(Uri.parse('$urlApi/funcionarios/calculos/mes/$matricula'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => PontosDoMesDTO.fromJson(data)).toList();
    } else {
      throw Exception('Falha ao carregar dados');
    }
  }

  Future<String> cadastrar(FuncionarioCadastroDTO requestData) async {
    String jsonRequest = jsonEncode(requestData);
    log(jsonRequest);
    var response = await http.post(
      Uri.parse('$urlApi/funcionarios'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonRequest,
    );

    if (response.statusCode == 201) {
      return ('Funcionario cadastrado com sucesso');
    } else {
      log('Erro ao cadastrar funcionario: ${response.statusCode}-${response.body}');
      return ('Erro ao cadastrar funcionario: ${response.statusCode}-${response.body}');
    }
  }
}
