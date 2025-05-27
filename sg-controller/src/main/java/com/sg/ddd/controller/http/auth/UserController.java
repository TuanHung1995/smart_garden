package com.sg.ddd.controller.http.auth;

import com.sg.ddd.application.service.user.UserAppService;
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
@RequestMapping("/api/auth")
@Slf4j
public class UserController {

    @Autowired
    private UserAppService userAppService;

    // Find User by Email
     @PostMapping("/findByEmail")
     public ResponseEntity<?> findByEmail(@RequestBody String email) {

         log.info("Find User by Email: {}", email);
         Optional<User> user = userAppService.findByEmail(email);
         if (user.isPresent()) {
             return ResponseEntity.ok(user.get());
         } else {
             return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found");
         }
     }


    // Login
//     @PostMapping("/login")
//     public ResponseEntity<?> login(@RequestBody LoginRequest loginRequest) {
//    //     log.info("Login request: {}", loginRequest);
//    //     return ResponseEntity.ok("Login successful");
    // }

}
