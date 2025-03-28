-- Connect to the default database before running this
-- DROP DATABASE must be run outside of a transaction block

-- Drop and recreate the database
DROP DATABASE IF EXISTS "DataWarehouseAnalytics";
CREATE DATABASE "DataWarehouseAnalytics";

-- Now manually connect to the new database before running the next part of the script

-- Create Schema
CREATE SCHEMA gold;

-- Create tables
CREATE TABLE gold.dim_customers (
    customer_key SERIAL PRIMARY KEY,
    customer_id INT,
    customer_number VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50),
    marital_status VARCHAR(50),
    gender VARCHAR(50),
    birthdate DATE,
    create_date DATE
);

CREATE TABLE gold.dim_products (
    product_key SERIAL PRIMARY KEY,
    product_id INT,
    product_number VARCHAR(50),
    product_name VARCHAR(50),
    category_id VARCHAR(50),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    maintenance VARCHAR(50),
    cost INT,
    product_line VARCHAR(50),
    start_date DATE
);

CREATE TABLE gold.fact_sales (
    order_number VARCHAR(50),
    product_key INT REFERENCES gold.dim_products(product_key),
    customer_key INT REFERENCES gold.dim_customers(customer_key),
    order_date DATE,
    shipping_date DATE,
    due_date DATE,
    sales_amount INT,
    quantity SMALLINT,
    price INT
);

-- Truncate tables before inserting data
TRUNCATE TABLE gold.dim_customers RESTART IDENTITY CASCADE;
TRUNCATE TABLE gold.dim_products RESTART IDENTITY CASCADE;
TRUNCATE TABLE gold.fact_sales RESTART IDENTITY CASCADE;

-- Bulk insert data using COPY command (Update file paths as needed)
COPY gold.dim_customers FROM '/path/to/gold.dim_customers.csv' DELIMITER ',' CSV HEADER;
COPY gold.dim_products FROM '/path/to/gold.dim_products.csv' DELIMITER ',' CSV HEADER;
COPY gold.fact_sales FROM '/path/to/gold.fact_sales.csv' DELIMITER ',' CSV HEADER;