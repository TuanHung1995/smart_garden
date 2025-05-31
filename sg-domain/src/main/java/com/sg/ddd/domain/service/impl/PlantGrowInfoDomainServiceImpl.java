package com.sg.ddd.domain.service.impl;

import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import com.sg.ddd.domain.repository.PlantGrowInfoRepository;
import com.sg.ddd.domain.service.PlantGrowInfoDomainService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class PlantGrowInfoDomainServiceImpl implements PlantGrowInfoDomainService {

    private final PlantGrowInfoRepository plantGrowInfoRepository;

    public PlantGrowInfoDomainServiceImpl(PlantGrowInfoRepository plantGrowInfoRepository) {
        this.plantGrowInfoRepository = plantGrowInfoRepository;
    }

    @Override
    public List<PlantGrowInfo> getAllPlantGrowInfoByEmail(String email) {
        return plantGrowInfoRepository.findAllByEmail(email);
    }
}
