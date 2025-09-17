package com.sg.ddd.infrastructure.persistence.repository;

import com.sg.ddd.domain.model.entity.Media;
import com.sg.ddd.domain.port.MediaRepository;
import com.sg.ddd.infrastructure.persistence.mapper.MediaJPAMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class MediaInfrasRepositoryImpl implements MediaRepository {

    private final MediaJPAMapper mediaJPAMapper;

    public MediaInfrasRepositoryImpl(MediaJPAMapper mediaJPAMapper) {
        this.mediaJPAMapper = mediaJPAMapper;
    }

    @Override
    public Media save(Media media) {
        log.info("Saving media with URL: {} and type: {}", media.getUrl(), media.getType());
        return mediaJPAMapper.save(media);
    }

}
