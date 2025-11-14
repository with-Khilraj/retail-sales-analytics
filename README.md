# Retail Sales Analytics System

## Overview
The **Retail Sales Analytics System** is a SQL-based project designed to simulate a real-world retail environment. It demonstrates **database design, SQL querying, data analytics, and optimization** skills. This project is perfect for showcasing your ability to handle **relational databases, query optimization, and stored procedures**, making it highly relevant for SQL Developer or Data Engineer roles.

---

## Features

- Relational database design following normalization principles
- SQL queries for key business insights:
  - Top-selling products
  - Total revenue per customer
  - Monthly revenue trends
  - Best customers by number of orders
- Stored procedure for automated monthly sales reporting
- Indexing and query optimization to improve performance
- ER diagram illustrating database relationships

---

## Database Schema

**Tables:**

1. **Customers**
   - `customer_id` (PK)
   - `name`
   - `city`
   - `join_date`

2. **Products**
   - `product_id` (PK)
   - `name`
   - `category`
   - `price`

3. **Orders**
   - `order_id` (PK)
   - `customer_id` (FK → Customers.customer_id)
   - `order_date`

4. **OrderItems**
   - `item_id` (PK)
   - `order_id` (FK → Orders.order_id)
   - `product_id` (FK → Products.product_id)
   - `quantity`

**Relationships:**
- One customer can have multiple orders (1:M)
- One order can have multiple order items (1:M)
- One product can appear in multiple order items (1:M)

---

## Setup Instructions

### Clone the repository:**
git clone https://github.com/<your-username>/retail-sales-analytics.git
cd retail-sales-analytics

### Open SQL client (MySQL Workbench, pgAdmin, etc.)

### Run the SQL script:
source sql/retail_sales_project.sql;

### Verify Tables:
SHOW TABLES;
SELECT * FROM Customers;

### Run analytics queries and test the stored procedure:
CALL GetMonthlySales(5, 2024);
