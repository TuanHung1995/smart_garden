package com.sg.ddd.domain.repository;

import com.sg.ddd.domain.model.entity.Garden;

import java.util.Optional;

public interface GardenRepository {

    Garden findById(Long id);

}
