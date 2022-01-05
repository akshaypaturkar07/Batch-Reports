package com.freelance.batchreports.repositories;

import com.freelance.batchreports.constants.ReportsQueryConstants;
import com.freelance.batchreports.entities.MstCustomerVendor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public interface VendorRepository extends CrudRepository<MstCustomerVendor, BigDecimal> {
    @Query(value = ReportsQueryConstants.GET_CUSTOMER_NAME,nativeQuery = true)
    String getCustomerName(@Param("id") BigDecimal id);
}
