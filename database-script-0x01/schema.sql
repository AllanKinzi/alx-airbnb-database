-- ====================================================================
-- DATABASE SCHEMA CREATION - PROPERTY BOOKING SYSTEM (3NF COMPLIANT)
-- ====================================================================

-- Drop existing tables if they exist (in reverse dependency order)
DROP TABLE IF EXISTS User_Address;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS User;

-- ====================================================================
-- CORE TABLES
-- ====================================================================

-- User Table
CREATE TABLE User (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(20) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT user_email_format CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT user_phone_format CHECK (phone_number IS NULL OR phone_number ~ '^\+?[1-9]\d{1,14}$')
);

-- Location Table (New - for normalization)
CREATE TABLE Location (
    location_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state_province VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT location_unique UNIQUE (street_address, city, state_province, postal_code, country)
);

-- Property Table (Modified for normalization)
CREATE TABLE Property (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id UUID NOT NULL,
    location_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_property_host FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_property_location FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE RESTRICT,
    
    -- Check Constraints
    CONSTRAINT property_price_positive CHECK (price_per_night > 0),
    CONSTRAINT property_name_length CHECK (LENGTH(name) >= 3)
);

-- Booking Table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    
    -- Check Constraints
    CONSTRAINT booking_date_valid CHECK (end_date > start_date),
    CONSTRAINT booking_price_positive CHECK (total_price > 0),
    CONSTRAINT booking_future_date CHECK (start_date >= CURRENT_DATE)
);

-- Payment Table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')),
    
    -- Foreign Key Constraints
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE,
    
    -- Check Constraints
    CONSTRAINT payment_amount_positive CHECK (amount > 0)
);

-- Review Table
CREATE TABLE Review (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    
    -- Check Constraints
    CONSTRAINT review_rating_valid CHECK (rating >= 1 AND rating <= 5),
    CONSTRAINT review_comment_length CHECK (LENGTH(comment) >= 10),
    
    -- Unique Constraint (one review per user per property)
    CONSTRAINT review_unique UNIQUE (property_id, user_id)
);

-- Message Table
CREATE TABLE Message (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_message_recipient FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE,
    
    -- Check Constraints
    CONSTRAINT message_no_self_send CHECK (sender_id != recipient_id),
    CONSTRAINT message_body_length CHECK (LENGTH(message_body) >= 1)
);

-- ====================================================================
-- OPTIONAL ENHANCEMENT TABLES
-- ====================================================================

-- User Address Table (Optional - for multiple addresses per user)
CREATE TABLE User_Address (
    address_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    location_id UUID NOT NULL,
    address_type VARCHAR(20) NOT NULL CHECK (address_type IN ('billing', 'shipping', 'primary')),
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_user_address_user FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_user_address_location FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE RESTRICT,
    
    -- Unique Constraint (one default address per user per type)
    CONSTRAINT user_address_default_unique UNIQUE (user_id, address_type, is_default) DEFERRABLE INITIALLY DEFERRED
);

-- ====================================================================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- ====================================================================

-- User Table Indexes
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);
CREATE INDEX idx_user_created_at ON User(created_at);

-- Location Table Indexes
CREATE INDEX idx_location_city ON Location(city);
CREATE INDEX idx_location_state ON Location(state_province);
CREATE INDEX idx_location_country ON Location(country);
CREATE INDEX idx_location_city_state ON Location(city, state_province);

-- Property Table Indexes
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location_id ON Property(location_id);
CREATE INDEX idx_property_price ON Property(price_per_night);
CREATE INDEX idx_property_created_at ON Property(created_at);
CREATE INDEX idx_property_location_price ON Property(location_id, price_per_night);

-- Booking Table Indexes
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_start_date ON Booking(start_date);
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- Payment Table Indexes
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
CREATE INDEX idx_payment_date ON Payment(payment_date);
CREATE INDEX idx_payment_method ON Payment(payment_method);

-- Review Table Indexes
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_user_id ON Review(user_id);
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_review_created_at ON Review(created_at);
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- Message Table Indexes
CREATE INDEX idx_message_sender_id ON Message(sender_id);
CREATE INDEX idx_message_recipient_id ON Message(recipient_id);
CREATE INDEX idx_message_sent_at ON Message(sent_at);

-- User_Address Table Indexes
CREATE INDEX idx_user_address_user_id ON User_Address(user_id);
CREATE INDEX idx_user_address_location_id ON User_Address(location_id);
CREATE INDEX idx_user_address_type ON User_Address(address_type);

-- ====================================================================
-- TRIGGERS FOR AUTOMATIC UPDATES
-- ====================================================================

-- Update Property updated_at timestamp
CREATE OR REPLACE FUNCTION update_property_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_property_updated_at
    BEFORE UPDATE ON Property
    FOR EACH ROW
    EXECUTE FUNCTION update_property_timestamp();

-- ====================================================================
-- VIEWS FOR COMMON QUERIES
-- ====================================================================

-- Property Details View (with location information)
CREATE VIEW property_details AS
SELECT 
    p.property_id,
    p.name,
    p.description,
    p.price_per_night,
    CONCAT(u.first_name, ' ', u.last_name) AS host_name,
    CONCAT(l.street_address, ', ', l.city, ', ', l.state_province, ' ', l.postal_code, ', ', l.country) AS full_address,
    l.city,
    l.state_province,
    l.country,
    p.created_at,
    p.updated_at
FROM Property p
JOIN User u ON p.host_id = u.user_id
JOIN Location l ON p.location_id = l.location_id;

-- Booking Summary View
CREATE VIEW booking_summary AS
SELECT 
    b.booking_id,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    p.name AS property_name,
    CONCAT(l.city, ', ', l.state_province) AS property_location,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN Location l ON p.location_id = l.location_id;

-- Property Reviews Summary View
CREATE VIEW property_review_summary AS
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(r.review_id) AS review_count,
    ROUND(AVG(r.rating), 2) AS average_rating,
    MAX(r.created_at) AS latest_review_date
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name;

-- ====================================================================
-- SAMPLE DATA INSERTION (Optional)
-- ====================================================================

-- Insert sample users
INSERT INTO User (first_name, last_name, email, password_hash, phone_number, role) VALUES
('John', 'Doe', 'john.doe@example.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewgdJNzBuNvVTngi', '+1234567890', 'host'),
('Jane', 'Smith', 'jane.smith@example.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewgdJNzBuNvVTngi', '+1987654321', 'guest'),
('Admin', 'User', 'admin@example.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewgdJNzBuNvVTngi', '+1555555555', 'admin');

-- Insert sample locations
INSERT INTO Location (street_address, city, state_province, postal_code, country) VALUES
('123 Main Street', 'New York', 'NY', '10001', 'USA'),
('456 Oak Avenue', 'Los Angeles', 'CA', '90210', 'USA'),
('789 Pine Road', 'Chicago', 'IL', '60601', 'USA');

-- ====================================================================
-- DATABASE SETUP COMPLETION
-- ====================================================================

-- Grant necessary permissions (adjust as needed)
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO your_app_user;
-- GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO your_app_user;

-- Display table creation summary
SELECT 
    schemaname,
    tablename,
    tableowner
FROM pg_tables 
WHERE schemaname = 'public' 
ORDER BY tablename;