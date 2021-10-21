package com.freelance.Batchreports.repositories;

import com.freelance.Batchreports.constants.ReportsQueryConstants;
import com.freelance.Batchreports.entities.MstCustomerVendor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public interface VendorRepository extends CrudRepository<MstCustomerVendor, BigDecimal> {
    @Query(value = ReportsQueryConstants.GET_CUSTOMER_NAME,nativeQuery = true)
    public String getCustomerName();
}
