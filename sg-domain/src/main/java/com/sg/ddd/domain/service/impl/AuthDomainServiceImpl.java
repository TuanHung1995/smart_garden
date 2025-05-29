package com.sg.ddd.domain.service.impl;

import com.sg.ddd.domain.model.entity.User;
import com.sg.ddd.domain.repository.UserRepository;
import com.sg.ddd.domain.service.AuthDomainService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthDomainServiceImpl implements AuthDomainService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public AuthDomainServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public User register(String email, String password, String address,
                         String firstName, String lastName, String phone) {

        return userRepository.save(
                email,
                passwordEncoder.encode(password),
                address,
                phone
        );
    }

}
