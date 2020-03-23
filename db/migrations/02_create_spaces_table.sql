CREATE TABLE spaces(space_id SERIAL PRIMARY KEY, space_name VARCHAR(60) NOT NULL, description VARCHAR(500), price DECIMAL(6, 2) NOT NULL, user_id INTEGER REFERENCES users(user_id));
