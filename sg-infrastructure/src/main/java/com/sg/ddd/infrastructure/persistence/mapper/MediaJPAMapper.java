package com.sg.ddd.infrastructure.persistence.mapper;

import com.sg.ddd.domain.model.entity.Media;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MediaJPAMapper extends JpaRepository<Media, Long> {
}
