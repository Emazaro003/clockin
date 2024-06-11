package com.emanu.DTO;

import com.emanu.Domain.DiaDaSemana;
import com.emanu.Domain.Funcionario;
import lombok.Data;

import java.time.LocalTime;
import java.util.List;

@Data
public class FuncionarioResponseDTO {

    private Long id;

    private String nome;

    private String cargo;

    private List<DiaDaSemana> diasDaSemana;

    private LocalTime entrada;

    private LocalTime saida;

    private LocalTime intervaloEntrada;

    private LocalTime intervaloSaida;

    private UsuarioResponseDTO usuarioResponseDTO;
}
