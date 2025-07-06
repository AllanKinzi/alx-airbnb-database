-- === User Table Indexes ===
CREATE INDEX idx_user_email ON User(email);
-- user_id already has PRIMARY KEY index

-- === Property Table Indexes ===
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location_id ON Property(location_id);
CREATE INDEX idx_property_price ON Property(price_per_night);

-- === Booking Table Indexes ===
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- Composite index if filtering by user_id and status together often:
CREATE INDEX idx_booking_user_status ON Booking(user_id, status);


-- Measure the performance of the query:
EXPLAIN SELECT * FROM Booking WHERE user_id = '550e8400-e29b-41d4-a716-446655440007' AND status = 'confirmed';
