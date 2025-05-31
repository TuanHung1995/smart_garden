package com.sg.ddd.application.service.plant.grow.impl;

import com.sg.ddd.application.service.plant.grow.PlantGrowInfoAppService;
import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import com.sg.ddd.domain.service.PlantGrowInfoDomainService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlantGrowInfoAppServiceImpl implements PlantGrowInfoAppService {

    private final PlantGrowInfoDomainService plantGrowInfoDomainService;

    public PlantGrowInfoAppServiceImpl(PlantGrowInfoDomainService plantGrowInfoDomainService) {
        this.plantGrowInfoDomainService = plantGrowInfoDomainService;
    }

    @Override
    public List<PlantGrowInfo> getAllPlantGrowInfoByEmail(String email) {
        return plantGrowInfoDomainService.getAllPlantGrowInfoByEmail(email);
    }

}
