package com.sg.ddd.application.service.auth;

import com.sg.ddd.application.payload.LoginRequest;

public interface AuthAppService {

    String login(LoginRequest loginRequest);

}
