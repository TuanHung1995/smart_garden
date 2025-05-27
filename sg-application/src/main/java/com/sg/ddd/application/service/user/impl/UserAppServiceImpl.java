package com.sg.ddd.application.service.user.impl;

import com.sg.ddd.application.service.user.UserAppService;
import com.sg.ddd.domain.model.entity.User;
import com.sg.ddd.domain.service.UserDomainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserAppServiceImpl implements UserAppService {

    @Autowired
    private UserDomainService userDomainService;

    @Override
    public Optional<User> findByEmail(String email) {
        return userDomainService.findByEmail(email);
    }

}
