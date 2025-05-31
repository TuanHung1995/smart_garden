package com.sg.ddd.domain.model.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;

import java.util.Date;


@Accessors(chain = true)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "sg_users_001")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
    private String resetToken; // Token for password reset
    private Date createdAt;
    private Date updatedAt;

}
