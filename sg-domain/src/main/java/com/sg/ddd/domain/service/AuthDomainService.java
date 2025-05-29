package com.sg.ddd.domain.service;

import com.sg.ddd.domain.model.entity.User;

public interface AuthDomainService {

    User register(String email, String password, String address,
                  String firstName, String lastName, String phone);

}
