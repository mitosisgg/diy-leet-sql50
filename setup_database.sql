-- Database Setup for SQL Practice Questions
-- Designed for PostgreSQL 14+
-- Run this script to create tables and populate with realistic test data

DROP DATABASE IF EXISTS sql_practice;
CREATE DATABASE sql_practice;
\c sql_practice;

-- Enable UUID extension for unique identifiers
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10),
    country VARCHAR(50),
    city VARCHAR(50),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    profile_data JSONB
);

-- Categories table
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INTEGER REFERENCES categories(category_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    category_id INTEGER REFERENCES categories(category_id),
    price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    stock_quantity INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    specifications JSONB
);

-- Orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending',
    total_amount DECIMAL(10,2) NOT NULL,
    shipping_address TEXT,
    billing_address TEXT,
    payment_method VARCHAR(50),
    shipped_date TIMESTAMP,
    delivered_date TIMESTAMP
);

-- Order items table
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0
);

-- Posts table (for social media/blog features)
CREATE TABLE posts (
    post_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    title VARCHAR(200) NOT NULL,
    content TEXT,
    post_type VARCHAR(20) DEFAULT 'text',
    status VARCHAR(20) DEFAULT 'published',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    view_count INTEGER DEFAULT 0,
    like_count INTEGER DEFAULT 0,
    tags JSONB
);

-- Comments table
CREATE TABLE comments (
    comment_id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES posts(post_id),
    user_id INTEGER REFERENCES users(user_id),
    parent_comment_id INTEGER REFERENCES comments(comment_id),
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    like_count INTEGER DEFAULT 0,
    is_deleted BOOLEAN DEFAULT FALSE
);

-- Movies table
CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    director VARCHAR(100),
    release_year INTEGER,
    genre VARCHAR(50),
    duration_minutes INTEGER,
    budget DECIMAL(15,2),
    box_office DECIMAL(15,2),
    imdb_rating DECIMAL(3,1),
    description TEXT,
    metadata JSONB
);

-- Ratings table
CREATE TABLE ratings (
    rating_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    movie_id INTEGER REFERENCES movies(movie_id),
    rating INTEGER CHECK (rating >= 1 AND rating <= 10),
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, movie_id)
);

-- Activity table (for tracking user actions)
CREATE TABLE activity (
    activity_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    activity_type VARCHAR(50) NOT NULL,
    entity_type VARCHAR(50),
    entity_id INTEGER,
    activity_data JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Employees table (for HR/company queries)
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50),
    position VARCHAR(100),
    manager_id INTEGER REFERENCES employees(employee_id),
    salary DECIMAL(10,2),
    hire_date DATE NOT NULL,
    termination_date DATE,
    is_active BOOLEAN DEFAULT TRUE
);

-- Sales table
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(employee_id),
    customer_id INTEGER,
    product_id INTEGER REFERENCES products(product_id),
    sale_date DATE NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    commission_rate DECIMAL(5,4) DEFAULT 0.05
);

-- Create indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_registration_date ON users(registration_date);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_created_at ON posts(created_at);
CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_comments_user_id ON comments(user_id);
CREATE INDEX idx_ratings_user_id ON ratings(user_id);
CREATE INDEX idx_ratings_movie_id ON ratings(movie_id);
CREATE INDEX idx_activity_user_id ON activity(user_id);
CREATE INDEX idx_activity_created_at ON activity(created_at);
CREATE INDEX idx_employees_manager_id ON employees(manager_id);
CREATE INDEX idx_employees_department ON employees(department);
CREATE INDEX idx_sales_employee_id ON sales(employee_id);
CREATE INDEX idx_sales_sale_date ON sales(sale_date);

-- Insert seed data

-- Categories
INSERT INTO categories (name, description) VALUES
('Electronics', 'Electronic devices and gadgets'),
('Books', 'Physical and digital books'),
('Clothing', 'Apparel and accessories'),
('Home & Garden', 'Home improvement and garden supplies'),
('Sports', 'Sports equipment and gear');

INSERT INTO categories (name, description, parent_category_id) VALUES
('Smartphones', 'Mobile phones and accessories', 1),
('Laptops', 'Laptop computers', 1),
('Fiction', 'Fiction books', 2),
('Non-Fiction', 'Non-fiction books', 2),
('Men''s Clothing', 'Clothing for men', 3),
('Women''s Clothing', 'Clothing for women', 3);

