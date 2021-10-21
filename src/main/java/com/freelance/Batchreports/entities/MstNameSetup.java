package com.freelance.Batchreports.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.Instant;

@Table(name = "mst_name_setup")
@Entity
public class MstNameSetup {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "trans_id", nullable = false, precision = 9)
    private BigDecimal id;

    @Column(name = "int_id", nullable = false, precision = 131089)
    private BigDecimal intId;

    @Column(name = "hc_id", nullable = false, precision = 131089)
    private BigDecimal hcId;

    @Column(name = "plant_id", nullable = false, precision = 131089)
    private BigDecimal plantId;

    @Column(name = "agg1_name", length = 10)
    private String agg1Name;

    @Column(name = "agg1_item_id", precision = 131089)
    private BigDecimal agg1ItemId;

    @Column(name = "agg2_name", length = 10)
    private String agg2Name;

    @Column(name = "agg2_item_id", precision = 131089)
    private BigDecimal agg2ItemId;

    @Column(name = "agg3_name", length = 10)
    private String agg3Name;

    @Column(name = "agg3_item_id", precision = 131089)
    private BigDecimal agg3ItemId;

    @Column(name = "agg4_name", length = 10)
    private String agg4Name;

    @Column(name = "agg4_item_id", precision = 131089)
    private BigDecimal agg4ItemId;

    @Column(name = "agg5_name", length = 10)
    private String agg5Name;

    @Column(name = "agg5_item_id", precision = 131089)
    private BigDecimal agg5ItemId;

    @Column(name = "cement1_name", length = 10)
    private String cement1Name;

    @Column(name = "cement1_item_id", precision = 131089)
    private BigDecimal cement1ItemId;

    @Column(name = "cement2_name", length = 10)
    private String cement2Name;

    @Column(name = "cement2_item_id", precision = 131089)
    private BigDecimal cement2ItemId;

    @Column(name = "fill_name", length = 10)
    private String fillName;

    @Column(name = "fill_item_id", precision = 131089)
    private BigDecimal fillItemId;

    @Column(name = "water1_name", length = 10)
    private String water1Name;

    @Column(name = "water1_item_id", precision = 131089)
    private BigDecimal water1ItemId;

    @Column(name = "water2_name", length = 10)
    private String water2Name;

    @Column(name = "water2_item_id", precision = 131089)
    private BigDecimal water2ItemId;

    @Column(name = "admix1_name", length = 10)
    private String admix1Name;

    @Column(name = "admix1_item_id", precision = 131089)
    private BigDecimal admix1ItemId;

    @Column(name = "admix12_name", length = 10)
    private String admix12Name;

    @Column(name = "admix12_item_id", precision = 131089)
    private BigDecimal admix12ItemId;

    @Column(name = "admix2_name", length = 10)
    private String admix2Name;

    @Column(name = "admix2_item_id", precision = 131089)
    private BigDecimal admix2ItemId;

    @Column(name = "admix22_name", length = 10)
    private String admix22Name;

    @Column(name = "admix22_item_id", precision = 131089)
    private BigDecimal admix22ItemId;

    @Column(name = "silica_name", length = 10)
    private String silicaName;

    @Column(name = "silica_item_id", precision = 131089)
    private BigDecimal silicaItemId;

    @Column(name = "slurry_name", length = 10)
    private String slurryName;

    @Column(name = "slurry_item_id", precision = 131089)
    private BigDecimal slurryItemId;

    @Column(name = "pigname", length = 10)
    private String pigname;

    @Column(name = "action_on", nullable = false)
    private Instant actionOn;

    @Column(name = "rec_status", nullable = false)
    private Integer recStatus;

    @Column(name = "insertion_type", length = 1)
    private String insertionType;

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public String getInsertionType() {
        return insertionType;
    }

    public void setInsertionType(String insertionType) {
        this.insertionType = insertionType;
    }

    public Integer getRecStatus() {
        return recStatus;
    }

    public void setRecStatus(Integer recStatus) {
        this.recStatus = recStatus;
    }

    public Instant getActionOn() {
        return actionOn;
    }

    public void setActionOn(Instant actionOn) {
        this.actionOn = actionOn;
    }

    public String getPigname() {
        return pigname;
    }

    public void setPigname(String pigname) {
        this.pigname = pigname;
    }

    public BigDecimal getSlurryItemId() {
        return slurryItemId;
    }

    public void setSlurryItemId(BigDecimal slurryItemId) {
        this.slurryItemId = slurryItemId;
    }

    public String getSlurryName() {
        return slurryName;
    }

    public void setSlurryName(String slurryName) {
        this.slurryName = slurryName;
    }

    public BigDecimal getSilicaItemId() {
        return silicaItemId;
    }

    public void setSilicaItemId(BigDecimal silicaItemId) {
        this.silicaItemId = silicaItemId;
    }

    public String getSilicaName() {
        return silicaName;
    }

    public void setSilicaName(String silicaName) {
        this.silicaName = silicaName;
    }

    public BigDecimal getAdmix22ItemId() {
        return admix22ItemId;
    }

    public void setAdmix22ItemId(BigDecimal admix22ItemId) {
        this.admix22ItemId = admix22ItemId;
    }

    public String getAdmix22Name() {
        return admix22Name;
    }

    public void setAdmix22Name(String admix22Name) {
        this.admix22Name = admix22Name;
    }

    public BigDecimal getAdmix2ItemId() {
        return admix2ItemId;
    }

    public void setAdmix2ItemId(BigDecimal admix2ItemId) {
        this.admix2ItemId = admix2ItemId;
    }

    public String getAdmix2Name() {
        return admix2Name;
    }

    public void setAdmix2Name(String admix2Name) {
        this.admix2Name = admix2Name;
    }

    public BigDecimal getAdmix12ItemId() {
        return admix12ItemId;
    }

    public void setAdmix12ItemId(BigDecimal admix12ItemId) {
        this.admix12ItemId = admix12ItemId;
    }

    public String getAdmix12Name() {
        return admix12Name;
    }

    public void setAdmix12Name(String admix12Name) {
        this.admix12Name = admix12Name;
    }

    public BigDecimal getAdmix1ItemId() {
        return admix1ItemId;
    }

    public void setAdmix1ItemId(BigDecimal admix1ItemId) {
        this.admix1ItemId = admix1ItemId;
    }

    public String getAdmix1Name() {
        return admix1Name;
    }

    public void setAdmix1Name(String admix1Name) {
        this.admix1Name = admix1Name;
    }

    public BigDecimal getWater2ItemId() {
        return water2ItemId;
    }

    public void setWater2ItemId(BigDecimal water2ItemId) {
        this.water2ItemId = water2ItemId;
    }

    public String getWater2Name() {
        return water2Name;
    }

    public void setWater2Name(String water2Name) {
        this.water2Name = water2Name;
    }

    public BigDecimal getWater1ItemId() {
        return water1ItemId;
    }

    public void setWater1ItemId(BigDecimal water1ItemId) {
        this.water1ItemId = water1ItemId;
    }

    public String getWater1Name() {
        return water1Name;
    }

    public void setWater1Name(String water1Name) {
        this.water1Name = water1Name;
    }

    public BigDecimal getFillItemId() {
        return fillItemId;
    }

    public void setFillItemId(BigDecimal fillItemId) {
        this.fillItemId = fillItemId;
    }

    public String getFillName() {
        return fillName;
    }

    public void setFillName(String fillName) {
        this.fillName = fillName;
    }

    public BigDecimal getCement2ItemId() {
        return cement2ItemId;
    }

    public void setCement2ItemId(BigDecimal cement2ItemId) {
        this.cement2ItemId = cement2ItemId;
    }

    public String getCement2Name() {
        return cement2Name;
    }

    public void setCement2Name(String cement2Name) {
        this.cement2Name = cement2Name;
    }

    public BigDecimal getCement1ItemId() {
        return cement1ItemId;
    }

    public void setCement1ItemId(BigDecimal cement1ItemId) {
        this.cement1ItemId = cement1ItemId;
    }

    public String getCement1Name() {
        return cement1Name;
    }

    public void setCement1Name(String cement1Name) {
        this.cement1Name = cement1Name;
    }

    public BigDecimal getAgg5ItemId() {
        return agg5ItemId;
    }

    public void setAgg5ItemId(BigDecimal agg5ItemId) {
        this.agg5ItemId = agg5ItemId;
    }

    public String getAgg5Name() {
        return agg5Name;
    }

    public void setAgg5Name(String agg5Name) {
        this.agg5Name = agg5Name;
    }

    public BigDecimal getAgg4ItemId() {
        return agg4ItemId;
    }

    public void setAgg4ItemId(BigDecimal agg4ItemId) {
        this.agg4ItemId = agg4ItemId;
    }

    public String getAgg4Name() {
        return agg4Name;
    }

    public void setAgg4Name(String agg4Name) {
        this.agg4Name = agg4Name;
    }

    public BigDecimal getAgg3ItemId() {
        return agg3ItemId;
    }

    public void setAgg3ItemId(BigDecimal agg3ItemId) {
        this.agg3ItemId = agg3ItemId;
    }

    public String getAgg3Name() {
        return agg3Name;
    }

    public void setAgg3Name(String agg3Name) {
        this.agg3Name = agg3Name;
    }

    public BigDecimal getAgg2ItemId() {
        return agg2ItemId;
    }

    public void setAgg2ItemId(BigDecimal agg2ItemId) {
        this.agg2ItemId = agg2ItemId;
    }

    public String getAgg2Name() {
        return agg2Name;
    }

    public void setAgg2Name(String agg2Name) {
        this.agg2Name = agg2Name;
    }

    public BigDecimal getAgg1ItemId() {
        return agg1ItemId;
    }

    public void setAgg1ItemId(BigDecimal agg1ItemId) {
        this.agg1ItemId = agg1ItemId;
    }

    public String getAgg1Name() {
        return agg1Name;
    }

    public void setAgg1Name(String agg1Name) {
        this.agg1Name = agg1Name;
    }

    public BigDecimal getPlantId() {
        return plantId;
    }

    public void setPlantId(BigDecimal plantId) {
        this.plantId = plantId;
    }

    public BigDecimal getHcId() {
        return hcId;
    }

    public void setHcId(BigDecimal hcId) {
        this.hcId = hcId;
    }

    public BigDecimal getIntId() {
        return intId;
    }

    public void setIntId(BigDecimal intId) {
        this.intId = intId;
    }
}