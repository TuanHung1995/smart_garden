package com.sg.ddd.application.service.plant.grow;

import com.sg.ddd.domain.model.entity.PlantGrowInfo;

import java.util.List;

public interface PlantGrowInfoAppService {

    List<PlantGrowInfo> getAllPlantGrowInfoByEmail(String email);

}
