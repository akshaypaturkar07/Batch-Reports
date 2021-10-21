package com.freelance.Batchreports.service;

import com.freelance.Batchreports.entities.TrnRmcBatch;
import com.freelance.Batchreports.entities.TrnRmcBatchDetail;
import com.freelance.Batchreports.repositories.BatchDetailRepository;
import com.freelance.Batchreports.repositories.BatchRepository;
import com.freelance.Batchreports.repositories.PlantRepository;
import com.freelance.Batchreports.repositories.VendorRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class ReportService {
    Logger logger = LoggerFactory.getLogger(ReportService.class);

    @Autowired
    private BatchRepository batchRepository;
    @Autowired
    private BatchDetailRepository batchDetailRepository;
    @Autowired
    private VendorRepository vendorRepository;
    @Autowired
    private PlantRepository plantRepository;

    public List<TrnRmcBatch> getBatchData(){
        logger.info("Fetching batch data");
        return (List<TrnRmcBatch>)batchRepository.findAll();
    }

    public List<TrnRmcBatchDetail> getBatchDetailsData(){
        logger.info("Fetching batch details data");
        return (List<TrnRmcBatchDetail>)batchDetailRepository.findAll();
    }

    public void generateReports(BigDecimal batchNo,BigDecimal id){
        logger.info("Generating PDF report");
        String customerName = vendorRepository.getCustomerName(id);
        String planSerialNumber = plantRepository.getPlantSerialNumber(id);
        Object batch = batchRepository.getBatchByBatchNo(batchNo,id);
        Iterable<Object[]> batchDetails = batchDetailRepository.getBatchDetailsByBatchNo(batchNo,id);

    }
}
