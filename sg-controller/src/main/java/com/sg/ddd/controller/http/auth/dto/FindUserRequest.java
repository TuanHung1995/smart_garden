package com.sg.ddd.controller.http.auth.dto;

public class FindUserRequest {
    private String email;

    public FindUserRequest() {
    }

    public FindUserRequest(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
