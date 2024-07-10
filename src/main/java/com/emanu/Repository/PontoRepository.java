package com.emanu.Repository;

import com.emanu.DTO.PontoResponseDTO;
import com.emanu.DTO.PontosDoMesDTO;
import com.emanu.Domain.DiaDaSemana;
import com.emanu.Domain.Funcionario;
import com.emanu.Domain.Ponto;
import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;
import java.util.TreeMap;

@ApplicationScoped
public class PontoRepository implements PanacheRepository<Ponto> {

    public List<PontoResponseDTO> pontosDoFuncionario(Funcionario funcionario) {
        return listAll().stream()
                .filter(p -> p.getFuncionario().getUsuario().getMatricula().equals(funcionario.getUsuario().getMatricula()))
                .map(this::PontoToPontoResponseDTO).toList();
    }

    public List<PontoResponseDTO> pontosDoFuncionarioNoDia(Funcionario funcionario, LocalDate dia) {
        return listAll().stream()
                .filter(p -> p.getFuncionario().getUsuario().getMatricula().equals(funcionario.getUsuario().getMatricula()) && p.getData().equals(LocalDate.now()))
                .map(this::PontoToPontoResponseDTO).toList();
    }

    public Duration calcularSaldoDia(Funcionario funcionario, LocalDate data) {
        List<Ponto> pontosDoDia = listAll().stream()
                .filter(p -> p.getFuncionario().getUsuario().getMatricula().equals(funcionario.getUsuario().getMatricula()) && p.getData().equals(data))
                .sorted(Comparator.comparing(Ponto::getHora))
                .toList();

        if (pontosDoDia.isEmpty()) return Duration.ZERO;

        Duration saldo;
        switch (pontosDoDia.size()) {
            case 1:
                saldo = Duration.between(pontosDoDia.get(0).getHora(), LocalTime.now());
                break;
            case 2, 3:
                saldo = Duration.between(pontosDoDia.get(0).getHora(), pontosDoDia.get(1).getHora());
                break;
            case 4:
                Duration parte1 = Duration.between(pontosDoDia.get(0).getHora(), pontosDoDia.get(1).getHora());
                Duration parte2 = Duration.between(pontosDoDia.get(2).getHora(), pontosDoDia.get(3).getHora());
                saldo = parte1.plus(parte2);
                break;
            default:
                saldo = Duration.ZERO;
                break;
        }
        return saldo;
    }

    public static Duration calcularSaldoDia1(Funcionario funcionario, List<Ponto> pontos, LocalDate data) {
        List<Ponto> pontosDoDia = pontos.stream()
                .filter(p -> p.getFuncionario().getUsuario().getMatricula().equals(funcionario.getUsuario().getMatricula()) && p.getData().equals(data))
                .sorted(Comparator.comparing(Ponto::getHora))
                .toList();

        if (pontosDoDia.isEmpty()) return Duration.ZERO;

        Duration saldo;
        switch (pontosDoDia.size()) {
            case 1:
                saldo = Duration.between(pontosDoDia.get(0).getHora(), LocalTime.now());
                break;
            case 2, 3:
                saldo = Duration.between(pontosDoDia.get(0).getHora(), pontosDoDia.get(1).getHora());
                break;
            case 4:
                Duration parte1 = Duration.between(pontosDoDia.get(0).getHora(), pontosDoDia.get(1).getHora());
                Duration parte2 = Duration.between(pontosDoDia.get(2).getHora(), pontosDoDia.get(3).getHora());
                saldo = parte1.plus(parte2);
                break;
            default:
                saldo = Duration.ZERO;
                break;
        }
        return saldo;
    }

    public List<PontosDoMesDTO> calcularSaldoMes(Funcionario funcionario, int mes, int ano) {
        List<PontosDoMesDTO> saldoMes = new ArrayList<>();
        AtomicReference<Duration> saldoTotal = new AtomicReference<>(Duration.ZERO);

        Map<LocalDate, List<Ponto>> pontosAgrupados = listAll().stream()
                .filter(p -> p.getFuncionario().getUsuario().getMatricula().equals(funcionario.getUsuario().getMatricula()) && p.getData().getMonthValue() == mes && p.getData().getYear() == ano)
                .collect(Collectors.groupingBy(Ponto::getData, TreeMap::new, Collectors.toList()));


        pontosAgrupados.forEach((data, pontosDoDia) -> {
            Duration horasEsperadas = Duration.between(funcionario.getEntrada(), funcionario.getIntervaloEntrada()).plus(Duration.between(funcionario.getIntervaloSaida(), funcionario.getSaida()));
            Duration horasTrabalhadas = calcularSaldoDia1(funcionario, pontosDoDia, data);
            Duration saldoDoDia = horasTrabalhadas.minus(horasEsperadas);
            System.out.println(saldoDoDia + " " + horasTrabalhadas + " " + horasEsperadas);
            saldoTotal.set(saldoTotal.get().plus(saldoDoDia));
            saldoMes.add(new PontosDoMesDTO(LocalTime.MIDNIGHT.plus(horasTrabalhadas), data, formatDuration(saldoTotal.get())));
        });

        return saldoMes;
    }

    public String calcularSaldoTotal(Funcionario funcionario) {
        AtomicReference<Duration> saldoTotal = new AtomicReference<>(Duration.ZERO);

        Map<LocalDate, List<Ponto>> pontosAgrupados = listAll().stream()
                .filter(p -> p.getFuncionario().getUsuario().getMatricula().equals(funcionario.getUsuario().getMatricula()))
                .collect(Collectors.groupingBy(Ponto::getData, TreeMap::new, Collectors.toList()));


        pontosAgrupados.forEach((data, pontosDoDia) -> {
            Duration horasEsperadas = Duration.between(funcionario.getEntrada(), funcionario.getIntervaloEntrada()).plus(Duration.between(funcionario.getIntervaloSaida(), funcionario.getSaida()));
            Duration horasTrabalhadas = calcularSaldoDia1(funcionario, pontosDoDia, data);
            Duration saldoDoDia = horasTrabalhadas.minus(horasEsperadas);
            System.out.println(saldoDoDia + " " + horasTrabalhadas + " " + horasEsperadas);
            saldoTotal.set(saldoTotal.get().plus(saldoDoDia));
        });

        return formatDuration(saldoTotal.get());
    }

    private static String formatDuration(Duration duration) {
        long seconds = duration.getSeconds();
        boolean negative = seconds < 0;
        seconds = Math.abs(seconds);

        long hours = seconds / 3600;
        long minutes = (seconds % 3600) / 60;
        long secs = seconds % 60;

        return String.format("%s%02d:%02d:%02d", negative ? "-" : "", hours, minutes, secs);
    }

    private PontoResponseDTO PontoToPontoResponseDTO(Ponto p) {
        PontoResponseDTO pontoResponseDTO = new PontoResponseDTO();
        pontoResponseDTO.setFuncionarioId(p.getFuncionario().getId());
        pontoResponseDTO.setHora(p.getHora());
        pontoResponseDTO.setData(p.getData());
        pontoResponseDTO.setDiaDaSemana(DiaDaSemana.fromDayOfWeek(p.getData().getDayOfWeek()));

        return pontoResponseDTO;
    }
}