-- Users
INSERT INTO users (username, email, first_name, last_name, date_of_birth, gender, country, city, registration_date, last_login, profile_data) VALUES
('john_doe', 'john.doe@email.com', 'John', 'Doe', '1990-05-15', 'Male', 'USA', 'New York', '2023-01-15 10:30:00', '2024-01-20 14:22:00', '{"interests": ["technology", "sports"], "newsletter": true}'),
('jane_smith', 'jane.smith@email.com', 'Jane', 'Smith', '1985-08-22', 'Female', 'Canada', 'Toronto', '2023-02-20 09:15:00', '2024-01-19 16:45:00', '{"interests": ["books", "travel"], "newsletter": false}'),
('mike_wilson', 'mike.wilson@email.com', 'Mike', 'Wilson', '1992-12-03', 'Male', 'UK', 'London', '2023-03-10 11:45:00', '2024-01-18 12:30:00', '{"interests": ["movies", "music"], "newsletter": true}'),
('sarah_johnson', 'sarah.johnson@email.com', 'Sarah', 'Johnson', '1988-04-17', 'Female', 'Australia', 'Sydney', '2023-04-05 14:20:00', '2024-01-21 09:15:00', '{"interests": ["fitness", "cooking"], "newsletter": true}'),
('david_brown', 'david.brown@email.com', 'David', 'Brown', '1995-11-28', 'Male', 'USA', 'Los Angeles', '2023-05-12 16:00:00', '2024-01-17 20:10:00', '{"interests": ["gaming", "technology"], "newsletter": false}'),
('emily_davis', 'emily.davis@email.com', 'Emily', 'Davis', '1991-07-09', 'Female', 'Germany', 'Berlin', '2023-06-18 08:30:00', '2024-01-22 11:20:00', '{"interests": ["art", "culture"], "newsletter": true}'),
('alex_garcia', 'alex.garcia@email.com', 'Alex', 'Garcia', '1987-09-14', 'Male', 'Spain', 'Madrid', '2023-07-25 13:45:00', '2024-01-16 15:30:00', '{"interests": ["sports", "travel"], "newsletter": false}'),
('lisa_martinez', 'lisa.martinez@email.com', 'Lisa', 'Martinez', '1993-02-26', 'Female', 'Mexico', 'Mexico City', '2023-08-30 10:15:00', '2024-01-19 18:45:00', '{"interests": ["food", "photography"], "newsletter": true}'),
('chris_lee', 'chris.lee@email.com', 'Chris', 'Lee', '1989-06-11', 'Male', 'South Korea', 'Seoul', '2023-09-15 12:00:00', '2024-01-20 22:15:00', '{"interests": ["technology", "gaming"], "newsletter": true}'),
('anna_white', 'anna.white@email.com', 'Anna', 'White', '1994-10-03', 'Female', 'France', 'Paris', '2023-10-20 15:30:00', '2024-01-18 13:40:00', '{"interests": ["fashion", "art"], "newsletter": false}');

-- Products
INSERT INTO products (name, description, category_id, price, cost, stock_quantity, specifications) VALUES
('iPhone 15 Pro', 'Latest Apple smartphone with advanced features', 6, 999.00, 650.00, 50, '{"storage": "128GB", "color": "Natural Titanium", "screen": "6.1 inch"}'),
('Samsung Galaxy S24', 'High-end Android smartphone', 6, 899.00, 580.00, 75, '{"storage": "256GB", "color": "Phantom Black", "screen": "6.2 inch"}'),
('MacBook Pro M3', 'Professional laptop with M3 chip', 7, 1999.00, 1200.00, 25, '{"processor": "M3", "memory": "16GB", "storage": "512GB"}'),
('Dell XPS 13', 'Ultrabook laptop for professionals', 7, 1299.00, 800.00, 40, '{"processor": "Intel i7", "memory": "16GB", "storage": "512GB"}'),
('The Great Gatsby', 'Classic American novel', 8, 12.99, 6.50, 100, '{"author": "F. Scott Fitzgerald", "pages": 180, "format": "paperback"}'),
('Sapiens', 'A brief history of humankind', 9, 16.99, 8.50, 80, '{"author": "Yuval Noah Harari", "pages": 464, "format": "hardcover"}'),
('Nike Air Max', 'Popular running shoes', 10, 129.99, 65.00, 120, '{"size_range": "6-13", "color": "White/Black", "type": "running"}'),
('Adidas Ultraboost', 'High-performance running shoes', 10, 149.99, 75.00, 95, '{"size_range": "5-14", "color": "Core Black", "type": "running"}'),
('Summer Dress', 'Casual summer dress for women', 11, 49.99, 20.00, 60, '{"sizes": ["S", "M", "L", "XL"], "material": "Cotton", "color": "Blue"}'),
('Men''s Polo Shirt', 'Classic polo shirt for men', 10, 39.99, 15.00, 85, '{"sizes": ["S", "M", "L", "XL", "XXL"], "material": "Cotton", "color": "Navy"}');

