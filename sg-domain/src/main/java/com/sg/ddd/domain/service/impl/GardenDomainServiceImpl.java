package com.sg.ddd.domain.service.impl;

import com.sg.ddd.domain.model.entity.Garden;
import com.sg.ddd.domain.model.entity.User;
import com.sg.ddd.domain.port.CurrentUserProvider;
import com.sg.ddd.domain.repository.GardenRepository;
import com.sg.ddd.domain.repository.UserRepository;
import com.sg.ddd.domain.service.GardenDomainService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class GardenDomainServiceImpl implements GardenDomainService {

    private final GardenRepository gardenRepository;
    private final UserRepository userRepository;
    private final CurrentUserProvider currentUserProvider;

    public GardenDomainServiceImpl(GardenRepository gardenRepository, UserRepository userRepository, CurrentUserProvider currentUserProvider) {
        this.gardenRepository = gardenRepository;
        this.userRepository = userRepository;
        this.currentUserProvider = currentUserProvider;
    }

    @Override
    public List<Garden> findAllGardensByUserId() {
        Long userId = currentUserProvider.getCurrentUserId().orElseThrow(() -> new RuntimeException("Current user ID not found"));
        log.info("Fetching all gardens for user ID: {}", userId);
        return gardenRepository.findAllByUserId(userId);
    }

    @Override
    public List<Garden> addGarden(String name, String description) {
        Long userId = currentUserProvider.getCurrentUserId().orElseThrow(() -> new RuntimeException("Current user ID not found"));
        log.info("Adding garden for user ID: {}, Name: {}, Description: {}", userId, name, description);

        User user = userRepository.findById(userId);

        Garden garden = new Garden();
        garden.setName(name);
        garden.setDescription(description);
        garden.setUser(user);


        return gardenRepository.save(garden);
    }
}
