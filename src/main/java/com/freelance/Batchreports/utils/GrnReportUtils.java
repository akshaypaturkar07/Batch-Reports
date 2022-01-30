package com.freelance.Batchreports.utils;

import com.freelance.Batchreports.constants.FieldConstants;
import com.freelance.Batchreports.dtos.BatchDetailDto;
import com.freelance.Batchreports.dtos.BatchReportDto;
import com.freelance.Batchreports.dtos.GrnReportDto;
import com.freelance.Batchreports.dtos.ItemDto;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
@Service
public class GrnReportUtils {

    public GrnReportDto formGrnReport(Iterable<Object[]> objects) {
        GrnReportDto grnReportDto = new GrnReportDto();
        Set<ItemDto> items = new HashSet<>();
        Optional<Object[]> optionalObjects = StreamSupport.stream(objects.spliterator(), false).findFirst();
        if (optionalObjects.isPresent()) {
            Object[] obj = optionalObjects.get();
            grnReportDto = formGrnData(obj);
        }
        StreamSupport.stream(objects.spliterator(), false).forEach(object -> {
            ItemDto itemDto = formItemsData(object);
            items.add(itemDto);
        });
        grnReportDto.setItemList(items);
        return grnReportDto;
    }
    
    private GrnReportDto formGrnData(Object[] obj){
        GrnReportDto grnReportDto = new GrnReportDto();
        grnReportDto.setCompanyName(String.valueOf(obj[0]));
        grnReportDto.setCompanyAddress(String.valueOf(obj[1]));
        grnReportDto.setMobileNo(String.valueOf(obj[2]));
        grnReportDto.setGrnCode(String.valueOf(obj[3]));
        grnReportDto.setGrnDate(String.valueOf(obj[4]));
        grnReportDto.setPoId(String.valueOf(obj[5]));
        grnReportDto.setPoDate(String.valueOf(obj[6]));
        grnReportDto.setPlantName(String.valueOf(obj[7]));
        grnReportDto.setRefChallanNo(String.valueOf(obj[8]));
        grnReportDto.setVehicleNo(String.valueOf(obj[9]));
        grnReportDto.setCustVendorName(String.valueOf(obj[10]));
        grnReportDto.setCustVendorAddress(String.valueOf(obj[11]));
        grnReportDto.setSupplierGstNo(String.valueOf(obj[12]));
        grnReportDto.setConsineeGstNo(String.valueOf(obj[13]));
        grnReportDto.setStateName(String.valueOf(obj[24]));
        grnReportDto.setStateCode(String.valueOf(obj[25]));
        return grnReportDto;
    }

    private ItemDto formItemsData(Object[] obj){
        ItemDto itemDto = new ItemDto();
        itemDto.setItemCode(String.valueOf(obj[14]));
        itemDto.setItemDesc(String.valueOf(obj[15]));
        itemDto.setUnitName(String.valueOf(obj[16]));
        itemDto.setItemQuantity((BigDecimal) obj[17]);
        itemDto.setUnitRate((BigDecimal)obj[18]);
        itemDto.setCgstRate((BigDecimal) obj[19]);
        itemDto.setSgstRate((BigDecimal) obj[20]);
        itemDto.setIgstRate((BigDecimal) obj[21]);
        itemDto.setDiscPercent((BigDecimal) obj[22]);
        itemDto.setFreightCharge((BigDecimal) obj[23]);
        return itemDto;
    }

    public Map<String, Object> buildParamMap(GrnReportDto grnReportDto) {
        Map<String, Object> map = new HashMap<>();
        map.put(FieldConstants.COMPANY_NAME,grnReportDto.getCompanyName());
        map.put(FieldConstants.COMPANY_ADDRESS,grnReportDto.getCompanyAddress());
        map.put(FieldConstants.MOBILE_NO,grnReportDto.getMobileNo());
        map.put(FieldConstants.GRN_CODE,grnReportDto.getGrnCode());
        map.put(FieldConstants.GRN_DATE,grnReportDto.getGrnDate());
        map.put(FieldConstants.PO_ID,grnReportDto.getPoId());
        map.put(FieldConstants.PO_DATE,grnReportDto.getPoDate());
        map.put(FieldConstants.PLANT_NAME,grnReportDto.getPlantName());
        map.put(FieldConstants.CHALLAN_NO,grnReportDto.getRefChallanNo());
        map.put(FieldConstants.VEHICLE_NO,grnReportDto.getVehicleNo());
        map.put(FieldConstants.DRIVER_NO,"8965874565");
        map.put(FieldConstants.CUST_VENDOR_NAME,grnReportDto.getCustVendorName());
        map.put(FieldConstants.CUST_VENDOR_ADDRESS,grnReportDto.getCustVendorAddress());
        map.put(FieldConstants.GST_NO,grnReportDto.getSupplierGstNo());
        map.put(FieldConstants.GST_NUM,grnReportDto.getConsineeGstNo());
        map.put(FieldConstants.STATE_NAME,grnReportDto.getStateName());
        map.put(FieldConstants.STATE_CODE,grnReportDto.getStateCode());
        return map;
    }

    }
