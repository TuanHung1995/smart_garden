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
    private Date createdAt;
    private Date updatedAt;



//    id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
//            `avatar` BIGINT(20) NOT NULL COMMENT 'Reference to sg_settings_001',
//            `full_name` VARCHAR(255) NOT NULL COMMENT 'Full name',
//            `email` VARCHAR(255) NOT NULL COMMENT 'Email address',
//            `phone` VARCHAR(20) NOT NULL COMMENT 'Phone number',
//            `password` VARCHAR(255) NOT NULL COMMENT 'Password hash',
//            `address` TEXT NOT NULL COMMENT 'Address',
//            `country_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_countries_001',
//            `region_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_regions_001',
//            `role` VARCHAR(10) NOT NULL COMMENT 'User role: ADMIN or USER',
//            `latitude` DOUBLE NOT NULL COMMENT 'Latitude',
//            `longitude` DOUBLE NOT NULL COMMENT 'Longitude',
//            `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
//            `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
//    PRIMARY KEY (`id`),
//    CONSTRAINT `fk_user_country` FOREIGN KEY (`country_id`) REFERENCES `sg_countries_001`(`id`),
//    CONSTRAINT `fk_user_region` FOREIGN KEY (`region_id`) REFERENCES `sg_regions_001`(`id`),
//    CONSTRAINT `fk_user_avatar` FOREIGN KEY (`avatar`) REFERENCES `sg_media_001`(`id`)
//            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User account data';

}
