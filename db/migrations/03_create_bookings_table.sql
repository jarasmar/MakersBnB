CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    space_id INTEGER REFERENCES spaces(space_id),
    user_id INTEGER REFERENCES users(user_id),
    date DATE
    status INT DEFAULT 0
);