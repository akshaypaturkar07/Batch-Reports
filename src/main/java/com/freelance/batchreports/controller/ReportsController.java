package com.freelance.batchreports.controller;

import com.freelance.batchreports.constants.SwaggerConstants;
import com.freelance.batchreports.entities.TrnRmcBatch;
import com.freelance.batchreports.entities.TrnRmcBatchDetail;
import com.freelance.batchreports.service.ReportService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
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
    @GetMapping(value = "/generatePdfReport",produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<?> generateReport(@RequestParam BigDecimal batchNum, @RequestParam BigDecimal id,
                                            @RequestParam BigDecimal contactId, @RequestParam BigDecimal plantId,
                                            HttpServletResponse response) {
        ResponseEntity responseEntity = null;
        byte[] batchReportDto = null;
        try {
            logger.info("Generating PDF report for batch number " + batchNum);
            batchReportDto = reportService.generateReports(batchNum, id,contactId,plantId,response);
            if(batchReportDto !=null && batchReportDto.length > 0){
                responseEntity = new ResponseEntity<>(batchReportDto, HttpStatus.OK);
            }
        } catch (Exception e) {
            logger.error("Exception occurred while generating PDF reports {}" + e);
            responseEntity = new ResponseEntity<>(batchReportDto, HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return responseEntity;
    }
}
