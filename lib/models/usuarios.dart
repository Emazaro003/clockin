class Usuario {
  final int? id;
  final String matricula;
  final String? senha;
  final String? tipoUsuario;

  Usuario({
    this.id,
    required this.matricula,
    this.senha,
    this.tipoUsuario,
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

class FuncionarioRequestDTO {
  final int? id;
  final String? nome;
  final String? cargo;
  final List<String>? diasDaSemana;
  final String? entrada;
  final String? saida;
  final String? intervaloEntrada;
  final String? intervaloSaida;
  final UsuarioResquestDTO? usuarioResquestDTO;

  FuncionarioRequestDTO({
    this.id,
    this.nome,
    this.cargo,
    this.diasDaSemana,
    this.entrada,
    this.saida,
    this.intervaloEntrada,
    this.intervaloSaida,
    this.usuarioResquestDTO,
  });

  factory FuncionarioRequestDTO.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Map cannot be null');
    }

    return FuncionarioRequestDTO(
      nome: json['nome'],
      cargo: json['cargo'],
      diasDaSemana: List<String>.from(json['diasDaSemana']),
      entrada: json['entrada'],
      saida: json['saida'],
      intervaloEntrada: json['intervaloEntrada'],
      intervaloSaida: json['intervaloSaida'],
      usuarioResquestDTO: UsuarioResquestDTO.fromJson(json['usuarioResquestDTO']),
    );
  }


  factory FuncionarioRequestDTO.fromMap(Map<String, dynamic> map) {
    return FuncionarioRequestDTO(
      nome: map['nome'],
      cargo: map['cargo'],
      diasDaSemana: List<String>.from(map['diasDaSemana']),
      entrada: map['entrada'],
      saida: map['saida'],
      intervaloEntrada: map['intervaloEntrada'],
      intervaloSaida: map['intervaloSaida'],
      usuarioResquestDTO: UsuarioResquestDTO.fromMap(map['usuarioResquestDTO']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cargo': cargo,
      'diasDaSemana': diasDaSemana,
      'entrada': entrada,
      'saida': saida,
      'intervaloEntrada': intervaloEntrada,
      'intervaloSaida': intervaloSaida,
      'usuario': usuarioResquestDTO?.toJson(),
    };
  }
}

class UsuarioResquestDTO {
  final int? id;
  final String? matricula;
  final String? senha;
  final String? tipoUsuario;

  UsuarioResquestDTO({
    this.id,
    this.matricula,
    this.senha,
    this.tipoUsuario,
  });

  factory UsuarioResquestDTO.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Map cannot be null');
    }

    return UsuarioResquestDTO(
      matricula: json['matricula'] ?? '',
      senha: json['senha'] ?? '',
    );
  }


  factory UsuarioResquestDTO.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('Map cannot be null');
    }

    return UsuarioResquestDTO(
      matricula: map['matricula'] ?? '',
      senha: map['senha'] ?? '',
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

class FuncionarioCadastroDTO {
  final String? nome;
  final String? cargo;
  final List<String>? diasDaSemana;
  final String? entrada;
  final String? saida;
  final String? intervaloEntrada;
  final String? intervaloSaida;
  final UsuarioCadastroDTO? usuarioResquestDTO;

  FuncionarioCadastroDTO({
    this.nome,
    this.cargo,
    this.diasDaSemana,
    this.entrada,
    this.saida,
    this.intervaloEntrada,
    this.intervaloSaida,
    this.usuarioResquestDTO,
  });

  factory FuncionarioCadastroDTO.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Map cannot be null');
    }

    return FuncionarioCadastroDTO(
      nome: json['nome'],
      cargo: json['cargo'],
      diasDaSemana: List<String>.from(json['diasDaSemana']),
      entrada: json['entrada'],
      saida: json['saida'],
      intervaloEntrada: json['intervaloEntrada'],
      intervaloSaida: json['intervaloSaida'],
      usuarioResquestDTO: UsuarioCadastroDTO.fromJson(json['usuarioResquestDTO']),
    );
  }


  factory FuncionarioCadastroDTO.fromMap(Map<String, dynamic> map) {
    return FuncionarioCadastroDTO(
      nome: map['nome'],
      cargo: map['cargo'],
      diasDaSemana: List<String>.from(map['diasDaSemana']),
      entrada: map['entrada'],
      saida: map['saida'],
      intervaloEntrada: map['intervaloEntrada'],
      intervaloSaida: map['intervaloSaida'],
      usuarioResquestDTO: UsuarioCadastroDTO.fromMap(map['usuarioResquestDTO']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cargo': cargo,
      'diasDaSemana': diasDaSemana,
      'entrada': entrada,
      'saida': saida,
      'intervaloEntrada': intervaloEntrada,
      'intervaloSaida': intervaloSaida,
      'usuarioResquestDTO': usuarioResquestDTO?.toJson(),
    };
  }
}

class UsuarioCadastroDTO {
  final String? matricula;
  final String? senha;

  UsuarioCadastroDTO({
    this.matricula,
    this.senha,
  });

  factory UsuarioCadastroDTO.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Map cannot be null');
    }

    return UsuarioCadastroDTO(
      matricula: json['matricula'] ?? '',
      senha: json['senha'] ?? '',
    );
  }


  factory UsuarioCadastroDTO.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('Map cannot be null');
    }

    return UsuarioCadastroDTO(
      matricula: map['matricula'] ?? '',
      senha: map['senha'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matricula': matricula,
      'senha': senha,
    };
  }
}
