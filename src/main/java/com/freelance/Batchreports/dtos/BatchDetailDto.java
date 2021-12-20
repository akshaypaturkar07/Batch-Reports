package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Objects;

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
    private BigDecimal water1correction;



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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BatchDetailDto that = (BatchDetailDto) o;
        return Objects.equals(gate1Actual, that.gate1Actual) && Objects.equals(gate2Actual, that.gate2Actual) && Objects.equals(gate3Actual, that.gate3Actual) && Objects.equals(gate4Actual, that.gate4Actual) && Objects.equals(gate5Actual, that.gate5Actual) && Objects.equals(cement1Actual, that.cement1Actual) && Objects.equals(cement2Actual, that.cement2Actual) && Objects.equals(filler1Actual, that.filler1Actual) && Objects.equals(water1Actual, that.water1Actual) && Objects.equals(water2Actual, that.water2Actual) && Objects.equals(silicaActual, that.silicaActual) && Objects.equals(adm1Actual1, that.adm1Actual1) && Objects.equals(adm2Actual1, that.adm2Actual1) && Objects.equals(water1correction, that.water1correction) && Objects.equals(gate1TotalSet, that.gate1TotalSet) && Objects.equals(gate2TotalSet, that.gate2TotalSet) && Objects.equals(gate3TotalSet, that.gate3TotalSet) && Objects.equals(gate4TotalSet, that.gate4TotalSet) && Objects.equals(gate5TotalSet, that.gate5TotalSet) && Objects.equals(cement1TotalSet, that.cement1TotalSet) && Objects.equals(cement2TotalSet, that.cement2TotalSet) && Objects.equals(fillerTotalSet, that.fillerTotalSet) && Objects.equals(water1TotalSet, that.water1TotalSet) && Objects.equals(water2TotalSet, that.water2TotalSet) && Objects.equals(silicaTotalSet, that.silicaTotalSet) && Objects.equals(adm1TotalSet, that.adm1TotalSet) && Objects.equals(adm2TotalSet, that.adm2TotalSet) && Objects.equals(gate1ActualSum, that.gate1ActualSum) && Objects.equals(gate2ActualSum, that.gate2ActualSum) && Objects.equals(gate3ActualSum, that.gate3ActualSum) && Objects.equals(gate4ActualSum, that.gate4ActualSum) && Objects.equals(gate5ActualSum, that.gate5ActualSum) && Objects.equals(cement1ActualSum, that.cement1ActualSum) && Objects.equals(cement2ActualSum, that.cement2ActualSum) && Objects.equals(filler1ActualSum, that.filler1ActualSum) && Objects.equals(water1ActualSum, that.water1ActualSum) && Objects.equals(water2ActualSum, that.water2ActualSum) && Objects.equals(silicaActualSum, that.silicaActualSum) && Objects.equals(adm1Actual1Sum, that.adm1Actual1Sum) && Objects.equals(adm2Actual1Sum, that.adm2Actual1Sum);
    }

    @Override
    public int hashCode() {
        return Objects.hash(gate1Actual, gate2Actual, gate3Actual, gate4Actual, gate5Actual, cement1Actual, cement2Actual, filler1Actual, water1Actual, water2Actual, silicaActual, adm1Actual1, adm2Actual1, water1correction, gate1TotalSet, gate2TotalSet, gate3TotalSet, gate4TotalSet, gate5TotalSet, cement1TotalSet, cement2TotalSet, fillerTotalSet, water1TotalSet, water2TotalSet, silicaTotalSet, adm1TotalSet, adm2TotalSet, gate1ActualSum, gate2ActualSum, gate3ActualSum, gate4ActualSum, gate5ActualSum, cement1ActualSum, cement2ActualSum, filler1ActualSum, water1ActualSum, water2ActualSum, silicaActualSum, adm1Actual1Sum, adm2Actual1Sum);
    }
}
