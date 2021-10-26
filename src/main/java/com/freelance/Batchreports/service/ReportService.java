package com.freelance.Batchreports.service;

import com.freelance.Batchreports.dtos.BatchDetailDto;
import com.freelance.Batchreports.dtos.BatchReportDto;
import com.freelance.Batchreports.entities.TrnRmcBatch;
import com.freelance.Batchreports.entities.TrnRmcBatchDetail;
import com.freelance.Batchreports.repositories.BatchDetailRepository;
import com.freelance.Batchreports.repositories.BatchRepository;
import com.freelance.Batchreports.repositories.PlantRepository;
import com.freelance.Batchreports.repositories.VendorRepository;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.util.JRLoader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    public byte[] generateReports(BigDecimal batchNo, BigDecimal id, BigDecimal contactId, BigDecimal plantId) {
        ByteArrayOutputStream  byteArrayOutputStream = new ByteArrayOutputStream() ;
        try{
            logger.info("Generating PDF report");
            Iterable<Object[]> reportData = batchRepository.getReportsData(batchNo, id,contactId,plantId);
            BatchReportDto  batchReportDto =  formBatchReportsData(reportData);
            String jrxmlPath = "classpath:/reports/docketreport.jrxml";
            String jasperPath = "classpath:/reports/docketreport.jasper";
            JasperCompileManager.compileReportToFile(jrxmlPath,jasperPath);
            File file = new File(jasperPath);
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(file);
            Map<String,Object> parameters = buildParamMap(batchReportDto);
            JasperPrint  jasperPrint = JasperFillManager.fillReport(jasperReport,parameters,new JREmptyDataSource());
            JasperExportManager.exportReportToPdfStream(jasperPrint,byteArrayOutputStream);

        }catch (Exception e){
            logger.error("Exception occurred while processing report");
        }
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
        java.sql.Date batchDate = (java.sql.Date)obj[0];
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


    private BatchReportDto setCalculatedParams(BatchReportDto batchReportDto){
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

    private BatchReportDto setTotalWeightsData(BatchReportDto  batchReportDto){
        batchReportDto.setSilicaActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getSilicaActual().longValue()).sum()));
        batchReportDto.setCement1ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getCement1Actual().longValue()).sum()));
        batchReportDto.setCement2ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getCement2Actual().longValue()).sum()));
        batchReportDto.setFiller1ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getFiller1Actual().longValue()).sum()));
        batchReportDto.setGate1ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getGate1Actual().longValue()).sum()));
        batchReportDto.setGate2ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getGate2Actual().longValue()).sum()));
        batchReportDto.setGate3ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getGate3Actual().longValue()).sum()));
        batchReportDto.setGate4ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getGate4Actual().longValue()).sum()));
        batchReportDto.setGate5ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getGate5Actual().longValue()).sum()));
        batchReportDto.setWater1ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getWater1Actual().longValue()).sum()));
        batchReportDto.setWater2ActualTotal(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getWater2Actual().longValue()).sum()));
        batchReportDto.setAdm1Actual1Total(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getAdm1Actual1().longValue()).sum()));
        batchReportDto.setAdm2Actual1Total(BigDecimal.valueOf(batchReportDto.getBatchDetailDtoList().stream().mapToLong(e->e.getAdm2Actual1().longValue()).sum()));
        return batchReportDto;
    }
    private Map<String,Object> buildParamMap(BatchReportDto  batchReportDto){
        Map<String,Object> map = new HashMap<>();
        return map;
    }
}
