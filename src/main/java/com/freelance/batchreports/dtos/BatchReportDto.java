package com.freelance.batchreports.dtos;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Set;

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

    private BigDecimal gate1;
    private BigDecimal gate2;
    private BigDecimal gate3;
    private BigDecimal gate4;
    private BigDecimal gate5;
    private BigDecimal cement1;
    private BigDecimal cement2;
    private BigDecimal filler;
    private BigDecimal water1;
    private BigDecimal water2;
    private BigDecimal silica;
    private BigDecimal adm1;
    private BigDecimal adm2;

    private String plantName;
    private Set<BatchDetailDto> batchDetailDtoList;
}
