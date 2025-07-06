-- ====================================================================
-- INNER JOIN
-- ====================================================================

-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT u.first_name, u.last_name, u.role , b.start_date, b.end_date, b.status
FROM user u
INNER JOIN booking b ON u.user_id = b.user_id;

-- Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT p.name, p.description, p.price_per_night,r.rating, r.comment 
FROM property p
LEFT JOIN review r
ON p.property_id = r.property_id;

-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT u.first_name, u.last_name, u.role, b.start_date, b.end_date, b.status
FROM user u
LEFT JOIN booking b ON u.user_id = b.user_id

UNION

SELECT u.first_name, u.last_name, u.role, b.start_date, b.end_date, b.status
FROM user u
RIGHT JOIN booking b ON u.user_id = b.user_id;