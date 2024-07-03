import 'package:intl/intl.dart';

class PontoDTO {
  final String matricula;
  final DateTime data;
  final DateTime hora;

  PontoDTO({required this.matricula, required this.data, required this.hora});

  Map<String, dynamic> toJson() {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormat = DateFormat('HH:mm:ss');

    return {
      'matricula': matricula,
      'data': dateFormat.format(data),
      'hora': timeFormat.format(hora),
    };
  }
}
