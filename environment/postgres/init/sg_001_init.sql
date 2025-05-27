DO
$$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_database WHERE datname = 'sg_001'
   ) THEN
      CREATE DATABASE sg_001
         ENCODING = 'UTF8'
         LC_COLLATE = 'en_US.utf8'
         LC_CTYPE = 'en_US.utf8'
         TEMPLATE = template0;
END IF;  -- <- Bắt buộc
END
$$;

-- ########################################################################

-- 1. ticket table
CREATE TABLE IF NOT EXISTS ticket (
                                      id BIGSERIAL PRIMARY KEY,
                                      name VARCHAR(50) NOT NULL,
    desc TEXT,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    status INTEGER NOT NULL DEFAULT 0,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

-- Indexes
CREATE INDEX IF NOT EXISTS idx_ticket_end_time ON ticket(end_time);
CREATE INDEX IF NOT EXISTS idx_ticket_start_time ON ticket(start_time);
CREATE INDEX IF NOT EXISTS idx_ticket_status ON ticket(status);

-- Comments
COMMENT ON TABLE ticket IS 'ticket table';
COMMENT ON COLUMN ticket.id IS 'Primary key';
COMMENT ON COLUMN ticket.name IS 'ticket name';
COMMENT ON COLUMN ticket.desc IS 'ticket description';
COMMENT ON COLUMN ticket.start_time IS 'ticket sale start time';
COMMENT ON COLUMN ticket.end_time IS 'ticket sale end time';
COMMENT ON COLUMN ticket.status IS 'ticket sale activity status: 0=deactive, 1=active';
COMMENT ON COLUMN ticket.updated_at IS 'Last update time';
COMMENT ON COLUMN ticket.created_at IS 'Creation time';

-- 2. ticket_item table
CREATE TABLE IF NOT EXISTS ticket_item (
                                           id BIGSERIAL PRIMARY KEY,
                                           name VARCHAR(50) NOT NULL,
    description TEXT,
    stock_initial INTEGER NOT NULL DEFAULT 0,
    stock_available INTEGER NOT NULL DEFAULT 0,
    is_stock_prepared BOOLEAN NOT NULL DEFAULT FALSE,
    price_original BIGINT NOT NULL,
    price_flash BIGINT NOT NULL,
    sale_start_time TIMESTAMP NOT NULL,
    sale_end_time TIMESTAMP NOT NULL,
    status INTEGER NOT NULL DEFAULT 0,
    activity_id BIGINT NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    );

-- Indexes
CREATE INDEX IF NOT EXISTS idx_ticket_item_end_time ON ticket_item(sale_end_time);
CREATE INDEX IF NOT EXISTS idx_ticket_item_start_time ON ticket_item(sale_start_time);
CREATE INDEX IF NOT EXISTS idx_ticket_item_status ON ticket_item(status);

-- Comments
COMMENT ON TABLE ticket_item IS 'Table for ticket details';
COMMENT ON COLUMN ticket_item.id IS 'Primary key';
COMMENT ON COLUMN ticket_item.name IS 'Ticket title';
COMMENT ON COLUMN ticket_item.description IS 'Ticket description';
COMMENT ON COLUMN ticket_item.stock_initial IS 'Initial stock quantity (e.g., 1000 tickets)';
COMMENT ON COLUMN ticket_item.stock_available IS 'Current available stock (e.g., 900 tickets)';
COMMENT ON COLUMN ticket_item.is_stock_prepared IS 'Indicates if stock is pre-warmed (0/1)';
COMMENT ON COLUMN ticket_item.price_original IS 'Original ticket price';
COMMENT ON COLUMN ticket_item.price_flash IS 'Discounted price during flash sale';
COMMENT ON COLUMN ticket_item.sale_start_time IS 'Flash sale start time';
COMMENT ON COLUMN ticket_item.sale_end_time IS 'Flash sale end time';
COMMENT ON COLUMN ticket_item.status IS 'Ticket status (e.g., active/inactive)';
COMMENT ON COLUMN ticket_item.activity_id IS 'ID of associated activity';
COMMENT ON COLUMN ticket_item.updated_at IS 'Timestamp of the last update';
COMMENT ON COLUMN ticket_item.created_at IS 'Creation timestamp';


-- ticket
INSERT INTO ticket (name, desc, start_time, end_time, status, updated_at, created_at) VALUES
    ('Đợt Mở Bán Vé Ngày 12/12', 'Sự kiện mở bán vé đặc biệt cho ngày 12/12', '2024-12-12 00:00:00', '2024-12-12 23:59:59', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Đợt Mở Bán Vé Ngày 01/01', 'Sự kiện mở bán vé cho ngày đầu năm mới 01/01', '2025-01-01 00:00:00', '2025-01-01 23:59:59', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ticket_item
INSERT INTO ticket_item (name, description, stock_initial, stock_available, is_stock_prepared, price_original, price_flash, sale_start_time, sale_end_time, status, activity_id, updated_at, created_at) VALUES
    -- 12/12
    ('Vé Sự Kiện 12/12 - Hạng Phổ Thông', 'Vé phổ thông cho sự kiện ngày 12/12', 1000, 1000, FALSE, 100000, 10000, '2024-12-12 00:00:00', '2024-12-12 23:59:59', 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Vé Sự Kiện 12/12 - Hạng VIP', 'Vé VIP cho sự kiện ngày 12/12', 500, 500, FALSE, 200000, 15000, '2024-12-12 00:00:00', '2024-12-12 23:59:59', 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

    -- 01/01
    ('Vé Sự Kiện 01/01 - Hạng Phổ Thông', 'Vé phổ thông cho sự kiện ngày 01/01', 2000, 2000, FALSE, 100000, 10000, '2025-01-01 00:00:00', '2025-01-01 23:59:59', 1, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Vé Sự Kiện 01/01 - Hạng VIP', 'Vé VIP cho sự kiện ngày 01/01', 1000, 1000, FALSE, 200000, 15000, '2025-01-01 00:00:00', '2025-01-01 23:59:59', 1, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ##################################################################################

-- sg_media_001
-- CREATE TABLE IF NOT EXISTS sg_media_001 (
--     id BIGSERIAL PRIMARY KEY,
--     url TEXT NOT NULL,
--     type VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_media_001 IS 'Media resources table';
--
-- -- sg_plants_001
-- CREATE TABLE IF NOT EXISTS sg_plants_001 (
--     id BIGSERIAL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     scientific_name VARCHAR(255) NOT NULL,
--     description TEXT NOT NULL,
--     significant TEXT NOT NULL,
--     grows TEXT NOT NULL,
--     main_image_url BIGINT NOT NULL,
--     season CHAR(1) NOT NULL, -- (X, H, T, Đ)
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- );
-- COMMENT ON TABLE sg_plants_001 IS 'Plant master data';
--
-- -- sg_soil_types_001
-- CREATE TABLE IF NOT EXISTS sg_soil_types_001 (
--     id BIGSERIAL PRIMARY KEY,
--     type VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_soil_types_001 IS 'Soil type master';
--
-- -- sg_soils_001
-- CREATE TABLE IF NOT EXISTS sg_soils_001 (
--     id BIGSERIAL PRIMARY KEY,
--     type_id BIGINT NOT NULL REFERENCES sg_soil_types_001(id),
--     name VARCHAR(255) NOT NULL,
--     pH_level FLOAT NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_soils_001 IS 'Soil characteristics table';
--
--
-- -- sg_plant_soils_001
-- -- CREATE TABLE IF NOT EXISTS sg_plant_soils_001 (
-- --     id BIGSERIAL PRIMARY KEY,
-- --     plant_id BIGINT NOT NULL REFERENCES sg_plants_001(id),
-- --     soil_id BIGINT NOT NULL REFERENCES sg_soils_001(id),
-- --     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- --     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- -- );
-- -- COMMENT ON TABLE sg_plant_soils_001 IS 'Plant to soil mapping';
--
-- -- sg_countries_001
-- CREATE TABLE IF NOT EXISTS sg_countries_001 (
--     id BIGSERIAL PRIMARY KEY,
--     country VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- );
-- COMMENT ON TABLE sg_countries_001 IS 'Country list';
--
-- -- sg_regions_001
-- CREATE TABLE IF NOT EXISTS sg_regions_001 (
--     id BIGSERIAL PRIMARY KEY,
--     country_id BIGINT NOT NULL REFERENCES sg_countries_001(id),
--     region VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- );
-- COMMENT ON TABLE sg_regions_001 IS 'Region list per country';
--
-- -- sg_soil_regions_001
-- -- CREATE TABLE IF NOT EXISTS sg_soil_regions_001 (
-- --     id BIGSERIAL PRIMARY KEY,
-- --     soil_id BIGINT NOT NULL REFERENCES sg_soils_001(id),
-- --     region_id BIGINT NOT NULL REFERENCES sg_regions_001(id),
-- --     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- --     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- -- );
-- -- COMMENT ON TABLE sg_soil_regions_001 IS 'Soil to region mapping';
--
-- -- sg_fertilizer_types_001
-- CREATE TABLE IF NOT EXISTS sg_fertilizer_types_001 (
--     id BIGSERIAL PRIMARY KEY,
--     type VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- );
-- COMMENT ON TABLE sg_fertilizer_types_001 IS 'Fertilizer type categories';
--
-- -- sg_fertilizers_001
-- CREATE TABLE IF NOT EXISTS sg_fertilizers_001 (
--     id BIGSERIAL PRIMARY KEY,
--     type_id BIGINT NOT NULL REFERENCES sg_fertilizer_types_001(id),
--     name VARCHAR(255) NOT NULL,
--     usage TEXT NOT NULL,
--     formula TEXT NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_fertilizers_001 IS 'Fertilizer information table';
--
-- -- sg_plant_fertilizers_001
-- -- CREATE TABLE IF NOT EXISTS sg_plant_fertilizers_001 (
-- --                                                         id BIGSERIAL PRIMARY KEY,
-- --                                                         plant_id BIGINT NOT NULL REFERENCES sg_plants_001(id),
-- --     fertilizer_id BIGINT NOT NULL REFERENCES sg_fertilizers_001(id),
-- --     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- --     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- --     );
-- -- COMMENT ON TABLE sg_plant_fertilizers_001 IS 'Plant to fertilizer mapping';
--
-- -- sg_weather_forecasts_001
-- CREATE TABLE IF NOT EXISTS sg_weather_forecasts_001 (
--     id BIGSERIAL PRIMARY KEY,
--     region VARCHAR(255) NOT NULL,
--     forecast_date DATE NOT NULL,
--     temperature FLOAT NOT NULL,
--     humidity FLOAT NOT NULL,
--     precipitation FLOAT NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_weather_forecasts_001 IS 'Daily weather forecast data';
--
-- -- sg_news_001
-- CREATE TABLE IF NOT EXISTS sg_news_001 (
--     id BIGSERIAL PRIMARY KEY,
--     title VARCHAR(255) NOT NULL,
--     content TEXT NOT NULL,
--     source TEXT NOT NULL,
--     region VARCHAR(255) NOT NULL,
--     published_at TIMESTAMP NOT NULL
--     );
-- COMMENT ON TABLE sg_news_001 IS 'News articles data';
--
-- -- sg_news_categories_001
-- CREATE TABLE IF NOT EXISTS sg_news_categories_001 (
--     id BIGSERIAL PRIMARY KEY,
--     category VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_news_categories_001 IS 'News categories';

-- -- sg_categories_news_001
-- -- CREATE TABLE IF NOT EXISTS sg_categories_news_001 (
-- --     id BIGSERIAL PRIMARY KEY,
-- --     category_id BIGINT NOT NULL REFERENCES sg_news_categories_001(id),
-- --     news_id BIGINT NOT NULL REFERENCES sg_news_001(id),
-- --     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- --     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- --     );
-- -- COMMENT ON TABLE sg_categories_news_001 IS 'Join table for news and categories';
--
-- -- sg_users_001
-- CREATE TABLE IF NOT EXISTS sg_users_001 (
--     id BIGSERIAL PRIMARY KEY,
--     avatar BIGINT NOT NULL REFERENCES sg_settings_001(id),
--     full_name VARCHAR(255) NOT NULL,
--     email VARCHAR(255) NOT NULL,
--     role VARCHAR(10) NOT NULL, -- (ADMIN, USER)
--     location GEOGRAPHY(POINT, 4326) NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_users_001 IS 'User account data';
-- COMMENT ON COLUMN sg_users_001.role IS 'User role: ADMIN or USER';
--
-- -- sg_search_history_001
-- CREATE TABLE IF NOT EXISTS sg_search_history_001 (
--     id BIGSERIAL PRIMARY KEY,
--     user_id BIGINT NOT NULL REFERENCES sg_users_001(id),
--     query TEXT NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_search_history_001 IS 'Search history for users';
--
-- -- sg_languages_001
-- CREATE TABLE IF NOT EXISTS sg_languages_001 (
--     id BIGSERIAL PRIMARY KEY,
--     language VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_languages_001 IS 'Supported languages';
--
-- -- sg_settings_001
-- CREATE TABLE IF NOT EXISTS sg_settings_001 (
--     id BIGSERIAL PRIMARY KEY,
--     user_id BIGINT NOT NULL REFERENCES sg_users_001(id),
--     language_id BIGINT NOT NULL REFERENCES sg_languages_001(id),
--     watering_notification BOOLEAN NOT NULL,
--     manuring_notification BOOLEAN NOT NULL,
--     news_notification BOOLEAN NOT NULL,
--     regular_notification BOOLEAN NOT NULL,
--     theme VARCHAR(20) NOT NULL, -- DARK, NIGHT, SYSTEM
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_settings_001 IS 'User settings and preferences';
--
-- -- sg_garden_001
-- CREATE TABLE IF NOT EXISTS sg_garden_001 (
--     id BIGSERIAL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     description TEXT NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_garden_001 IS 'Garden information table';
--
-- -- Bảng sg_plant_grow_info_001
-- CREATE TABLE IF NOT EXISTS sg_plant_grow_info_001 (
--     id BIGSERIAL PRIMARY KEY COMMENT 'Primary key',
--     garden_id BIGINT REFERENCES sg_gardens_001(id),
--     plant_image_id BIGINT REFERENCES sg_media_001(id),
--     name VARCHAR(255) NOT NULL COMMENT 'Plant name',
--     description TEXT COMMENT 'Plant description',
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
-- );
--
-- -- sg_plant_grow_media_001
-- -- CREATE TABLE IF NOT EXISTS sg_plant_grow_media_001 (
-- --     id BIGSERIAL PRIMARY KEY,
-- --     plant_info_id BIGINT NOT NULL REFERENCES sg_plant_grow_info_001(id),
-- --     media_id BIGINT NOT NULL REFERENCES sg_media_001(id),
-- --     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
-- --     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- --     );
-- -- COMMENT ON TABLE sg_plant_grow_media_001 IS 'Plant grow media resources';
--
-- -- Bảng sg_diary_categories_001
-- CREATE TABLE IF NOT EXISTS sg_diary_categories_001 (
--     id BIGSERIAL PRIMARY KEY COMMENT 'Primary key',
--     category VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
--     );
--
-- COMMENT ON TABLE sg_diary_categories_001 IS 'Diary categories table';
-- COMMENT ON COLUMN sg_diary_categories_001.id IS 'Primary key';
--
-- -- Bảng sg_plant_grow_diary_001
-- CREATE TABLE IF NOT EXISTS sg_plant_grow_diary_001 (
--     id BIGSERIAL PRIMARY KEY,
--     diary_category_id BIGINT NOT NULL REFERENCES sg_diary_categories_001(id),
--     grow_info_id BIGINT NOT NULL REFERENCES sg_plant_grow_info_001(id),
--     description TEXT,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
-- );
--
-- -- sg_plant_existed_managed_001
-- CREATE TABLE IF NOT EXISTS sg_plant_existed_managed_001 (
--     id BIGSERIAL PRIMARY KEY,
--     plant_id BIGINT NOT NULL REFERENCES sg_plants_001(id),
--     user_id BIGINT NOT NULL REFERENCES sg_users_001(id),
--     info_id BIGINT NOT NULL REFERENCES sg_plant_grow_info_001(id),
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- );
-- COMMENT ON TABLE sg_plant_existed_managed_001 IS 'Plants existed from management list';
--
-- -- Bảng sg_plant_not_existed_managed_001
-- CREATE TABLE IF NOT EXISTS sg_plant_not_existed_managed_001 (
--     id BIGSERIAL PRIMARY KEY,
--     ai_response_id BIGINT REFERENCES sg_ai_response_001(id),
--     user_id BIGINT NOT NULL REFERENCES sg_users_001(id),
--     info_id BIGINT NOT NULL REFERENCES sg_plant_grow_info_001(id),
--     created_at TIMESTAMP,
--     updated_at TIMESTAMP
-- );
--
-- -- Bảng sg_ai_response_categories_001
-- CREATE TABLE IF NOT EXISTS sg_ai_response_categories_001 (
--     id BIGSERIAL PRIMARY KEY,
--     category VARCHAR(255),
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
-- );
--
-- -- Bảng sg_ai_input_001
-- CREATE TABLE IF NOT EXISTS sg_ai_input_001 (
--     id BIGSERIAL PRIMARY KEY COMMENT 'Primary key',
--     input_query TEXT NOT NULL COMMENT 'Input query for AI',
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
-- );
--
-- -- Bảng sg_ai_response_001
-- CREATE TABLE IF NOT EXISTS sg_ai_response_001 (
--     id BIGSERIAL PRIMARY KEY,
--     input_id BIGINT REFERENCES sg_ai_input_001(id),
--     ai_response_category_id BIGINT REFERENCES sg_ai_response_categories_001(id),
--     ai_response JSONB,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
-- );
--
-- -- Bảng sg_feedback_categories_001
-- CREATE TABLE IF NOT EXISTS sg_feedback_categories_001 (
--     id BIGSERIAL PRIMARY KEY,
--     category VARCHAR(255),
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
-- );
--
-- -- Bảng sg_feedback_001
-- CREATE TABLE IF NOT EXISTS sg_feedback_001 (
--     id BIGSERIAL PRIMARY KEY,
--     category_id BIGINT REFERENCES sg_feedback_categories_001(id),
--     star INT,
--     detail TEXT,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
-- );
--
-- -- Bảng sg_feedback_media_001
-- CREATE TABLE IF NOT EXISTS sg_feedback_media_001 (
--     id BIGSERIAL PRIMARY KEY,
--     feedback_id BIGINT REFERENCES sg_feedback_001(id),
--     media_id BIGINT REFERENCES sg_media_001(id),
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last update time',
-- );
--
-- -- sg_ai_images_001
-- CREATE TABLE IF NOT EXISTS sg_ai_images_001 (
--     id BIGSERIAL PRIMARY KEY,
--     user_id BIGINT NOT NULL REFERENCES sg_users_001(id),
--     media_id BIGINT NOT NULL REFERENCES sg_media_001(id),
--     result_plant_id BIGINT NOT NULL REFERENCES sg_plants_001(id),
--     ai_response JSONB NOT NULL,
--     type VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
--     );
-- COMMENT ON TABLE sg_ai_images_001 IS 'AI processed plant images';
