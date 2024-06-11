package com.emanu.DTO;

import com.emanu.Domain.TipoUsuario;
import lombok.Data;

@Data
public class UsuarioDTO {

    private String matricula;

    private String senha;

    private TipoUsuario tipoUsuario;
}
