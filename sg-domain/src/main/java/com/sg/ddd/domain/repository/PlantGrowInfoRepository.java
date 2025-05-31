package com.sg.ddd.domain.repository;

import com.sg.ddd.domain.model.entity.PlantGrowInfo;

import java.util.Collection;
import java.util.List;

public interface PlantGrowInfoRepository {

    List<PlantGrowInfo> findAllByEmail(String email);

}
