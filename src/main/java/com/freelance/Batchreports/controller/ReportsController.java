package com.freelance.Batchreports.controller;

import com.freelance.Batchreports.constants.SwaggerConstants;
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

    @ApiOperation(value = SwaggerConstants.GENERATE_BATCH_REPORT, nickname = SwaggerConstants.GENERATE_BATCH_REPORT_NICK)
    @ApiResponses(value = {@ApiResponse(code = 200, message = SwaggerConstants.GENERATE_BATCH_REPORT_200_OK)})
    @GetMapping(value = "/batchReport",produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<?> generateReport(@RequestParam BigDecimal batchNum, @RequestParam BigDecimal id,
                                            @RequestParam BigDecimal contactId, @RequestParam BigDecimal plantId,
                                            HttpServletResponse response) {
        ResponseEntity responseEntity = null;
        byte[] batchReportDto = null;
        try {
            logger.info("Generating batch report for batch number " + batchNum);
            batchReportDto = reportService.generateBatchReports(batchNum, id,contactId,plantId,response);
            if(batchReportDto !=null && batchReportDto.length > 0){
                responseEntity = new ResponseEntity<>(batchReportDto, HttpStatus.OK);
            }
        } catch (Exception e) {
            logger.error("Exception occurred while generating batch reports {}" + e);
            responseEntity = new ResponseEntity<>(batchReportDto, HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return responseEntity;
    }

    @ApiOperation(value = SwaggerConstants.GENERATE_GRN_REPORT, nickname = SwaggerConstants.GENERATE_GRN_REPORT_NICK)
    @ApiResponses(value = {@ApiResponse(code = 200, message = SwaggerConstants.GENERATE_GRN_REPORT_200_OK)})
    @GetMapping(value = "/grnReport",produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<?> generateGrnReport(@RequestParam BigDecimal hcId, @RequestParam BigDecimal plantId,
                                               @RequestParam BigDecimal vendorId, @RequestParam BigDecimal poId,@RequestParam BigDecimal conId,HttpServletResponse response) {
        ResponseEntity responseEntity = null;
        byte[] grnReportDto = null;
        try {
            grnReportDto = reportService.generateGrnReports(hcId,plantId,vendorId,poId,conId,response);
            if(grnReportDto !=null && grnReportDto.length > 0){
                responseEntity = new ResponseEntity<>(grnReportDto, HttpStatus.OK);
            }
        } catch (Exception e) {
            logger.error("Exception occurred while generating GRN reports {}" + e);
            responseEntity = new ResponseEntity<>(grnReportDto, HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return responseEntity;
    }

    @ApiOperation(value = SwaggerConstants.GENERATE_GRN_REPORT, nickname = SwaggerConstants.GENERATE_GRN_REPORT_NICK)
    @ApiResponses(value = {@ApiResponse(code = 200, message = SwaggerConstants.GENERATE_GRN_REPORT_200_OK)})
    @GetMapping(value = "/poReport",produces = MediaType.APPLICATION_PDF_VALUE)
    public ResponseEntity<?> generatePOReport(@RequestParam BigDecimal poId,HttpServletResponse response) {
        ResponseEntity responseEntity = null;
        byte[] poReportDto = null;
        try {
            poReportDto = reportService.generatePOReports(poId,response);
            if(poReportDto !=null && poReportDto.length > 0){
                responseEntity = new ResponseEntity<>(poReportDto, HttpStatus.OK);
            }
        } catch (Exception e) {
            logger.error("Exception occurred while generating PO reports {}" + e);
            responseEntity = new ResponseEntity<>(poReportDto, HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return responseEntity;
    }
}
