package com.sg.ddd.infrastructure.persistence.repository;

import com.sg.ddd.domain.model.entity.Garden;
import com.sg.ddd.domain.model.entity.Media;
import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import com.sg.ddd.domain.model.entity.User;
import com.sg.ddd.domain.repository.PlantGrowInfoRepository;
import com.sg.ddd.infrastructure.persistence.mapper.PlantGrowInfoJPAMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class PlantGrowInfoInfrasRepositoryImpl implements PlantGrowInfoRepository {

    private final PlantGrowInfoJPAMapper plantGrowInfoJPAMapper;

    public PlantGrowInfoInfrasRepositoryImpl(PlantGrowInfoJPAMapper plantGrowInfoJPAMapper) {
        this.plantGrowInfoJPAMapper = plantGrowInfoJPAMapper;
    }

    /**
     * Find all PlantGrowInfo by user email.
     *
     * @param email the user's email
     * @return a list of PlantGrowInfo associated with the given email
     */
    public List<PlantGrowInfo> findAllByEmail(String email) {
        return plantGrowInfoJPAMapper.findAllByUserEmail(email);
    }

    /**
     * Add a new PlantGrowInfo for a user and garden.
     *
     * @param user the user who owns the plant grow info
     * @param garden the garden associated with the plant grow info
     * @param plantGrowInfo the PlantGrowInfo entity to be added
//     * @param mediaId the ID of the media associated with the plant grow info
     * @return a list containing the newly added PlantGrowInfo
     */
    @Override
    public List<PlantGrowInfo> addPlantGrowInfo(User user, Garden garden, PlantGrowInfo plantGrowInfo) {

        plantGrowInfo.setUser(user);
        plantGrowInfo.setGarden(garden);

        plantGrowInfoJPAMapper.save(plantGrowInfo);
        return plantGrowInfoJPAMapper.findAllByUserId(user.getId());
    }

    /**
     * Find a PlantGrowInfo by its ID.
     *
     * @param id the ID of the PlantGrowInfo
     * @return an Optional containing the PlantGrowInfo if found, otherwise empty
     */
    @Override
    public Optional<PlantGrowInfo> findById(Long id) {
        return plantGrowInfoJPAMapper.findById(id);
    }

    /**
     * Delete a PlantGrowInfo entity.
     *
     * @param plantGrowInfo the PlantGrowInfo entity to be deleted
     * @return a list of remaining PlantGrowInfo entities after deletion
     */
    @Override
    public List<PlantGrowInfo> deletePlantGrowInfo(PlantGrowInfo plantGrowInfo) {
        plantGrowInfoJPAMapper.delete(plantGrowInfo);
        return plantGrowInfoJPAMapper.findAllByUserId(plantGrowInfo.getUser().getId());
    }
}
