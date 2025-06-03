package com.sg.ddd.application.service.plant.grow.impl;

import com.sg.ddd.application.service.plant.grow.PlantGrowInfoAppService;
import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import com.sg.ddd.domain.port.CurrentUserProvider;
import com.sg.ddd.domain.service.PlantGrowInfoDomainService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class PlantGrowInfoAppServiceImpl implements PlantGrowInfoAppService {

    private final PlantGrowInfoDomainService plantGrowInfoDomainService;
    private final CurrentUserProvider currentUserProvider;

    public PlantGrowInfoAppServiceImpl(PlantGrowInfoDomainService plantGrowInfoDomainService, CurrentUserProvider currentUserProvider) {
        this.plantGrowInfoDomainService = plantGrowInfoDomainService;
        this.currentUserProvider = currentUserProvider;
    }

    /**
     * Retrieves all PlantGrowInfo entities associated with the current user's email.
     *
     * @return a list of PlantGrowInfo entities
     */
    @Override
    public List<PlantGrowInfo> getAllPlantGrowInfoByEmail() {
        String email = currentUserProvider.getCurrentUserEmail()
                .orElseThrow(() -> new RuntimeException("Current user email not found"));
        return plantGrowInfoDomainService.getAllPlantGrowInfoByEmail(email);
    }

    /**
     * Adds new PlantGrowInfo entities for the current user.
     *
     * @param name        the name of the plant
     * @param description a description of the plant
//     * @param mediaId    the ID of the plant's media (image or video)
     * @param type        the type of the plant
     * @param gardenId    the ID of the garden
     * @return a list of newly added PlantGrowInfo entities
     */
    @Override
    public List<PlantGrowInfo> addPlantGrowInfo(String name, String description, String type, String gardenId) {
        return plantGrowInfoDomainService.addPlantGrowInfo(name, description, type, gardenId);
    }

    /**
     * Deletes a PlantGrowInfo entity by its ID.
     *
     * @param id the ID of the PlantGrowInfo entity to delete
     * @return a list of remaining PlantGrowInfo entities after deletion
     */
    @Override
    public List<PlantGrowInfo> deletePlantGrowInfo(Long id) {;
        return plantGrowInfoDomainService.deletePlantGrowInfo(id);
    }

}
