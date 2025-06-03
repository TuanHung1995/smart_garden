package com.sg.ddd.domain.service;

import com.sg.ddd.domain.model.entity.Garden;

import java.util.List;

public interface GardenDomainService {

    /**
     * Retrieves all gardens associated with the current user.
     *
     * @return a list of gardens
     */
    List<Garden> findAllGardensByUserId();

    /**
     * Adds a new garden with the specified name and description.
     *
     * @param name        the name of the garden
     * @param description the description of the garden
     * @return a list of gardens including the newly added one
     */
    List<Garden> addGarden(String name, String description);

}
