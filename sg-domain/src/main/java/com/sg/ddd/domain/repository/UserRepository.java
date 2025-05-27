package com.sg.ddd.domain.repository;

import com.sg.ddd.domain.model.entity.User;
import org.springframework.stereotype.Repository;

import java.util.Optional;

public interface UserRepository {

    // Define methods for user repository, e.g.:
     Optional<User> findByEmail(String email);
    // void save(User user);
    // List<User> findAll();
    // void deleteById(Long id);

    // Example method signature
//    String getUserRole(String email);  // Example method to get user role by email

}
