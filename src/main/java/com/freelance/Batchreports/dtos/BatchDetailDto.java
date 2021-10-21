package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class BatchDetailDto {
    private BigDecimal gate1Actual;
    private BigDecimal gate2Actual;
    private BigDecimal gate3Actual;
    private BigDecimal gate4Actual;
    private BigDecimal gate5Actual;
    private BigDecimal cement1Actual;
    private BigDecimal filler1Actual;
    private BigDecimal water1Actual;
    private BigDecimal water1Target;
    private BigDecimal water2Actual;
    private BigDecimal silicaActual;
    private BigDecimal adm1Actual1;
    private BigDecimal adm2Actual1;
}
