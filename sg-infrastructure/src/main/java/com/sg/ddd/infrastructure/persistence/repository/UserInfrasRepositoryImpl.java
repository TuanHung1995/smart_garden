package com.sg.ddd.infrastructure.persistence.repository;

import com.sg.ddd.domain.model.entity.User;
import com.sg.ddd.domain.repository.UserRepository;
import com.sg.ddd.domain.service.UserDomainService;
import com.sg.ddd.infrastructure.persistence.mapper.UserJPAMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@Slf4j
public class UserInfrasRepositoryImpl implements UserRepository {

    @Autowired
    private UserJPAMapper userJPAMapper;

    @Override
    public Optional<User> findByEmail(String email) {
        return userJPAMapper.findByEmail(email);
    }

    @Override
    public User save(String email, String password, String address, String phone) {
        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setAddress(address);
        user.setPhone(phone);
        user.setRole("ROLE_USER");

        log.info("Saving user with email: {}", email);
        return userJPAMapper.save(user);
    }

}
