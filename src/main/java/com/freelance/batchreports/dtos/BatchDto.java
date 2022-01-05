package com.freelance.batchreports.dtos;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class BatchDto {
    private LocalDate batchDate;
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
}
