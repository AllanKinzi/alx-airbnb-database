====================================================================
-- SUBQUERIES
====================================================================

-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.

SELECT * FROM property
WHERE property_id
IN (
	SELECT property_id FROM review 
	GROUP BY property_id 
	HAVING AVG(rating) > 4.0
);

-- Write a correlated subquery to find users who have made more than 3 bookings.
SELECT * FROM user
WHERE user_id
IN (
	SELECT user_id FROM booking 
	GROUP BY user_id 
	HAVING COUNT(user_id) > 3
);