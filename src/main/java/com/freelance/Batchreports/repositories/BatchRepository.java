package com.freelance.Batchreports.repositories;

import com.freelance.Batchreports.entities.TrnRmcBatch;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
@Repository
public interface BatchRepository extends CrudRepository<TrnRmcBatch, BigDecimal> {
}
