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
    private BigDecimal cement2Actual;
    private BigDecimal filler1Actual;
    private BigDecimal water1Actual;
    private BigDecimal water2Actual;
    private BigDecimal silicaActual;
    private BigDecimal adm1Actual1;
    private BigDecimal adm2Actual1;



    private BigDecimal gate1TotalSet;
    private BigDecimal gate2TotalSet;
    private BigDecimal gate3TotalSet;
    private BigDecimal gate4TotalSet;
    private BigDecimal gate5TotalSet;
    private BigDecimal cement1TotalSet;
    private BigDecimal cement2TotalSet;
    private BigDecimal fillerTotalSet;
    private BigDecimal water1TotalSet;
    private BigDecimal water2TotalSet;
    private BigDecimal silicaTotalSet;
    private BigDecimal adm1TotalSet;
    private BigDecimal adm2TotalSet;

    private BigDecimal gate1ActualSum;
    private BigDecimal gate2ActualSum;
    private BigDecimal gate3ActualSum;
    private BigDecimal gate4ActualSum;
    private BigDecimal gate5ActualSum;
    private BigDecimal cement1ActualSum;
    private BigDecimal cement2ActualSum;
    private BigDecimal filler1ActualSum;
    private BigDecimal water1ActualSum;
    private BigDecimal water2ActualSum;
    private BigDecimal silicaActualSum;
    private BigDecimal adm1Actual1Sum;
    private BigDecimal adm2Actual1Sum;
}
