package com.freelance.Batchreports.service;

import com.freelance.Batchreports.dtos.BatchDetailDto;
import com.freelance.Batchreports.dtos.BatchReportDto;
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
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
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

    public BatchReportDto generateReports(BigDecimal batchNo, BigDecimal id) {
        logger.info("Generating PDF report");
        Iterable<Object[]> reportData = batchRepository.getReportsData(batchNo, id);
        return formBatchReportsData(reportData);
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
        return batchReportDto;
    }

    private BatchDetailDto formBatchDetails(Object[] object) {
        BatchDetailDto batchDetailDto = new BatchDetailDto();
        batchDetailDto.setGate1Actual((BigDecimal) object[31]);
        batchDetailDto.setGate2Actual((BigDecimal) object[32]);
        batchDetailDto.setGate3Actual((BigDecimal) object[33]);
        batchDetailDto.setGate4Actual((BigDecimal) object[34]);
        batchDetailDto.setGate5Actual((BigDecimal) object[35]);
        batchDetailDto.setCement1Actual((BigDecimal) object[36]);
        batchDetailDto.setFiller1Actual((BigDecimal) object[37]);
        batchDetailDto.setWater1Actual((BigDecimal) object[38]);
        batchDetailDto.setWater1Target((BigDecimal) object[39]);
        batchDetailDto.setWater2Actual((BigDecimal) object[40]);
        batchDetailDto.setSilicaActual((BigDecimal) object[41]);
        batchDetailDto.setAdm1Actual1((BigDecimal) object[42]);
        batchDetailDto.setAdm2Actual1((BigDecimal) object[43]);
        return batchDetailDto;
    }

    private BatchReportDto formBatchReports(Object[] obj) {
        BatchReportDto batchReportDto = new BatchReportDto();
        batchReportDto.setBatchDate((Date) obj[0]);
        batchReportDto.setBatchStartTime((String) obj[1]);
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
        batchReportDto.setPlantName((String) obj[44]);
        return batchReportDto;
    }
}
