-- INSERT statements for Property Management Database
-- Note: Replace UUIDs with actual generated UUIDs in your implementation

-- ===================================
-- USER TABLE INSERTS
-- ===================================

-- Admin Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'John', 'Admin', 'admin@propertymanager.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewF5JUoKOEm5e2tK', '+15550101', 'admin', '2024-01-15 08:00:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Sarah', 'Wilson', 'sarah.admin@propertymanager.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewF5JUoKOEm5e2tK', '+15550102', 'admin', '2024-01-16 09:15:00');

-- Host Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440003', 'Michael', 'Johnson', 'michael.host@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewF5JUoKOEm5e2tK', '+15550201', 'host', '2024-02-01 10:30:00'),
('550e8400-e29b-41d4-a716-446655440004', 'Emily', 'Davis', 'emily.host@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewF5JUoKOEm5e2tK', '+15550202', 'host', '2024-02-03 14:20:00'),
('550e8400-e29b-41d4-a716-446655440005', 'David', 'Brown', 'david.host@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewF5JUoKOEm5e2tK', '+15550203', 'host', '2024-02-05 16:45:00'),
('550e8400-e29b-41d4-a716-446655440006', 'Lisa', 'Anderson', 'lisa.host@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewF5JUoKOEm5e2tK', '+15550204', 'host', '2024-02-07 11:10:00');

-- Guest Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('550e8400-e29b-41d4-a716-446655440007', 'Robert', 'Miller', 'robert.guest@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewF5JUoKOEm5e2tK', '+15550301', 'guest', '2024-03-01 09:00:00'),
('550e8400-e29b-41d4-a716-446655440008', 'Jennifer', 'Garcia', 'jennifer.guest@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewF5JUoKOEm5e2tK', '+15550302', 'guest', '2024-03-05 13:25:00'),
('550e8400-e29b-41d4-a716-446655440009', 'Christopher', 'Martinez', 'chris.guest@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewF5JUoKOEm5e2tK', '+15550303', 'guest', '2024-03-10 15:40:00'),

-- ===================================
-- LOCATION TABLE INSERTS
-- ===================================

INSERT INTO Location (location_id, street_address, city, state_province, postal_code, country, created_at) VALUES
('650e8400-e29b-41d4-a716-446655440001', '123 Ocean Drive', 'Miami', 'Florida', '33139', 'United States', '2024-02-01 10:00:00'),
('650e8400-e29b-41d4-a716-446655440002', '456 Broadway Ave', 'New York', 'New York', '10001', 'United States', '2024-02-02 11:30:00'),
('650e8400-e29b-41d4-a716-446655440003', '789 Sunset Boulevard', 'Los Angeles', 'California', '90028', 'United States', '2024-02-03 14:15:00'),

-- ===================================
-- PROPERTY TABLE INSERTS
-- ===================================

INSERT INTO Property (property_id, host_id, location_id, name, description, price_per_night, created_at, updated_at) VALUES
('750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440001', 'Luxury Miami Beach Condo', 'Stunning oceanfront condo with panoramic views, modern amenities, and direct beach access. Features 2 bedrooms, 2 bathrooms, full kitchen, and private balcony.', 299.99, '2024-02-15 10:00:00', '2024-02-15 10:00:00'),
('750e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440002', 'Manhattan Studio Loft', 'Chic studio apartment in the heart of Manhattan. Perfect for business travelers or couples. Features high ceilings, exposed brick, and modern furnishings.', 189.99, '2024-02-16 11:30:00', '2024-02-16 11:30:00'),

