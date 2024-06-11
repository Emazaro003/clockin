package com.emanu.DTO.Mapper;

import com.emanu.DTO.FuncionarioDTO;
import com.emanu.DTO.FuncionarioRequestDTO;
import com.emanu.DTO.UsuarioDTO;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class DtoToDto {
    private static UsuarioDTO funcionarioRequestToUsuario(FuncionarioRequestDTO funcionarioRequestDTO) {
        UsuarioDTO usuarioDTO = new UsuarioDTO();
        usuarioDTO.setMatricula(funcionarioRequestDTO.getUsuarioResquestDTO().getMatricula());
        usuarioDTO.setSenha(funcionarioRequestDTO.getUsuarioResquestDTO().getSenha());
        return usuarioDTO;
    }

    private static FuncionarioDTO funcionarioRequestToFuncionario(FuncionarioRequestDTO funcionarioRequestDTO) {
        FuncionarioDTO funcionarioDTO = new FuncionarioDTO();
        funcionarioDTO.setNome(funcionarioRequestDTO.getNome());
        funcionarioDTO.setCargo(funcionarioRequestDTO.getCargo());
        funcionarioDTO.setEntrada(funcionarioRequestDTO.getEntrada());
        funcionarioDTO.setSaida(funcionarioRequestDTO.getSaida());
        funcionarioDTO.setIntervaloSaida(funcionarioRequestDTO.getIntervaloSaida());
        funcionarioDTO.setIntervaloEntrada(funcionarioRequestDTO.getIntervaloEntrada());
        funcionarioDTO.setDiasDaSemana(funcionarioRequestDTO.getDiasDaSemana());
        return funcionarioDTO;
    }
}
