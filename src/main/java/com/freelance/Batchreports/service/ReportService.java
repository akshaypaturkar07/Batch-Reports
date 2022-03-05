package com.freelance.Batchreports.service;

import com.freelance.Batchreports.constants.FieldConstants;
import com.freelance.Batchreports.dtos.BatchReportDto;
import com.freelance.Batchreports.dtos.GrnReportDto;
import com.freelance.Batchreports.dtos.POItem;
import com.freelance.Batchreports.dtos.POReportDto;
import com.freelance.Batchreports.repositories.DataRepository;
import com.freelance.Batchreports.utils.BatchReportUtils;
import com.freelance.Batchreports.utils.CurrencyUtils;
import com.freelance.Batchreports.utils.GrnReportUtils;
import com.freelance.Batchreports.utils.PoReportUtils;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
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
    private PoReportUtils poReportUtils;

    @Autowired
    private CurrencyUtils currencyUtils;

    public byte[] generateBatchReports(BigDecimal batchNo, BigDecimal id, BigDecimal contactId, BigDecimal plantId, HttpServletResponse response) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
            logger.info("Generating batch report");
            String realPath = ResourceUtils.getFile("classpath:reports").getAbsolutePath() + "/";
            Iterable<Object[]> reportData = dataRepository.getBatchReportsData(batchNo, id, contactId, plantId);
            BatchReportDto batchReportDto = batchReportUtils.formBatchReportsData(reportData);
            File file = ResourceUtils.getFile("classpath:reports/batchreport.jrxml");
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
            String realPath = ResourceUtils.getFile("classpath:reports").getAbsolutePath() + "\\";
            Iterable<Object[]> reportData = dataRepository.getGRNReportsData(hcId,plantId,vendorId,poId,conId);
            GrnReportDto grnReportDto = grnReportUtils.formGrnReport(reportData);
            grnReportDto.getItemList().stream().findFirst().get().setAmountInWords(grnReportDto.getAmountInWords());
            grnReportDto.getItemList().stream().findFirst().get().setTaxAmountInWords(grnReportDto.getTaxAmountInWords());
            grnReportDto.getItemList().stream().findFirst().get().setGrandTotal(grnReportUtils.calculateTotalAmount(grnReportDto.getItemList()));
            grnReportDto.setGrandTotal(grnReportUtils.calculateTotalAmount(grnReportDto.getItemList()));
            File file = ResourceUtils.getFile("classpath:reports/grnreport.jrxml");
            JasperReport jasperReport = JasperCompileManager.compileReport(file.getAbsolutePath());
            JRDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(grnReportDto.getItemList());
            Map<String, Object> parameters = grnReportUtils.buildParamMap(grnReportDto);
            parameters.put(FieldConstants.IMAGES, realPath);
            parameters.put(FieldConstants.GRAND_TOTAL,grnReportDto.getGrandTotal().setScale(2, BigDecimal.ROUND_UP));
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters,beanCollectionDataSource);
            JasperExportManager.exportReportToPdfStream(jasperPrint, byteArrayOutputStream);
        } catch (Exception e) {
            logger.error("Exception occurred while processing report {}" + e);
        }
        response.setContentType(MediaType.APPLICATION_PDF_VALUE);
        return byteArrayOutputStream.toByteArray();
    }

    public byte[] generatePOReports(BigDecimal poId,HttpServletResponse response) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
            logger.info("Generating PO report");
            String realPath = ResourceUtils.getFile("classpath:reports").getAbsolutePath() + "\\";
            Iterable<Object[]> reportData = dataRepository.getPOReportsData(poId);
            POReportDto poReportDto = poReportUtils.formPOReport(reportData);
            BigDecimal subTotal = BigDecimal.valueOf(poReportDto.getPoItemSet().stream().mapToLong(e->e.getTotal().longValue()).sum()).setScale(2, RoundingMode.HALF_UP);
            BigDecimal cgstRate1 = subTotal.multiply(poReportDto.getCgstRate1()).divide(BigDecimal.valueOf(100)).setScale(2, RoundingMode.HALF_UP);
            BigDecimal sgstRate1 = subTotal.multiply(poReportDto.getSgstRate1()).divide(BigDecimal.valueOf(100)).setScale(2, RoundingMode.HALF_UP);
            BigDecimal cgstRate2 = subTotal.multiply(poReportDto.getCgstRate2()).divide(BigDecimal.valueOf(100)).setScale(2, RoundingMode.HALF_UP);
            BigDecimal sgstRate2 = subTotal.multiply(poReportDto.getSgstRate2()).divide(BigDecimal.valueOf(100)).setScale(2, RoundingMode.HALF_UP);
            BigDecimal discount = subTotal.multiply(poReportDto.getPoItemSet().stream().findFirst().get().getDiscount()).divide(BigDecimal.valueOf(100)).setScale(2, RoundingMode.HALF_UP);
            BigDecimal total = subTotal.add(cgstRate2).add(cgstRate2).add(sgstRate1).add(sgstRate2).add(poReportDto.getFreightCharge()).subtract(discount).setScale(2, RoundingMode.HALF_UP);
            File file = ResourceUtils.getFile("classpath:reports/po_report.jrxml");
            JasperReport jasperReport = JasperCompileManager.compileReport(file.getAbsolutePath());
            Map<String, Object> parameters = poReportUtils.buildParamMap(poReportDto);
            parameters.put(FieldConstants.IMAGES, realPath);
            poReportDto.getPoItemSet().stream().findFirst().get().setSubTotal(subTotal);
            poReportDto.getPoItemSet().stream().findFirst().get().setCgstRate1(cgstRate1);
            poReportDto.getPoItemSet().stream().findFirst().get().setSgstRate1(sgstRate1);
            poReportDto.getPoItemSet().stream().findFirst().get().setCgstRate2(cgstRate2);
            poReportDto.getPoItemSet().stream().findFirst().get().setSgstRate2(sgstRate2);
            poReportDto.getPoItemSet().stream().findFirst().get().setDocTotal(total);
            poReportDto.getPoItemSet().stream().findFirst().get().setDocTotalInWords(currencyUtils.convertToIndianCurrency(total));
            JRDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(poReportDto.getPoItemSet());
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters,beanCollectionDataSource);
            JasperExportManager.exportReportToPdfStream(jasperPrint, byteArrayOutputStream);
        } catch (Exception e) {
            logger.error("Exception occurred while processing report {}" + e);
        }
        response.setContentType(MediaType.APPLICATION_PDF_VALUE);
        return byteArrayOutputStream.toByteArray();
    }
}