-- ===================================
-- BOOKING TABLE INSERTS
-- ===================================

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Confirmed bookings
('850e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', '2024-04-15', '2024-04-18', 899.97, 'confirmed', '2024-03-20 10:30:00'),
('850e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440008', '2024-04-20', '2024-04-23', 569.97, 'confirmed', '2024-03-22 14:15:00'),
('850e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440009', '2024-05-01', '2024-05-05', 1999.96, 'confirmed', '2024-03-25 16:20:00'),
('850e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440010', '2024-05-10', '2024-05-12', 499.98, 'confirmed', '2024-03-28 11:45:00'),
('850e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440011', '2024-05-15', '2024-05-17', 719.98, 'confirmed', '2024-04-01 09:00:00'),

-- Pending bookings
('850e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440012', '2024-06-01', '2024-06-04', 839.97, 'pending', '2024-04-10 13:30:00'),
('850e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440007', '2024-06-10', '2024-06-13', 479.97, 'pending', '2024-04-12 15:20:00'),

-- Canceled bookings
('850e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440008', '2024-04-01', '2024-04-03', 399.98, 'canceled', '2024-03-15 12:00:00'),
('850e8400-e29b-41d4-a716-446655440009', '750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440009', '2024-03-25', '2024-03-28', 899.97, 'canceled', '2024-03-10 08:45:00');

-- ===================================
-- PAYMENT TABLE INSERTS
-- ===================================

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
-- Payments for confirmed bookings
('950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440001', 899.97, '2024-03-20 10:35:00', 'credit_card'),
('950e8400-e29b-41d4-a716-446655440002', '850e8400-e29b-41d4-a716-446655440002', 569.97, '2024-03-22 14:20:00', 'stripe'),
('950e8400-e29b-41d4-a716-446655440003', '850e8400-e29b-41d4-a716-446655440003', 1999.96, '2024-03-25 16:25:00', 'paypal'),
('950e8400-e29b-41d4-a716-446655440004', '850e8400-e29b-41d4-a716-446655440004', 499.98, '2024-03-28 11:50:00', 'credit_card'),
('950e8400-e29b-41d4-a716-446655440005', '850e8400-e29b-41d4-a716-446655440005', 719.98, '2024-04-01 09:05:00', 'stripe'),

-- Refund for canceled booking
('950e8400-e29b-41d4-a716-446655440006', '850e8400-e29b-41d4-a716-446655440009', -899.97, '2024-03-12 10:00:00', 'credit_card');

-- ===================================
-- REVIEW TABLE INSERTS
-- ===================================

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('a50e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', 5, 'Absolutely amazing oceanfront condo! The views were breathtaking and the location was perfect. Michael was a great host and very responsive. Would definitely stay here again!', '2024-04-19 16:30:00'),
('a50e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440008', 4, 'Great studio in Manhattan. Perfect location for exploring the city. The space was clean and well-equipped. Only minor issue was some street noise at night, but overall excellent stay.', '2024-04-24 11:15:00'),
('a50e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440009', 5, 'This villa exceeded all expectations! The infinity pool, views, and amenities were incredible. Emily was an outstanding host. Perfect for our group celebration. Highly recommended!', '2024-05-06 14:45:00'),
('a50e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440010', 4, 'Beautiful lakefront apartment with stunning views. The location was convenient for business meetings downtown. Apartment was spacious and comfortable. Would stay again!', '2024-05-13 09:20:00'),
('a50e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440011', 5, 'Charming Victorian home in a fantastic neighborhood. The house had so much character and David was incredibly helpful with recommendations. Loved the garden area!', '2024-05-18 18:00:00'),
('a50e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440012', 3, 'Nice condo but had some maintenance issues with the air conditioning. The view was great and location excellent. Host was responsive to issues but took time to resolve.', '2024-03-15 12:30:00');

