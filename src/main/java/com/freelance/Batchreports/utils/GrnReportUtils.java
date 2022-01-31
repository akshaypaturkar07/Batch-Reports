package com.freelance.Batchreports.utils;

import com.freelance.Batchreports.constants.FieldConstants;
import com.freelance.Batchreports.dtos.GrnReportDto;
import com.freelance.Batchreports.dtos.ItemDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.StreamSupport;

@Service
public class GrnReportUtils {
    @Autowired
    private CurrencyUtils currencyUtils;

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
        return setCalculatedParams(grnReportDto,items);
    }

    private GrnReportDto formGrnData(Object[] obj) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-d", Locale.US);
        LocalDate grnDate = LocalDate.parse(String.valueOf(obj[4]),formatter);
        LocalDate poDate = LocalDate.parse(String.valueOf(obj[6]),formatter);
        GrnReportDto grnReportDto = new GrnReportDto();
        grnReportDto.setCompanyName(String.valueOf(obj[0]));
        grnReportDto.setCompanyAddress(String.valueOf(obj[1]));
        grnReportDto.setMobileNo(String.valueOf(obj[2]));
        grnReportDto.setGrnCode(String.valueOf(obj[3]));
        grnReportDto.setGrnDate(DateTimeFormatter.ofPattern("dd/MM/yyyy", Locale.US).format(grnDate));
        grnReportDto.setPoId(String.valueOf(obj[5]));
        grnReportDto.setPoDate(DateTimeFormatter.ofPattern("dd-MM-yyyy", Locale.US).format(poDate));
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

    private ItemDto formItemsData(Object[] obj) {
        ItemDto itemDto = new ItemDto();
        itemDto.setItemCode(String.valueOf(obj[14]));
        itemDto.setItemDesc(String.valueOf(obj[15]));
        itemDto.setUnitName(String.valueOf(obj[16]));
        itemDto.setItemQuantity((BigDecimal) obj[17]);
        itemDto.setUnitRate((BigDecimal) obj[18]);
        itemDto.setCgstRate((BigDecimal) obj[19]);
        itemDto.setSgstRate((BigDecimal) obj[20]);
        itemDto.setIgstRate((BigDecimal) obj[21]);
        itemDto.setDiscPercent((BigDecimal) obj[22]);
        itemDto.setFreightCharge((BigDecimal) obj[23]);
        return itemDto;
    }

    public Map<String, Object> buildParamMap(GrnReportDto grnReportDto, Set<ItemDto> itemDtos) {
        Map<String, Object> map = new HashMap<>();
        map.put(FieldConstants.COMPANY_NAME, grnReportDto.getCompanyName());
        map.put(FieldConstants.COMPANY_ADDRESS, grnReportDto.getCompanyAddress());
        map.put(FieldConstants.MOBILE_NO, grnReportDto.getMobileNo());
        map.put(FieldConstants.GRN_CODE, grnReportDto.getGrnCode());
        map.put(FieldConstants.GRN_DATE, grnReportDto.getGrnDate());
        map.put(FieldConstants.PO_ID, grnReportDto.getPoId());
        map.put(FieldConstants.PO_DATE, grnReportDto.getPoDate());
        map.put(FieldConstants.PLANT_NAME, grnReportDto.getPlantName());
        map.put(FieldConstants.CHALLAN_NO, grnReportDto.getRefChallanNo());
        map.put(FieldConstants.VEHICLE_NO, grnReportDto.getVehicleNo());
        map.put(FieldConstants.DRIVER_NO, "8965874565");
        map.put(FieldConstants.CUST_VENDOR_NAME, grnReportDto.getCustVendorName());
        map.put(FieldConstants.CUST_VENDOR_ADDRESS, grnReportDto.getCustVendorAddress());
        map.put(FieldConstants.GST_NO, grnReportDto.getSupplierGstNo());
        map.put(FieldConstants.GST_NUM, grnReportDto.getConsineeGstNo());
        map.put(FieldConstants.STATE_NAME, grnReportDto.getStateName());
        map.put(FieldConstants.STATE_CODE, grnReportDto.getStateCode());
        map.put(FieldConstants.TAX_AMT_WORDS, grnReportDto.getTaxAmountInWords());
        map.put(FieldConstants.AMT_WORDS, grnReportDto.getAmountInWords());
        return map;
    }

    private BigDecimal calculateTotalAmount(Set<ItemDto> itemDtos) {
        BigDecimal subTotal = getSubTotal(itemDtos);
        BigDecimal tax = getTotalTax(itemDtos);
        BigDecimal freightCharges =  itemDtos.stream().findFirst().get().getFreightCharge();
        BigDecimal discount =  (subTotal.multiply(itemDtos.stream().findFirst().get().getDiscPercent()).divide(BigDecimal.valueOf(100)));
        return BigDecimal.valueOf(subTotal.longValue()+tax.longValue()+freightCharges.longValue()-discount.longValue());
    }

    private BigDecimal getSubTotal(Set<ItemDto> itemDtos) {
        long price = 0;
        for (ItemDto itemDto : itemDtos) {
            price += itemDto.getItemQuantity().longValue() * itemDto.getUnitRate().longValue();
        }
        return BigDecimal.valueOf(price);
    }

    private BigDecimal getTotalTax(Set<ItemDto> itemDtos) {
        BigDecimal subTotal = getSubTotal(itemDtos);
        BigDecimal cgst = (itemDtos.stream().findFirst().get().getCgstRate().multiply(subTotal)).divide(BigDecimal.valueOf(100));
        BigDecimal sgst = (itemDtos.stream().findFirst().get().getSgstRate().multiply(subTotal)).divide(BigDecimal.valueOf(100));
        BigDecimal igst = (itemDtos.stream().findFirst().get().getIgstRate().multiply(subTotal)).divide(BigDecimal.valueOf(100));
        long totalTax = cgst.longValue() + sgst.longValue() + igst.longValue();
        return BigDecimal.valueOf(totalTax);
    }

    private GrnReportDto setCalculatedParams(GrnReportDto grnReportDto, Set<ItemDto> itemDtos) {
        grnReportDto.setTaxAmountInWords(currencyUtils.convertToIndianCurrency(getTotalTax(itemDtos)));
        grnReportDto.setAmountInWords(currencyUtils.convertToIndianCurrency(calculateTotalAmount(itemDtos)));
        return grnReportDto;
    }

}
