package com.emanu.DTO;

import com.emanu.Domain.DiaDaSemana;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
public class PontoResponseDTO {
    private Long funcionarioId;

    private LocalDate data;

    private LocalTime hora;

    private DiaDaSemana diaDaSemana;
}

