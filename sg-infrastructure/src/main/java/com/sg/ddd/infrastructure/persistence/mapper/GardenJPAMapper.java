package com.sg.ddd.infrastructure.persistence.mapper;

import com.sg.ddd.domain.model.entity.Garden;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GardenJPAMapper extends JpaRepository<Garden, Long> {
}
