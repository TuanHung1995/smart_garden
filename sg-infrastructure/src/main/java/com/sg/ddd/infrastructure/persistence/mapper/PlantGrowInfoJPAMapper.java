package com.sg.ddd.infrastructure.persistence.mapper;

import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PlantGrowInfoJPAMapper extends JpaRepository<PlantGrowInfo, Long> {

    List<PlantGrowInfo> findAllByUserEmail(String email);

    List<PlantGrowInfo> findAllByUserId(Long id);

}
