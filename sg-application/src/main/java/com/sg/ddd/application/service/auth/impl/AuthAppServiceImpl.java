package com.sg.ddd.application.service.auth.impl;

import com.sg.ddd.application.service.auth.AuthAppService;
import com.sg.ddd.application.payload.LoginRequest;
import com.sg.ddd.domain.service.AuthDomainService;
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
    private final AuthDomainService authDomainService;

    public AuthAppServiceImpl(AuthenticationManager authenticationManager, JwtTokenProvider jwtTokenProvider, AuthDomainService authDomainService) {
        this.authenticationManager = authenticationManager;
        this.jwtTokenProvider = jwtTokenProvider;
        this.authDomainService = authDomainService;
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

    @Override
    public String register(String email, String password, String address,
                           String firstName, String lastName, String phone) {
        System.out.println("Registering user with email: " + email);
        authDomainService.register(email, password, address, firstName, lastName, phone);
        System.out.println("User registered successfully: " + email);
        return "User registered successfully";
    }

}
