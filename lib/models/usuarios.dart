class Usuario {
  final int id;
  final String matricula;
  final String senha;
  final String tipoUsuario;

  Usuario({
    required this.id,
    required this.matricula,
    required this.senha,
    required this.tipoUsuario,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      matricula: json['matricula'],
      senha: json['senha'],
      tipoUsuario: json['tipoUsuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matricula': matricula,
      'senha': senha,
      'tipoUsuario': tipoUsuario,
    };
  }
}

class Funcionario {
  final int id;
  final String nome;
  final String cargo;
  final Usuario usuario;

  Funcionario({
    required this.id,
    required this.nome,
    required this.cargo,
    required this.usuario,
  });

  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return Funcionario(
      id: json['id'],
      nome: json['nome'],
      cargo: json['cargo'],
      usuario: Usuario.fromJson(json['usuario']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cargo': cargo,
      'usuario': usuario.toJson(),
    };
  }
}

class PontoFuncionario {
  final String data;
  final String hora;
  final Funcionario funcionario;

  PontoFuncionario({
    required this.data,
    required this.hora,
    required this.funcionario,
  });

  factory PontoFuncionario.fromJson(Map<String, dynamic> json) {
    return PontoFuncionario(
      data: json['data'],
      hora: json['hora'],
      funcionario: Funcionario.fromJson(json['funcionario']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'hora': hora,
      'funcionario': funcionario.toJson(),
    };
  }
}
