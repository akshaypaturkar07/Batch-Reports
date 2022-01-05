package com.freelance.batchreports.dtos;

import lombok.Data;

@Data
public class Items {
    private String itemCode;
    private String itemDescription;
    private Long unit;
    private Double quantity;
    private Double price;
    private Double total;
}
