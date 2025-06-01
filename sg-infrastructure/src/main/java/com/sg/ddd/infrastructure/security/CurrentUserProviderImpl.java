package com.sg.ddd.infrastructure.security;

import com.sg.ddd.domain.port.CurrentUserProvider;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class CurrentUserProviderImpl implements CurrentUserProvider {

    @Override
    public Optional<String> getCurrentUserEmail() {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()) {
            return Optional.empty();
        }

        Object principal = auth.getPrincipal();
        if (principal instanceof UserDetails userDetails) {
            return Optional.of(userDetails.getUsername());
        } else if (principal instanceof String email) {
            return Optional.of(email);
        }

        return Optional.empty();
    }

    @Override
    public Optional<Long> getCurrentUserId() {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated()) {
            return Optional.empty();
        }

        Object principal = auth.getPrincipal();
        if (principal instanceof Long id) {
            return Optional.of(id);
        }

        return Optional.empty();
    }

}
