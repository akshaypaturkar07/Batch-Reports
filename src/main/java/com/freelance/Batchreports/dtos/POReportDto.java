package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Set;

@Data
public class POReportDto {
    private String companyName;
    private String companyAddress;
    private String email;
    private String mobileNo;
    private String poId;
    private String poDate;
    private String branchName;
    private String quoteNo;
    private String quoteDate;
    private String modeOfShipment;
    private String deliveryName;
    private String deliveryAddress;
    private String siteContactNo;
    private String siteContact;
    private String siteEmail;
    private String siteGstNo;
    private String vendorCode;
    private String vendorName;
    private String vendorAddress;
    private String supplierGstNo;
    private String contactPersonName;
    private String vendorContactNo;
    private String deliveryShipFrom;
    private BigDecimal cgstRate1;
    private BigDecimal sgstRate1;
    private BigDecimal cgstRate2;
    private BigDecimal sgstRate2;
    private BigDecimal freightCharge;
    private Set<POItem> poItemSet;

}
