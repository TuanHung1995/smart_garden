package com.sg.ddd.controller.http.auth;

import com.sg.ddd.application.service.auth.AuthAppService;
import com.sg.ddd.application.service.user.UserAppService;
import com.sg.ddd.controller.http.auth.dto.FindUserRequest;
import com.sg.ddd.domain.model.entity.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/api/v1/auth")
@Slf4j
public class UserController {

    @Autowired
    private UserAppService userAppService;

    private final AuthAppService authService;

    public UserController(AuthAppService authService) {
        this.authService = authService;
    }

    // Find User by Email
     @PostMapping("/findByEmail")
     public ResponseEntity<?> findByEmail(@RequestBody FindUserRequest request) {

         log.info("Find User by Email: {}", request.getEmail());
         Optional<User> user = userAppService.findByEmail(request.getEmail());
         if (user.isPresent()) {
             return ResponseEntity.ok(user.get());
         } else {
             return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
         }
     }

    // Login


}