-- ===================================
-- MESSAGE TABLE INSERTS
-- ===================================

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Guest to Host messages
('b50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440003', 'Hi Michael! I''m excited about my upcoming stay at your Miami condo. What time is check-in, and are there any special instructions?', '2024-04-10 14:30:00'),
('b50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 'Hello! I have a question about parking for the Manhattan studio. Is there a garage nearby or street parking available?', '2024-04-15 10:15:00'),
('b50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', 'Hi Emily! Our group is so excited about the Hollywood Hills villa. Can you recommend any good restaurants nearby for our celebration dinner?', '2024-04-25 16:20:00'),

-- Host to Guest responses
('b50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', 'Hi Robert! Check-in is anytime after 3 PM. I''ll send you the door code and WiFi password closer to your arrival date. Looking forward to hosting you!', '2024-04-10 15:45:00'),
('b50e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', 'Hello Jennifer! There''s a parking garage two blocks away at $25/day, or street parking is available but can be challenging. I''d recommend the garage for convenience.', '2024-04-15 11:30:00'),
('b50e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440009', 'Hi Christopher! I''d highly recommend Yamashiro for the views and atmosphere, or Republique for excellent food. Both are about 10 minutes away. Have a wonderful celebration!', '2024-04-25 18:00:00'),

-- Admin messages
('b50e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003', 'Hi Michael, we noticed your Miami property has excellent reviews! We''d like to feature it in our newsletter. Please let us know if you''re interested.', '2024-04-20 09:00:00'),
('b50e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440004', 'Hello Emily, congratulations on maintaining a 5-star rating! We''d like to invite you to our host appreciation program. Details to follow.', '2024-04-22 13:15:00');

-- ===================================
-- OPTIONAL ENHANCEMENT TABLES
-- ===================================

-- USER_ADDRESS TABLE INSERTS
INSERT INTO User_Address (address_id, user_id, location_id, address_type, is_default, created_at) VALUES
('c50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', '650e8400-e29b-41d4-a716-446655440010', 'primary', TRUE, '2024-03-01 10:00:00'),
('c50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440008', '650e8400-e29b-41d4-a716-446655440009', 'billing', TRUE, '2024-03-05 14:30:00'),
('c50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440009', '650e8400-e29b-41d4-a716-446655440008', 'primary', TRUE, '2024-03-10 16:15:00'),
('c50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440010', '650e8400-e29b-41d4-a716-446655440007', 'billing', TRUE, '2024-03-12 11:20:00'),
('c50e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440011', '650e8400-e29b-41d4-a716-446655440006', 'primary', TRUE, '2024-03-15 13:45:00');

-- PAYMENT_METHOD TABLE INSERTS
INSERT INTO Payment_Method (method_id, method_name, provider_details, is_active, created_at) VALUES
('d50e8400-e29b-41d4-a716-446655440001', 'Visa Credit Card', '{"type": "credit_card", "brand": "visa", "processor": "stripe", "fees": "2.9% + 30¢"}', TRUE, '2024-01-01 08:00:00'),
('d50e8400-e29b-41d4-a716-446655440002', 'Mastercard Credit Card', '{"type": "credit_card", "brand": "mastercard", "processor": "stripe", "fees": "2.9% + 30¢"}', TRUE, '2024-01-01 08:00:00'),
('d50e8400-e29b-41d4-a716-446655440003', 'PayPal', '{"type": "digital_wallet", "processor": "paypal", "fees": "3.49% + fixed_fee"}', TRUE, '2024-01-01 08:00:00'),
('d50e8400-e29b-41d4-a716-446655440004', 'American Express', '{"type": "credit_card", "brand": "amex", "processor": "stripe", "fees": "3.4% + 30¢"}', TRUE, '2024-01-01 08:00:00'),
('d50e8400-e29b-41d4-a716-446655440005', 'Apple Pay', '{"type": "digital_wallet", "processor": "stripe", "fees": "2.9% + 30¢"}', TRUE, '2024-01-15 10:00:00'),
('d50e8400-e29b-41d4-a716-446655440006', 'Google Pay', '{"type": "digital_wallet", "processor": "stripe", "fees": "2.9% + 30¢"}', TRUE, '2024-01-15 10:00:00');

-- ===================================
-- NOTES FOR IMPLEMENTATION
-- ===================================