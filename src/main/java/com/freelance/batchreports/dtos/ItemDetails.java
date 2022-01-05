package com.freelance.batchreports.dtos;

import lombok.Data;

@Data
public class ItemDetails {
    private String itemCode;
    private String itemDescription;
    private Long hsnCode;
    private Double quantity;
    private String uom;
    private Double rate;
    private Double discount;
    private Double total;
}
