package com.sg.ddd.application.service.user;

import com.sg.ddd.domain.model.entity.User;

import java.util.Optional;

public interface UserAppService {

    Optional<User> findByEmail(String email);

}
