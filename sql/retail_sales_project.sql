--   PROJECT: Retail Sales Analytics System
-- DESCRIPTION: Database design, sample data, analytics, stored procedure, and optimization.

CREATE DATABASE IF NOT EXISTS RetailSalesDB;
USE RetailSalesDB;

-- Step 1: Create Tables

# Customer Table
CREATE TABLE Customers (
	customer_id int primary key,
    name varchar(100),
    city varchar(50),
    join_date date
);

# Product Table
create table Products (
	product_id int primary key,
    name varchar(100),
    category varchar(50),
    price decimal(10, 2)
);

# Order Table
create table Orders (
	order_id int primary key,
    customer_id int,
    order_date date,
    foreign key (customer_id) references Customers(customer_id)
);

# OrderItems Table
create table OrderItems (
	item_id int primary key,
    order_id int,
    product_id int,
    quantity int,
    foreign key (order_id) references Orders(order_id),
    foreign key (product_id) references Products(product_id)
);


-- Step 2: Insert Sample Data
insert into Customers values
(1, 'Aarav', 'Kathmandu', '2024-01-10'),
(2, 'Sita', 'Pokhara', '2024-02-05'),
(3, 'Milan', 'Lalitpur', '2024-03-15');

insert into Products values
(1, 'Laptop', 'Electronics', 90000),
(2, 'Headphones', 'Electronics', 3000),
(3, 'Shoes', 'Fashion', 4000),
(4, 'Watch', 'Fashion', 6000);

insert into Orders values
(1, 1, '2024-05-01'),
(2, 2, '2024-05-02'),
(3, 1, '2024-05-05');

insert into OrderItems values
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 3, 1, 1),
(5, 3, 4, 1);


-- STEP 3: Analytics Queries

# Top 5 highest selling products
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 5;

-- Total revenue per customer
SELECT c.name, SUM(oi.quantity * p.price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Monthly revenue trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(oi.quantity * p.price) AS revenue
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- Best customers by total orders
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_orders DESC;


-- STEP 4: Stored Procedure for Monthly Sales
DELIMITER //

CREATE PROCEDURE GetMonthlySales(IN month_param INT, IN year_param INT)
BEGIN
    SELECT 
        SUM(oi.quantity * p.price) AS monthly_sales
    FROM Orders o
    JOIN OrderItems oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    WHERE MONTH(o.order_date) = month_param
      AND YEAR(o.order_date) = year_param;
END //

DELIMITER ;
-- CALL GetMonthlySales(5, 2024);


-- -------------------------------------------------------------------
-- STEP 5: Performance Optimization (Indexes)

CREATE INDEX idx_order_date ON Orders(order_date);
CREATE INDEX idx_customer_city ON Customers(city);
CREATE INDEX idx_product_category ON Products(category);


