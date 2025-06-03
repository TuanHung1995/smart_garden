package com.sg.ddd.infrastructure.persistence.mapper;

import com.sg.ddd.domain.model.entity.Garden;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GardenJPAMapper extends JpaRepository<Garden, Long> {

    List<Garden> findAllByUserId(Long userId);

}
