package com.sg.ddd.application.service.plant.grow;

import com.sg.ddd.domain.model.entity.PlantGrowInfo;

import java.util.List;

public interface PlantGrowInfoAppService {
    /**
     * Retrieves all PlantGrowInfo entities associated with the current user's email.
     *
     * @return a list of PlantGrowInfo entities
     */
    List<PlantGrowInfo> getAllPlantGrowInfoByEmail();

    /**
     * Adds new PlantGrowInfo entities for the current user.
     *
     * @return a list of newly added PlantGrowInfo entities
     */
    List<PlantGrowInfo> addPlantGrowInfo(String name, String description, String type, String gardenId);

    /**
     * Deletes a PlantGrowInfo entity by its ID.
     *
     * @param id the ID of the PlantGrowInfo entity to delete
     */
    List<PlantGrowInfo> deletePlantGrowInfo(Long id);

}
