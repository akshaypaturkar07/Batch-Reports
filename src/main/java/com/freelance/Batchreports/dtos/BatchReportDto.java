package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.math.BigDecimal;
import java.sql.Date;
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
    private String plantName;
    private List<BatchDetailDto> batchDetailDtoList;
}
