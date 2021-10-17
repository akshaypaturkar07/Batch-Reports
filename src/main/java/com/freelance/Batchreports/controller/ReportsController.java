package com.freelance.Batchreports.controller;

import com.freelance.Batchreports.entities.TrnRmcBatch;
import com.freelance.Batchreports.entities.TrnRmcBatchDetail;
import com.freelance.Batchreports.repositories.BatchDetailRepository;
import com.freelance.Batchreports.repositories.BatchRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/reports")
public class ReportsController {
    @Autowired
    private BatchRepository batchRepository;
    @Autowired
    private BatchDetailRepository batchDetailRepository;

    @GetMapping("/batch")
    public List<TrnRmcBatch> getBatchData(){
       return (List<TrnRmcBatch>)batchRepository.findAll();
    }

    @GetMapping("/batchDetail")
    public List<TrnRmcBatchDetail> getBatchDetailsData(){
        return (List<TrnRmcBatchDetail>)batchDetailRepository.findAll();
    }
}
