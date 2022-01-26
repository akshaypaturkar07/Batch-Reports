package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Set;

@Data
public class GrnReportDto {
    private String companyName;
    private String companyAddress;
    private String mobileNo;
    private String grnCode;
    private String grnDate;
    private String poId;
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
    private String cgstRate;
    private String sgstRate;
    private String igstRate;
    private String discPercent;
    private String freightCharge;
    private String taxAmountInWords;
    private String amountInWords;
}
