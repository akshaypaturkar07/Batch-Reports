package com.freelance.Batchreports.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.Instant;

@Table(name = "mst_customer_vendor")
@Entity
public class MstCustomerVendor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cust_vendor_id", nullable = false, precision = 7)
    private BigDecimal id;

    @Column(name = "cust_vendor_name", nullable = false, length = 100)
    private String custVendorName;

    @Column(name = "cust_vendor_addr", nullable = false, length = 250)
    private String custVendorAddr;

    @Column(name = "cust_vendor_lat", precision = 10, scale = 7)
    private BigDecimal custVendorLat;

    @Column(name = "cust_vendor_long", precision = 10, scale = 7)
    private BigDecimal custVendorLong;

    @Column(name = "cust_vendor_city", nullable = false, length = 50)
    private String custVendorCity;

    @Column(name = "cust_vendor_state_id", nullable = false, precision = 2)
    private BigDecimal custVendorStateId;

    @Column(name = "pin_code", nullable = false, length = 6)
    private String pinCode;

    @Column(name = "ll_no1", length = 15)
    private String llNo1;

    @Column(name = "ll_no2", length = 15)
    private String llNo2;

    @Column(name = "mob_no1", length = 15)
    private String mobNo1;

    @Column(name = "mob_no2", length = 15)
    private String mobNo2;

    @Column(name = "wa_no1", length = 15)
    private String waNo1;

    @Column(name = "wa_no2", length = 15)
    private String waNo2;

    @Column(name = "email_id1", length = 50)
    private String emailId1;

    @Column(name = "email_id2", length = 50)
    private String emailId2;

    @Column(name = "cust_vendor_url", length = 100)
    private String custVendorUrl;

    @Column(name = "fb_handle", length = 100)
    private String fbHandle;

    @Column(name = "twr_handle", length = 100)
    private String twrHandle;

    @Column(name = "pan_no", length = 10)
    private String panNo;

    @Column(name = "gst_no", length = 15)
    private String gstNo;

    @Column(name = "ifsc_code", length = 15)
    private String ifscCode;

    @Column(name = "bank_acc_no", length = 15)
    private String bankAccNo;

    @Column(name = "rec_status", nullable = false, precision = 1)
    private BigDecimal recStatus;

    @Column(name = "action_by", nullable = false, precision = 3)
    private BigDecimal actionBy;

    @Column(name = "action_on", nullable = false)
    private Instant actionOn;

    @Column(name = "hc_id", precision = 2)
    private BigDecimal hcId;

    @Column(name = "bank_name", length = 50)
    private String bankName;

    @Column(name = "cust_vendor_code", length = 15)
    private String custVendorCode;

    @Column(name = "cust_vendor_firm_name", length = 100)
    private String custVendorFirmName;

    @Column(name = "cust_vendor_firm_addr", length = 250)
    private String custVendorFirmAddr;

    @Column(name = "credit_limit", precision = 13, scale = 2)
    private BigDecimal creditLimit;

    @Column(name = "int_id", nullable = false, precision = 2)
    private BigDecimal intId;

    @Column(name = "sap_code", length = 20)
    private String sapCode;

    @Column(name = "sap_id", precision = 8)
    private BigDecimal sapId;

    @Column(name = "plant_id", precision = 5)
    private BigDecimal plantId;

    @Column(name = "insertion_type", length = 1)
    private String insertionType;

    @Lob
    @Column(name = "file_path")
    private String filePath;

    @Column(name = "is_customer")
    private Integer isCustomer;


    public Integer getIsCustomer() {
        return isCustomer;
    }

    public void setIsCustomer(Integer isCustomer) {
        this.isCustomer = isCustomer;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getInsertionType() {
        return insertionType;
    }

    public void setInsertionType(String insertionType) {
        this.insertionType = insertionType;
    }

    public BigDecimal getPlantId() {
        return plantId;
    }

    public void setPlantId(BigDecimal plantId) {
        this.plantId = plantId;
    }

    public BigDecimal getSapId() {
        return sapId;
    }

    public void setSapId(BigDecimal sapId) {
        this.sapId = sapId;
    }

    public String getSapCode() {
        return sapCode;
    }

    public void setSapCode(String sapCode) {
        this.sapCode = sapCode;
    }

    public BigDecimal getIntId() {
        return intId;
    }

    public void setIntId(BigDecimal intId) {
        this.intId = intId;
    }

    public BigDecimal getCreditLimit() {
        return creditLimit;
    }

    public void setCreditLimit(BigDecimal creditLimit) {
        this.creditLimit = creditLimit;
    }

    public String getCustVendorFirmAddr() {
        return custVendorFirmAddr;
    }

    public void setCustVendorFirmAddr(String custVendorFirmAddr) {
        this.custVendorFirmAddr = custVendorFirmAddr;
    }

    public String getCustVendorFirmName() {
        return custVendorFirmName;
    }

    public void setCustVendorFirmName(String custVendorFirmName) {
        this.custVendorFirmName = custVendorFirmName;
    }

    public String getCustVendorCode() {
        return custVendorCode;
    }

    public void setCustVendorCode(String custVendorCode) {
        this.custVendorCode = custVendorCode;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public BigDecimal getHcId() {
        return hcId;
    }

    public void setHcId(BigDecimal hcId) {
        this.hcId = hcId;
    }

    public Instant getActionOn() {
        return actionOn;
    }

    public void setActionOn(Instant actionOn) {
        this.actionOn = actionOn;
    }

    public BigDecimal getActionBy() {
        return actionBy;
    }

    public void setActionBy(BigDecimal actionBy) {
        this.actionBy = actionBy;
    }

    public BigDecimal getRecStatus() {
        return recStatus;
    }

    public void setRecStatus(BigDecimal recStatus) {
        this.recStatus = recStatus;
    }

    public String getBankAccNo() {
        return bankAccNo;
    }

    public void setBankAccNo(String bankAccNo) {
        this.bankAccNo = bankAccNo;
    }

    public String getIfscCode() {
        return ifscCode;
    }

    public void setIfscCode(String ifscCode) {
        this.ifscCode = ifscCode;
    }

    public String getGstNo() {
        return gstNo;
    }

    public void setGstNo(String gstNo) {
        this.gstNo = gstNo;
    }

    public String getPanNo() {
        return panNo;
    }

    public void setPanNo(String panNo) {
        this.panNo = panNo;
    }

    public String getTwrHandle() {
        return twrHandle;
    }

    public void setTwrHandle(String twrHandle) {
        this.twrHandle = twrHandle;
    }

    public String getFbHandle() {
        return fbHandle;
    }

    public void setFbHandle(String fbHandle) {
        this.fbHandle = fbHandle;
    }

    public String getCustVendorUrl() {
        return custVendorUrl;
    }

    public void setCustVendorUrl(String custVendorUrl) {
        this.custVendorUrl = custVendorUrl;
    }

    public String getEmailId2() {
        return emailId2;
    }

    public void setEmailId2(String emailId2) {
        this.emailId2 = emailId2;
    }

    public String getEmailId1() {
        return emailId1;
    }

    public void setEmailId1(String emailId1) {
        this.emailId1 = emailId1;
    }

    public String getWaNo2() {
        return waNo2;
    }

    public void setWaNo2(String waNo2) {
        this.waNo2 = waNo2;
    }

    public String getWaNo1() {
        return waNo1;
    }

    public void setWaNo1(String waNo1) {
        this.waNo1 = waNo1;
    }

    public String getMobNo2() {
        return mobNo2;
    }

    public void setMobNo2(String mobNo2) {
        this.mobNo2 = mobNo2;
    }

    public String getMobNo1() {
        return mobNo1;
    }

    public void setMobNo1(String mobNo1) {
        this.mobNo1 = mobNo1;
    }

    public String getLlNo2() {
        return llNo2;
    }

    public void setLlNo2(String llNo2) {
        this.llNo2 = llNo2;
    }

    public String getLlNo1() {
        return llNo1;
    }

    public void setLlNo1(String llNo1) {
        this.llNo1 = llNo1;
    }

    public String getPinCode() {
        return pinCode;
    }

    public void setPinCode(String pinCode) {
        this.pinCode = pinCode;
    }

    public BigDecimal getCustVendorStateId() {
        return custVendorStateId;
    }

    public void setCustVendorStateId(BigDecimal custVendorStateId) {
        this.custVendorStateId = custVendorStateId;
    }

    public String getCustVendorCity() {
        return custVendorCity;
    }

    public void setCustVendorCity(String custVendorCity) {
        this.custVendorCity = custVendorCity;
    }

    public BigDecimal getCustVendorLong() {
        return custVendorLong;
    }

    public void setCustVendorLong(BigDecimal custVendorLong) {
        this.custVendorLong = custVendorLong;
    }

    public BigDecimal getCustVendorLat() {
        return custVendorLat;
    }

    public void setCustVendorLat(BigDecimal custVendorLat) {
        this.custVendorLat = custVendorLat;
    }

    public String getCustVendorAddr() {
        return custVendorAddr;
    }

    public void setCustVendorAddr(String custVendorAddr) {
        this.custVendorAddr = custVendorAddr;
    }

    public String getCustVendorName() {
        return custVendorName;
    }

    public void setCustVendorName(String custVendorName) {
        this.custVendorName = custVendorName;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }
}