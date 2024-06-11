package com.emanu.Repository;

import com.emanu.Domain.Funcionario;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
@ApplicationScoped
public class FuncionarioRepository implements PanacheRepository<Funcionario> {
}
