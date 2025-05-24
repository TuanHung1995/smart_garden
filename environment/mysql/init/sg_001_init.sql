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
