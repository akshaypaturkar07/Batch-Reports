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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

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
            Iterable<Object[]> reportData = batchRepository.getReportsData(batchNo, id, contactId, plantId);
            BatchReportDto batchReportDto = formBatchReportsData(reportData);
            File file = ResourceUtils.getFile("classpath:reports/docketreport.jrxml");
            JasperReport jasperReport = JasperCompileManager.compileReport(file.getAbsolutePath());
            JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(batchReportDto.getBatchDetailDtoList());
            Map<String, Object> parameters = buildParamMap(batchReportDto);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, new JREmptyDataSource());
            JasperExportManager.exportReportToPdfStream(jasperPrint, byteArrayOutputStream);
        } catch (Exception e) {
            logger.error("Exception occurred while processing report {}"+e);
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
        batchReportDto.setBatchDetailDtoList(batchDetailDtoList);
        batchReportDto = setTotalWeightsData(batchReportDto);
        return setCalculatedParams(batchReportDto);
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


    private BatchReportDto setCalculatedParams(BatchReportDto batchReportDto) {
        int batchSize = batchReportDto.getBatchDetailDtoList().size();
        batchReportDto.setFillNameNX(batchReportDto.getFillerTarget().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setSilicaNameNX(batchReportDto.getSilicaTarget().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setAdmix2NameNX(batchReportDto.getAdm1Target2().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setAgg5NameNX(batchReportDto.getGate5Target().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setAgg4NameNX(batchReportDto.getGate4Target().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setAgg3NameNX(batchReportDto.getGate3Target().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setAgg2NameNX(batchReportDto.getGate2Target().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setAgg1NameNX(batchReportDto.getGate1Target().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setCement2NameNX(batchReportDto.getCement2Target().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setWater2NameNX(batchReportDto.getWater2Target().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setWater1NameNX(batchReportDto.getWater1Target().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setAdmix1NameNX(batchReportDto.getAdm1Target1().multiply(BigDecimal.valueOf(batchSize)));
        batchReportDto.setCement1NameNX(batchReportDto.getCement1Target().multiply(BigDecimal.valueOf(batchSize)));
        return batchReportDto;
    }

    private BatchReportDto setTotalWeightsData(BatchReportDto batchReportDto) {
        batchReportDto.setSilicaActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getSilicaActual().longValue()).sum()));
        batchReportDto.setCement1ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getCement1Actual().longValue()).sum()));
        batchReportDto.setCement2ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getCement2Actual().longValue()).sum()));
        batchReportDto.setFiller1ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getFiller1Actual().longValue()).sum()));
        batchReportDto.setGate1ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getGate1Actual().longValue()).sum()));
        batchReportDto.setGate2ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getGate2Actual().longValue()).sum()));
        batchReportDto.setGate3ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getGate3Actual().longValue()).sum()));
        batchReportDto.setGate4ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getGate4Actual().longValue()).sum()));
        batchReportDto.setGate5ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getGate5Actual().longValue()).sum()));
        batchReportDto.setWater1ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getWater1Actual().longValue()).sum()));
        batchReportDto.setWater2ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getWater2Actual().longValue()).sum()));
        batchReportDto.setAdm1Actual1Total(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getAdm1Actual1().longValue()).sum()));
        batchReportDto.setAdm2Actual1Total(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e -> e.getAdm2Actual1().longValue()).sum()));
        return batchReportDto;
    }

    private Map<String, Object> buildParamMap(BatchReportDto batchReportDto) {
        Map<String, Object> map = new HashMap<>();
        map.put(FieldConstants.BATCH_SIZE,batchReportDto.getBatchSize());
        map.put(FieldConstants.ORDERED_QUANTITY,batchReportDto.getOrderedQty());
        map.put(FieldConstants.WithThisLoad,batchReportDto.getWiththisload());
        map.put(FieldConstants.TRUCK_NUMBER,batchReportDto.getTruckNo());
        map.put(FieldConstants.TRUCK_DRIVER,batchReportDto.getTruckDriver());
        map.put(FieldConstants.SITE,batchReportDto.getSite());
        map.put(FieldConstants.RECIPE_CODE,batchReportDto.getRecipeCode());
        map.put(FieldConstants.RECIPE_NAME,batchReportDto.getRecipeName());
        map.put(FieldConstants.PRODUCTION_QUANTITY,batchReportDto.getProductionQty());
        map.put(FieldConstants.PLANT_SERIAL_NO,batchReportDto.getPlantRegNo());
        map.put(FieldConstants.PLANT_NAME,batchReportDto.getPlantName());
        map.put(FieldConstants.ORDER_NO,batchReportDto.getOrderNo());
        map.put(FieldConstants.MIXER_QUANTITY,batchReportDto.getMixerCapacity());
        map.put(FieldConstants.MANUAL_QUANTITY,null);
        map.put(FieldConstants.CUSTOMER,batchReportDto.getCustVendorName());
        map.put(FieldConstants.BATCHER_NAME,batchReportDto.getBatcherName());
        map.put(FieldConstants.BATCH_START_TIME,batchReportDto.getBatchStartTime());
        map.put(FieldConstants.BATCH_END_TIME,batchReportDto.getBatchEndTime());
        map.put(FieldConstants.BATCH_DATE,batchReportDto.getBatchDate());
        map.put(FieldConstants.BATCH_NO,batchReportDto.getBatchNo());
        map.put(FieldConstants.AGG1_NAME,batchReportDto.getAgg1Name());
        map.put(FieldConstants.AGG2_NAME,batchReportDto.getAgg2Name());
        map.put(FieldConstants.AGG3_NAME,batchReportDto.getAgg3Name());
        map.put(FieldConstants.AGG4_NAME,batchReportDto.getAgg4Name());
        map.put(FieldConstants.AGG5_NAME,batchReportDto.getAgg5Name());
        map.put(FieldConstants.CEMENT1_NAME,batchReportDto.getCement1Name());
        map.put(FieldConstants.CEMENT2_NAME,batchReportDto.getCement2Name());
        map.put(FieldConstants.FILL_NAME,batchReportDto.getFillName());
        map.put(FieldConstants.WATER1_NAME,batchReportDto.getWater1Name());
        map.put(FieldConstants.WATER2_NAME,batchReportDto.getWater2Name());
        map.put(FieldConstants.SILICA_NAME,batchReportDto.getSilicaName());
        map.put(FieldConstants.ADMIX1_NAME,batchReportDto.getAdmix1Name());
        map.put(FieldConstants.ADMIX2_NAME,batchReportDto.getAdmix2Name());

        map.put(FieldConstants.GATE1_TARGET,batchReportDto.getGate1Target());
        map.put(FieldConstants.GATE2_TARGET,batchReportDto.getGate2Target());
        map.put(FieldConstants.GATE3_TARGET,batchReportDto.getGate3Target());
        map.put(FieldConstants.GATE4_TARGET,batchReportDto.getGate4Target());
        map.put(FieldConstants.GATE5_TARGET,batchReportDto.getGate5Target());
        map.put(FieldConstants.CEMENT1_TARGET,batchReportDto.getCement1Target());
        map.put(FieldConstants.CEMENT2_TARGET,batchReportDto.getCement2Target());
        map.put(FieldConstants.FILLER_TARGET,batchReportDto.getFillerTarget());
        map.put(FieldConstants.WATER1_TARGET,batchReportDto.getWater1Target());
        map.put(FieldConstants.WATER2_TARGET,batchReportDto.getWater2Target());
        map.put(FieldConstants.SILICA_TARGET,batchReportDto.getSilicaTarget());
        map.put(FieldConstants.ADM1_TARGET1,batchReportDto.getAdm1Target1());
        map.put(FieldConstants.ADM1_TARGET2,batchReportDto.getAdm1Target2());

        map.put(FieldConstants.GATE1_TARGET,batchReportDto.getGate1Target());
        map.put(FieldConstants.GATE2_TARGET,batchReportDto.getGate2Target());
        map.put(FieldConstants.GATE3_TARGET,batchReportDto.getGate3Target());
        map.put(FieldConstants.GATE4_TARGET,batchReportDto.getGate4Target());
        map.put(FieldConstants.GATE5_TARGET,batchReportDto.getGate5Target());
        map.put(FieldConstants.CEMENT1_TARGET,batchReportDto.getCement1Target());
        map.put(FieldConstants.CEMENT2_TARGET,batchReportDto.getCement2Target());
        map.put(FieldConstants.FILLER_TARGET,batchReportDto.getFillerTarget());
        map.put(FieldConstants.WATER1_TARGET,batchReportDto.getWater1Target());
        map.put(FieldConstants.WATER2_TARGET,batchReportDto.getWater2Target());
        map.put(FieldConstants.SILICA_TARGET,batchReportDto.getSilicaTarget());
        map.put(FieldConstants.ADM1_TARGET1,batchReportDto.getAdm1Target1());
        map.put(FieldConstants.ADM1_TARGET2,batchReportDto.getAdm1Target2());

        map.put(FieldConstants.GATE1_ACTUAL_TOTAL,batchReportDto.getGate1ActualTotal());
        map.put(FieldConstants.GATE2_ACTUAL_TOTAL,batchReportDto.getGate2ActualTotal());
        map.put(FieldConstants.GATE3_ACTUAL_TOTAL,batchReportDto.getGate3ActualTotal());
        map.put(FieldConstants.GATE4_ACTUAL_TOTAL,batchReportDto.getGate4ActualTotal());
        map.put(FieldConstants.GATE5_ACTUAL_TOTAL,batchReportDto.getGate5ActualTotal());
        map.put(FieldConstants.CEMENT1_ACTUAL_TOTAL,batchReportDto.getCement1ActualTotal());
        map.put(FieldConstants.CEMENT2_ACTUAL_TOTAL,batchReportDto.getCement2ActualTotal());
        map.put(FieldConstants.FILLER1_ACTUAL_TOTAL,batchReportDto.getFiller1ActualTotal());
        map.put(FieldConstants.WATER1_ACTUAL_TOTAL,batchReportDto.getWater1ActualTotal());
        map.put(FieldConstants.WATER2_ACTUAL_TOTAL,batchReportDto.getWater2ActualTotal());
        map.put(FieldConstants.SILICA_ACTUAL_TOTAL,batchReportDto.getSilicaActualTotal());
        map.put(FieldConstants.ADM1_ACTUAL_TOTAL,batchReportDto.getAdm1Actual1Total());
        map.put(FieldConstants.ADM2_ACTUAL_TOTAL,batchReportDto.getAdm1Actual1Total());

        map.put(FieldConstants.AGG1_NAMEX,batchReportDto.getAgg1NameNX());
        map.put(FieldConstants.AGG2_NAMEX,batchReportDto.getAgg2NameNX());
        map.put(FieldConstants.AGG3_NAMEX,batchReportDto.getAgg3NameNX());
        map.put(FieldConstants.AGG4_NAMEX,batchReportDto.getAgg4NameNX());
        map.put(FieldConstants.AGG5_NAMEX,batchReportDto.getAgg5NameNX());
        map.put(FieldConstants.CEMENT1_NAMEX,batchReportDto.getCement1NameNX());
        map.put(FieldConstants.CEMENT2_NAMEX,batchReportDto.getCement2NameNX());
        map.put(FieldConstants.FILL_NAMEX,batchReportDto.getFillNameNX());
        map.put(FieldConstants.WATER1NAMEX,batchReportDto.getWater1NameNX());
        map.put(FieldConstants.WATER2NAMEX,batchReportDto.getWater2NameNX());
        map.put(FieldConstants.SILICANAMEX,batchReportDto.getSilicaNameNX());
        map.put(FieldConstants.ADMIX1_NAME,batchReportDto.getAdmix1NameNX());
        map.put(FieldConstants.ADMIX2_NAME,batchReportDto.getAdmix2NameNX());

        return map;
    }
}