-- Orders
INSERT INTO orders (user_id, order_date, status, total_amount, shipping_address, payment_method, shipped_date, delivered_date) VALUES
(1, '2024-01-10 14:30:00', 'delivered', 999.00, '123 Main St, New York, NY', 'credit_card', '2024-01-11 10:00:00', '2024-01-13 16:30:00'),
(2, '2024-01-12 09:15:00', 'delivered', 1315.98, '456 Oak Ave, Toronto, ON', 'paypal', '2024-01-13 11:30:00', '2024-01-15 14:20:00'),
(3, '2024-01-14 16:45:00', 'shipped', 179.98, '789 Pine Rd, London, UK', 'credit_card', '2024-01-15 09:00:00', NULL),
(4, '2024-01-15 11:20:00', 'processing', 49.99, '321 Elm St, Sydney, AU', 'debit_card', NULL, NULL),
(5, '2024-01-16 13:45:00', 'delivered', 1999.00, '654 Maple Dr, Los Angeles, CA', 'credit_card', '2024-01-17 08:30:00', '2024-01-19 17:15:00'),
(1, '2024-01-18 10:30:00', 'cancelled', 129.99, '123 Main St, New York, NY', 'credit_card', NULL, NULL),
(6, '2024-01-19 15:00:00', 'pending', 89.98, '987 Cedar Ln, Berlin, DE', 'bank_transfer', NULL, NULL),
(7, '2024-01-20 12:15:00', 'shipped', 149.99, '147 Birch Ave, Madrid, ES', 'credit_card', '2024-01-21 10:45:00', NULL);

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_amount) VALUES
(1, 1, 1, 999.00, 0.00),
(2, 4, 1, 1299.00, 0.00),
(2, 5, 1, 12.99, 0.00),
(2, 6, 1, 16.99, 13.00),
(3, 7, 1, 129.99, 0.00),
(3, 9, 1, 49.99, 0.00),
(4, 9, 1, 49.99, 0.00),
(5, 3, 1, 1999.00, 0.00),
(6, 7, 1, 129.99, 0.00),
(7, 10, 2, 39.99, 0.00),
(7, 5, 1, 12.99, 3.00),
(8, 8, 1, 149.99, 0.00);

-- Posts
INSERT INTO posts (user_id, title, content, post_type, view_count, like_count, tags) VALUES
(1, 'My Experience with the iPhone 15 Pro', 'Just got the new iPhone and here are my thoughts...', 'review', 156, 23, '["technology", "review", "iphone"]'),
(2, 'Best Books to Read in 2024', 'Here''s my curated list of must-read books this year', 'list', 89, 45, '["books", "reading", "recommendations"]'),
(3, 'Movie Review: Latest Blockbuster', 'Watched the new action movie last night...', 'review', 234, 67, '["movies", "review", "entertainment"]'),
(4, 'Healthy Recipes for Busy People', 'Quick and nutritious meals you can make in 30 minutes', 'guide', 312, 89, '["health", "cooking", "recipes"]'),
(5, 'Gaming Setup 2024', 'My complete gaming rig and peripherals', 'showcase', 178, 34, '["gaming", "technology", "setup"]'),
(6, 'Art Gallery Visit in Berlin', 'Explored some amazing contemporary art today', 'travel', 67, 12, '["art", "travel", "berlin"]'),
(1, 'Tech Trends to Watch', 'Emerging technologies that will shape the future', 'analysis', 445, 78, '["technology", "trends", "future"]'),
(7, 'Marathon Training Tips', 'How I prepared for my first marathon', 'guide', 123, 56, '["sports", "running", "fitness"]');

