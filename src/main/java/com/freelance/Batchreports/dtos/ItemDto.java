package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.util.Objects;

@Data
public class ItemDto {
    private String itemCode;
    private String itemDesc;
    private String unitName;
    private Long itemQuantity;
    private Long unitRate;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ItemDto itemDto = (ItemDto) o;
        return Objects.equals(itemCode, itemDto.itemCode) && Objects.equals(itemDesc, itemDto.itemDesc) && Objects.equals(unitName, itemDto.unitName) && Objects.equals(itemQuantity, itemDto.itemQuantity) && Objects.equals(unitRate, itemDto.unitRate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(itemCode, itemDesc, unitName, itemQuantity, unitRate);
    }
}
