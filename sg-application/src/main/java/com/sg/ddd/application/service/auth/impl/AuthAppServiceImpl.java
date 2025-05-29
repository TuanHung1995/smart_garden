package com.sg.ddd.application.service.auth.impl;

import com.sg.ddd.application.service.auth.AuthAppService;
import com.sg.ddd.application.payload.LoginRequest;
import com.sg.ddd.infrastructure.security.JwtTokenProvider;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class AuthAppServiceImpl implements AuthAppService {

    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider jwtTokenProvider;

    public AuthAppServiceImpl(AuthenticationManager authenticationManager, JwtTokenProvider jwtTokenProvider) {
        this.authenticationManager = authenticationManager;
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @Override
    public String login(LoginRequest loginRequest) {
        System.out.println("Attempting to authenticate user with email: " + loginRequest.getEmail());
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
                loginRequest.getEmail(), loginRequest.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);
        System.out.println("Authentication successful for user: " + loginRequest.getEmail());
        return jwtTokenProvider.generateToken(authentication);
    }

}
