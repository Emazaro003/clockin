package com.emanu.DTO.Mapper;

import com.emanu.DTO.FuncionarioDTO;
import com.emanu.DTO.FuncionarioResponseDTO;
import com.emanu.DTO.UsuarioDTO;
import com.emanu.DTO.UsuarioResponseDTO;
import com.emanu.Domain.Funcionario;
import com.emanu.Domain.TipoUsuario;
import com.emanu.Domain.Usuario;
import io.smallrye.common.constraint.NotNull;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class DtoToDomain {

    public Funcionario funcionario(
            @NotNull FuncionarioDTO funcionarioDTO
    ){
        Funcionario funcionario = new Funcionario();

        funcionario.setNome(funcionarioDTO.getNome());
        funcionario.setCargo(funcionarioDTO.getCargo());
        funcionario.setEntrada(funcionarioDTO.getEntrada());
        funcionario.setSaida(funcionarioDTO.getSaida());
        funcionario.setDiasDaSemana(funcionarioDTO.getDiasDaSemana());
        funcionario.setIntervaloEntrada(funcionarioDTO.getIntervaloEntrada());
        funcionario.setIntervaloSaida(funcionarioDTO.getIntervaloSaida());

        return funcionario;
    };

    public Usuario usuario(
            @NotNull UsuarioDTO usuarioDTO,
            TipoUsuario tipoUsuario
    ){
        Usuario usuario = new Usuario();

        usuario.setMatricula(usuarioDTO.getMatricula());
        usuario.setSenha(usuarioDTO.getSenha());
        usuario.setTipoUsuario(tipoUsuario);

        return usuario;
    }

    private static FuncionarioResponseDTO funcionarioToFuncionarioResponseDTO(Funcionario funcionario) {
        FuncionarioResponseDTO funcionarioResponseDTO = new FuncionarioResponseDTO();
        funcionarioResponseDTO.setId(funcionario.getId());
        funcionarioResponseDTO.setNome(funcionario.getNome());
        funcionarioResponseDTO.setCargo(funcionario.getCargo());
        funcionarioResponseDTO.setEntrada(funcionario.getEntrada());
        funcionarioResponseDTO.setSaida(funcionario.getSaida());
        funcionarioResponseDTO.setIntervaloEntrada(funcionario.getIntervaloEntrada());
        funcionarioResponseDTO.setIntervaloSaida(funcionario.getIntervaloSaida());
        funcionarioResponseDTO.setDiasDaSemana(funcionario.getDiasDaSemana());

        return funcionarioResponseDTO;
    }

    private static UsuarioResponseDTO funcionarioToUsuarioResponseDTO(Funcionario funcionario) {
        UsuarioResponseDTO usuarioResponseDTO = new UsuarioResponseDTO();
        usuarioResponseDTO.setId(funcionario.getUsuario().getId());
        usuarioResponseDTO.setMatricula(funcionario.getUsuario().getMatricula());

        return usuarioResponseDTO;
    }
}
