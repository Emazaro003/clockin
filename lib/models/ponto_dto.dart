import 'package:intl/intl.dart';

class PontoDTO {
  final int funcionarioId;
  final String diaDaSemana;
  final String matricula;
  final String data;
  final String hora;

  PontoDTO({required this.matricula, required this.data, required this.hora, required this.diaDaSemana, required this.funcionarioId});

  Map<String, dynamic> toJson() {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormat = DateFormat('HH:mm:ss');

    return {
      'matricula': matricula,
      'data': dateFormat.format(data as DateTime),
      'hora': timeFormat.format(hora as DateTime),
    };
  }

  factory PontoDTO.fromJson(Map<String, dynamic> json) {
    return PontoDTO(
      data: json['data'],
      diaDaSemana: json['diaDaSemana'],
      funcionarioId: json['funcionarioId'],
      hora: json['hora'], matricula: '',
    );
  }
}

