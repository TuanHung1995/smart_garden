package com.sg.ddd.domain.service;

import com.sg.ddd.domain.model.entity.PlantGrowInfo;

import java.util.List;

public interface PlantGrowInfoDomainService {

    List<PlantGrowInfo> getAllPlantGrowInfoByEmail(String email);

}
