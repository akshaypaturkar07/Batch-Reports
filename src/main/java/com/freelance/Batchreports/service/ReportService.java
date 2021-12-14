package com.freelance.Batchreports.service;

import com.freelance.Batchreports.constants.FieldConstants;
import com.freelance.Batchreports.dtos.BatchDetailDto;
import com.freelance.Batchreports.dtos.BatchReportDto;
import com.freelance.Batchreports.entities.TrnRmcBatch;
import com.freelance.Batchreports.entities.TrnRmcBatchDetail;
import com.freelance.Batchreports.repositories.BatchDetailRepository;
import com.freelance.Batchreports.repositories.BatchRepository;
import com.freelance.Batchreports.repositories.PlantRepository;
import com.freelance.Batchreports.repositories.VendorRepository;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.apache.commons.lang3.StringUtils;
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
import java.util.*;
import java.util.stream.StreamSupport;

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
    @Autowired
    private ServletContext context;

    public List<TrnRmcBatch> getBatchData() {
        logger.info("Fetching batch data");
        return (List<TrnRmcBatch>) batchRepository.findAll();
    }

    public List<TrnRmcBatchDetail> getBatchDetailsData() {
        logger.info("Fetching batch details data");
        return (List<TrnRmcBatchDetail>) batchDetailRepository.findAll();
    }

    public byte[] generateReports(BigDecimal batchNo, BigDecimal id, BigDecimal contactId, BigDecimal plantId, HttpServletResponse response) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try {
            logger.info("Generating PDF report");
            String realPath = ResourceUtils.getFile("classpath:reports").getAbsolutePath() + "/";
            Iterable<Object[]> reportData = batchRepository.getReportsData(batchNo, id, contactId, plantId);
            BatchReportDto batchReportDto = formBatchReportsData(reportData);
            File file = ResourceUtils.getFile("classpath:reports/docketreport.jrxml");
            JasperReport jasperReport = JasperCompileManager.compileReport(file.getAbsolutePath());
            JRDataSource beanCollectionDataSource = new JRBeanCollectionDataSource(batchReportDto.getBatchDetailDtoList());
            Map<String, Object> parameters = buildParamMap(batchReportDto);
            parameters.put(FieldConstants.IMAGES, realPath);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, beanCollectionDataSource);
            JasperExportManager.exportReportToPdfStream(jasperPrint, byteArrayOutputStream);
        } catch (Exception e) {
            logger.error("Exception occurred while processing report {}" + e);
        }
        response.setContentType(MediaType.APPLICATION_PDF_VALUE);
        return byteArrayOutputStream.toByteArray();
    }

    private BatchReportDto formBatchReportsData(Iterable<Object[]> objects) {
        BatchReportDto batchReportDto = new BatchReportDto();
        List<BatchDetailDto> batchDetailDtoList = new ArrayList<>();
        Optional<Object[]> optionalObjects = StreamSupport.stream(objects.spliterator(), false).findFirst();
        if (optionalObjects.isPresent()) {
            Object[] obj = optionalObjects.get();
            batchReportDto = formBatchReports(obj);
        }
        StreamSupport.stream(objects.spliterator(), false).forEach(object -> {
            BatchDetailDto batchDetailDto = formBatchDetails(object);
            batchDetailDtoList.add(batchDetailDto);
        });
        BatchReportDto finalBatchReportDto = batchReportDto;
        batchDetailDtoList.forEach(e -> setCalculatedParamsByProdQuantity(finalBatchReportDto, e));
        batchDetailDtoList.forEach(e -> setCalculatedParamsByBatchSize(finalBatchReportDto, e));
        batchReportDto.setBatchDetailDtoList(batchDetailDtoList);
        return batchReportDto;
    }

    private BatchDetailDto formBatchDetails(Object[] object) {
        BatchDetailDto batchDetailDto = new BatchDetailDto();
        batchDetailDto.setGate1Actual((BigDecimal) object[44]);
        batchDetailDto.setGate2Actual((BigDecimal) object[45]);
        batchDetailDto.setGate3Actual((BigDecimal) object[46]);
        batchDetailDto.setGate4Actual((BigDecimal) object[47]);
        batchDetailDto.setGate5Actual((BigDecimal) object[48]);
        batchDetailDto.setCement1Actual((BigDecimal) object[49]);
        batchDetailDto.setCement2Actual((BigDecimal) object[50]);
        batchDetailDto.setFiller1Actual((BigDecimal) object[51]);
        batchDetailDto.setWater1Actual((BigDecimal) object[52]);
        batchDetailDto.setWater2Actual((BigDecimal) object[53]);
        batchDetailDto.setSilicaActual((BigDecimal) object[54]);
        batchDetailDto.setAdm1Actual1((BigDecimal) object[55]);
        batchDetailDto.setAdm2Actual1((BigDecimal) object[56]);
        return batchDetailDto;
    }

    private BatchReportDto formBatchReports(Object[] obj) {
        BatchReportDto batchReportDto = new BatchReportDto();
        java.sql.Date batchDate = (java.sql.Date) obj[0];
        batchReportDto.setBatchDate(batchDate.toString().split(",")[0]);
        batchReportDto.setBatchStartTime(String.valueOf(obj[1]));
        batchReportDto.setBatchEndTime((String) obj[2]);
        batchReportDto.setBatchNo((BigDecimal) obj[3]);
        batchReportDto.setSite((String) obj[4]);
        batchReportDto.setRecipeCode((String) obj[5]);
        batchReportDto.setRecipeName((String) obj[6]);
        batchReportDto.setTruckNo((String) obj[7]);
        batchReportDto.setTruckDriver((String) obj[8]);
        batchReportDto.setOrderNo((String) obj[9]);
        batchReportDto.setBatcherName((String) obj[10]);
        batchReportDto.setOrderedQty((BigDecimal) obj[11]);
        batchReportDto.setProductionQty((BigDecimal) obj[12]);
        batchReportDto.setWiththisload((BigDecimal) obj[13]);
        batchReportDto.setMixerCapacity((BigDecimal) obj[14]);
        batchReportDto.setBatchSize((BigDecimal) obj[15]);
        batchReportDto.setPlantRegNo((String) obj[16]);
        batchReportDto.setCustVendorName((String) obj[17]);
        batchReportDto.setAgg1Name((String) obj[18]);
        batchReportDto.setAgg2Name((String) obj[19]);
        batchReportDto.setAgg3Name((String) obj[20]);
        batchReportDto.setAgg4Name((String) obj[21]);
        batchReportDto.setAgg5Name((String) obj[22]);
        batchReportDto.setCement1Name((String) obj[23]);
        batchReportDto.setCement2Name((String) obj[24]);
        batchReportDto.setFillName((String) obj[25]);
        batchReportDto.setWater1Name((String) obj[26]);
        batchReportDto.setWater2Name((String) obj[27]);
        batchReportDto.setSilicaName((String) obj[28]);
        batchReportDto.setAdmix1Name((String) obj[29]);
        batchReportDto.setAdmix2Name((String) obj[30]);
        batchReportDto.setGate1Target((BigDecimal) obj[31]);
        batchReportDto.setGate2Target((BigDecimal) obj[32]);
        batchReportDto.setGate3Target((BigDecimal) obj[33]);
        batchReportDto.setGate4Target((BigDecimal) obj[34]);
        batchReportDto.setGate5Target((BigDecimal) obj[35]);
        batchReportDto.setCement1Target((BigDecimal) obj[36]);
        batchReportDto.setCement2Target((BigDecimal) obj[37]);
        batchReportDto.setFillerTarget((BigDecimal) obj[38]);
        batchReportDto.setWater1Target((BigDecimal) obj[39]);
        batchReportDto.setWater2Target((BigDecimal) obj[40]);
        batchReportDto.setSilicaTarget((BigDecimal) obj[41]);
        batchReportDto.setAdm1Target1((BigDecimal) obj[42]);
        batchReportDto.setAdm1Target2((BigDecimal) obj[43]);
        batchReportDto.setPlantName((String) obj[57]);
        return batchReportDto;
    }

    private Map<String, Object> buildParamMap(BatchReportDto batchReportDto) {
        Map<String, Object> map = new HashMap<>();
        map.put(FieldConstants.BATCH_SIZE, batchReportDto.getBatchSize());
        map.put(FieldConstants.ORDERED_QUANTITY, batchReportDto.getOrderedQty());
        map.put(FieldConstants.WithThisLoad, batchReportDto.getWiththisload());
        map.put(FieldConstants.TRUCK_NUMBER, batchReportDto.getTruckNo());
        map.put(FieldConstants.TRUCK_DRIVER, batchReportDto.getTruckDriver());
        map.put(FieldConstants.SITE, batchReportDto.getSite());
        map.put(FieldConstants.RECIPE_CODE, batchReportDto.getRecipeCode());
        map.put(FieldConstants.RECIPE_NAME, batchReportDto.getRecipeName());
        map.put(FieldConstants.PRODUCTION_QUANTITY, batchReportDto.getProductionQty());
        map.put(FieldConstants.PLANT_SERIAL_NO, batchReportDto.getPlantRegNo());
        map.put(FieldConstants.PLANT_NAME, batchReportDto.getPlantName());
        map.put(FieldConstants.ORDER_NO, StringUtils.isEmpty(batchReportDto.getOrderNo()) ? "NA" : batchReportDto.getOrderNo());
        map.put(FieldConstants.MIXER_QUANTITY, batchReportDto.getMixerCapacity());
        map.put(FieldConstants.MANUAL_QUANTITY, BigDecimal.valueOf(0));
        map.put(FieldConstants.CUSTOMER, batchReportDto.getCustVendorName());
        map.put(FieldConstants.BATCHER_NAME, batchReportDto.getBatcherName());
        map.put(FieldConstants.BATCH_START_TIME, batchReportDto.getBatchStartTime());
        map.put(FieldConstants.BATCH_END_TIME, batchReportDto.getBatchEndTime());
        map.put(FieldConstants.BATCH_DATE, batchReportDto.getBatchDate());
        map.put(FieldConstants.BATCH_NO, batchReportDto.getBatchNo());

        map.put(FieldConstants.AGG1_NAME, StringUtils.isEmpty(batchReportDto.getAgg1Name()) ? "-" : batchReportDto.getAgg1Name());
        map.put(FieldConstants.AGG2_NAME, StringUtils.isEmpty(batchReportDto.getAgg2Name()) ? "-" : batchReportDto.getAgg2Name());
        map.put(FieldConstants.AGG3_NAME, StringUtils.isEmpty(batchReportDto.getAgg3Name()) ? "-" : batchReportDto.getAgg3Name());
        map.put(FieldConstants.AGG4_NAME, StringUtils.isEmpty(batchReportDto.getAgg4Name()) ? "-" : batchReportDto.getAgg4Name());
        map.put(FieldConstants.AGG5_NAME, StringUtils.isEmpty(batchReportDto.getAgg5Name()) ? "-" : batchReportDto.getAgg5Name());
        map.put(FieldConstants.CEMENT1_NAME, StringUtils.isEmpty(batchReportDto.getCement1Name()) ? "-" : batchReportDto.getCement1Name());
        map.put(FieldConstants.CEMENT2_NAME, StringUtils.isEmpty(batchReportDto.getCement2Name()) ? "-" : batchReportDto.getCement2Name());
        map.put(FieldConstants.FILL_NAME, StringUtils.isEmpty(batchReportDto.getFillName()) ? "-" : batchReportDto.getFillName());
        map.put(FieldConstants.WATER1_NAME, StringUtils.isEmpty(batchReportDto.getWater1Name()) ? "-" : batchReportDto.getWater1Name());
        map.put(FieldConstants.WATER2_NAME, StringUtils.isEmpty(batchReportDto.getWater2Name()) ? "-" : batchReportDto.getWater2Name());
        map.put(FieldConstants.SILICA_NAME, StringUtils.isEmpty(batchReportDto.getSilicaName()) ? "-" : batchReportDto.getSilicaName());
        map.put(FieldConstants.ADMIX1_NAME, StringUtils.isEmpty(batchReportDto.getAdmix1Name()) ? "-" : batchReportDto.getAdmix1Name());
        map.put(FieldConstants.ADMIX2_NAME, StringUtils.isEmpty(batchReportDto.getAdmix2Name()) ? "-" : batchReportDto.getAdmix2Name());

        map.put(FieldConstants.GATE1_TARGET, batchReportDto.getGate1());
        map.put(FieldConstants.GATE2_TARGET, batchReportDto.getGate2());
        map.put(FieldConstants.GATE3_TARGET, batchReportDto.getGate3());
        map.put(FieldConstants.GATE4_TARGET, batchReportDto.getGate4());
        map.put(FieldConstants.GATE5_TARGET, batchReportDto.getGate5());
        map.put(FieldConstants.CEMENT1_TARGET, batchReportDto.getCement1());
        map.put(FieldConstants.CEMENT2_TARGET, batchReportDto.getCement2());
        map.put(FieldConstants.FILLER_TARGET, batchReportDto.getFiller());
        map.put(FieldConstants.WATER1_TARGET, batchReportDto.getWater1());
        map.put(FieldConstants.WATER2_TARGET, batchReportDto.getWater2());
        map.put(FieldConstants.SILICA_TARGET, batchReportDto.getSilica());
        map.put(FieldConstants.ADM1_TARGET1, batchReportDto.getAdm1());
        map.put(FieldConstants.ADM1_TARGET2, batchReportDto.getAdm2());
        return map;
    }

    private BatchDetailDto setCalculatedParamsByProdQuantity(BatchReportDto batchReportDto, BatchDetailDto batchDetailDto) {
        batchDetailDto.setGate1TotalSet(batchReportDto.getGate1Target().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setGate2TotalSet(batchReportDto.getGate2Target().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setGate3TotalSet(batchReportDto.getGate3Target().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setGate4TotalSet(batchReportDto.getGate4Target().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setGate5TotalSet(batchReportDto.getGate5Target().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setCement1TotalSet(batchReportDto.getCement1Target().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setCement2TotalSet(batchReportDto.getCement2Target().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setFillerTotalSet(batchReportDto.getFillerTarget().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setWater1TotalSet(batchReportDto.getWater1Target().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setWater2TotalSet(batchReportDto.getWater2Target().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setSilicaTotalSet(batchReportDto.getSilicaTarget().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setAdm1TotalSet(batchReportDto.getAdm1Target1().multiply(batchReportDto.getProductionQty()));
        batchDetailDto.setAdm2TotalSet(batchReportDto.getAdm1Target2().multiply(batchReportDto.getProductionQty()));
        return batchDetailDto;
    }

    private BatchDetailDto setCalculatedParamsByBatchSize(BatchReportDto batchReportDto, BatchDetailDto batchDetailDto) {
        batchReportDto.setGate1(batchReportDto.getGate1Target().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setGate2(batchReportDto.getGate2Target().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setGate3(batchReportDto.getGate3Target().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setGate4(batchReportDto.getGate4Target().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setGate5(batchReportDto.getGate5Target().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setCement1(batchReportDto.getCement1Target().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setCement2(batchReportDto.getCement2Target().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setFiller(batchReportDto.getFillerTarget().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setWater1(batchReportDto.getWater1Target().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setWater2(batchReportDto.getWater2Target().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setSilica(batchReportDto.getSilicaTarget().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setAdm1(batchReportDto.getAdm1Target1().multiply(batchReportDto.getBatchSize()));
        batchReportDto.setAdm2(batchReportDto.getAdm1Target2().multiply(batchReportDto.getBatchSize()));
        return batchDetailDto;
    }


}
