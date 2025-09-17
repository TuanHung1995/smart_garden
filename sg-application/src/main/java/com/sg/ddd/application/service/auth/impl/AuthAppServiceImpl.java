package com.sg.ddd.application.service.auth.impl;

import com.sg.ddd.application.service.auth.AuthAppService;
import com.sg.ddd.application.payload.auth.LoginRequest;
import com.sg.ddd.domain.model.entity.User;
import com.sg.ddd.domain.service.AuthDomainService;
import com.sg.ddd.infrastructure.config.security.JwtTokenProvider;
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

        // Authenticate the user using the provided credentials
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
                loginRequest.getEmail(), loginRequest.getPassword()));

        // Set the authentication in the security context
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return jwtTokenProvider.generateToken(authentication);
    }

    @Override
    public User register(String email, String password, String confirmPassword, String address,
                         String firstName, String lastName, String phone) {
        return authDomainService.register(email, password, confirmPassword, address, firstName, lastName, phone);
    }

    @Override
    public void forgotPassword(String email) {
        authDomainService.forgotPassword(email);
    }

    @Override
    public void resetPassword(String token, String newPassword, String confirmNewPassword) {
        authDomainService.resetPassword(token, newPassword, confirmNewPassword);
    }

}
