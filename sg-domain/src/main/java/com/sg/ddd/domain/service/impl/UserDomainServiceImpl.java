package com.sg.ddd.domain.service.impl;

import com.sg.ddd.domain.model.entity.User;
import com.sg.ddd.domain.repository.UserRepository;
import com.sg.ddd.domain.service.UserDomainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserDomainServiceImpl implements UserDomainService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public Optional<User> findByEmail(String email) {
        // Implement the logic to find a user by email
        // This could involve calling a repository method
        return userRepository.findByEmail(email);
    }

}
