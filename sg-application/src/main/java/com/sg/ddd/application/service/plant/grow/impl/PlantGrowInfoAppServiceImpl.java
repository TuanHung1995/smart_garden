package com.sg.ddd.application.service.plant.grow.impl;

import com.sg.ddd.application.service.plant.grow.PlantGrowInfoAppService;
import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import com.sg.ddd.domain.port.CurrentUserProvider;
import com.sg.ddd.domain.service.PlantGrowInfoDomainService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlantGrowInfoAppServiceImpl implements PlantGrowInfoAppService {

    private final PlantGrowInfoDomainService plantGrowInfoDomainService;
    private final CurrentUserProvider currentUserProvider;

    public PlantGrowInfoAppServiceImpl(PlantGrowInfoDomainService plantGrowInfoDomainService, CurrentUserProvider currentUserProvider) {
        this.plantGrowInfoDomainService = plantGrowInfoDomainService;
        this.currentUserProvider = currentUserProvider;
    }

//    @Override
//    public List<PlantGrowInfo> getAllPlantGrowInfoByEmail(String email) {
//        return plantGrowInfoDomainService.getAllPlantGrowInfoByEmail(email);
//    }
    @Override
    public List<PlantGrowInfo> getAllPlantGrowInfoByEmail() {
        String email = currentUserProvider.getCurrentUserEmail()
                .orElseThrow(() -> new RuntimeException("Current user email not found"));
        return plantGrowInfoDomainService.getAllPlantGrowInfoByEmail(email);
    }

}
