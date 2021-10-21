package com.freelance.Batchreports.repositories;

import com.freelance.Batchreports.constants.ReportsQueryConstants;
import com.freelance.Batchreports.entities.TrnRmcBatchDetail;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;

@Repository
public interface BatchDetailRepository extends CrudRepository<TrnRmcBatchDetail, BigDecimal> {
    @Query(value = ReportsQueryConstants.GET_BATCH_DETAIL_BY_BATCHNO,nativeQuery = true)
    Iterable<Object[]> getBatchDetailsByBatchNo(@Param("batchNo") BigDecimal batchNo,@Param("id") BigDecimal id);
}
