package com.emanu.Domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@Entity(name = "ponto")
public class Ponto {

    @Id
    @GeneratedValue
    private Long id;

    @OneToOne
    private Funcionario funcionario;

    private LocalDate data;

    private LocalTime hora;
}
