package com.sg.ddd.infrastructure.persistence.repository;

import com.sg.ddd.domain.model.entity.User;
import com.sg.ddd.domain.port.MailSender;
import com.sg.ddd.domain.repository.UserRepository;
import com.sg.ddd.domain.service.UserDomainService;
import com.sg.ddd.infrastructure.persistence.mapper.UserJPAMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
@Slf4j
public class UserInfrasRepositoryImpl implements UserRepository {

    @Value("${server.port}")
    private String serverPort;

    private final UserJPAMapper userJPAMapper;
    private final MailSender mailSender;
    private final PasswordEncoder passwordEncoder;

    @Lazy
    public UserInfrasRepositoryImpl(UserJPAMapper userJPAMapper, MailSender mailSender, PasswordEncoder passwordEncoder) {
        this.userJPAMapper = userJPAMapper;
        this.mailSender = mailSender;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return userJPAMapper.findByEmail(email);
    }

    @Override
    public User findById(Long id) {
        return userJPAMapper.findById(id).orElseThrow(() -> new RuntimeException("User not found with ID: " + id));
    }

    @Override
    public User save(String email, String password, String address, String phone) {
        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setAddress(address);
        user.setPhone(phone);
        user.setRole("ROLE_USER");

        return userJPAMapper.save(user);
    }

    @Override
    public void forgotPassword(String email) {
        User user = userJPAMapper.findByEmail(email)
                .orElse(null);

        if (user == null) {
            log.warn("User with email {} not found for password reset", email);
            return;
        }

        String token = UUID.randomUUID().toString();

        // Set reset token for the user
        user.setResetToken(token);
        userJPAMapper.save(user);

        String link = "http://localhost:" + serverPort + "/api/auth/reset-password?token=" + token;
        String content = "Click on link below to reset your password:\n" + link;

        mailSender.send(user.getEmail(), "Reset Password", content);
    }

    @Override
    public void resetPassword(String token, String newPassword, String confirmNewPassword) {
        if (!newPassword.equals(confirmNewPassword)) {
            throw new IllegalArgumentException("Passwords do not match");
        }

        // Find user by reset token
        User user = userJPAMapper.findByResetToken(token);
        if (user == null) {
            log.warn("Invalid reset token: {}", token);
            return;
        }

        user.setPassword(passwordEncoder.encode(newPassword));

        // Set token to null after reset
        user.setResetToken(null);
        userJPAMapper.save(user);
    }

}
