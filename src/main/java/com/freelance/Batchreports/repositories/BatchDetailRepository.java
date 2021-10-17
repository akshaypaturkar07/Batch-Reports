package com.freelance.Batchreports.repositories;

import com.freelance.Batchreports.entities.TrnRmcBatchDetail;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
@Repository
public interface BatchDetailRepository extends CrudRepository<TrnRmcBatchDetail, BigDecimal> {
}
