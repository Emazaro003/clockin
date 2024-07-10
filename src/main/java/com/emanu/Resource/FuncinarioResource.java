package com.emanu.Resource;

import com.emanu.DTO.*;
import com.emanu.DTO.Mapper.DtoToDomain;
import com.emanu.DTO.Mapper.DtoToDto;
import com.emanu.Domain.Funcionario;
import com.emanu.Domain.Ponto;
import com.emanu.UseCase.InformacoesFuncionario;
import com.emanu.UseCase.GerenciarFuncionario;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.core.Response;

import java.net.URI;
import java.time.Duration;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Path("/funcionarios")
public class FuncinarioResource {

    @Inject
    GerenciarFuncionario gerenciarFuncionario;

    @Inject
    InformacoesFuncionario informacoesFuncionario;

    @Inject
    DtoToDto dtoToDto;

    @Inject
    DtoToDomain dtoToDomain;

    @GET
    public Response getFuncinarios() {
        List<Funcionario> funcionarios = informacoesFuncionario.getFuncionarios();

        List<FuncionarioResponseDTO> funcionarioResponseDTOs = new ArrayList<>();

        for (Funcionario funcionario : funcionarios) {
            FuncionarioResponseDTO funcionarioResponseDTO = getFuncionarioResponseDTO(funcionario);

            UsuarioResponseDTO usuarioResponseDTO = getUsuarioResponseDTO(funcionario);

            funcionarioResponseDTO.setUsuarioResponseDTO(usuarioResponseDTO);

            funcionarioResponseDTOs.add(funcionarioResponseDTO);
        }

        return Response.ok(funcionarioResponseDTOs).build();
    }

    @GET
    @Path("/{matricula}")
    public Response getPontoFuncionario(@PathParam("matricula") String matricula){
        Funcionario funcionario = informacoesFuncionario.getFuncionarioPorMatricula(matricula);
        System.out.println(funcionario);
        return Response.ok().entity(informacoesFuncionario.getPontoFuncionario(funcionario)).build();
    }

    @POST
    public Response postFuncinarios(FuncionarioRequestDTO funcionarioRequestDTO) {
        if (funcionarioRequestDTO.getUsuarioResquestDTO() == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("Campo 'usuarioResquestDTO' é obrigatório.")
                    .build();
        }

        FuncionarioDTO funcionarioDTO = getFuncionarioDTO(funcionarioRequestDTO);
        UsuarioDTO usuarioDTO = getUsuarioDTO(funcionarioRequestDTO);

        Funcionario funcionario = gerenciarFuncionario.adicionarFuncionario(funcionarioDTO, usuarioDTO);

        if (funcionario == null) {
            return Response.status(Response.Status.BAD_REQUEST).entity("Matricula já existe").build();
        }

        return Response.created(URI.create("")).entity(funcionario).build();
    }

    @POST
    @Path("/ponto")
    public Response registrarPonto(PontoDTO pontoDTO){
        Funcionario funcionario = informacoesFuncionario.getFuncionarioPorMatricula(pontoDTO.getMatricula());

        if (funcionario == null) {
            return Response.status(Response.Status.NOT_FOUND).entity("Funcionario não encontrado").build();
        }

        Ponto p = new Ponto();
        p.setData(pontoDTO.getData());
        p.setHora(pontoDTO.getHora());
        p.setFuncionario(funcionario);

        if (gerenciarFuncionario.salvaPonto(p)) {
            return Response.created(URI.create("")).entity(p).build();
        }

        return Response.status(Response.Status.BAD_REQUEST).entity("Numero de pontos não pode ultrapassar 4").build();

    }

    @GET
    @Path("/detalhes/{matricula}")
    public Response getFuncionarioByMatricula(@PathParam("matricula") String matricula) {
        Funcionario funcionario = informacoesFuncionario.getFuncionarioPorMatricula(matricula);

        if (funcionario == null) {
            return Response.status(Response.Status.NOT_FOUND).entity("Funcionario não encontrado").build();
        }

        FuncionarioRequestDTO funcionarioRequestDTO = convertToFuncionarioRequestDTO(funcionario);
        return Response.ok(funcionarioRequestDTO).build();
    }

