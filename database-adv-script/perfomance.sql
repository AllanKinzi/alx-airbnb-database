SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price AS booking_price,
    b.status AS booking_status,
    b.created_at AS booking_created_at,
    
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    
    p.property_id,
    p.name AS property_name,
    p.description AS property_description,
    p.price_per_night,
    
    pay.payment_id,
    pay.payment_method,
    pay.payment_status,
    pay.amount AS payment_amount,
    pay.payment_date AS payment_created_at

FROM Booking b

JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;