-- Comments
INSERT INTO comments (post_id, user_id, content, like_count) VALUES
(1, 2, 'Great review! I''m thinking of upgrading too.', 5),
(1, 3, 'How''s the battery life compared to the 14 Pro?', 2),
(1, 4, 'The camera improvements are really noticeable.', 8),
(2, 1, 'Added these to my reading list, thanks!', 3),
(2, 5, 'Have you read Sapiens? It''s amazing.', 7),
(3, 4, 'I disagree with your rating, but good analysis.', 1),
(4, 6, 'These recipes look delicious and easy to make!', 12),
(4, 7, 'Do you have any vegetarian alternatives?', 4),
(5, 3, 'Nice setup! What monitor are you using?', 6),
(6, 2, 'Berlin has such a vibrant art scene!', 3),
(7, 8, 'Very insightful predictions about AI.', 9),
(8, 4, 'This motivated me to start running again!', 15);

-- Movies
INSERT INTO movies (title, director, release_year, genre, duration_minutes, budget, box_office, imdb_rating, description) VALUES
('The Matrix', 'The Wachowskis', 1999, 'Sci-Fi', 136, 63000000, 467200000, 8.7, 'A computer hacker learns about the true nature of reality'),
('Inception', 'Christopher Nolan', 2010, 'Sci-Fi', 148, 160000000, 836800000, 8.8, 'A thief enters people''s dreams to steal secrets'),
('Pulp Fiction', 'Quentin Tarantino', 1994, 'Crime', 154, 8000000, 214100000, 8.9, 'Interconnected stories of crime in Los Angeles'),
('The Godfather', 'Francis Ford Coppola', 1972, 'Crime', 175, 6000000, 246120000, 9.2, 'The patriarch of a crime family transfers control to his son'),
('Forrest Gump', 'Robert Zemeckis', 1994, 'Drama', 142, 55000000, 678200000, 8.8, 'The story of a man with low IQ who achieves great things'),
('The Dark Knight', 'Christopher Nolan', 2008, 'Action', 152, 185000000, 1004900000, 9.0, 'Batman faces the Joker in Gotham City'),
('Schindler''s List', 'Steven Spielberg', 1993, 'Drama', 195, 22000000, 322200000, 9.0, 'A businessman saves Jews during the Holocaust'),
('Avatar', 'James Cameron', 2009, 'Sci-Fi', 162, 237000000, 2923700000, 7.9, 'A paraplegic marine joins a mission on Pandora'),
('Titanic', 'James Cameron', 1997, 'Romance', 194, 200000000, 2257000000, 7.9, 'A love story aboard the doomed ship'),
('The Shawshank Redemption', 'Frank Darabont', 1994, 'Drama', 142, 25000000, 16000000, 9.3, 'A banker wrongly imprisoned forms a friendship');

-- Ratings
INSERT INTO ratings (user_id, movie_id, rating, review, created_at) VALUES
(1, 1, 9, 'Mind-blowing movie that changed cinema forever', '2024-01-15 14:30:00'),
(1, 2, 8, 'Complex but rewarding, Nolan at his best', '2024-01-16 16:45:00'),
(2, 1, 8, 'Great action and philosophical themes', '2024-01-17 10:20:00'),
(2, 3, 9, 'Tarantino''s masterpiece with incredible dialogue', '2024-01-18 12:15:00'),
(3, 4, 10, 'Perfect in every aspect, true cinema', '2024-01-19 18:30:00'),
(3, 5, 7, 'Heartwarming story, great performance by Hanks', '2024-01-20 14:45:00'),
(4, 6, 9, 'Dark, intense, and brilliantly acted', '2024-01-21 11:00:00'),
(4, 7, 9, 'Emotionally powerful and historically important', '2024-01-22 09:30:00'),
(5, 8, 6, 'Visually stunning but story lacks depth', '2024-01-10 20:15:00'),
(5, 9, 7, 'Epic romance with tragic ending', '2024-01-11 22:30:00'),
(6, 10, 10, 'The greatest film ever made, flawless', '2024-01-12 15:45:00'),
(7, 1, 8, 'Revolutionary effects and story', '2024-01-13 17:20:00'),
(8, 2, 9, 'Incredibly clever and well-crafted', '2024-01-14 19:10:00'),
(9, 3, 8, 'Cool characters and memorable scenes', '2024-01-15 21:00:00'),
(10, 4, 9, 'Masterful storytelling and performances', '2024-01-16 13:25:00');

