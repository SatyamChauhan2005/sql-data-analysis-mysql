-- ============================================================
--  RETAIL SALES ANALYSIS — DATABASE SETUP
--  Author  : Satyam Chauhan
--  GitHub  : https://github.com/SatyamChauhan2005
--  Version : 1.0
-- ============================================================

-- Create and use database
CREATE DATABASE IF NOT EXISTS retail_sales_db;
USE retail_sales_db;

-- ============================================================
-- TABLE 1: regions
-- ============================================================
CREATE TABLE IF NOT EXISTS regions (
    region_id   INT PRIMARY KEY AUTO_INCREMENT,
    region_name VARCHAR(50) NOT NULL,
    zone        VARCHAR(20) NOT NULL
);

INSERT INTO regions (region_name, zone) VALUES
('North Delhi',   'North'),
('South Delhi',   'South'),
('East Delhi',    'East'),
('West Delhi',    'West'),
('Noida',         'East'),
('Gurgaon',       'South'),
('Mumbai Central','West'),
('Pune',          'West'),
('Bangalore',     'South'),
('Chennai',       'South'),
('Kolkata',       'East'),
('Hyderabad',     'South');

-- ============================================================
-- TABLE 2: customers
-- ============================================================
CREATE TABLE IF NOT EXISTS customers (
    customer_id   INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    segment       ENUM('Retail','Corporate','SMB') NOT NULL,
    region_id     INT NOT NULL,
    email         VARCHAR(100),
    phone         VARCHAR(15),
    joined_date   DATE NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

INSERT INTO customers (customer_name, segment, region_id, email, phone, joined_date) VALUES
('Anil Sharma',      'Corporate', 1,  'anil@corp.com',     '9811001001', '2022-01-15'),
('Priya Verma',      'Retail',    2,  'priya@gmail.com',   '9822002002', '2022-02-20'),
('Rohit Gupta',      'SMB',       3,  'rohit@biz.com',     '9833003003', '2022-03-10'),
('Sunita Patel',     'Corporate', 4,  'sunita@corp.com',   '9844004004', '2022-04-05'),
('Manoj Kumar',      'Retail',    5,  'manoj@gmail.com',   '9855005005', '2022-05-18'),
('Kavita Singh',     'SMB',       6,  'kavita@biz.com',    '9866006006', '2022-06-22'),
('Deepak Yadav',     'Corporate', 7,  'deepak@corp.com',   '9877007007', '2022-07-14'),
('Neha Joshi',       'Retail',    8,  'neha@gmail.com',    '9888008008', '2022-08-30'),
('Vijay Mehta',      'SMB',       9,  'vijay@biz.com',     '9899009009', '2022-09-12'),
('Anita Rao',        'Corporate', 10, 'anita@corp.com',    '9810010010', '2022-10-07'),
('Suresh Nair',      'Retail',    11, 'suresh@gmail.com',  '9821011011', '2022-11-25'),
('Ritu Agarwal',     'SMB',       12, 'ritu@biz.com',      '9832012012', '2022-12-03'),
('Vikram Chauhan',   'Corporate', 1,  'vikram@corp.com',   '9843013013', '2023-01-19'),
('Pooja Mishra',     'Retail',    2,  'pooja@gmail.com',   '9854014014', '2023-02-14'),
('Amit Tripathi',    'SMB',       3,  'amit@biz.com',      '9865015015', '2023-03-28'),
('Sonia Kapoor',     'Corporate', 4,  'sonia@corp.com',    '9876016016', '2023-04-11'),
('Rakesh Pandey',    'Retail',    5,  'rakesh@gmail.com',  '9887017017', '2023-05-06'),
('Meena Tiwari',     'SMB',       6,  'meena@biz.com',     '9898018018', '2023-06-20'),
('Ashok Dubey',      'Corporate', 7,  'ashok@corp.com',    '9809019019', '2023-07-15'),
('Lalita Bose',      'Retail',    8,  'lalita@gmail.com',  '9820020020', '2023-08-09'),
('Nitin Saxena',     'SMB',       9,  'nitin@biz.com',     '9831021021', '2023-09-23'),
('Geeta Pillai',     'Corporate', 10, 'geeta@corp.com',    '9842022022', '2023-10-17'),
('Harish Reddy',     'Retail',    11, 'harish@gmail.com',  '9853023023', '2023-11-02'),
('Sneha Kulkarni',   'SMB',       12, 'sneha@biz.com',     '9864024024', '2023-12-28'),
('Pankaj Srivastava','Corporate', 1,  'pankaj@corp.com',   '9875025025', '2024-01-10'),
('Divya Chatterjee', 'Retail',    2,  'divya@gmail.com',   '9886026026', '2024-02-22'),
('Mohit Bansal',     'SMB',       3,  'mohit@biz.com',     '9897027027', '2024-03-16'),
('Aarti Desai',      'Corporate', 4,  'aarti@corp.com',    '9808028028', '2024-04-04'),
('Sanjay Iyer',      'Retail',    5,  'sanjay@gmail.com',  '9819029029', '2024-05-19'),
('Rekha Menon',      'SMB',       6,  'rekha@biz.com',     '9830030030', '2024-06-07');

-- ============================================================
-- TABLE 3: categories & products
-- ============================================================
CREATE TABLE IF NOT EXISTS categories (
    category_id   INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Furniture'),
('Office Supplies'),
('Clothing'),
('Stationery'),
('Software');

CREATE TABLE IF NOT EXISTS products (
    product_id   INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id  INT NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL,
    cost_price   DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO products (product_name, category_id, unit_price, cost_price) VALUES
('Laptop Pro 15',         1, 75000.00, 52000.00),
('Wireless Mouse',        1,  1200.00,   600.00),
('Mechanical Keyboard',   1,  3500.00,  1800.00),
('27" Monitor',           1, 22000.00, 14000.00),
('USB-C Hub',             1,  2800.00,  1200.00),
('Office Chair Ergo',     2, 18000.00, 10000.00),
('Standing Desk',         2, 32000.00, 20000.00),
('Bookshelf 5-Tier',      2,  6500.00,  3500.00),
('File Cabinet',          2,  9500.00,  5500.00),
('Whiteboard 4x3',        2,  4200.00,  2000.00),
('A4 Paper Ream (500)',   3,   450.00,   200.00),
('Stapler Heavy Duty',    3,   850.00,   380.00),
('Pen Set 10pc',          3,   180.00,    60.00),
('Sticky Notes Pack',     3,   120.00,    45.00),
('Highlighter Set',       3,   220.00,    80.00),
('Formal Shirt',          4,  1800.00,   800.00),
('Trousers Corporate',    4,  2200.00,  1000.00),
('Blazer Premium',        4,  6500.00,  3000.00),
('Notebook A5 100pg',     5,   280.00,   100.00),
('Planner 2024',          5,   550.00,   200.00),
('Sketch Pens 24pc',      5,   350.00,   120.00),
('MS Office License',     6, 12000.00,  8000.00),
('Antivirus 1yr',         6,  1800.00,   900.00),
('Tally Software',        6, 22000.00, 15000.00),
('Adobe Acrobat',         6,  9500.00,  6000.00);

-- ============================================================
-- TABLE 4: orders
-- ============================================================
CREATE TABLE IF NOT EXISTS orders (
    order_id     INT PRIMARY KEY AUTO_INCREMENT,
    customer_id  INT NOT NULL,
    order_date   DATE NOT NULL,
    ship_date    DATE NOT NULL,
    status       ENUM('Delivered','Returned','Pending','Cancelled') NOT NULL DEFAULT 'Delivered',
    payment_mode ENUM('Online','Cash','Credit','UPI') NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (customer_id, order_date, ship_date, status, payment_mode) VALUES
(1,  '2023-01-05', '2023-01-08', 'Delivered',  'Online'),
(2,  '2023-01-12', '2023-01-15', 'Delivered',  'UPI'),
(3,  '2023-01-20', '2023-01-24', 'Returned',   'Online'),
(4,  '2023-02-02', '2023-02-05', 'Delivered',  'Credit'),
(5,  '2023-02-14', '2023-02-18', 'Delivered',  'UPI'),
(6,  '2023-02-25', '2023-03-01', 'Delivered',  'Cash'),
(7,  '2023-03-08', '2023-03-11', 'Delivered',  'Online'),
(8,  '2023-03-17', '2023-03-21', 'Cancelled',  'UPI'),
(9,  '2023-03-28', '2023-04-01', 'Delivered',  'Online'),
(10, '2023-04-05', '2023-04-08', 'Delivered',  'Credit'),
(11, '2023-04-19', '2023-04-22', 'Delivered',  'Cash'),
(12, '2023-04-30', '2023-05-03', 'Returned',   'Online'),
(13, '2023-05-10', '2023-05-13', 'Delivered',  'UPI'),
(14, '2023-05-22', '2023-05-26', 'Delivered',  'Online'),
(15, '2023-06-03', '2023-06-06', 'Delivered',  'Credit'),
(16, '2023-06-15', '2023-06-19', 'Delivered',  'Cash'),
(17, '2023-06-27', '2023-07-01', 'Delivered',  'UPI'),
(18, '2023-07-08', '2023-07-11', 'Cancelled',  'Online'),
(19, '2023-07-19', '2023-07-22', 'Delivered',  'Credit'),
(20, '2023-07-30', '2023-08-03', 'Delivered',  'UPI'),
(21, '2023-08-11', '2023-08-14', 'Delivered',  'Online'),
(22, '2023-08-22', '2023-08-26', 'Returned',   'Cash'),
(23, '2023-09-03', '2023-09-06', 'Delivered',  'UPI'),
(24, '2023-09-14', '2023-09-18', 'Delivered',  'Online'),
(25, '2023-09-25', '2023-09-29', 'Delivered',  'Credit'),
(26, '2023-10-06', '2023-10-09', 'Delivered',  'UPI'),
(27, '2023-10-17', '2023-10-21', 'Delivered',  'Online'),
(28, '2023-10-28', '2023-11-01', 'Cancelled',  'Cash'),
(29, '2023-11-08', '2023-11-11', 'Delivered',  'UPI'),
(30, '2023-11-19', '2023-11-23', 'Delivered',  'Online'),
(1,  '2023-11-30', '2023-12-03', 'Delivered',  'Credit'),
(2,  '2023-12-10', '2023-12-14', 'Delivered',  'UPI'),
(3,  '2023-12-20', '2023-12-24', 'Delivered',  'Online'),
(4,  '2024-01-08', '2024-01-11', 'Delivered',  'Cash'),
(5,  '2024-01-19', '2024-01-22', 'Returned',   'UPI'),
(6,  '2024-02-01', '2024-02-04', 'Delivered',  'Online'),
(7,  '2024-02-12', '2024-02-16', 'Delivered',  'Credit'),
(8,  '2024-02-23', '2024-02-27', 'Delivered',  'UPI'),
(9,  '2024-03-05', '2024-03-08', 'Delivered',  'Online'),
(10, '2024-03-16', '2024-03-20', 'Cancelled',  'Cash'),
(11, '2024-03-27', '2024-03-31', 'Delivered',  'UPI'),
(12, '2024-04-07', '2024-04-10', 'Delivered',  'Online'),
(13, '2024-04-18', '2024-04-22', 'Delivered',  'Credit'),
(14, '2024-04-29', '2024-05-03', 'Returned',   'UPI'),
(15, '2024-05-10', '2024-05-13', 'Delivered',  'Online'),
(16, '2024-05-21', '2024-05-25', 'Delivered',  'Cash'),
(17, '2024-06-01', '2024-06-04', 'Delivered',  'UPI'),
(18, '2024-06-12', '2024-06-16', 'Delivered',  'Online'),
(19, '2024-06-23', '2024-06-27', 'Delivered',  'Credit'),
(20, '2024-07-04', '2024-07-07', 'Delivered',  'UPI');

-- ============================================================
-- TABLE 5: order_items
-- ============================================================
CREATE TABLE IF NOT EXISTS order_items (
    item_id     INT PRIMARY KEY AUTO_INCREMENT,
    order_id    INT NOT NULL,
    product_id  INT NOT NULL,
    quantity    INT NOT NULL,
    discount    DECIMAL(4,2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_id, product_id, quantity, discount) VALUES
(1, 1, 2, 0.05), (1, 3, 1, 0.00), (1, 11, 5, 0.00),
(2, 13, 3, 0.00), (2, 14, 2, 0.00),
(3, 6, 1, 0.10), (3, 19, 4, 0.00),
(4, 1, 1, 0.05), (4, 22, 1, 0.00), (4, 4, 1, 0.08),
(5, 16, 3, 0.00), (5, 17, 2, 0.00),
(6, 11, 10, 0.05), (6, 12, 2, 0.00),
(7, 7, 1, 0.10), (7, 9, 1, 0.00), (7, 23, 1, 0.00),
(8, 18, 2, 0.00),
(9, 2, 5, 0.00), (9, 5, 2, 0.00),
(10, 24, 1, 0.05), (10, 22, 2, 0.00),
(11, 11, 20, 0.10), (11, 13, 6, 0.00),
(12, 8, 1, 0.00), (12, 20, 2, 0.00),
(13, 1, 3, 0.05), (13, 4, 2, 0.05),
(14, 15, 5, 0.00), (14, 19, 3, 0.00),
(15, 6, 2, 0.08), (15, 10, 1, 0.00),
(16, 17, 4, 0.00), (16, 16, 4, 0.00),
(17, 11, 15, 0.10), (17, 14, 8, 0.00),
(18, 1, 1, 0.00),
(19, 25, 1, 0.05), (19, 23, 2, 0.00),
(20, 21, 3, 0.00), (20, 20, 1, 0.00),
(21, 2, 8, 0.00), (21, 3, 3, 0.05),
(22, 18, 1, 0.00),
(23, 1, 1, 0.05), (23, 5, 3, 0.00),
(24, 22, 3, 0.08), (24, 24, 1, 0.05),
(25, 7, 2, 0.10), (25, 9, 1, 0.00),
(26, 11, 25, 0.10), (26, 13, 10, 0.00),
(27, 4, 3, 0.05), (27, 2, 6, 0.00),
(28, 6, 1, 0.00),
(29, 16, 5, 0.00), (29, 17, 3, 0.00),
(30, 19, 6, 0.00), (30, 20, 3, 0.00),
(31, 1, 4, 0.05), (31, 22, 2, 0.05),
(32, 13, 8, 0.00), (32, 15, 5, 0.00),
(33, 6, 3, 0.08), (33, 10, 2, 0.00),
(34, 24, 2, 0.05), (34, 25, 1, 0.05),
(35, 2, 4, 0.00), (35, 3, 2, 0.00),
(36, 11, 30, 0.10), (36, 14, 10, 0.00),
(37, 7, 1, 0.10), (37, 8, 2, 0.00),
(38, 16, 6, 0.00), (38, 17, 5, 0.00),
(39, 1, 2, 0.05), (39, 4, 1, 0.05),
(40, 23, 3, 0.00),
(41, 11, 12, 0.10), (41, 13, 5, 0.00),
(42, 22, 1, 0.05), (42, 24, 1, 0.05),
(43, 1, 5, 0.05), (43, 2, 10, 0.00),
(44, 18, 3, 0.00), (44, 20, 2, 0.00),
(45, 6, 2, 0.08), (45, 9, 1, 0.00),
(46, 16, 4, 0.00), (46, 17, 4, 0.00),
(47, 11, 20, 0.10), (47, 15, 8, 0.00),
(48, 7, 2, 0.10), (48, 10, 1, 0.00),
(49, 25, 2, 0.05), (49, 22, 3, 0.05),
(50, 2, 12, 0.00), (50, 5, 5, 0.00);
