package com.freelance.Batchreports.utils;

import com.freelance.Batchreports.constants.FieldConstants;
import com.freelance.Batchreports.dtos.POItem;
import com.freelance.Batchreports.dtos.POReportDto;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.StreamSupport;

@Service
public class PoReportUtils {
    public POReportDto formPOReport(Iterable<Object[]> objects) {
        POReportDto poReportDto = new POReportDto();
        Set<POItem> items = new HashSet<>();
        Optional<Object[]> optionalObjects = StreamSupport.stream(objects.spliterator(), false).findFirst();
        if (optionalObjects.isPresent()) {
            Object[] obj = optionalObjects.get();
            poReportDto = formPOData(obj);
        }
        StreamSupport.stream(objects.spliterator(), false).forEach(object -> {
            POItem itemDto = formPOItemsData(object);
            items.add(itemDto);
        });
        poReportDto.setPoItemSet(items);
        return poReportDto;
    }

    private POReportDto formPOData(Object[] obj) {
        String poDate = LocalDate.parse(String.valueOf(obj[5]), DateTimeFormatter.ofPattern("yyyy-MM-dd")).format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
        POReportDto poReportDto = new POReportDto();
        poReportDto.setCompanyName(String.valueOf(obj[0]));
        poReportDto.setCompanyAddress(String.valueOf(obj[1]));
        poReportDto.setEmail(String.valueOf(obj[2]));
        poReportDto.setMobileNo(String.valueOf(obj[3]));
        poReportDto.setPoId(String.valueOf(obj[4]));
        poReportDto.setPoDate(poDate);
        poReportDto.setBranchName(String.valueOf(obj[6]));
        poReportDto.setQuoteNo("Mail Through Quotation Received");
        poReportDto.setQuoteDate("");
        poReportDto.setModeOfShipment("");
        poReportDto.setDeliveryName(String.valueOf(obj[0]));
        poReportDto.setDeliveryAddress(String.valueOf(obj[7]));
        poReportDto.setSiteContactNo(String.valueOf(obj[8]));
        poReportDto.setSiteContact(String.valueOf(obj[9]));
        poReportDto.setSiteEmail(String.valueOf(obj[10]));
        poReportDto.setSiteGstNo(String.valueOf(obj[11]));
        poReportDto.setVendorCode(String.valueOf(obj[12]));
        poReportDto.setVendorName(String.valueOf(obj[13]));
        poReportDto.setVendorAddress(String.valueOf(obj[14]));
        poReportDto.setSupplierGstNo(String.valueOf(obj[15]));
        poReportDto.setContactPersonName(String.valueOf(obj[16]));
        poReportDto.setVendorContactNo(String.valueOf(obj[17]));
        poReportDto.setDeliveryShipFrom(String.valueOf(obj[13]));
        poReportDto.setFreightCharge((BigDecimal) obj[28]);
        poReportDto.setCgstRate1((BigDecimal)obj[25]);
        poReportDto.setSgstRate1((BigDecimal)obj[26]);
        poReportDto.setCgstRate2((BigDecimal)obj[27]);
        poReportDto.setSgstRate2((BigDecimal)obj[25]);
        return poReportDto;
    }

    private POItem formPOItemsData(Object[] obj) {
        POItem itemDto = new POItem();
        itemDto.setItemCode(String.valueOf(obj[18]));
        itemDto.setItemDesc(String.valueOf(obj[19]));
        itemDto.setHsnCode((BigDecimal)obj[20]);
        itemDto.setQuantity((BigDecimal)obj[21]);
        itemDto.setUnitOfMeasure(String.valueOf(obj[22]));
        itemDto.setDiscount((BigDecimal)obj[23]);
        itemDto.setRate((BigDecimal)obj[24]);
        itemDto.setTotal(itemDto.getQuantity().multiply(itemDto.getRate()));
        itemDto.setTax((BigDecimal)obj[29]);
        itemDto.setCgstRate1((BigDecimal)obj[25]);
        itemDto.setSgstRate1((BigDecimal)obj[26]);
        itemDto.setCgstRate2((BigDecimal)obj[27]);
        itemDto.setSgstRate2((BigDecimal)obj[25]);
        itemDto.setFreightCharge((BigDecimal) obj[28]);
        return itemDto;
    }

    public Map<String, Object> buildParamMap(POReportDto poReportDto) {
        Map<String, Object> map = new HashMap<>();
        map.put(FieldConstants.COMPANY_NAME, poReportDto.getCompanyName());
        map.put(FieldConstants.COMPANY_ADDRESS, poReportDto.getCompanyAddress());
        map.put(FieldConstants.MOBILE_NO, poReportDto.getMobileNo());
        map.put(FieldConstants.EMAIL, poReportDto.getEmail());
        map.put(FieldConstants.PO_ID, poReportDto.getPoId());
        map.put(FieldConstants.PO_DATE, poReportDto.getPoDate());
        map.put(FieldConstants.BRANCH_NAME, poReportDto.getBranchName());
        map.put(FieldConstants.QUOTE_NO, poReportDto.getQuoteNo());
        map.put(FieldConstants.QUOTE_DATE, poReportDto.getQuoteDate());
        map.put(FieldConstants.MODE_OF_SHIPMENT, poReportDto.getModeOfShipment());
        map.put(FieldConstants.DELIVERY_NAME, poReportDto.getDeliveryName());
        map.put(FieldConstants.DELIVERY_ADDRESS, poReportDto.getDeliveryAddress());
        map.put(FieldConstants.SITE_CONTACT_NO, poReportDto.getSiteContactNo());
        map.put(FieldConstants.SITE_CONTACT, poReportDto.getSiteContact());
        map.put(FieldConstants.SITE_EMAIL, poReportDto.getSiteEmail());
        map.put(FieldConstants.SITE_GST_NO, poReportDto.getSiteGstNo());
        map.put(FieldConstants.VENDOR_CODE, poReportDto.getVendorCode());
        map.put(FieldConstants.VENDOR_NAME, poReportDto.getVendorName());
        map.put(FieldConstants.VENDOR_ADDRESS,poReportDto.getVendorAddress());
        map.put(FieldConstants.SUPPLIER_GST_NO, poReportDto.getSupplierGstNo());
        map.put(FieldConstants.CONTACT_PERSON_NAME, poReportDto.getContactPersonName());
        map.put(FieldConstants.VENDOR_CONTACT_NO, poReportDto.getVendorContactNo());
        map.put(FieldConstants.DELIVERY_SHIP_FROM, poReportDto.getDeliveryShipFrom());
        map.put(FieldConstants.FREIGHT_CHARGE,poReportDto.getFreightCharge() );
        map.put(FieldConstants.CGST_RATE1, poReportDto.getCgstRate1());
        map.put(FieldConstants.SGST_RATE1, poReportDto.getSgstRate1());
        map.put(FieldConstants.CGST_RATE2, poReportDto.getCgstRate2());
        map.put(FieldConstants.SGST_RATE2, poReportDto.getSgstRate2());
        return map;

    }



}
