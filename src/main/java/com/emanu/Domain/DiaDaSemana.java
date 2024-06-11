package com.emanu.Domain;

import java.time.DayOfWeek;

public enum DiaDaSemana {
    SEGUNDA, TERCA, QUARTA, QUINTA, SEXTA, SABADO, DOMINGO;

    public static DiaDaSemana fromDayOfWeek(DayOfWeek dayOfWeek) {
        switch (dayOfWeek) {
            case MONDAY:
                return SEGUNDA;
            case TUESDAY:
                return TERCA;
            case WEDNESDAY:
                return QUARTA;
            case THURSDAY:
                return QUINTA;
            case FRIDAY:
                return SEXTA;
            case SATURDAY:
                return SABADO;
            case SUNDAY:
                return DOMINGO;
            default:
                throw new IllegalArgumentException("Dia da semana inválido: " + dayOfWeek);
        }
    }
}