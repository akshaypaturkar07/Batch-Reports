package com.freelance.batchreports.repositories;

import com.freelance.batchreports.constants.ReportsQueryConstants;
import com.freelance.batchreports.entities.MstPlant;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public interface PlantRepository extends CrudRepository<MstPlant, BigDecimal> {
    @Query(value = ReportsQueryConstants.GET_PLANT_SERIAL_NO,nativeQuery = true)
    String getPlantSerialNumber(@Param("id") BigDecimal id);
}
