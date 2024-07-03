import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:clockin/api/url.dart';
import 'package:clockin/dataBase/db_login.dart';
import 'package:clockin/models/ponto_dto.dart';
import 'package:clockin/models/usuarios.dart';
import 'package:http/http.dart' as http;

class CallApi {
  DatabaseHelper dbHelper = DatabaseHelper();

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
    String hora = DateTime.now().toIso8601String().split('T')[1].substring(0, 8);

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
}
