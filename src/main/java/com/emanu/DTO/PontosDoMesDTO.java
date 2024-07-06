package com.emanu.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@AllArgsConstructor
public class PontosDoMesDTO {

    private LocalTime horasTrabalhadas;

    private LocalDate data;

    private String saldo;
}
