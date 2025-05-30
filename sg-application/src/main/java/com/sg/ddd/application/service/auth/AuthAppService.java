package com.sg.ddd.application.service.auth;

import com.sg.ddd.application.payload.LoginRequest;
import com.sg.ddd.domain.model.entity.User;

public interface AuthAppService {

    String login(LoginRequest loginRequest);

    User register(String email, String password, String confirmPassword, String address,
                  String firstName, String lastName, String phone);

    void forgotPassword(String email);

    void resetPassword(String token, String newPassword, String confirmNewPassword);
}
