package com.freelance.Batchreports.service;

import com.freelance.Batchreports.constants.FieldConstants;
import com.freelance.Batchreports.dtos.BatchReportDto;
import com.freelance.Batchreports.dtos.GrnReportDto;
import com.freelance.Batchreports.repositories.DataRepository;
import com.freelance.Batchreports.utils.BatchReportUtils;
import com.freelance.Batchreports.utils.GrnReportUtils;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.math.BigDecimal;
import java.util.Map;

@Service
public class ReportService {
    Logger logger = LoggerFactory.getLogger(ReportService.class);

    @Autowired
    private DataRepository dataRepository;;

    @Autowired
    private ServletContext context;

    @Autowired
    private BatchReportUtils batchReportUtils;

    @Autowired
    private GrnReportUtils grnReportUtils;

    @Autowired
    private ResourceLoader resourceLoader;

    public byte[] generateBatchReports(BigDecimal batchNo, BigDecimal id, BigDecimal contactId, BigDecimal plantId, HttpServletResponse response) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
            logger.info("Generating batch report");
            String realPath = ResourceUtils.getFile("classpath:reports").getAbsolutePath() + "/";
            Iterable<Object[]> reportData = dataRepository.getBatchReportsData(batchNo, id, contactId, plantId);
            BatchReportDto batchReportDto = batchReportUtils.formBatchReportsData(reportData);
            File file = ResourceUtils.getFile("classpath:reports/BatchReport.jrxml");
            JasperReport jasperReport = JasperCompileManager.compileReport(file.getAbsolutePath());
            JRDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(batchReportDto.getBatchDetailDtoList());
            Map<String, Object> parameters = batchReportUtils.buildParamMap(batchReportDto);
            parameters.put(FieldConstants.IMAGES, realPath);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, beanCollectionDataSource);
            JasperExportManager.exportReportToPdfStream(jasperPrint, byteArrayOutputStream);
        } catch (Exception e) {
            logger.error("Exception occurred while processing report {}" + e);
        }
        response.setContentType(MediaType.APPLICATION_PDF_VALUE);
        return byteArrayOutputStream.toByteArray();
    }

    public byte[] generateGrnReports(BigDecimal hcId,BigDecimal plantId,BigDecimal vendorId,BigDecimal poId,BigDecimal conId,HttpServletResponse response) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
            logger.info("Generating GRN report");
            //String realPath = ResourceUtils.getFile("classpath:reports").getAbsolutePath() + "/";
            Iterable<Object[]> reportData = dataRepository.getGRNReportsData(hcId,plantId,vendorId,poId,conId);
            GrnReportDto grnReportDto = grnReportUtils.formGrnReport(reportData);
            File file = resourceLoader.getResource("classpath:reports/GrnReport.jrxml").getFile();
            JasperReport jasperReport = JasperCompileManager.compileReport(file.getAbsolutePath());
            JRDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(grnReportDto.getItemList());
            Map<String, Object> parameters = grnReportUtils.buildParamMap(grnReportDto);
            //parameters.put(FieldConstants.IMAGES, realPath);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters,beanCollectionDataSource);
            JasperExportManager.exportReportToPdfStream(jasperPrint, byteArrayOutputStream);
        } catch (Exception e) {
            logger.error("Exception occurred while processing report {}" + e);
        }
        response.setContentType(MediaType.APPLICATION_PDF_VALUE);
        return byteArrayOutputStream.toByteArray();
    }
}
