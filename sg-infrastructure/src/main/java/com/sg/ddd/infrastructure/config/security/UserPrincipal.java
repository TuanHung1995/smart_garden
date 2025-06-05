package com.sg.ddd.infrastructure.config.security;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

public class UserPrincipal implements UserDetails {

    @Getter
    private Long id;
    //    private boolean isActive;
    private String fullName;
    private String email;
    private String role; // ADMIN or USER
    private String phone;
    private String password; // Password hash
    private String address;
    private double latitude;
    private double longitude;
    private String resetToken;

    public UserPrincipal(Long id, String email, String password, List<GrantedAuthority> authorities) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.role = authorities.stream()
                .map(GrantedAuthority::getAuthority)
                .findFirst()
                .orElse("USER") // Default role if none found
                .replace("ROLE_", ""); // Remove "ROLE_" prefix
    }


    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // Implement logic to return user authorities based on role

        return List.of(() -> "ROLE_" + role.toUpperCase());
    }

    @Override
    public String getPassword() {
        return password;
    }

}
