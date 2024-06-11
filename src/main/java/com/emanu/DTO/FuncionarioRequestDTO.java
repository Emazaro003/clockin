package com.emanu.DTO;

import com.emanu.Domain.DiaDaSemana;
import lombok.Data;

import java.time.LocalTime;
import java.util.List;

@Data
public class FuncionarioRequestDTO {

    private String nome;

    private String cargo;

    private List<DiaDaSemana> diasDaSemana;

    private LocalTime entrada;

    private LocalTime saida;

    private LocalTime intervaloEntrada;

    private LocalTime intervaloSaida;

    private UsuarioResquestDTO usuarioResquestDTO;
}
