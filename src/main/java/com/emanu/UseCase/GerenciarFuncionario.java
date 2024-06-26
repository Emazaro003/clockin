package com.emanu.UseCase;

import com.emanu.DTO.FuncionarioDTO;
import com.emanu.DTO.PontoResponseDTO;
import com.emanu.DTO.UsuarioDTO;
import com.emanu.Domain.Funcionario;
import com.emanu.Domain.Ponto;
import com.emanu.Domain.TipoUsuario;
import com.emanu.Domain.Usuario;
import com.emanu.Repository.FuncionarioRepository;
import com.emanu.Repository.PontoRepository;
import com.emanu.Repository.UsuarioRepository;
import com.emanu.DTO.Mapper.DtoToDomain;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

import java.time.LocalDate;
import java.util.List;

@ApplicationScoped
public class GerenciarFuncionario {

    @Inject
    public FuncionarioRepository funcionarioRepository;

    @Inject
    public UsuarioRepository usuarioRepository;

    @Inject
    public PontoRepository pontoRepository;

    @Inject
    public DtoToDomain dtoToDomain;

    @Transactional
    public Funcionario adicionarFuncionario(
            FuncionarioDTO funcionarioDTO,
            UsuarioDTO usuarioDTO
    ){
        Usuario usuario = dtoToDomain.usuario(usuarioDTO, TipoUsuario.FUNCIONARIO);

        usuarioRepository.persist(usuario);

        Funcionario funcionario = dtoToDomain.funcionario(funcionarioDTO);;

        funcionario.setUsuario(usuario);

        funcionarioRepository.persist(funcionario);

        return funcionario;
    }

    @Transactional
    public Boolean salvaPonto(Ponto p){
        List<PontoResponseDTO> pontos = pontoRepository.pontosDoFuncionario(p.getFuncionario());
        pontos.forEach(ponto -> {
            System.out.println(ponto.getData() + LocalDate.now().toString() + LocalDate.now().equals(ponto.getData()));
        });
        System.out.println("Pontos do dia: " + pontos.size());
        if (pontos.size() < 4) {
            pontoRepository.persist(p);
            return true;
        }
        return false;
    }

}
