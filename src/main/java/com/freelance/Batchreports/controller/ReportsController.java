package com.freelance.Batchreports.controller;

import com.freelance.Batchreports.constants.SwaggerConstants;
import com.freelance.Batchreports.dtos.BatchReportDto;
import com.freelance.Batchreports.entities.TrnRmcBatch;
import com.freelance.Batchreports.entities.TrnRmcBatchDetail;
import com.freelance.Batchreports.service.ReportService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/reports")
public class ReportsController {
    Logger logger = LoggerFactory.getLogger(ReportsController.class);

    @Autowired
    private ReportService reportService;

    @ApiOperation(value = SwaggerConstants.GET_BATCH_DATA, nickname = SwaggerConstants.GET_BATCH_DATA_NICK)
    @ApiResponses(value = {@ApiResponse(code = 200, message = SwaggerConstants.GET_BATCH_DATA_200_OK)})
    @GetMapping("/batch")
    public List<TrnRmcBatch> getBatchData() {
        return reportService.getBatchData();
    }

    @ApiOperation(value = SwaggerConstants.GET_BATCH_DETAIL_DATA, nickname = SwaggerConstants.GET_BATCH_DETAIL_DATA_NICK)
    @ApiResponses(value = {@ApiResponse(code = 200, message = SwaggerConstants.GET_BATCH_DETAIL_DATA_200_OK)})
    @GetMapping("/batchDetail")
    public List<TrnRmcBatchDetail> getBatchDetailsData() {
        return reportService.getBatchDetailsData();
    }

    @ApiOperation(value = SwaggerConstants.GENERATE_PDF, nickname = SwaggerConstants.GENERATE_PDF_NICK)
    @ApiResponses(value = {@ApiResponse(code = 200, message = SwaggerConstants.GENERATE_PDF_200_OK)})
    @GetMapping("/generatePdfReport")
    public ResponseEntity<?> generateReport(@RequestParam BigDecimal batchNum, @RequestParam BigDecimal id) {
        ResponseEntity responseEntity;
        BatchReportDto batchReportDto = null;
        try {
            logger.info("Generating PDF report for batch number " + batchNum);
            batchReportDto = reportService.generateReports(batchNum, id);
            responseEntity = new ResponseEntity<>(batchReportDto, HttpStatus.OK);
        } catch (Exception e) {
            logger.error("Exception occurred while generating PDF reports {}" + e);
            responseEntity = new ResponseEntity<>(batchReportDto, HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return responseEntity;
    }
}
