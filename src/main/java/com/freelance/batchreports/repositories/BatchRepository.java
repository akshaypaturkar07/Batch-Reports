package com.freelance.batchreports.repositories;

import com.freelance.batchreports.constants.ReportsQueryConstants;
import com.freelance.batchreports.entities.TrnRmcBatch;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public interface BatchRepository extends CrudRepository<TrnRmcBatch, BigDecimal> {
    @Query(value = ReportsQueryConstants.GET_BATCH_BY_BATCHNO,nativeQuery = true)
    Object getBatchByBatchNo(@Param("batchNo") BigDecimal batchNo,@Param("id") BigDecimal id);

    @Query(value = ReportsQueryConstants.GET_AGGREGATED_DATA_BATCH_REPORTS,nativeQuery = true)
    Iterable<Object[]> getReportsData(@Param("batchNo") BigDecimal batchNo,@Param("id") BigDecimal id,@Param("conId") BigDecimal conId,@Param("plantId") BigDecimal plantId);
}
