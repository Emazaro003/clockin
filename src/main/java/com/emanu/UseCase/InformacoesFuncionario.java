package com.emanu.UseCase;

import com.emanu.DTO.PontoResponseDTO;
import com.emanu.DTO.PontosDoMesDTO;
import com.emanu.Domain.Funcionario;
import com.emanu.Domain.Ponto;
import com.emanu.Domain.Usuario;
import com.emanu.Repository.FuncionarioRepository;
import com.emanu.Repository.PontoRepository;
import com.emanu.Repository.UsuarioRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.time.Duration;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class InformacoesFuncionario {

    @Inject
    FuncionarioRepository funcionarioRepository;

    @Inject
    PontoRepository pontoRepository;

    @Inject
    UsuarioRepository usuarioRepository;

    public Funcionario getFuncionario(Long id) {
        return funcionarioRepository.findById(id);
    }

    public Funcionario getFuncionarioPorMatricula(String matricula) {
        List<Funcionario> funcionarios = getFuncionarios();

        Optional<Funcionario> funcionario = funcionarios.stream().filter(f -> f.getUsuario().getMatricula().equals(matricula)).findFirst();

        return funcionario.orElse(null);
    }

    public List<Funcionario> getFuncionarios() {
        return funcionarioRepository.listAll();
    }

    public List<String> getFuncionariosMatricula() {
        List<Funcionario> funcionarios = funcionarioRepository.listAll();
        return funcionarios.stream().map(f -> f.getUsuario().getMatricula()).toList();
    }

    public List<PontoResponseDTO> getPontoFuncionario(Funcionario funcionario) {
        return pontoRepository.pontosDoFuncionario(funcionario);
    }

    public List<Usuario> getUsuarios(){
        return usuarioRepository.listAll();
    }

    public Duration getSaldoDoDia(Funcionario funcionario){
        return pontoRepository.calcularSaldoDia(funcionario, LocalDate.now());
    }

    public List<PontosDoMesDTO> getSaldoDoMes(Funcionario funcionario){
        return pontoRepository.calcularSaldoMes(funcionario, LocalDate.now().getMonthValue(), LocalDate.now().getYear());
    }

    public String getSaldoTotal(Funcionario funcionario){
        return pontoRepository.calcularSaldoTotal(funcionario);
    }
}
