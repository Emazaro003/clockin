package com.emanu.Domain;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalTime;
import java.util.List;

@Data
@Entity(name = "funcionarios")
public class Funcionario {

    @Id
    @GeneratedValue
    private long id;

    private String nome;

    private String cargo;

    @ElementCollection
    private List<DiaDaSemana> diasDaSemana;

    private LocalTime entrada;

    private LocalTime saida;

    private LocalTime intervaloEntrada;

    private LocalTime intervaloSaida;

    @OneToOne
    private Usuario usuario;
}
