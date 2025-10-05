CREATE DATABASE Carrental;


CREATE SCHEMA car_rental;


CREATE TABLE car_rental.Car (
   car_id INT IDENTITY(1,1) PRIMARY KEY,
   car_model VARCHAR(50) NOT NULL,
   manufacturer VARCHAR(50) NOT NULL,
   year INT NOT NULL,
   color VARCHAR(30),
   rental_rate DECIMAL(10,2) NOT NULL,
   availability BIT DEFAULT 1
);

INSERT INTO car_rental.Car (car_model, manufacturer, year, color, rental_rate, availability)
VALUES
('Corolla', 'Toyota', 2021, 'White', 4500.00, 1),
('Civic', 'Honda', 2022, 'Black', 5000.00, 1),
('CX-5', 'Mazda', 2020, 'Red', 5500.00, 1),
('X-Trail', 'Nissan', 2019, 'Silver', 4000.00, 1),
('Forester', 'Subaru', 2023, 'Blue', 6000.00, 1);

SELECT *
FROM car_rental.Car

CREATE TABLE car_rental.Customer (
   customer_id INT IDENTITY(1,1) PRIMARY KEY,
   first_name VARCHAR(30) NOT NULL,
   last_name VARCHAR(30) NOT NULL,
   email VARCHAR(50),
   phone_number VARCHAR(20),
   address VARCHAR(100)
);

INSERT INTO car_rental.Customer (first_name, last_name, email, phone_number, address)
VALUES
('John', 'Doe', 'john.doe@email.com', '0722123456', '123 Main St, Nairobi'),
('Jane', 'Smith', 'jane.smith@email.com', '0733123456', '456 West Rd, Kisumu'),
('Brian', 'Kemboi', 'brian.kemboi@email.com', '0744123456', '789 East Ave, Eldoret'),
('Alice', 'Wanjiku', 'alice.wanjiku@email.com', '0755123456', '321 South Ln, Nakuru'),
('Cynthia', 'Kiprop', 'cynthia.kiprop@email.com', '0733945456', '459 East Rd, Mombasa');


CREATE TABLE car_rental.Booking (
   booking_id INT IDENTITY(1,1) PRIMARY KEY,
   car_id INT NOT NULL,
   customer_id INT NOT NULL,
   rental_start_date DATE NOT NULL,
   rental_end_date DATE NOT NULL,
   total_amount DECIMAL(10,2) NOT NULL,
   FOREIGN KEY (car_id) REFERENCES car_rental.Car(car_id),
   FOREIGN KEY (customer_id) REFERENCES car_rental.Customer(customer_id)
);

INSERT INTO car_rental.Booking (car_id, customer_id, rental_start_date, rental_end_date, total_amount)
VALUES
(1, 1, '2025-09-01', '2025-09-05', 22500.00),
(2, 2, '2025-08-10', '2025-08-15', 25000.00),
(3, 3, '2025-07-20', '2025-07-25', 27500.00),
(4, 4, '2025-06-05', '2025-06-10', 20000.00),
(5, 5, '2025-05-12', '2025-05-18', 36000.00);


CREATE TABLE car_rental.Payment (
   payment_id INT IDENTITY(1,1) PRIMARY KEY,
   booking_id INT NOT NULL,
   payment_date DATE NOT NULL,
   amount DECIMAL(10,2) NOT NULL,
   payment_method VARCHAR(20),
   FOREIGN KEY (booking_id) REFERENCES car_rental.Booking(booking_id)
);

INSERT INTO car_rental.Payment (booking_id, payment_date, amount, payment_method)
VALUES
(1, '2025-09-02', 22500.00, 'Mpesa'),
(2, '2025-08-11', 25000.00, 'Card'),
(3, '2025-07-21', 27500.00, 'Cash'),
(4, '2025-06-06', 20000.00, 'Mpesa'),
(5, '2025-05-13', 36000.00, 'Card');


