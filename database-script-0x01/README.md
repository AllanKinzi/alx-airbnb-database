## Database Schema - Third Normal Form

This document contains the final normalized database schema that complies with Third Normal Form (3NF) requirements.

## Core Tables

### User
- **user_id**: Primary Key, UUID, Indexed
- **first_name**: VARCHAR, NOT NULL
- **last_name**: VARCHAR, NOT NULL
- **email**: VARCHAR, UNIQUE, NOT NULL
- **password_hash**: VARCHAR, NOT NULL
- **phone_number**: VARCHAR, NULL
- **role**: ENUM (`guest`, `host`, `admin`), NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Location (New)
- **location_id**: Primary Key, UUID, Indexed
- **street_address**: VARCHAR, NOT NULL
- **city**: VARCHAR, NOT NULL
- **state_province**: VARCHAR, NOT NULL
- **postal_code**: VARCHAR, NOT NULL
- **country**: VARCHAR, NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Property (Modified)
- **property_id**: Primary Key, UUID, Indexed
- **host_id**: Foreign Key, references `User(user_id)`
- **location_id**: Foreign Key, references `Location(location_id)`
- **name**: VARCHAR, NOT NULL
- **description**: TEXT, NOT NULL
- **price_per_night**: DECIMAL, NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- **updated_at**: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

### Booking
- **booking_id**: Primary Key, UUID, Indexed
- **property_id**: Foreign Key, references `Property(property_id)`
- **user_id**: Foreign Key, references `User(user_id)`
- **start_date**: DATE, NOT NULL
- **end_date**: DATE, NOT NULL
- **total_price**: DECIMAL, NOT NULL
- **status**: ENUM (`pending`, `confirmed`, `canceled`), NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Payment
- **payment_id**: Primary Key, UUID, Indexed
- **booking_id**: Foreign Key, references `Booking(booking_id)`
- **amount**: DECIMAL, NOT NULL
- **payment_date**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- **payment_method**: ENUM (`credit_card`, `paypal`, `stripe`), NOT NULL

### Review
- **review_id**: Primary Key, UUID, Indexed
- **property_id**: Foreign Key, references `Property(property_id)`
- **user_id**: Foreign Key, references `User(user_id)`
- **rating**: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
- **comment**: TEXT, NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Message
- **message_id**: Primary Key, UUID, Indexed
- **sender_id**: Foreign Key, references `User(user_id)`
- **recipient_id**: Foreign Key, references `User(user_id)`
- **message_body**: TEXT, NOT NULL
- **sent_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Optional Enhancement Tables

### User_Address (Optional)
- **address_id**: Primary Key, UUID, Indexed
- **user_id**: Foreign Key, references `User(user_id)`
- **location_id**: Foreign Key, references `Location(location_id)`
- **address_type**: ENUM (`billing`, `shipping`, `primary`), NOT NULL
- **is_default**: BOOLEAN, DEFAULT FALSE
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Payment_Method (Optional Enhancement)
- **method_id**: Primary Key, UUID, Indexed
- **method_name**: VARCHAR, NOT NULL
- **provider_details**: JSON, NULL
- **is_active**: BOOLEAN, DEFAULT TRUE
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Relationships

### Primary Relationships
- **User → Property**: One-to-Many (A host can own multiple properties)
- **Location → Property**: One-to-Many (A location can have multiple properties)
- **User → Booking**: One-to-Many (A user can make multiple bookings)
- **Property → Booking**: One-to-Many (A property can have multiple bookings)
- **Booking → Payment**: One-to-One (Each booking has one payment)
- **User → Review**: One-to-Many (A user can write multiple reviews)
- **Property → Review**: One-to-Many (A property can have multiple reviews)
- **User → Message**: One-to-Many (As sender and recipient)

### Optional Relationships
- **User → User_Address**: One-to-Many (A user can have multiple addresses)
- **Location → User_Address**: One-to-Many (A location can be used by multiple users)
- **Payment_Method → Payment**: One-to-Many (A payment method can be used for multiple payments)

## Constraints

### User Table
- Unique constraint on `email`
- Non-null constraints on required fields
- Role must be one of: `guest`, `host`, `admin`

### Location Table
- Non-null constraints on all address components
- Composite unique constraint on (`street_address`, `city`, `state_province`, `postal_code`, `country`)

### Property Table
- Foreign key constraint on `host_id` references `User(user_id)`
- Foreign key constraint on `location_id` references `Location(location_id)`
- Price per night must be positive
- Non-null constraints on essential attributes

### Booking Table
- Foreign key constraint on `property_id` references `Property(property_id)`
- Foreign key constraint on `user_id` references `User(user_id)`
- Date validation: `end_date` must be after `start_date`
- Status must be one of: `pending`, `confirmed`, `canceled`
- Total price must be positive

### Payment Table
- Foreign key constraint on `booking_id` references `Booking(booking_id)`
- Amount must be positive
- Payment method must be one of: `credit_card`, `paypal`, `stripe`

### Review Table
- Foreign key constraint on `property_id` references `Property(property_id)`
- Foreign key constraint on `user_id` references `User(user_id)`
- Rating must be between 1 and 5 (inclusive)
- Composite unique constraint on (`property_id`, `user_id`) to prevent duplicate reviews

### Message Table
- Foreign key constraint on `sender_id` references `User(user_id)`
- Foreign key constraint on `recipient_id` references `User(user_id)`
- Check constraint: `sender_id` ≠ `recipient_id` (prevent self-messaging)

### User_Address Table (Optional)
- Foreign key constraint on `user_id` references `User(user_id)`
- Foreign key constraint on `location_id` references `Location(location_id)`
- Address type must be one of: `billing`, `shipping`, `primary`
- Only one default address per user per address type

### Payment_Method Table (Optional)
- Unique constraint on `method_name`
- Non-null constraint on `method_name`

## Indexes

### Primary Indexes
- All primary keys are automatically indexed
- `User.email` - unique index for login lookups
- `Property.host_id` - index for host property queries
- `Property.location_id` - index for location-based searches
- `Booking.property_id` - index for property booking queries
- `Booking.user_id` - index for user booking history
- `Review.property_id` - index for property reviews
- `Review.user_id` - index for user review history

### Composite Indexes
- `Booking(start_date, end_date)` - for availability queries
- `Property(location_id, price_per_night)` - for location and price filtering
- `Review(property_id, rating)` - for property rating aggregations

## 3NF Compliance Verification

### First Normal Form (1NF) ✅
- All attributes contain atomic values
- No repeating groups
- Each row is unique
- All columns contain values of the same data type

### Second Normal Form (2NF) ✅
- All tables are in 1NF
- All non-key attributes are fully functionally dependent on primary keys
- No partial dependencies (all tables use single-column primary keys)

### Third Normal Form (3NF) ✅
- All tables are in 2NF
- No transitive dependencies exist
- Location data properly normalized into separate table
- All non-key attributes depend only on primary keys, not on other non-key attributes