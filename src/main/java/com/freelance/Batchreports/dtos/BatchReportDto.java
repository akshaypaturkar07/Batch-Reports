package com.freelance.Batchreports.dtos;

import lombok.Data;

import java.util.List;

@Data
public class BatchReportDto {
    private BatchDto batchDto;
    private List<BatchDetailDto> batchDetailDtoList;
    private PlantDto plantDto;
    private VendorDto vendorDto;


}
