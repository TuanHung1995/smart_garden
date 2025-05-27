package com.sg.ddd.domain.service;

import com.sg.ddd.domain.model.entity.User;

import java.util.Optional;

public interface UserDomainService {

    Optional<User> findByEmail(String email);

}
