package com.emanu.DTO;

import com.emanu.Domain.Funcionario;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
public class PontoDTO {

    private String matricula;

    private LocalDate data;

    private LocalTime hora;
}
