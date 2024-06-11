package com.emanu.Domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity(name = "usuarios")
@NoArgsConstructor
public class Usuario {

    @Id
    @GeneratedValue
    private long id;

    private String matricula;

    private String senha;

    private TipoUsuario tipoUsuario;

    public Usuario(String matricula, String senha) {
        this.matricula = matricula;
        this.senha = senha;
    }
}