-- Activity
INSERT INTO activity (user_id, activity_type, entity_type, entity_id, activity_data) VALUES
(1, 'login', NULL, NULL, '{"ip_address": "192.168.1.100", "device": "iPhone"}'),
(1, 'purchase', 'order', 1, '{"amount": 999.00, "payment_method": "credit_card"}'),
(2, 'login', NULL, NULL, '{"ip_address": "10.0.0.50", "device": "Chrome"}'),
(2, 'view_product', 'product', 4, '{"duration_seconds": 120}'),
(3, 'create_post', 'post', 3, '{"title": "Movie Review: Latest Blockbuster"}'),
(4, 'comment', 'post', 1, '{"comment_id": 3}'),
(5, 'purchase', 'order', 5, '{"amount": 1999.00, "payment_method": "credit_card"}'),
(1, 'rate_movie', 'movie', 1, '{"rating": 9}'),
(2, 'follow_user', 'user', 1, '{"action": "follow"}'),
(3, 'like_post', 'post', 2, '{"action": "like"}');

-- Employees
INSERT INTO employees (first_name, last_name, email, department, position, manager_id, salary, hire_date) VALUES
('Robert', 'Johnson', 'robert.johnson@company.com', 'Engineering', 'VP Engineering', NULL, 180000, '2020-01-15'),
('Michelle', 'Anderson', 'michelle.anderson@company.com', 'Sales', 'Sales Director', NULL, 150000, '2020-03-20'),
('James', 'Wilson', 'james.wilson@company.com', 'Engineering', 'Senior Software Engineer', 1, 120000, '2021-06-10'),
('Jennifer', 'Taylor', 'jennifer.taylor@company.com', 'Sales', 'Senior Sales Rep', 2, 95000, '2021-08-15'),
('Daniel', 'Moore', 'daniel.moore@company.com', 'Engineering', 'Software Engineer', 1, 95000, '2022-02-01'),
('Laura', 'Jackson', 'laura.jackson@company.com', 'Marketing', 'Marketing Manager', NULL, 85000, '2022-04-12'),
('Kevin', 'White', 'kevin.white@company.com', 'Sales', 'Sales Rep', 2, 75000, '2022-09-05'),
('Amanda', 'Harris', 'amanda.harris@company.com', 'Engineering', 'Junior Developer', 3, 70000, '2023-01-20'),
('Mark', 'Clark', 'mark.clark@company.com', 'Marketing', 'Content Specialist', 6, 60000, '2023-05-10'),
('Sarah', 'Lewis', 'sarah.lewis@company.com', 'Sales', 'Sales Rep', 2, 72000, '2023-07-18');

-- Sales
INSERT INTO sales (employee_id, customer_id, product_id, sale_date, quantity, unit_price, total_amount) VALUES
(4, 1, 1, '2024-01-10', 1, 999.00, 999.00),
(7, 2, 4, '2024-01-12', 1, 1299.00, 1299.00),
(4, 3, 7, '2024-01-14', 1, 129.99, 129.99),
(10, 4, 9, '2024-01-15', 1, 49.99, 49.99),
(7, 5, 3, '2024-01-16', 1, 1999.00, 1999.00),
(4, 6, 10, '2024-01-19', 2, 39.99, 79.98),
(10, 7, 8, '2024-01-20', 1, 149.99, 149.99),
(7, 1, 2, '2024-01-21', 1, 899.00, 899.00),
(4, 2, 5, '2024-01-22', 3, 12.99, 38.97),
(10, 3, 6, '2024-01-23', 2, 16.99, 33.98);

ANALYZE;