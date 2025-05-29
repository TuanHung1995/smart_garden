package com.sg.ddd.controller.http.auth;

import com.sg.ddd.application.payload.JwtAuthResponse;
import com.sg.ddd.application.payload.LoginRequest;
import com.sg.ddd.application.payload.RegisterRequest;
import com.sg.ddd.application.service.auth.AuthAppService;
import com.sg.ddd.application.service.user.UserAppService;
import com.sg.ddd.domain.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/auth")
@Slf4j
public class AuthController {

    private final AuthAppService authService;
    private final UserAppService userAppService;

    public AuthController(AuthAppService authService, UserAppService userAppService) {
        this.authService = authService;
        this.userAppService = userAppService;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        log.info("Login attempt for email: {}", request.getEmail());
        String token = authService.login(request);
        log.info("User logged in: {}", request.getEmail());

        JwtAuthResponse response = new JwtAuthResponse();
        response.setAccessToken(token);

        // Return the token in the response
        log.info("Token: {}", token);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest request) {
        log.info("Registering user with email: {}", request.getEmail());

        // Check if user already exists
//        if (userAppService.findByEmail(request.getEmail()).isPresent()) {
//            log.warn("User already exists with email: {}", request.getEmail());
//            return ResponseEntity.badRequest().body("User already exists");
//        }

        // Register the user
        String result = authService.register(request.getEmail(), request.getPassword(),
                                             request.getAddress(), request.getFirstName(),
                                             request.getLastName(), request.getPhone());
        log.info("User registered successfully: {}", request.getEmail());

        return ResponseEntity.ok(result);
    }

}