CREATE TABLE car_rental.Insurance (
   insurance_id INT IDENTITY(1,1) PRIMARY KEY,
   car_id INT NOT NULL,
   insurance_provider VARCHAR(50),
   policy_number VARCHAR(30),
   start_date DATE,
   end_date DATE,
   FOREIGN KEY (car_id) REFERENCES car_rental.Car(car_id)
);

INSERT INTO car_rental.Insurance (car_id, insurance_provider, policy_number, start_date, end_date)
VALUES
(1, 'Britam', 'BR1234', '2025-01-01', '2025-12-31'),
(2, 'Jubilee', 'JB5678', '2025-02-01', '2026-01-31'),
(3, 'Madison', 'MD9101', '2025-03-01', '2026-02-28'),
(4, 'ICEA', 'IC1121', '2025-04-01', '2026-03-31'),
(5, 'UAP', 'UA3141', '2025-05-01', '2026-04-30');


CREATE TABLE car_rental.Location (
   location_id INT IDENTITY(1,1) PRIMARY KEY,
   car_id INT NOT NULL,
   location_name VARCHAR(50),
   address VARCHAR(100),
   contact_number VARCHAR(20),
   FOREIGN KEY (car_id) REFERENCES car_rental.Car(car_id)
);

INSERT INTO car_rental.Location (car_id, location_name, address, contact_number)
VALUES
(1, 'Karen Branch', '123 Karen Rd, Nairobi', '0712345678'),
(2, 'Kasarani Branch', '456 Kasarani Rd, Nairobi', '0722123456'),
(3, 'Westlands Branch', '789 Westlands Ave, Nairobi', '0733123456'),
(4, 'Ruiru Branch', '321 North Ln, Ruiru', '0744123456'),
(5, 'Lavington Branch', '459 East Rd, Lavington', '0755123456');

CREATE TABLE car_rental.Reservation (
   reservation_id INT IDENTITY(1,1) PRIMARY KEY,
   car_id INT NOT NULL,
   customer_id INT NOT NULL,
   reservation_date DATE,
   pickup_date DATE,
   return_date DATE,
   FOREIGN KEY (car_id) REFERENCES car_rental.Car(car_id),
   FOREIGN KEY (customer_id) REFERENCES car_rental.Customer(customer_id)
);

INSERT INTO car_rental.Reservation (car_id, customer_id, reservation_date, pickup_date, return_date)
VALUES
(1, 1, '2025-09-01', '2025-09-03', '2025-09-05'),
(2, 2, '2025-08-10', '2025-08-12', '2025-08-15'),
(3, 3, '2025-07-20', '2025-07-22', '2025-07-25'),
(4, 4, '2025-06-05', '2025-06-07', '2025-06-10'),
(5, 5, '2025-05-12', '2025-05-14', '2025-05-18');


CREATE TABLE car_rental.Maintenance (
   maintenance_id INT IDENTITY(1,1) PRIMARY KEY,
   car_id INT NOT NULL,
   maintenance_date DATE,
   description VARCHAR(100),
   cost DECIMAL(10,2),
   FOREIGN KEY (car_id) REFERENCES car_rental.Car(car_id)
);

INSERT INTO car_rental.Maintenance (car_id, maintenance_date, description, cost)
VALUES
(1, '2025-02-01', 'Engine Service', 12000.00),
(2, '2025-03-10', 'Oil Change', 5000.00),
(3, '2025-04-15', 'Brake Replacement', 8000.00),
(4, '2025-05-05', 'Wheel Alignment', 3000.00),
(5, '2025-06-12', 'Air Filter Replacement', 2500.00);


SELECT * FROM car_rental.Customer WHERE address LIKE '%Nairobi%';
SELECT * FROM car_rental.Car WHERE availability = 1;
SELECT * FROM car_rental.Booking WHERE total_amount > 20000;

UPDATE car_rental.Car
SET availability = 0
WHERE car_id = 3;


DELETE FROM car_rental.Maintenance
WHERE maintenance_id = 5;
