package com.sg.ddd.domain.service.impl;

import com.sg.ddd.domain.model.entity.Garden;
import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import com.sg.ddd.domain.model.entity.User;
import com.sg.ddd.domain.port.CurrentUserProvider;
import com.sg.ddd.domain.repository.GardenRepository;
import com.sg.ddd.domain.repository.PlantGrowInfoRepository;
import com.sg.ddd.domain.repository.UserRepository;
import com.sg.ddd.domain.service.PlantGrowInfoDomainService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class PlantGrowInfoDomainServiceImpl implements PlantGrowInfoDomainService {

    private final PlantGrowInfoRepository plantGrowInfoRepository;
    private final UserRepository userRepository;
    private final GardenRepository gardenRepository;
    private final CurrentUserProvider currentUserProvider;

    public PlantGrowInfoDomainServiceImpl(PlantGrowInfoRepository plantGrowInfoRepository, UserRepository userRepository, GardenRepository gardenRepository, CurrentUserProvider currentUserProvider) {
        this.plantGrowInfoRepository = plantGrowInfoRepository;
        this.userRepository = userRepository;
        this.gardenRepository = gardenRepository;
        this.currentUserProvider = currentUserProvider;
    }

    @Override
    public List<PlantGrowInfo> getAllPlantGrowInfoByEmail(String email) {
        return plantGrowInfoRepository.findAllByEmail(email);
    }

    @Override
    public List<PlantGrowInfo> addPlantGrowInfo(String name, String description, String type, String gardenId) {
        Long currentUserId = currentUserProvider.getCurrentUserId()
                .orElseThrow(() -> new RuntimeException("Current user ID not found"));

        Long gardenIdLong = gardenId != null ? Long.parseLong(gardenId) : null;

        Garden garden = null;

        if (gardenIdLong != null) {
            garden = gardenRepository.findById(gardenIdLong);
        }

        User user = userRepository.findById(currentUserId);
        PlantGrowInfo plantGrowInfo = new PlantGrowInfo();
        plantGrowInfo.setName(name);
        plantGrowInfo.setDescription(description);
        plantGrowInfo.setType(type);

        return plantGrowInfoRepository.addPlantGrowInfo(user, garden, plantGrowInfo);
    }

    /**
     * Deletes a PlantGrowInfo by its ID.
     *
     * @param id the ID of the PlantGrowInfo to delete
     * @return a list of remaining PlantGrowInfo after deletion
     */
    @Override
    public List<PlantGrowInfo> deletePlantGrowInfo(Long id) {
        PlantGrowInfo plantGrowInfo = plantGrowInfoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("PlantGrowInfo not found with ID: " + id));
        return plantGrowInfoRepository.deletePlantGrowInfo(plantGrowInfo);
    }
}
