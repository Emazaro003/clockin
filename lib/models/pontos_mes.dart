class PontosDoMesDTO {
  final String data;
  final String horasTrabalhadas;
  final String saldo;

  PontosDoMesDTO({
    required this.data,
    required this.horasTrabalhadas,
    required this.saldo,
  });

  factory PontosDoMesDTO.fromJson(Map<String, dynamic> json) {
    return PontosDoMesDTO(
      data: json['data'],
      horasTrabalhadas: json['horasTrabalhadas'],
      saldo: json['saldo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'horasTrabalhadas': horasTrabalhadas,
      'saldo': saldo,
    };
  }
}