    @GET
    @Path("/calculos/dia/{matricula}")
    public Response getSaldoDoDia(@PathParam("matricula") String matricula){
        Funcionario funcionario = informacoesFuncionario.getFuncionarioPorMatricula(matricula);

        Duration saldo = informacoesFuncionario.getSaldoDoDia(funcionario);

        return Response.status(Response.Status.OK).entity(LocalTime.MIDNIGHT.plus(saldo)).build();
    }

    @GET
    @Path("/calculos/mes/{matricula}")
    public Response getSaldoDoMes(@PathParam("matricula") String matricula){
        Funcionario funcionario = informacoesFuncionario.getFuncionarioPorMatricula(matricula);

        List<PontosDoMesDTO> pontosDoMes = informacoesFuncionario.getSaldoDoMes(funcionario);

        return Response.status(Response.Status.OK).entity(pontosDoMes).build();
    }

    @GET
    @Path("/calculos/{matricula}")
    public Response getSaldoTotal(@PathParam("matricula") String matricula){
        Funcionario funcionario = informacoesFuncionario.getFuncionarioPorMatricula(matricula);

        String saldoTotal = informacoesFuncionario.getSaldoTotal(funcionario);

        return Response.status(Response.Status.OK).entity(saldoTotal).build();
    }

    private FuncionarioRequestDTO convertToFuncionarioRequestDTO(Funcionario funcionario) {
        UsuarioResquestDTO usuarioResquestDTO = new UsuarioResquestDTO();
        usuarioResquestDTO.setMatricula(funcionario.getUsuario().getMatricula());
        usuarioResquestDTO.setSenha(funcionario.getUsuario().getSenha());

        FuncionarioRequestDTO funcionarioRequestDTO = new FuncionarioRequestDTO();
        funcionarioRequestDTO.setNome(funcionario.getNome());
        funcionarioRequestDTO.setCargo(funcionario.getCargo());
        funcionarioRequestDTO.setDiasDaSemana(funcionario.getDiasDaSemana());
        funcionarioRequestDTO.setEntrada(funcionario.getEntrada());
        funcionarioRequestDTO.setSaida(funcionario.getSaida());
        funcionarioRequestDTO.setIntervaloEntrada(funcionario.getIntervaloEntrada());
        funcionarioRequestDTO.setIntervaloSaida(funcionario.getIntervaloSaida());
        funcionarioRequestDTO.setUsuarioResquestDTO(usuarioResquestDTO);

        return funcionarioRequestDTO;
    }

    private static UsuarioResponseDTO getUsuarioResponseDTO(Funcionario funcionario) {
        UsuarioResponseDTO usuarioResponseDTO = new UsuarioResponseDTO();
        usuarioResponseDTO.setId(funcionario.getUsuario().getId());
        usuarioResponseDTO.setMatricula(funcionario.getUsuario().getMatricula());

        return usuarioResponseDTO;
    }

    private static FuncionarioResponseDTO getFuncionarioResponseDTO(Funcionario funcionario) {
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

    private static UsuarioDTO getUsuarioDTO(FuncionarioRequestDTO funcionarioRequestDTO) {
        UsuarioResquestDTO usuarioResquestDTO = funcionarioRequestDTO.getUsuarioResquestDTO();
        if (usuarioResquestDTO == null) {
            throw new IllegalArgumentException("Campo 'usuarioResquestDTO' não pode ser nulo");
        }

        UsuarioDTO usuarioDTO = new UsuarioDTO();
        usuarioDTO.setMatricula(usuarioResquestDTO.getMatricula());
        usuarioDTO.setSenha(usuarioResquestDTO.getSenha());
        return usuarioDTO;
    }

    private static FuncionarioDTO getFuncionarioDTO(FuncionarioRequestDTO funcionarioRequestDTO) {
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