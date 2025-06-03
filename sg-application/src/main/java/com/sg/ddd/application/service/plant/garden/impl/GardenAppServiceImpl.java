package com.sg.ddd.application.service.plant.garden.impl;

import com.sg.ddd.application.service.plant.garden.GardenAppService;
import com.sg.ddd.domain.model.entity.Garden;
import com.sg.ddd.domain.port.CurrentUserProvider;
import com.sg.ddd.domain.service.GardenDomainService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class GardenAppServiceImpl implements GardenAppService {

    private final GardenDomainService gardenDomainService;

    public GardenAppServiceImpl(GardenDomainService gardenDomainService) {
        this.gardenDomainService = gardenDomainService;
    }

    @Override
    public List<Garden> findAllGardensByUserId() {
        return gardenDomainService.findAllGardensByUserId();
    }

    @Override
    public List<Garden> addGarden(String name, String description) {
        return gardenDomainService.addGarden(name, description);
    }
}
