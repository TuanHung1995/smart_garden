package com.sg.ddd.infrastructure.persistence.mapper;

import com.sg.ddd.domain.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserJPAMapper extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);

//    User findByEmail(String email, boolean ignoreCase);

    User findByResetToken(String token);

    // Additional methods can be defined here as needed
}
