package com.freelance.Batchreports.service;

import com.freelance.Batchreports.controller.ReportsController;
import com.freelance.Batchreports.entities.TrnRmcBatch;
import com.freelance.Batchreports.entities.TrnRmcBatchDetail;
import com.freelance.Batchreports.repositories.BatchDetailRepository;
import com.freelance.Batchreports.repositories.BatchRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReportService {
    Logger logger = LoggerFactory.getLogger(ReportService.class);

    @Autowired
    private BatchRepository batchRepository;
    @Autowired
    private BatchDetailRepository batchDetailRepository;

    public List<TrnRmcBatch> getBatchData(){
        logger.info("Fetching batch data");
        return (List<TrnRmcBatch>)batchRepository.findAll();
    }

    public List<TrnRmcBatchDetail> getBatchDetailsData(){
        logger.info("Fetching batch details data");
        return (List<TrnRmcBatchDetail>)batchDetailRepository.findAll();
    }

    public void generateReports(){
        logger.info("Generating PDF report");
    }
}
