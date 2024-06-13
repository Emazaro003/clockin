package com.emanu.Domain;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@Entity(name = "ponto")
public class Ponto {

    @Id
    @GeneratedValue
    private Long id;

    @ManyToOne
    private Funcionario funcionario;

    private LocalDate data;

    private LocalTime hora;
}
