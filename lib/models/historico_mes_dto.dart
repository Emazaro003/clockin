import 'package:intl/intl.dart';

class HistoricoMesDTO {
  final int? funcionarioId;
  final String? diaDaSemana;
  final String? matricula;
  final String? data;
  final String? hora;

  HistoricoMesDTO(
      {this.matricula,
      this.data,
      this.hora,
      this.diaDaSemana,
      this.funcionarioId});

  factory HistoricoMesDTO.fromJson(Map<String, dynamic> json) {
    return HistoricoMesDTO(
      data: json['data'],
      diaDaSemana: json['diaDaSemana'],
      funcionarioId: json['funcionarioId'],
      hora: json['hora'],
      matricula: '',
    );
  }
}
