package com.freelance.batchreports.entities;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;

@Table(name = "mst_plant", indexes = {
        @Index(name = "uk_plant_plantname", columnList = "plant_name", unique = true),
        @Index(name = "uk_plant_plantregno", columnList = "plant_reg_no", unique = true)
})
@Entity
public class MstPlant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "plant_id", nullable = false, precision = 7)
    private BigDecimal id;

    @Column(name = "con_id", nullable = false, precision = 5)
    private BigDecimal conId;

    @Column(name = "int_id", nullable = false, precision = 3)
    private BigDecimal intId;

    @Column(name = "plant_name", length = 100)
    private String plantName;

    @Column(name = "plant_reg_no", length = 50)
    private String plantRegNo;

    @Column(name = "plant_reg_date")
    private LocalDate plantRegDate;

    @Column(name = "plant_address", nullable = false)
    private String plantAddress;

    @Column(name = "plant_details")
    private String plantDetails;

    @Column(name = "plant_install_date")
    private LocalDate plantInstallDate;

    @Column(name = "plant_contact_person", length = 100)
    private String plantContactPerson;

    @Column(name = "plant_latitude", nullable = false, precision = 131089)
    private BigDecimal plantLatitude;

    @Column(name = "plant_longitude", nullable = false, precision = 131089)
    private BigDecimal plantLongitude;

    @Column(name = "plant_contact_mobile_no", length = 15)
    private String plantContactMobileNo;

    @Column(name = "plant_type", nullable = false, precision = 2)
    private BigDecimal plantType;

    @Column(name = "plant_subtype", precision = 2)
    private BigDecimal plantSubtype;

    @Column(name = "plant_capacity", length = 100)
    private String plantCapacity;

    @Column(name = "plant_valid_from")
    private LocalDate plantValidFrom;

    @Column(name = "plant_valid_to")
    private LocalDate plantValidTo;

    @Column(name = "plant_status", nullable = false, precision = 1)
    private BigDecimal plantStatus;

    @Column(name = "geofence", precision = 3)
    private BigDecimal geofence;

    @Column(name = "comp_location_id", precision = 5)
    private BigDecimal compLocationId;

    @Column(name = "device_imei_no", nullable = false, length = 20)
    private String deviceImeiNo;

    @Column(name = "rec_status", precision = 1)
    private BigDecimal recStatus;

    @Column(name = "created_by", nullable = false, precision = 5)
    private BigDecimal createdBy;

    @Column(name = "created_on", nullable = false)
    private Instant createdOn;

    @Column(name = "modified_by", precision = 5)
    private BigDecimal modifiedBy;

    @Column(name = "modified_on")
    private Instant modifiedOn;

    @Column(name = "sync_status", nullable = false, precision = 1)
    private BigDecimal syncStatus;

    @Column(name = "register_mob_no", length = 15)
    private String registerMobNo;

    public String getRegisterMobNo() {
        return registerMobNo;
    }

    public void setRegisterMobNo(String registerMobNo) {
        this.registerMobNo = registerMobNo;
    }

    public BigDecimal getSyncStatus() {
        return syncStatus;
    }

    public void setSyncStatus(BigDecimal syncStatus) {
        this.syncStatus = syncStatus;
    }

    public Instant getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(Instant modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

    public BigDecimal getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(BigDecimal modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    public Instant getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Instant createdOn) {
        this.createdOn = createdOn;
    }

    public BigDecimal getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(BigDecimal createdBy) {
        this.createdBy = createdBy;
    }

    public BigDecimal getRecStatus() {
        return recStatus;
    }

    public void setRecStatus(BigDecimal recStatus) {
        this.recStatus = recStatus;
    }

    public String getDeviceImeiNo() {
        return deviceImeiNo;
    }

    public void setDeviceImeiNo(String deviceImeiNo) {
        this.deviceImeiNo = deviceImeiNo;
    }

    public BigDecimal getCompLocationId() {
        return compLocationId;
    }

    public void setCompLocationId(BigDecimal compLocationId) {
        this.compLocationId = compLocationId;
    }

    public BigDecimal getGeofence() {
        return geofence;
    }

    public void setGeofence(BigDecimal geofence) {
        this.geofence = geofence;
    }

    public BigDecimal getPlantStatus() {
        return plantStatus;
    }

    public void setPlantStatus(BigDecimal plantStatus) {
        this.plantStatus = plantStatus;
    }

    public LocalDate getPlantValidTo() {
        return plantValidTo;
    }

    public void setPlantValidTo(LocalDate plantValidTo) {
        this.plantValidTo = plantValidTo;
    }

    public LocalDate getPlantValidFrom() {
        return plantValidFrom;
    }

    public void setPlantValidFrom(LocalDate plantValidFrom) {
        this.plantValidFrom = plantValidFrom;
    }

    public String getPlantCapacity() {
        return plantCapacity;
    }

    public void setPlantCapacity(String plantCapacity) {
        this.plantCapacity = plantCapacity;
    }

    public BigDecimal getPlantSubtype() {
        return plantSubtype;
    }

    public void setPlantSubtype(BigDecimal plantSubtype) {
        this.plantSubtype = plantSubtype;
    }

    public BigDecimal getPlantType() {
        return plantType;
    }

    public void setPlantType(BigDecimal plantType) {
        this.plantType = plantType;
    }

    public String getPlantContactMobileNo() {
        return plantContactMobileNo;
    }

    public void setPlantContactMobileNo(String plantContactMobileNo) {
        this.plantContactMobileNo = plantContactMobileNo;
    }

    public BigDecimal getPlantLongitude() {
        return plantLongitude;
    }

    public void setPlantLongitude(BigDecimal plantLongitude) {
        this.plantLongitude = plantLongitude;
    }

    public BigDecimal getPlantLatitude() {
        return plantLatitude;
    }

    public void setPlantLatitude(BigDecimal plantLatitude) {
        this.plantLatitude = plantLatitude;
    }

    public String getPlantContactPerson() {
        return plantContactPerson;
    }

    public void setPlantContactPerson(String plantContactPerson) {
        this.plantContactPerson = plantContactPerson;
    }

    public LocalDate getPlantInstallDate() {
        return plantInstallDate;
    }

    public void setPlantInstallDate(LocalDate plantInstallDate) {
        this.plantInstallDate = plantInstallDate;
    }

    public String getPlantDetails() {
        return plantDetails;
    }

    public void setPlantDetails(String plantDetails) {
        this.plantDetails = plantDetails;
    }

    public String getPlantAddress() {
        return plantAddress;
    }

    public void setPlantAddress(String plantAddress) {
        this.plantAddress = plantAddress;
    }

    public LocalDate getPlantRegDate() {
        return plantRegDate;
    }

    public void setPlantRegDate(LocalDate plantRegDate) {
        this.plantRegDate = plantRegDate;
    }

    public String getPlantRegNo() {
        return plantRegNo;
    }

    public void setPlantRegNo(String plantRegNo) {
        this.plantRegNo = plantRegNo;
    }

    public String getPlantName() {
        return plantName;
    }

    public void setPlantName(String plantName) {
        this.plantName = plantName;
    }

    public BigDecimal getIntId() {
        return intId;
    }

    public void setIntId(BigDecimal intId) {
        this.intId = intId;
    }

    public BigDecimal getConId() {
        return conId;
    }

    public void setConId(BigDecimal conId) {
        this.conId = conId;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }
}