package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Objects;

@Data
public class POItem {
    private String itemCode;
    private String itemDesc;
    private BigDecimal hsnCode;
    private BigDecimal quantity;
    private String unitOfMeasure;
    private BigDecimal tax;
    private BigDecimal rate;
    private BigDecimal discount;
    private BigDecimal total;
    private BigDecimal subTotal;
    private BigDecimal docTotal;
    private String docTotalInWords;
    private BigDecimal cgstRate1;
    private BigDecimal sgstRate1;
    private BigDecimal cgstRate2;
    private BigDecimal sgstRate2;
    private BigDecimal freightCharge;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        POItem poItem = (POItem) o;
        return Objects.equals(itemCode, poItem.itemCode) && Objects.equals(itemDesc, poItem.itemDesc) && Objects.equals(hsnCode, poItem.hsnCode) && Objects.equals(quantity, poItem.quantity) && Objects.equals(unitOfMeasure, poItem.unitOfMeasure) && Objects.equals(tax, poItem.tax) && Objects.equals(rate, poItem.rate) && Objects.equals(discount, poItem.discount);
    }

    @Override
    public int hashCode() {
        return Objects.hash(itemCode, itemDesc, hsnCode, quantity, unitOfMeasure, tax, rate, discount);
    }
}
