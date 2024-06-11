package com.emanu.Resource;

import com.emanu.DTO.Login;
import com.emanu.DTO.LoginResponse;
import com.emanu.DTO.Mapper.DtoToDomain;
import com.emanu.DTO.Mapper.DtoToDto;
import com.emanu.Domain.Funcionario;
import com.emanu.UseCase.GerenciarFuncionario;
import com.emanu.UseCase.InformacoesFuncionario;
import jakarta.inject.Inject;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;
import lombok.Getter;

import java.util.Optional;

@Path("usuarios")
public class UsuarioResource {

    @Inject
    GerenciarFuncionario gerenciarFuncionario;

    @Inject
    InformacoesFuncionario informacoesFuncionario;

    @Inject
    DtoToDto dtoToDto;

    @Inject
    DtoToDomain dtoToDomain;

    @GET
    public Response getUsuarios(){
        return Response.status(Response.Status.OK).entity(informacoesFuncionario.getUsuarios()).build();
    }

    @POST
    public Response validarLogin(Login login) {
        Optional<Funcionario> funcionarioExiste = informacoesFuncionario.getFuncionarios().stream().
                filter(f -> f.getUsuario().getMatricula().equals(login.getMatricula()))
                .findFirst();

        if (funcionarioExiste.isEmpty()) {
            return Response.status(Response.Status.UNAUTHORIZED).entity("Usuario ou senha incorretos").build();
        }

        Funcionario funcionario = funcionarioExiste.get();
        if (!funcionario.getUsuario().getSenha().equals(login.getSenha())) {
            return Response.status(Response.Status.UNAUTHORIZED).entity("Usuario ou senha incorretos").build();
        }

        LoginResponse response = new LoginResponse();
        response.setId(funcionario.getId());
        response.setMatricula(funcionario.getUsuario().getMatricula());
        response.setSenha(funcionario.getUsuario().getSenha());
        response.setTipoUsuario(funcionario.getUsuario().getTipoUsuario());

        return Response.status(Response.Status.OK).entity(response).build();
    }
}
