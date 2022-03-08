package com.freelance.Batchreports.repositories;

import com.freelance.Batchreports.constants.ReportsQueryConstants;
import com.freelance.Batchreports.entities.TrnRmcBatchDetail;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public interface DataRepository extends CrudRepository<TrnRmcBatchDetail, BigDecimal> {
    @Query(value = ReportsQueryConstants.GET_AGGREGATED_DATA_BATCH_REPORTS,nativeQuery = true)
    Iterable<Object[]> getBatchReportsData(@Param("batchNo") BigDecimal batchNo,@Param("id") BigDecimal id,@Param("conId") BigDecimal conId,@Param("plantId") BigDecimal plantId);

    @Query(value = ReportsQueryConstants.GET_GRN_REPORT_DATA,nativeQuery = true)
    Iterable<Object[]> getGRNReportsData(@Param("hcId") BigDecimal hcId,@Param("plantId") BigDecimal plantId,@Param("vendorId") BigDecimal vendorId,@Param("poId") BigDecimal poId,@Param("conId") BigDecimal conId);

    @Query(value = ReportsQueryConstants.GET_PO_REPORT_DATA,nativeQuery = true)
    Iterable<Object[]> getPOReportsData(@Param("poId") BigDecimal poId);

    @Query(value = ReportsQueryConstants.GET_TAX_INVOICE_REPORT_DATA,nativeQuery = true)
    Iterable<Object[]> getTaxInvoiceReportsData(@Param("hc_id") BigDecimal hc_id);
}
