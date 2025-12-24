Vehicle Booking System – SQL Queries

Overview-->

This project demonstrates SQL queries for a Vehicle Booking System with three tables: users, vehicles, and bookings.
It covers JOINs, NOT EXISTS, WHERE filtering, and GROUP BY/HAVING aggregation.

-- Users table
CREATE TABLE users(
  user_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(50) UNIQUE NOT NULL,
  phone VARCHAR(50),
  role VARCHAR(30)
);

-- Vehicles table
CREATE TABLE vehicles(
  vehicle_id INT PRIMARY KEY,
  name VARCHAR(100),
  type VARCHAR(50),
  model VARCHAR(50),
  registration_number VARCHAR(50) UNIQUE,
  rental_price VARCHAR(50),
  status VARCHAR(50)
);

-- Bookings table
CREATE TABLE bookings(
  booking_id INT PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  vehicle_id INT REFERENCES vehicles(vehicle_id),
  start_date DATE,
  end_date DATE,
  status VARCHAR(50),
  total_cost VARCHAR(50)
);

-- 1. Booking details with customer & vehicle names
SELECT b.booking_id, u.name AS customer_name, v.name AS vehicle_name,
       b.start_date, b.end_date, b.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN vehicles v ON b.vehicle_id = v.vehicle_id;

-- 2. Vehicles never booked
SELECT v.*
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1 FROM bookings b WHERE b.vehicle_id = v.vehicle_id
);

-- 3. Available vehicles of a specific type
SELECT *
FROM vehicles
WHERE status='available' AND type='car';

-- 4. Vehicles booked more than twice
SELECT v.name AS vehicle_name, COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN vehicles v ON b.vehicle_id = v.vehicle_id
GROUP BY v.vehicle_id, v.name
HAVING COUNT(b.booking_id) > 2;
