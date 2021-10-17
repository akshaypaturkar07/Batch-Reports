package com.freelance.Batchreports.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

@Table(name = "trn_rmc_batch_detail",schema = "public")
@Entity
public class TrnRmcBatchDetail implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "trans_id", nullable = false, precision = 20)
    private BigDecimal id;

    @Column(name = "int_id", nullable = false, precision = 3)
    private BigDecimal intId;

    @Column(name = "con_id", nullable = false, precision = 5)
    private BigDecimal conId;

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

    @Column(name = "batch_year", precision = 11)
    private BigDecimal batchYear;

    @Column(name = "consistancy", precision = 11)
    private BigDecimal consistancy;

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

    @Column(name = "gate1_actual", precision = 11)
    private BigDecimal gate1Actual;

    @Column(name = "gate1_target", precision = 11)
    private BigDecimal gate1Target;

    @Column(name = "gate1_moisture", precision = 999)
    private BigDecimal gate1Moisture;

    @Column(name = "gate2_actual", precision = 11)
    private BigDecimal gate2Actual;

    @Column(name = "gate2_target", precision = 11)
    private BigDecimal gate2Target;

    @Column(name = "gate2_moisture", precision = 999)
    private BigDecimal gate2Moisture;

    @Column(name = "gate3_actual", precision = 11)
    private BigDecimal gate3Actual;

    @Column(name = "gate3_target", precision = 11)
    private BigDecimal gate3Target;

    @Column(name = "gate3_moisture", precision = 999)
    private BigDecimal gate3Moisture;

    @Column(name = "gate4_actual", precision = 11)
    private BigDecimal gate4Actual;

    @Column(name = "gate4_target", precision = 11)
    private BigDecimal gate4Target;

    @Column(name = "gate4_moisture", precision = 999)
    private BigDecimal gate4Moisture;

    @Column(name = "gate5_actual", precision = 11)
    private BigDecimal gate5Actual;

    @Column(name = "gate5_target", precision = 11)
    private BigDecimal gate5Target;

    @Column(name = "gate5_moisture", precision = 999)
    private BigDecimal gate5Moisture;

    @Column(name = "gate6_actual", precision = 11)
    private BigDecimal gate6Actual;

    @Column(name = "gate6_target", precision = 11)
    private BigDecimal gate6Target;

    @Column(name = "gate6_moisture", precision = 999)
    private BigDecimal gate6Moisture;

    @Column(name = "cement1_actual", precision = 11)
    private BigDecimal cement1Actual;

    @Column(name = "cement1_target", precision = 11)
    private BigDecimal cement1Target;

    @Column(name = "cement1_correction", precision = 999)
    private BigDecimal cement1Correction;

    @Column(name = "cement2_actual", precision = 11)
    private BigDecimal cement2Actual;

    @Column(name = "cement2_target", precision = 11)
    private BigDecimal cement2Target;

    @Column(name = "cement2_correction", precision = 999)
    private BigDecimal cement2Correction;

    @Column(name = "cement3_actual", precision = 11)
    private BigDecimal cement3Actual;

    @Column(name = "cement3_target", precision = 11)
    private BigDecimal cement3Target;

    @Column(name = "cement3_correction", precision = 999)
    private BigDecimal cement3Correction;

    @Column(name = "cement4_actual", precision = 11)
    private BigDecimal cement4Actual;

    @Column(name = "cement4_target", precision = 11)
    private BigDecimal cement4Target;

    @Column(name = "cement4_correction", precision = 999)
    private BigDecimal cement4Correction;

    @Column(name = "filler1_actual", precision = 11)
    private BigDecimal filler1Actual;

    @Column(name = "filler1_target", precision = 11)
    private BigDecimal filler1Target;

    @Column(name = "filler1_correction", precision = 999)
    private BigDecimal filler1Correction;

    @Column(name = "water1_actual", precision = 11)
    private BigDecimal water1Actual;

    @Column(name = "water1_target", precision = 11)
    private BigDecimal water1Target;

    @Column(name = "water1_correction", precision = 999)
    private BigDecimal water1Correction;

    @Column(name = "water2_actual", precision = 11)
    private BigDecimal water2Actual;

    @Column(name = "water2_target", precision = 11)
    private BigDecimal water2Target;

    @Column(name = "water2_correction", precision = 999)
    private BigDecimal water2Correction;

    @Column(name = "silica_actual", precision = 11)
    private BigDecimal silicaActual;

    @Column(name = "silica_target", precision = 11)
    private BigDecimal silicaTarget;

    @Column(name = "silica_correction", precision = 999)
    private BigDecimal silicaCorrection;

    @Column(name = "slurry_actual", precision = 11)
    private BigDecimal slurryActual;

    @Column(name = "slurry_target", precision = 11)
    private BigDecimal slurryTarget;

    @Column(name = "slurry_correction", precision = 999)
    private BigDecimal slurryCorrection;

    @Column(name = "adm1_actual1", precision = 999)
    private BigDecimal adm1Actual1;

    @Column(name = "adm1_target1", precision = 999)
    private BigDecimal adm1Target1;

    @Column(name = "adm1_correction1", precision = 999)
    private BigDecimal adm1Correction1;

    @Column(name = "adm1_actual2", precision = 999)
    private BigDecimal adm1Actual2;

    @Column(name = "adm1_target2", precision = 999)
    private BigDecimal adm1Target2;

    @Column(name = "adm1_correction2", precision = 999)
    private BigDecimal adm1Correction2;

    @Column(name = "adm2_actual1", precision = 999)
    private BigDecimal adm2Actual1;

    @Column(name = "adm2_target1", precision = 999)
    private BigDecimal adm2Target1;

    @Column(name = "adm2_correction1", precision = 999)
    private BigDecimal adm2Correction1;

    @Column(name = "adm2_actual2", precision = 999)
    private BigDecimal adm2Actual2;

    @Column(name = "adm2_target2", precision = 999)
    private BigDecimal adm2Target2;

    @Column(name = "adm2_correction2", precision = 999)
    private BigDecimal adm2Correction2;

    @Column(name = "pigment_actual", precision = 999)
    private BigDecimal pigmentActual;

    @Column(name = "pigment_target", precision = 999)
    private BigDecimal pigmentTarget;

    @Column(name = "batch_end_flag", precision = 999)
    private BigDecimal batchEndFlag;

    public TrnRmcBatchDetail(BigDecimal id, BigDecimal intId, BigDecimal conId, BigDecimal plantId, BigDecimal woId, BigDecimal batchNo, BigDecimal batchIndex, LocalDate batchDate, LocalTime batchTime, String batchTimeText, BigDecimal batchYear, BigDecimal consistancy, BigDecimal productionQty, BigDecimal orderedQty, BigDecimal returnedQty, BigDecimal withthisload, BigDecimal batchSize, BigDecimal gate1Actual, BigDecimal gate1Target, BigDecimal gate1Moisture, BigDecimal gate2Actual, BigDecimal gate2Target, BigDecimal gate2Moisture, BigDecimal gate3Actual, BigDecimal gate3Target, BigDecimal gate3Moisture, BigDecimal gate4Actual, BigDecimal gate4Target, BigDecimal gate4Moisture, BigDecimal gate5Actual, BigDecimal gate5Target, BigDecimal gate5Moisture, BigDecimal gate6Actual, BigDecimal gate6Target, BigDecimal gate6Moisture, BigDecimal cement1Actual, BigDecimal cement1Target, BigDecimal cement1Correction, BigDecimal cement2Actual, BigDecimal cement2Target, BigDecimal cement2Correction, BigDecimal cement3Actual, BigDecimal cement3Target, BigDecimal cement3Correction, BigDecimal cement4Actual, BigDecimal cement4Target, BigDecimal cement4Correction, BigDecimal filler1Actual, BigDecimal filler1Target, BigDecimal filler1Correction, BigDecimal water1Actual, BigDecimal water1Target, BigDecimal water1Correction, BigDecimal water2Actual, BigDecimal water2Target, BigDecimal water2Correction, BigDecimal silicaActual, BigDecimal silicaTarget, BigDecimal silicaCorrection, BigDecimal slurryActual, BigDecimal slurryTarget, BigDecimal slurryCorrection, BigDecimal adm1Actual1, BigDecimal adm1Target1, BigDecimal adm1Correction1, BigDecimal adm1Actual2, BigDecimal adm1Target2, BigDecimal adm1Correction2, BigDecimal adm2Actual1, BigDecimal adm2Target1, BigDecimal adm2Correction1, BigDecimal adm2Actual2, BigDecimal adm2Target2, BigDecimal adm2Correction2, BigDecimal pigmentActual, BigDecimal pigmentTarget, BigDecimal batchEndFlag) {
        this.id = id;
        this.intId = intId;
        this.conId = conId;
        this.plantId = plantId;
        this.woId = woId;
        this.batchNo = batchNo;
        this.batchIndex = batchIndex;
        this.batchDate = batchDate;
        this.batchTime = batchTime;
        this.batchTimeText = batchTimeText;
        this.batchYear = batchYear;
        this.consistancy = consistancy;
        this.productionQty = productionQty;
        this.orderedQty = orderedQty;
        this.returnedQty = returnedQty;
        this.withthisload = withthisload;
        this.batchSize = batchSize;
        this.gate1Actual = gate1Actual;
        this.gate1Target = gate1Target;
        this.gate1Moisture = gate1Moisture;
        this.gate2Actual = gate2Actual;
        this.gate2Target = gate2Target;
        this.gate2Moisture = gate2Moisture;
        this.gate3Actual = gate3Actual;
        this.gate3Target = gate3Target;
        this.gate3Moisture = gate3Moisture;
        this.gate4Actual = gate4Actual;
        this.gate4Target = gate4Target;
        this.gate4Moisture = gate4Moisture;
        this.gate5Actual = gate5Actual;
        this.gate5Target = gate5Target;
        this.gate5Moisture = gate5Moisture;
        this.gate6Actual = gate6Actual;
        this.gate6Target = gate6Target;
        this.gate6Moisture = gate6Moisture;
        this.cement1Actual = cement1Actual;
        this.cement1Target = cement1Target;
        this.cement1Correction = cement1Correction;
        this.cement2Actual = cement2Actual;
        this.cement2Target = cement2Target;
        this.cement2Correction = cement2Correction;
        this.cement3Actual = cement3Actual;
        this.cement3Target = cement3Target;
        this.cement3Correction = cement3Correction;
        this.cement4Actual = cement4Actual;
        this.cement4Target = cement4Target;
        this.cement4Correction = cement4Correction;
        this.filler1Actual = filler1Actual;
        this.filler1Target = filler1Target;
        this.filler1Correction = filler1Correction;
        this.water1Actual = water1Actual;
        this.water1Target = water1Target;
        this.water1Correction = water1Correction;
        this.water2Actual = water2Actual;
        this.water2Target = water2Target;
        this.water2Correction = water2Correction;
        this.silicaActual = silicaActual;
        this.silicaTarget = silicaTarget;
        this.silicaCorrection = silicaCorrection;
        this.slurryActual = slurryActual;
        this.slurryTarget = slurryTarget;
        this.slurryCorrection = slurryCorrection;
        this.adm1Actual1 = adm1Actual1;
        this.adm1Target1 = adm1Target1;
        this.adm1Correction1 = adm1Correction1;
        this.adm1Actual2 = adm1Actual2;
        this.adm1Target2 = adm1Target2;
        this.adm1Correction2 = adm1Correction2;
        this.adm2Actual1 = adm2Actual1;
        this.adm2Target1 = adm2Target1;
        this.adm2Correction1 = adm2Correction1;
        this.adm2Actual2 = adm2Actual2;
        this.adm2Target2 = adm2Target2;
        this.adm2Correction2 = adm2Correction2;
        this.pigmentActual = pigmentActual;
        this.pigmentTarget = pigmentTarget;
        this.batchEndFlag = batchEndFlag;
    }

    public TrnRmcBatchDetail() {
    }

    public BigDecimal getBatchEndFlag() {
        return batchEndFlag;
    }

    public void setBatchEndFlag(BigDecimal batchEndFlag) {
        this.batchEndFlag = batchEndFlag;
    }

    public BigDecimal getPigmentTarget() {
        return pigmentTarget;
    }

    public void setPigmentTarget(BigDecimal pigmentTarget) {
        this.pigmentTarget = pigmentTarget;
    }

    public BigDecimal getPigmentActual() {
        return pigmentActual;
    }

    public void setPigmentActual(BigDecimal pigmentActual) {
        this.pigmentActual = pigmentActual;
    }

    public BigDecimal getAdm2Correction2() {
        return adm2Correction2;
    }

    public void setAdm2Correction2(BigDecimal adm2Correction2) {
        this.adm2Correction2 = adm2Correction2;
    }

    public BigDecimal getAdm2Target2() {
        return adm2Target2;
    }

    public void setAdm2Target2(BigDecimal adm2Target2) {
        this.adm2Target2 = adm2Target2;
    }

    public BigDecimal getAdm2Actual2() {
        return adm2Actual2;
    }

    public void setAdm2Actual2(BigDecimal adm2Actual2) {
        this.adm2Actual2 = adm2Actual2;
    }

    public BigDecimal getAdm2Correction1() {
        return adm2Correction1;
    }

    public void setAdm2Correction1(BigDecimal adm2Correction1) {
        this.adm2Correction1 = adm2Correction1;
    }

    public BigDecimal getAdm2Target1() {
        return adm2Target1;
    }

    public void setAdm2Target1(BigDecimal adm2Target1) {
        this.adm2Target1 = adm2Target1;
    }

    public BigDecimal getAdm2Actual1() {
        return adm2Actual1;
    }

    public void setAdm2Actual1(BigDecimal adm2Actual1) {
        this.adm2Actual1 = adm2Actual1;
    }

    public BigDecimal getAdm1Correction2() {
        return adm1Correction2;
    }

    public void setAdm1Correction2(BigDecimal adm1Correction2) {
        this.adm1Correction2 = adm1Correction2;
    }

    public BigDecimal getAdm1Target2() {
        return adm1Target2;
    }

    public void setAdm1Target2(BigDecimal adm1Target2) {
        this.adm1Target2 = adm1Target2;
    }

    public BigDecimal getAdm1Actual2() {
        return adm1Actual2;
    }

    public void setAdm1Actual2(BigDecimal adm1Actual2) {
        this.adm1Actual2 = adm1Actual2;
    }

    public BigDecimal getAdm1Correction1() {
        return adm1Correction1;
    }

    public void setAdm1Correction1(BigDecimal adm1Correction1) {
        this.adm1Correction1 = adm1Correction1;
    }

    public BigDecimal getAdm1Target1() {
        return adm1Target1;
    }

    public void setAdm1Target1(BigDecimal adm1Target1) {
        this.adm1Target1 = adm1Target1;
    }

    public BigDecimal getAdm1Actual1() {
        return adm1Actual1;
    }

    public void setAdm1Actual1(BigDecimal adm1Actual1) {
        this.adm1Actual1 = adm1Actual1;
    }

    public BigDecimal getSlurryCorrection() {
        return slurryCorrection;
    }

    public void setSlurryCorrection(BigDecimal slurryCorrection) {
        this.slurryCorrection = slurryCorrection;
    }

    public BigDecimal getSlurryTarget() {
        return slurryTarget;
    }

    public void setSlurryTarget(BigDecimal slurryTarget) {
        this.slurryTarget = slurryTarget;
    }

    public BigDecimal getSlurryActual() {
        return slurryActual;
    }

    public void setSlurryActual(BigDecimal slurryActual) {
        this.slurryActual = slurryActual;
    }

    public BigDecimal getSilicaCorrection() {
        return silicaCorrection;
    }

    public void setSilicaCorrection(BigDecimal silicaCorrection) {
        this.silicaCorrection = silicaCorrection;
    }

    public BigDecimal getSilicaTarget() {
        return silicaTarget;
    }

    public void setSilicaTarget(BigDecimal silicaTarget) {
        this.silicaTarget = silicaTarget;
    }

    public BigDecimal getSilicaActual() {
        return silicaActual;
    }

    public void setSilicaActual(BigDecimal silicaActual) {
        this.silicaActual = silicaActual;
    }

    public BigDecimal getWater2Correction() {
        return water2Correction;
    }

    public void setWater2Correction(BigDecimal water2Correction) {
        this.water2Correction = water2Correction;
    }

    public BigDecimal getWater2Target() {
        return water2Target;
    }

    public void setWater2Target(BigDecimal water2Target) {
        this.water2Target = water2Target;
    }

    public BigDecimal getWater2Actual() {
        return water2Actual;
    }

    public void setWater2Actual(BigDecimal water2Actual) {
        this.water2Actual = water2Actual;
    }

    public BigDecimal getWater1Correction() {
        return water1Correction;
    }

    public void setWater1Correction(BigDecimal water1Correction) {
        this.water1Correction = water1Correction;
    }

    public BigDecimal getWater1Target() {
        return water1Target;
    }

    public void setWater1Target(BigDecimal water1Target) {
        this.water1Target = water1Target;
    }

    public BigDecimal getWater1Actual() {
        return water1Actual;
    }

    public void setWater1Actual(BigDecimal water1Actual) {
        this.water1Actual = water1Actual;
    }

    public BigDecimal getFiller1Correction() {
        return filler1Correction;
    }

    public void setFiller1Correction(BigDecimal filler1Correction) {
        this.filler1Correction = filler1Correction;
    }

    public BigDecimal getFiller1Target() {
        return filler1Target;
    }

    public void setFiller1Target(BigDecimal filler1Target) {
        this.filler1Target = filler1Target;
    }

    public BigDecimal getFiller1Actual() {
        return filler1Actual;
    }

    public void setFiller1Actual(BigDecimal filler1Actual) {
        this.filler1Actual = filler1Actual;
    }

    public BigDecimal getCement4Correction() {
        return cement4Correction;
    }

    public void setCement4Correction(BigDecimal cement4Correction) {
        this.cement4Correction = cement4Correction;
    }

    public BigDecimal getCement4Target() {
        return cement4Target;
    }

    public void setCement4Target(BigDecimal cement4Target) {
        this.cement4Target = cement4Target;
    }

    public BigDecimal getCement4Actual() {
        return cement4Actual;
    }

    public void setCement4Actual(BigDecimal cement4Actual) {
        this.cement4Actual = cement4Actual;
    }

    public BigDecimal getCement3Correction() {
        return cement3Correction;
    }

    public void setCement3Correction(BigDecimal cement3Correction) {
        this.cement3Correction = cement3Correction;
    }

    public BigDecimal getCement3Target() {
        return cement3Target;
    }

    public void setCement3Target(BigDecimal cement3Target) {
        this.cement3Target = cement3Target;
    }

    public BigDecimal getCement3Actual() {
        return cement3Actual;
    }

    public void setCement3Actual(BigDecimal cement3Actual) {
        this.cement3Actual = cement3Actual;
    }

    public BigDecimal getCement2Correction() {
        return cement2Correction;
    }

    public void setCement2Correction(BigDecimal cement2Correction) {
        this.cement2Correction = cement2Correction;
    }

    public BigDecimal getCement2Target() {
        return cement2Target;
    }

    public void setCement2Target(BigDecimal cement2Target) {
        this.cement2Target = cement2Target;
    }

    public BigDecimal getCement2Actual() {
        return cement2Actual;
    }

    public void setCement2Actual(BigDecimal cement2Actual) {
        this.cement2Actual = cement2Actual;
    }

    public BigDecimal getCement1Correction() {
        return cement1Correction;
    }

    public void setCement1Correction(BigDecimal cement1Correction) {
        this.cement1Correction = cement1Correction;
    }

    public BigDecimal getCement1Target() {
        return cement1Target;
    }

    public void setCement1Target(BigDecimal cement1Target) {
        this.cement1Target = cement1Target;
    }

    public BigDecimal getCement1Actual() {
        return cement1Actual;
    }

    public void setCement1Actual(BigDecimal cement1Actual) {
        this.cement1Actual = cement1Actual;
    }

    public BigDecimal getGate6Moisture() {
        return gate6Moisture;
    }

    public void setGate6Moisture(BigDecimal gate6Moisture) {
        this.gate6Moisture = gate6Moisture;
    }

    public BigDecimal getGate6Target() {
        return gate6Target;
    }

    public void setGate6Target(BigDecimal gate6Target) {
        this.gate6Target = gate6Target;
    }

    public BigDecimal getGate6Actual() {
        return gate6Actual;
    }

    public void setGate6Actual(BigDecimal gate6Actual) {
        this.gate6Actual = gate6Actual;
    }

    public BigDecimal getGate5Moisture() {
        return gate5Moisture;
    }

    public void setGate5Moisture(BigDecimal gate5Moisture) {
        this.gate5Moisture = gate5Moisture;
    }

    public BigDecimal getGate5Target() {
        return gate5Target;
    }

    public void setGate5Target(BigDecimal gate5Target) {
        this.gate5Target = gate5Target;
    }

    public BigDecimal getGate5Actual() {
        return gate5Actual;
    }

    public void setGate5Actual(BigDecimal gate5Actual) {
        this.gate5Actual = gate5Actual;
    }

    public BigDecimal getGate4Moisture() {
        return gate4Moisture;
    }

    public void setGate4Moisture(BigDecimal gate4Moisture) {
        this.gate4Moisture = gate4Moisture;
    }

    public BigDecimal getGate4Target() {
        return gate4Target;
    }

    public void setGate4Target(BigDecimal gate4Target) {
        this.gate4Target = gate4Target;
    }

    public BigDecimal getGate4Actual() {
        return gate4Actual;
    }

    public void setGate4Actual(BigDecimal gate4Actual) {
        this.gate4Actual = gate4Actual;
    }

    public BigDecimal getGate3Moisture() {
        return gate3Moisture;
    }

    public void setGate3Moisture(BigDecimal gate3Moisture) {
        this.gate3Moisture = gate3Moisture;
    }

    public BigDecimal getGate3Target() {
        return gate3Target;
    }

    public void setGate3Target(BigDecimal gate3Target) {
        this.gate3Target = gate3Target;
    }

    public BigDecimal getGate3Actual() {
        return gate3Actual;
    }

    public void setGate3Actual(BigDecimal gate3Actual) {
        this.gate3Actual = gate3Actual;
    }

    public BigDecimal getGate2Moisture() {
        return gate2Moisture;
    }

    public void setGate2Moisture(BigDecimal gate2Moisture) {
        this.gate2Moisture = gate2Moisture;
    }

    public BigDecimal getGate2Target() {
        return gate2Target;
    }

    public void setGate2Target(BigDecimal gate2Target) {
        this.gate2Target = gate2Target;
    }

    public BigDecimal getGate2Actual() {
        return gate2Actual;
    }

    public void setGate2Actual(BigDecimal gate2Actual) {
        this.gate2Actual = gate2Actual;
    }

    public BigDecimal getGate1Moisture() {
        return gate1Moisture;
    }

    public void setGate1Moisture(BigDecimal gate1Moisture) {
        this.gate1Moisture = gate1Moisture;
    }

    public BigDecimal getGate1Target() {
        return gate1Target;
    }

    public void setGate1Target(BigDecimal gate1Target) {
        this.gate1Target = gate1Target;
    }

    public BigDecimal getGate1Actual() {
        return gate1Actual;
    }

    public void setGate1Actual(BigDecimal gate1Actual) {
        this.gate1Actual = gate1Actual;
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

    public BigDecimal getConsistancy() {
        return consistancy;
    }

    public void setConsistancy(BigDecimal consistancy) {
        this.consistancy = consistancy;
    }

    public BigDecimal getBatchYear() {
        return batchYear;
    }

    public void setBatchYear(BigDecimal batchYear) {
        this.batchYear = batchYear;
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

    public BigDecimal getConId() {
        return conId;
    }

    public void setConId(BigDecimal conId) {
        this.conId = conId;
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