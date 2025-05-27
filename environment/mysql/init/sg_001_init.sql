CREATE DATABASE IF NOT EXISTS sg_001
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_unicode_ci;

-- 1. ticket table
CREATE TABLE IF NOT EXISTS `sg_001`.`ticket` (
     `id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `name` VARCHAR(50) NOT NULL COMMENT 'ticket name',
    `desc` TEXT COMMENT 'ticket description',
    `start_time` DATETIME NOT NULL COMMENT 'ticket sale start time',
    `end_time` DATETIME    NOT NULL COMMENT 'ticket sale end time',
    `status`   INT(11) NOT NULL DEFAULT 0 COMMENT 'ticket sale activity status', -- 0: deactive, 1: activity
    `updated_at` DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    `created_at`   DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    PRIMARY KEY (`id`),
    KEY `idx_end_time` (`end_time`), -- Very high query runtime
    KEY `idx_start_time` (`start_time`), -- Very high query runtime
    KEY `idx_status` (`status`) -- Very high query runtime
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ticket table';

-- 2. ticket detail (item) table
CREATE TABLE IF NOT EXISTS `sg_001`.`ticket_item` (
    `id` BIGINT(20)  NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `name` VARCHAR(50) NOT NULL COMMENT 'Ticket title',
    `description` TEXT COMMENT 'Ticket description',
    `stock_initial` INT(11) NOT NULL DEFAULT 0 COMMENT 'Initial stock quantity (e.g., 1000 tickets)',
    `stock_available` INT(11) NOT NULL DEFAULT 0 COMMENT 'Current available stock (e.g., 900 tickets)',
    `is_stock_prepared` BOOLEAN NOT NULL DEFAULT 0 COMMENT 'Indicates if stock is pre-warmed (0/1)', -- warm up cache
    `price_original` BIGINT(20) NOT NULL COMMENT 'Original ticket price', -- Giá gốc: ví dụ: 100K/ticket
    `price_flash` BIGINT(20) NOT NULL COMMENT 'Discounted price during flash sale', -- Giảm giá khung giờ vàng : ví dụ: 10K/ticket
    `sale_start_time` DATETIME NOT NULL COMMENT 'Flash sale start time',
    `sale_end_time` DATETIME NOT NULL COMMENT 'Flash sale end time',
    `status` INT(11) NOT NULL DEFAULT 0 COMMENT 'Ticket status (e.g., active/inactive)', -- Trạng thái của vé (ví dụ: hoạt động/không hoạt động)
    `activity_id` BIGINT(20) NOT NULL COMMENT 'ID of associated activity', -- ID của hoạt động liên quan đến vé
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp of the last update',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation timestamp',
    PRIMARY KEY (`id`),
    KEY `idx_end_time` (`sale_end_time`),
    KEY `idx_start_time` (`sale_start_time`),
    KEY `idx_status` (`status`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Table for ticket details';

-- INSERT MOCK DATA
-- Insert data into `ticket` table
INSERT INTO `vetautet`.`ticket` (`name`, `desc`, `start_time`, `end_time`, `status`, `updated_at`, `created_at`)
VALUES
    ('Đợt Mở Bán Vé Ngày 12/12', 'Sự kiện mở bán vé đặc biệt cho ngày 12/12', '2024-12-12 00:00:00', '2024-12-12 23:59:59', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Đợt Mở Bán Vé Ngày 01/01', 'Sự kiện mở bán vé cho ngày đầu năm mới 01/01', '2025-01-01 00:00:00', '2025-01-01 23:59:59', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Insert data into `ticket_item` table corresponding to each event in `ticket` table
INSERT INTO `vetautet`.`ticket_item` (`name`, `description`, `stock_initial`, `stock_available`, `is_stock_prepared`, `price_original`, `price_flash`, `sale_start_time`, `sale_end_time`, `status`, `activity_id`, `updated_at`, `created_at`)
VALUES
    -- Ticket items for the 12/12 event
    ('Vé Sự Kiện 12/12 - Hạng Phổ Thông', 'Vé phổ thông cho sự kiện ngày 12/12', 1000, 1000, 0, 100000, 10000, '2024-12-12 00:00:00', '2024-12-12 23:59:59', 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Vé Sự Kiện 12/12 - Hạng VIP', 'Vé VIP cho sự kiện ngày 12/12', 500, 500, 0, 200000, 15000, '2024-12-12 00:00:00', '2024-12-12 23:59:59', 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

    -- Ticket items for the 01/01 event
    ('Vé Sự Kiện 01/01 - Hạng Phổ Thông', 'Vé phổ thông cho sự kiện ngày 01/01', 2000, 2000, 0, 100000, 10000, '2025-01-01 00:00:00', '2025-01-01 23:59:59', 1, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Vé Sự Kiện 01/01 - Hạng VIP', 'Vé VIP cho sự kiện ngày 01/01', 1000, 1000, 0, 200000, 15000, '2025-01-01 00:00:00', '2025-01-01 23:59:59', 1, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- sg_media_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_media_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `url` TEXT NOT NULL COMMENT 'Media URL',
    `type` VARCHAR(255) NOT NULL COMMENT 'Media type',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Media resources table';

-- sg_plants_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_plants_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `name` VARCHAR(255) NOT NULL COMMENT 'Plant name',
    `scientific_name` VARCHAR(255) NOT NULL COMMENT 'Scientific name',
    `description` TEXT NOT NULL COMMENT 'Plant description',
    `significant` TEXT NOT NULL COMMENT 'Plant significance',
    `grows` TEXT NOT NULL COMMENT 'Growth environment',
    `main_image_url` BIGINT(20) NOT NULL COMMENT 'Reference to media table',
    `season` CHAR(1) NOT NULL COMMENT 'Season (X, H, T, Đ)',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Plant master data';

-- sg_soil_types_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_soil_types_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `type` VARCHAR(255) NOT NULL COMMENT 'Soil type name',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Soil type master';

-- sg_soils_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_soils_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `type_id` BIGINT(20) NOT NULL COMMENT 'Reference to soil type',
    `name` VARCHAR(255) NOT NULL COMMENT 'Soil name',
    `pH_level` FLOAT NOT NULL COMMENT 'Soil pH level',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    FOREIGN KEY (`type_id`) REFERENCES `sg_001`.`sg_soil_types_001`(`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Soil characteristics table';

-- sg_countries_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_countries_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `country` VARCHAR(255) NOT NULL COMMENT 'Country name',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Country list';

-- sg_regions_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_regions_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `country_id` BIGINT(20) NOT NULL COMMENT 'Reference to country',
    `region` VARCHAR(255) NOT NULL COMMENT 'Region name',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    FOREIGN KEY (`country_id`) REFERENCES `sg_001`.`sg_countries_001`(`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Region list per country';

-- sg_fertilizer_types_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_fertilizer_types_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `type` VARCHAR(255) NOT NULL COMMENT 'Fertilizer type name',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Fertilizer type categories';

-- sg_fertilizers_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_fertilizers_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `type_id` BIGINT(20) NOT NULL COMMENT 'Fertilizer type reference',
    `name` VARCHAR(255) NOT NULL COMMENT 'Fertilizer name',
    `usage` TEXT NOT NULL COMMENT 'Fertilizer usage information',
    `formula` TEXT NOT NULL COMMENT 'Fertilizer formula',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_fertilizer_type` FOREIGN KEY (`type_id`) REFERENCES `sg_fertilizer_types_001` (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Fertilizer information table';

-- sg_weather_forecasts_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_weather_forecasts_001` (
                                                                   `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `region` VARCHAR(255) NOT NULL COMMENT 'Forecast region',
    `forecast_date` DATE NOT NULL COMMENT 'Forecast date',
    `temperature` FLOAT NOT NULL COMMENT 'Forecast temperature',
    `humidity` FLOAT NOT NULL COMMENT 'Forecast humidity',
    `precipitation` FLOAT NOT NULL COMMENT 'Forecast precipitation',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Daily weather forecast data';

-- sg_news_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_news_001` (
                                                      `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `title` VARCHAR(255) NOT NULL COMMENT 'News title',
    `content` TEXT NOT NULL COMMENT 'News content',
    `source` TEXT NOT NULL COMMENT 'News source',
    `region` VARCHAR(255) NOT NULL COMMENT 'News region',
    `published_at` DATETIME NOT NULL COMMENT 'Publish time',
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'News articles data';

-- sg_news_categories_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_news_categories_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `category` VARCHAR(255) NOT NULL COMMENT 'News category',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'News categories';

-- sg_categories_news_001 (join table)
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_categories_news_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `category_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_news_categories_001',
    `news_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_news_001',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_catnews_category` FOREIGN KEY (`category_id`) REFERENCES `sg_news_categories_001`(`id`),
    CONSTRAINT `fk_catnews_news` FOREIGN KEY (`news_id`) REFERENCES `sg_news_001`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Join table for news and categories';

-- sg_users_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_users_001` (
                                                       `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `avatar` BIGINT(20) NOT NULL COMMENT 'Reference to sg_settings_001',
    `full_name` VARCHAR(255) NOT NULL COMMENT 'Full name',
    `email` VARCHAR(255) NOT NULL COMMENT 'Email address',
    `phone` VARCHAR(20) NOT NULL COMMENT 'Phone number',
    `password` VARCHAR(255) NOT NULL COMMENT 'Password hash',
    `address` TEXT NOT NULL COMMENT 'Address',
    `country_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_countries_001',
    `region_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_regions_001',
    `role` VARCHAR(10) NOT NULL COMMENT 'User role: ADMIN or USER',
    `latitude` DOUBLE NOT NULL COMMENT 'Latitude',
    `longitude` DOUBLE NOT NULL COMMENT 'Longitude',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_user_country` FOREIGN KEY (`country_id`) REFERENCES `sg_countries_001`(`id`),
    CONSTRAINT `fk_user_region` FOREIGN KEY (`region_id`) REFERENCES `sg_regions_001`(`id`),
    CONSTRAINT `fk_user_avatar` FOREIGN KEY (`avatar`) REFERENCES `sg_media_001`(`id`),
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User account data';

-- sg_search_history_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_search_history_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `user_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_users_001',
    `query` TEXT NOT NULL COMMENT 'Search query',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_search_user` FOREIGN KEY (`user_id`) REFERENCES `sg_users_001`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Search history for users';

-- sg_languages_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_languages_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `language` VARCHAR(255) NOT NULL COMMENT 'Language name',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Supported languages';

-- sg_settings_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_settings_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `user_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_users_001',
    `language_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_languages_001',
    `watering_notification` BOOLEAN NOT NULL COMMENT 'Notify watering',
    `manuring_notification` BOOLEAN NOT NULL COMMENT 'Notify manuring',
    `news_notification` BOOLEAN NOT NULL COMMENT 'Notify news',
    `regular_notification` BOOLEAN NOT NULL COMMENT 'Notify regular updates',
    `theme` VARCHAR(20) NOT NULL COMMENT 'Theme preference: DARK, NIGHT, SYSTEM',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_settings_user` FOREIGN KEY (`user_id`) REFERENCES `sg_users_001`(`id`),
    CONSTRAINT `fk_settings_lang` FOREIGN KEY (`language_id`) REFERENCES `sg_languages_001`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User settings and preferences';

-- sg_garden_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_garden_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `name` VARCHAR(255) NOT NULL COMMENT 'Garden name',
    `description` TEXT NOT NULL COMMENT 'Garden description',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Garden information table';

-- sg_plant_grow_info_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_plant_grow_info_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `garden_id` BIGINT(20) DEFAULT NULL COMMENT 'Reference to sg_garden_001',
    `plant_image_id` BIGINT(20) DEFAULT NULL COMMENT 'Reference to sg_media_001',
    `name` VARCHAR(255) NOT NULL COMMENT 'Plant name',
    `description` TEXT COMMENT 'Plant description',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_grow_info_garden` FOREIGN KEY (`garden_id`) REFERENCES `sg_garden_001`(`id`),
    CONSTRAINT `fk_grow_info_plant_image` FOREIGN KEY (`plant_image_id`) REFERENCES `sg_media_001`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Plant grow information';

-- sg_diary_categories_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_diary_categories_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `category` VARCHAR(255) NOT NULL COMMENT 'Diary category',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Diary categories table';

-- sg_plant_grow_diary_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_plant_grow_diary_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `diary_category_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_diary_categories_001',
    `grow_info_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_plant_grow_info_001',
    `description` TEXT COMMENT 'Diary description',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_diary_category` FOREIGN KEY (`diary_category_id`) REFERENCES `sg_diary_categories_001`(`id`),
    CONSTRAINT `fk_grow_info` FOREIGN KEY (`grow_info_id`) REFERENCES `sg_plant_grow_info_001`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Plant growth diary records';

-- sg_plant_existed_managed_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_plant_exitsted_managed_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `plant_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_plants_001',
    `user_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_users_001',
    `info_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_plant_grow_info_001',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_plant_existed_plant` FOREIGN KEY (`plant_id`) REFERENCES `sg_plants_001`(`id`),
    CONSTRAINT `fk_plant_existed_user` FOREIGN KEY (`user_id`) REFERENCES `sg_users_001`(`id`),
    CONSTRAINT `fk_plant_existed_info` FOREIGN KEY (`info_id`) REFERENCES `sg_plant_grow_info_001`(`id`) COMMENT='Plants existed from management list';
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Plants existed from management list';

-- sg_plant_not_existed_managed_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_plant_not_existed_managed_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `ai_response_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_ai_response_001',
    `user_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_users_001',
    `info_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_plant_grow_info_001',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_plant_not_existed_ai_response` FOREIGN KEY (`ai_response_id`) REFERENCES `sg_ai_response_001`(`id`),
    CONSTRAINT `fk_plant_not_existed_user` FOREIGN KEY (`user_id`) REFERENCES `sg_users_001`(`id`),
    CONSTRAINT `fk_plant_not_existed_info` FOREIGN KEY (`info_id`) REFERENCES `sg_plant_grow_info_001`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Plants not existed from management list';

-- sg_ai_response_categories_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_ai_response_categories_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key',
    `category` VARCHAR(255) NOT NULL COMMENT 'AI response category',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI response categories';

-- sg_ai_input_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_ai_input_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key',
    `input_query` TEXT NOT NULL COMMENT 'Input query for AI',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI input queries table';

-- sg_ai_response_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_ai_response_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key',
    `input_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_ai_input_001',
    `ai_response_category_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_ai_response_categories_001',
    `ai_response` JSON NOT NULL COMMENT 'AI response data',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    FOREIGN KEY (`input_id`) REFERENCES `sg_ai_input_001`(`id`),
    FOREIGN KEY (`ai_response_category_id`) REFERENCES `sg_ai_response_categories_001`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI response data table';

-- sg_feedback_categories_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_feedback_categories_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key',
    `category` VARCHAR(255) NOT NULL COMMENT 'Feedback category',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Feedback categories table';

-- sg_feedback_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_feedback_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key',
    `category_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_feedback_categories_001',
    `star` INT NOT NULL COMMENT 'Star rating (1-5)',
    `detail` TEXT NOT NULL COMMENT 'Feedback details',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    FOREIGN KEY (`category_id`) REFERENCES `sg_feedback_categories_001`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User feedback data table';

-- sg_feedback_media_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_feedback_media_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Primary key',
    `feedback_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_feedback_001',
    `media_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_media_001',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    FOREIGN KEY (`feedback_id`) REFERENCES `sg_feedback_001`(`id`),
    FOREIGN KEY (`media_id`) REFERENCES `sg_media_001`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Feedback media attachments table';

-- sg_ai_images_001
CREATE TABLE IF NOT EXISTS `sg_001`.`sg_ai_images_001` (
    `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `user_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_users_001',
    `media_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_media_001',
    `result_plant_id` BIGINT(20) NOT NULL COMMENT 'Reference to sg_plants_001',
    `ai_response` JSON NOT NULL COMMENT 'AI response data',
    `type` VARCHAR(255) NOT NULL COMMENT 'Type of AI image processing (e.g., classification, detection)',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last update time',
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `sg_users_001`(`id`),
    FOREIGN KEY (`media_id`) REFERENCES `sg_media_001`(`id`),
    FOREIGN KEY (`result_plant_id`) REFERENCES `sg_plants_001`(`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI image processing results table';
