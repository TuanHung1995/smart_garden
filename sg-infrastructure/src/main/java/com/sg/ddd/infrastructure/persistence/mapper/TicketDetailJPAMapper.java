package com.sg.ddd.infrastructure.persistence.mapper;

import com.sg.ddd.domain.model.entity.TicketDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

public interface TicketDetailJPAMapper extends JpaRepository<TicketDetail, Long> {

    Optional<TicketDetail> findById(Long id);
}
