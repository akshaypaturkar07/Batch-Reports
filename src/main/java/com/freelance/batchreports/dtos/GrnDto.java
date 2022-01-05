package com.freelance.batchreports.dtos;

import lombok.Data;

import java.util.List;

@Data
public class GrnDto {
    private String compName;
    private String compAddress;
    private String phoneNo;
    private String grnCode;
    private String grnDate;
    private Long poNo;
    private String poDate;
    private String branchName;
    private String challanNo;
    private String vehicleNo;
    private String driverNo;
    private String supplierName;
    private String supplierAddress;
    private String supplierGstNo;
    private String consigneeName;
    private String consigneeAddress;
    private String consigneeDetailsGstNo;
    private List<Items> itemsList;
    private Double cgst;
    private Double sgst;
    private Double igst;
    private Double total_Amt;
}