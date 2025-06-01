package com.sg.ddd.infrastructure.persistence.repository;

import com.sg.ddd.domain.model.entity.Garden;
import com.sg.ddd.domain.repository.GardenRepository;
import com.sg.ddd.infrastructure.persistence.mapper.GardenJPAMapper;
import org.springframework.stereotype.Service;

@Service
public class GardenInfrasRepositoryImpl implements GardenRepository {

    private final GardenJPAMapper gardenJPAMapper;

    public GardenInfrasRepositoryImpl(GardenJPAMapper gardenJPAMapper) {
        this.gardenJPAMapper = gardenJPAMapper;
    }

    @Override
    public Garden findById(Long id) {
        return gardenJPAMapper.findById(id)
                .orElseThrow(() -> new RuntimeException("Garden not found with id: " + id));
    }
}
