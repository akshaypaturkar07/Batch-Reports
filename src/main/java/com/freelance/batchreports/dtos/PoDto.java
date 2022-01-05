package com.freelance.batchreports.dtos;

import lombok.Data;

import java.util.List;

@Data
public class PoDto {
    private String compName;
    private String compAddress;
    private String phoneNo;
    private Long poNo;
    private String poDate;
    private String branchName;
    private String quoteNo;
    private String quoteDate;
    private String shipmentMode;
    private String deliveryAddress;
    private String siteContactNo;
    private String contactNo;
    private String email;
    private String gstNo;
    private String vendorCode;
    private String vendorName;
    private String suppliedGstNo;
    private String contactPersonName;
    private String mobileNo;
    private String deliveryShipFrom;
    private List<ItemDetails> itemDetailsList;
    private Double cgst;
    private Double sgst;
    private Double igst;
    private Double total_Amt;
}
