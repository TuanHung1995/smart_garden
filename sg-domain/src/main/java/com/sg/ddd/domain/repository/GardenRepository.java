package com.sg.ddd.domain.repository;

import com.sg.ddd.domain.model.entity.Garden;

import java.util.List;
import java.util.Optional;

public interface GardenRepository {

    /**
     * Finds a garden by its ID.
     *
     * @param id the ID of the garden
     * @return an Optional containing the found garden, or empty if not found
     */
    Garden findById(Long id);

    /**
     * Finds all gardens associated with a specific user ID.
     *
     * @param userId the ID of the user
     * @return a list of gardens associated with the user
     */
    List<Garden> findAllByUserId(Long userId);

    /**
     * Saves the given garden and returns a list of gardens associated with the user.
     *
     * @param garden the garden to save
     * @return a list of gardens including the newly saved one
     */
    List<Garden> save(Garden garden);
}
