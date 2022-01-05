package com.freelance.batchreports.dtos;

import lombok.Data;

@Data
public class GoodsDetails {
    private String goodDesc;
    private Long hsnCode;
    private Double quantity;
    private String unit;
    private Double rate;
    private Double amount;
}
