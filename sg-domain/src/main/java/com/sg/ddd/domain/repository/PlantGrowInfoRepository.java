package com.sg.ddd.domain.repository;

import com.sg.ddd.domain.model.entity.Garden;
import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import com.sg.ddd.domain.model.entity.User;

import java.util.Collection;
import java.util.List;

public interface PlantGrowInfoRepository {

    List<PlantGrowInfo> findAllByEmail(String email);

    List<PlantGrowInfo> addPlantGrowInfo(User user, Garden garden,
                                         PlantGrowInfo plantGrowInfo);

}
