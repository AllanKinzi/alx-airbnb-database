-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT b.user_id, u.first_name, u.last_name, COUNT(*) as total_count 
FROM booking b
LEFT JOIN user u ON b.user_id = u.user_id
GROUP BY b.user_id;

-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT 
	name , 
	description, 
	prop_count,
    RANK() OVER (ORDER BY prop_count DESC) as booking_rank
FROM (
	SELECT p.property_id, p.name, p.description, COUNT(p.property_id) AS prop_count FROM property p 
	LEFT JOIN booking b 
	ON p.property_id = b.property_id
	GROUP BY p.property_id
) AS property_bookings