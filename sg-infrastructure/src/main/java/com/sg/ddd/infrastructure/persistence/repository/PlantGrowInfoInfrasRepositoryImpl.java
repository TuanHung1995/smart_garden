package com.sg.ddd.infrastructure.persistence.repository;

import com.sg.ddd.domain.model.entity.PlantGrowInfo;
import com.sg.ddd.domain.repository.PlantGrowInfoRepository;
import com.sg.ddd.infrastructure.persistence.mapper.PlantGrowInfoJPAMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

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

}
