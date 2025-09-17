package com.sg.ddd.application.payload.auth;

import lombok.Data;

@Data
public class ResetPasswordRequest {

    private String token;
    private String newPassword;
    private String confirmPassword;

}
