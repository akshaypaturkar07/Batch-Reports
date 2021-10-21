package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Data
public class BatchReportDto {
    private Date batchDate;
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
    private List<BatchDetailDto> batchDetailDtoList;
}
