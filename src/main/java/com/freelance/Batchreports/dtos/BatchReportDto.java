package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class BatchReportDto {
    private String batchDate;
    private String batchStartTime;
    private String batchEndTime;
    private BigDecimal batchNo;
    private String site;
    private String recipeCode;
    private String recipeName;
    private String truckNo;
    private String truckDriver;
    private String orderNo;
    private String batcherName;
    private BigDecimal orderedQty;
    private BigDecimal productionQty;
    private BigDecimal withthisload;
    private BigDecimal mixerCapacity;
    private BigDecimal batchSize;
    private String plantRegNo;
    private String custVendorName;
    private String agg1Name;
    private String agg2Name;
    private String agg3Name;
    private String agg4Name;
    private String agg5Name;
    private String cement1Name;
    private String cement2Name;
    private String fillName;
    private String water1Name;
    private String water2Name;
    private String silicaName;
    private String admix1Name;
    private String admix2Name;
    private BigDecimal gate1Target;
    private BigDecimal gate2Target;
    private BigDecimal gate3Target;
    private BigDecimal gate4Target;
    private BigDecimal gate5Target;
    private BigDecimal cement1Target;
    private BigDecimal cement2Target;
    private BigDecimal fillerTarget;
    private BigDecimal water1Target;
    private BigDecimal water2Target;
    private BigDecimal silicaTarget;
    private BigDecimal adm1Target1;
    private BigDecimal adm1Target2;

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

    private String plantName;
    private List<BatchDetailDto> batchDetailDtoList;
}
