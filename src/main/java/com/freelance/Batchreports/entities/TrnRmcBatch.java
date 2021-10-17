package com.freelance.Batchreports.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

@Table(name = "trn_rmc_batch",schema = "public")
@Entity
public class TrnRmcBatch implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "trans_id", nullable = false, precision = 20)
    private BigDecimal id;

    @Column(name = "int_id", nullable = false, precision = 3)
    private BigDecimal intId;

    @Column(name = "cust_id", nullable = false, precision = 5)
    private BigDecimal custId;

    @Column(name = "plant_id", nullable = false, precision = 7)
    private BigDecimal plantId;

    @Column(name = "wo_id", nullable = false, precision = 11)
    private BigDecimal woId;

    @Column(name = "batch_no", precision = 999)
    private BigDecimal batchNo;

    @Column(name = "batch_index", precision = 11)
    private BigDecimal batchIndex;

    @Column(name = "batch_date")
    private LocalDate batchDate;

    @Column(name = "batch_time")
    private LocalTime batchTime;

    @Column(name = "batch_time_text")
    private String batchTimeText;

    @Column(name = "batch_start_time")
    private String batchStartTime;

    @Column(name = "batch_end_time")
    private String batchEndTime;

    @Column(name = "batch_year", precision = 11)
    private BigDecimal batchYear;

    @Column(name = "batcher_name")
    private String batcherName;

    @Column(name = "batcher_user_level")
    private String batcherUserLevel;

    @Column(name = "customer_code")
    private String customerCode;

    @Column(name = "recipe_code")
    private String recipeCode;

    @Column(name = "recipe_name")
    private String recipeName;

    @Column(name = "mixing_time", precision = 999)
    private BigDecimal mixingTime;

    @Column(name = "mixer_capacity", precision = 999)
    private BigDecimal mixerCapacity;

    @Column(name = "site")
    private String site;

    @Column(name = "truck_no")
    private String truckNo;

    @Column(name = "truck_driver")
    private String truckDriver;

    @Column(name = "production_qty", precision = 999)
    private BigDecimal productionQty;

    @Column(name = "ordered_qty", precision = 999)
    private BigDecimal orderedQty;

    @Column(name = "returned_qty", precision = 999)
    private BigDecimal returnedQty;

    @Column(name = "withthisload", precision = 999)
    private BigDecimal withthisload;

    @Column(name = "batch_size", precision = 999)
    private BigDecimal batchSize;

    @Column(name = "order_no")
    private String orderNo;

    @Column(name = "schedule_id")
    private String scheduleId;

    @Column(name = "gate1_target", precision = 11)
    private BigDecimal gate1Target;

    @Column(name = "gate2_target", precision = 11)
    private BigDecimal gate2Target;

    @Column(name = "gate3_target", precision = 11)
    private BigDecimal gate3Target;

    @Column(name = "gate4_target", precision = 11)
    private BigDecimal gate4Target;

    @Column(name = "gate5_target", precision = 11)
    private BigDecimal gate5Target;

    @Column(name = "gate6_target", precision = 11)
    private BigDecimal gate6Target;

    @Column(name = "cement1_target", precision = 11)
    private BigDecimal cement1Target;

    @Column(name = "cement2_target", precision = 11)
    private BigDecimal cement2Target;

    @Column(name = "cement3_target", precision = 11)
    private BigDecimal cement3Target;

    @Column(name = "cement4_target", precision = 11)
    private BigDecimal cement4Target;

    @Column(name = "filler_target", precision = 11)
    private BigDecimal fillerTarget;

    @Column(name = "water1_target", precision = 11)
    private BigDecimal water1Target;

    @Column(name = "slurry_target", precision = 11)
    private BigDecimal slurryTarget;

    @Column(name = "water2_target", precision = 11)
    private BigDecimal water2Target;

    @Column(name = "silica_target", precision = 11)
    private BigDecimal silicaTarget;

    @Column(name = "adm1_target1", precision = 999)
    private BigDecimal adm1Target1;

    @Column(name = "adm1_target2", precision = 999)
    private BigDecimal adm1Target2;

    @Column(name = "adm2_target1", precision = 999)
    private BigDecimal adm2Target1;

    @Column(name = "adm2_target2", precision = 999)
    private BigDecimal adm2Target2;

    public TrnRmcBatch() {
    }

    public TrnRmcBatch(BigDecimal id, BigDecimal intId, BigDecimal custId, BigDecimal plantId, BigDecimal woId, BigDecimal batchNo, BigDecimal batchIndex, LocalDate batchDate, LocalTime batchTime, String batchTimeText, String batchStartTime, String batchEndTime, BigDecimal batchYear, String batcherName, String batcherUserLevel, String customerCode, String recipeCode, String recipeName, BigDecimal mixingTime, BigDecimal mixerCapacity, String site, String truckNo, String truckDriver, BigDecimal productionQty, BigDecimal orderedQty, BigDecimal returnedQty, BigDecimal withthisload, BigDecimal batchSize, String orderNo, String scheduleId, BigDecimal gate1Target, BigDecimal gate2Target, BigDecimal gate3Target, BigDecimal gate4Target, BigDecimal gate5Target, BigDecimal gate6Target, BigDecimal cement1Target, BigDecimal cement2Target, BigDecimal cement3Target, BigDecimal cement4Target, BigDecimal fillerTarget, BigDecimal water1Target, BigDecimal slurryTarget, BigDecimal water2Target, BigDecimal silicaTarget, BigDecimal adm1Target1, BigDecimal adm1Target2, BigDecimal adm2Target1, BigDecimal adm2Target2) {
        this.id = id;
        this.intId = intId;
        this.custId = custId;
        this.plantId = plantId;
        this.woId = woId;
        this.batchNo = batchNo;
        this.batchIndex = batchIndex;
        this.batchDate = batchDate;
        this.batchTime = batchTime;
        this.batchTimeText = batchTimeText;
        this.batchStartTime = batchStartTime;
        this.batchEndTime = batchEndTime;
        this.batchYear = batchYear;
        this.batcherName = batcherName;
        this.batcherUserLevel = batcherUserLevel;
        this.customerCode = customerCode;
        this.recipeCode = recipeCode;
        this.recipeName = recipeName;
        this.mixingTime = mixingTime;
        this.mixerCapacity = mixerCapacity;
        this.site = site;
        this.truckNo = truckNo;
        this.truckDriver = truckDriver;
        this.productionQty = productionQty;
        this.orderedQty = orderedQty;
        this.returnedQty = returnedQty;
        this.withthisload = withthisload;
        this.batchSize = batchSize;
        this.orderNo = orderNo;
        this.scheduleId = scheduleId;
        this.gate1Target = gate1Target;
        this.gate2Target = gate2Target;
        this.gate3Target = gate3Target;
        this.gate4Target = gate4Target;
        this.gate5Target = gate5Target;
        this.gate6Target = gate6Target;
        this.cement1Target = cement1Target;
        this.cement2Target = cement2Target;
        this.cement3Target = cement3Target;
        this.cement4Target = cement4Target;
        this.fillerTarget = fillerTarget;
        this.water1Target = water1Target;
        this.slurryTarget = slurryTarget;
        this.water2Target = water2Target;
        this.silicaTarget = silicaTarget;
        this.adm1Target1 = adm1Target1;
        this.adm1Target2 = adm1Target2;
        this.adm2Target1 = adm2Target1;
        this.adm2Target2 = adm2Target2;
    }

    public BigDecimal getAdm2Target2() {
        return adm2Target2;
    }

    public void setAdm2Target2(BigDecimal adm2Target2) {
        this.adm2Target2 = adm2Target2;
    }

    public BigDecimal getAdm2Target1() {
        return adm2Target1;
    }

    public void setAdm2Target1(BigDecimal adm2Target1) {
        this.adm2Target1 = adm2Target1;
    }

    public BigDecimal getAdm1Target2() {
        return adm1Target2;
    }

    public void setAdm1Target2(BigDecimal adm1Target2) {
        this.adm1Target2 = adm1Target2;
    }

    public BigDecimal getAdm1Target1() {
        return adm1Target1;
    }

    public void setAdm1Target1(BigDecimal adm1Target1) {
        this.adm1Target1 = adm1Target1;
    }

    public BigDecimal getSilicaTarget() {
        return silicaTarget;
    }

    public void setSilicaTarget(BigDecimal silicaTarget) {
        this.silicaTarget = silicaTarget;
    }

    public BigDecimal getWater2Target() {
        return water2Target;
    }

    public void setWater2Target(BigDecimal water2Target) {
        this.water2Target = water2Target;
    }

    public BigDecimal getSlurryTarget() {
        return slurryTarget;
    }

    public void setSlurryTarget(BigDecimal slurryTarget) {
        this.slurryTarget = slurryTarget;
    }

    public BigDecimal getWater1Target() {
        return water1Target;
    }

    public void setWater1Target(BigDecimal water1Target) {
        this.water1Target = water1Target;
    }

    public BigDecimal getFillerTarget() {
        return fillerTarget;
    }

    public void setFillerTarget(BigDecimal fillerTarget) {
        this.fillerTarget = fillerTarget;
    }

    public BigDecimal getCement4Target() {
        return cement4Target;
    }

    public void setCement4Target(BigDecimal cement4Target) {
        this.cement4Target = cement4Target;
    }

    public BigDecimal getCement3Target() {
        return cement3Target;
    }

    public void setCement3Target(BigDecimal cement3Target) {
        this.cement3Target = cement3Target;
    }

    public BigDecimal getCement2Target() {
        return cement2Target;
    }

    public void setCement2Target(BigDecimal cement2Target) {
        this.cement2Target = cement2Target;
    }

    public BigDecimal getCement1Target() {
        return cement1Target;
    }

    public void setCement1Target(BigDecimal cement1Target) {
        this.cement1Target = cement1Target;
    }

    public BigDecimal getGate6Target() {
        return gate6Target;
    }

    public void setGate6Target(BigDecimal gate6Target) {
        this.gate6Target = gate6Target;
    }

    public BigDecimal getGate5Target() {
        return gate5Target;
    }

    public void setGate5Target(BigDecimal gate5Target) {
        this.gate5Target = gate5Target;
    }

    public BigDecimal getGate4Target() {
        return gate4Target;
    }

    public void setGate4Target(BigDecimal gate4Target) {
        this.gate4Target = gate4Target;
    }

    public BigDecimal getGate3Target() {
        return gate3Target;
    }

    public void setGate3Target(BigDecimal gate3Target) {
        this.gate3Target = gate3Target;
    }

    public BigDecimal getGate2Target() {
        return gate2Target;
    }

    public void setGate2Target(BigDecimal gate2Target) {
        this.gate2Target = gate2Target;
    }

    public BigDecimal getGate1Target() {
        return gate1Target;
    }

    public void setGate1Target(BigDecimal gate1Target) {
        this.gate1Target = gate1Target;
    }

    public String getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(String scheduleId) {
        this.scheduleId = scheduleId;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public BigDecimal getBatchSize() {
        return batchSize;
    }

    public void setBatchSize(BigDecimal batchSize) {
        this.batchSize = batchSize;
    }

    public BigDecimal getWiththisload() {
        return withthisload;
    }

    public void setWiththisload(BigDecimal withthisload) {
        this.withthisload = withthisload;
    }

    public BigDecimal getReturnedQty() {
        return returnedQty;
    }

    public void setReturnedQty(BigDecimal returnedQty) {
        this.returnedQty = returnedQty;
    }

    public BigDecimal getOrderedQty() {
        return orderedQty;
    }

    public void setOrderedQty(BigDecimal orderedQty) {
        this.orderedQty = orderedQty;
    }

    public BigDecimal getProductionQty() {
        return productionQty;
    }

    public void setProductionQty(BigDecimal productionQty) {
        this.productionQty = productionQty;
    }

    public String getTruckDriver() {
        return truckDriver;
    }

    public void setTruckDriver(String truckDriver) {
        this.truckDriver = truckDriver;
    }

    public String getTruckNo() {
        return truckNo;
    }

    public void setTruckNo(String truckNo) {
        this.truckNo = truckNo;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public BigDecimal getMixerCapacity() {
        return mixerCapacity;
    }

    public void setMixerCapacity(BigDecimal mixerCapacity) {
        this.mixerCapacity = mixerCapacity;
    }

    public BigDecimal getMixingTime() {
        return mixingTime;
    }

    public void setMixingTime(BigDecimal mixingTime) {
        this.mixingTime = mixingTime;
    }

    public String getRecipeName() {
        return recipeName;
    }

    public void setRecipeName(String recipeName) {
        this.recipeName = recipeName;
    }

    public String getRecipeCode() {
        return recipeCode;
    }

    public void setRecipeCode(String recipeCode) {
        this.recipeCode = recipeCode;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getBatcherUserLevel() {
        return batcherUserLevel;
    }

    public void setBatcherUserLevel(String batcherUserLevel) {
        this.batcherUserLevel = batcherUserLevel;
    }

    public String getBatcherName() {
        return batcherName;
    }

    public void setBatcherName(String batcherName) {
        this.batcherName = batcherName;
    }

    public BigDecimal getBatchYear() {
        return batchYear;
    }

    public void setBatchYear(BigDecimal batchYear) {
        this.batchYear = batchYear;
    }

    public String getBatchEndTime() {
        return batchEndTime;
    }

    public void setBatchEndTime(String batchEndTime) {
        this.batchEndTime = batchEndTime;
    }

    public String getBatchStartTime() {
        return batchStartTime;
    }

    public void setBatchStartTime(String batchStartTime) {
        this.batchStartTime = batchStartTime;
    }

    public String getBatchTimeText() {
        return batchTimeText;
    }

    public void setBatchTimeText(String batchTimeText) {
        this.batchTimeText = batchTimeText;
    }

    public LocalTime getBatchTime() {
        return batchTime;
    }

    public void setBatchTime(LocalTime batchTime) {
        this.batchTime = batchTime;
    }

    public LocalDate getBatchDate() {
        return batchDate;
    }

    public void setBatchDate(LocalDate batchDate) {
        this.batchDate = batchDate;
    }

    public BigDecimal getBatchIndex() {
        return batchIndex;
    }

    public void setBatchIndex(BigDecimal batchIndex) {
        this.batchIndex = batchIndex;
    }

    public BigDecimal getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(BigDecimal batchNo) {
        this.batchNo = batchNo;
    }

    public BigDecimal getWoId() {
        return woId;
    }

    public void setWoId(BigDecimal woId) {
        this.woId = woId;
    }

    public BigDecimal getPlantId() {
        return plantId;
    }

    public void setPlantId(BigDecimal plantId) {
        this.plantId = plantId;
    }

    public BigDecimal getCustId() {
        return custId;
    }

    public void setCustId(BigDecimal custId) {
        this.custId = custId;
    }

    public BigDecimal getIntId() {
        return intId;
    }

    public void setIntId(BigDecimal intId) {
        this.intId = intId;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }
}