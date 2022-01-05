package com.freelance.batchreports.dtos;

import lombok.Data;

import java.util.List;

@Data
public class TaxInvoiceDto {
    private String compName;
    private String compAddress;
    private String phoneNo;
    private String gstNo;
    private Long invoiceNo;
    private String invoiceDate;
    private String deliveryDate;
    private String deliveryNo;
    private String vehicleNo;
    private String driverName;
    private String poNo;
    private String branchName;
    private String irnNo;
    private Long ackNo;
    private String ackDate;
    private String vendorName;
    private String vendorAddress;
    private String venodrGstNo;
    private String consinee;
    private String site;
    List<GoodsDetails> goodsDetailsList;
    private String total;
    private String bankName;
    private Long acctNo;
    private String vendorBranchName;
    private String ifscCode;
    private String beneName;
    private String compPanNo;
    private Double cgst;
    private Double sgst;
    private Double igst;
    private Double total_Amt;


}
