package com.freelance.Batchreports.repositories;

import com.freelance.Batchreports.constants.ReportsQueryConstants;
import com.freelance.Batchreports.entities.MstPlant;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public interface PlantRepository extends CrudRepository<MstPlant, BigDecimal> {
    @Query(value = ReportsQueryConstants.GET_PLANT_SERIAL_NO,nativeQuery = true)
    public String getPlantSerialNumber();
}
