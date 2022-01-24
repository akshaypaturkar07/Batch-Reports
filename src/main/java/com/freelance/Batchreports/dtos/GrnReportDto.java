package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.util.Set;

@Data
public class GrnReportDto {
    private String companyName;
    private String companyAddress;
    private String mobileNo;
    private String grnCode;
    private String grnDate;
    private Integer poId;
    private String poDate;
    private String plantName;
    private String refChallanNo;
    private String vehicleNo;
    private String custVendorName;
    private String custVendorAddress;
    private String supplierGstNo;
    private String consineeGstNo;
    private String stateName;
    private String stateCode;
    private Set<ItemDto> itemList;
    private Integer cgstRate;
    private Integer sgstRate;
    private Integer igstRate;
    private Double discPercent;
    private Double freightCharge;
    private String taxAmountInWords;
    private String amountInWords;
}
