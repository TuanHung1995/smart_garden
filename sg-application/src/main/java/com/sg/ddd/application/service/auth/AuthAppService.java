package com.sg.ddd.application.service.auth;

import com.sg.ddd.application.payload.LoginRequest;

public interface AuthAppService {

    String login(LoginRequest loginRequest);

    String register(String email, String password, String address,
                    String firstName, String lastName, String phone);

}
