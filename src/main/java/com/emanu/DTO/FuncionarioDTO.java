package com.emanu.DTO;

import com.emanu.Domain.DiaDaSemana;
import jakarta.persistence.ElementCollection;
import lombok.Data;

import java.time.LocalTime;
import java.util.List;

@Data
public class FuncionarioDTO {

    private String nome;

    private String cargo;

    @ElementCollection
    private List<DiaDaSemana> diasDaSemana;

    private LocalTime entrada;

    private LocalTime saida;

    private LocalTime intervaloEntrada;

    private LocalTime intervaloSaida;
}
