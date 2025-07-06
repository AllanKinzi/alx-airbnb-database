
-- Create a new table with the partitioning structure
CREATE TABLE Booking_New (
    id INT,
    user_id INT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(50),
    PRIMARY KEY (id, start_date) 
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);


-- Populate the new table with the existing data
INSERT INTO Booking_New
SELECT booking_id, user_id,start_date,end_date,status FROM Booking;