USE blinkit_db;

-- 1. Customers
INSERT INTO customer (full_name, email, phone_no, status) VALUES
('Rohit Sharma', 'rohit@gmail.com', '9876543210', 'ACTIVE'),
('Priya Verma', 'priya@yahoo.com', '8765432109', 'ACTIVE'),
('Arjun Mehta', 'arjun@outlook.com', '7654321098', 'BLOCKED');

-- 2. Customer Addresses
INSERT INTO customer_address (customer_id, label, address_line1, address_line2, landmark, city, state, pincode, is_default) VALUES
(1, 'HOME', 'Flat 201, Sunrise Apartments', 'Near Park', 'Central Garden', 'Delhi', 'Delhi', '110085', 1),
(1, 'WORK', 'Office 15, Cyber Hub', 'DLF Phase 2', 'Near Metro', 'Gurgaon', 'Haryana', '122002', 0),
(2, 'HOME', 'B-12, Orchid Society', NULL, 'Opposite Mall', 'Mumbai', 'Maharashtra', '400078', 1),
(3, 'OTHER', 'Village Road, Sector 3', 'Near School', NULL, 'Chandigarh', 'Punjab', '140603', 1);

-- 3. City Zones
INSERT INTO city_zone (city, zone_name) VALUES
('Delhi', 'North Delhi'),
('Mumbai', 'Andheri East');

-- 4. Stores
INSERT INTO store (store_name, zone_id, address_line1, address_line2, pincode, opening_time, closing_time, is_active) VALUES
('Blinkit - Rohini Store', 1, 'Sector 8, Rohini', 'Opp Metro Pillar 373', '110085', '07:00:00', '23:00:00', 1),
('Blinkit - Andheri Store', 2, 'Mahakali Road, Andheri', NULL, '400093', '06:00:00', '22:00:00', 1);

-- 5. Product Categories
INSERT INTO product_category (parent_category_id, category_name) VALUES
(NULL, 'Groceries'),
(1, 'Fruits & Vegetables'),
(1, 'Dairy'),
(NULL, 'Snacks'),
(NULL, 'Beverages');

-- 6. Products (FIXED: Red Bull -> category_id = 5, not 6)
INSERT INTO product (category_id, product_name, brand_name, description, unit_size, mrp, is_active) VALUES
(2, 'Fresh Tomato', NULL, 'Farm fresh tomatoes', '1 kg', 45.00, 1),
(2, 'Potato', NULL, 'Organic potatoes', '1 kg', 40.00, 1),
(3, 'Amul Milk', 'Amul', 'Toned milk', '500 ml', 28.00, 1),
(3, 'Mother Dairy Paneer', 'Mother Dairy', 'Fresh paneer', '200 g', 95.00, 1),
(4, 'Lays Chips', 'PepsiCo', 'Salted chips', '52 g', 20.00, 1),
(4, 'Haldiram Bhujia', 'Haldiram', 'Spicy namkeen', '150 g', 55.00, 1),
(5, 'Coca Cola', 'Coca-Cola', 'Cold drink', '1 L', 65.00, 1),
(5, 'Red Bull', 'Red Bull', 'Energy drink', '250 ml', 125.00, 1);

-- 7. Store Inventory
INSERT INTO store_inventory (store_id, product_id, available_qty, reorder_level, selling_price) VALUES
(1, 1, 120, 20, 40.00),
(1, 2, 80, 15, 35.00),
(1, 3, 200, 50, 27.00),
(1, 5, 150, 30, 18.00),
(2, 4, 70, 10, 90.00),
(2, 6, 95, 20, 52.00),
(2, 7, 60, 10, 60.00),
(2, 8, 40, 5, 120.00);

-- 8. Coupons
INSERT INTO coupon (coupon_code, description, discount_type, discount_value, min_order_amount, start_date, end_date, usage_limit, is_active) VALUES
('NEW50', 'Flat 50 off for new users', 'FLAT', 50.00, 199.00, '2025-01-01', '2025-12-31', 1000, 1),
('SAVE10', '10% off on orders above 149', 'PERCENT', 10.00, 149.00, '2025-02-01', '2025-11-30', 5000, 1);

-- 9. Coupon Usage
INSERT INTO customer_coupon_usage (customer_id, coupon_id, usage_count) VALUES
(1, 1, 2),
(2, 2, 1);

-- 10. Orders
INSERT INTO `order` (customer_id, address_id, store_id, coupon_id, order_status, scheduled_delivery_time, subtotal_amount, delivery_fee, discount_amount, total_payable) VALUES
(1, 1, 1, 1, 'DELIVERED', '2025-11-28 20:15:00', 350.00, 20.00, 50.00, 320.00),
(2, 3, 2, 2, 'OUT_FOR_DELIVERY', '2025-11-28 18:30:00', 250.00, 15.00, 25.00, 240.00),
(1, 2, 2, NULL, 'PLACED', NULL, 180.00, 10.00, 0.00, 190.00);

-- 11. Order Items
INSERT INTO order_item (order_id, product_id, quantity, unit_price, line_total) VALUES
(1, 1, 2, 40.00, 80.00),
(1, 3, 5, 27.00, 135.00),
(1, 5, 3, 18.00, 54.00),
(2, 4, 1, 90.00, 90.00),
(2, 7, 1, 60.00, 60.00),
(3, 2, 2, 35.00, 70.00);

-- 12. Payments
INSERT INTO payment (order_id, payment_method, payment_status, transaction_ref, paid_amount) VALUES
(1, 'UPI', 'SUCCESS', 'TXN_UPI_001', 320.00),
(2, 'CARD', 'PENDING', 'TXN_CARD_002', 240.00),
(3, 'COD', 'PENDING', NULL, 190.00);

-- 13. Delivery Partners
INSERT INTO delivery_partner (full_name, phone_no, vehicle_type, current_zone_id, is_active) VALUES
('Manish Rider', '9991112223', 'BIKE', 1, 1),
('Sara Rider', '8882223334', 'SCOOTER', 2, 1);

-- 14. Delivery Assignments
INSERT INTO delivery_assignment (order_id, partner_id, picked_at, delivered_at, status) VALUES
(1, 1, '2025-11-28 19:50:00', '2025-11-28 20:05:00', 'DELIVERED'),
(2, 2, '2025-11-28 18:15:00', NULL, 'PICKED');

-- 15. Order Ratings
INSERT INTO order_rating (order_id, customer_id, store_rating, delivery_rating, comments) VALUES
(1, 1, 5, 4, 'Fast delivery and fresh products'),
(2, 2, 4, 5, 'Delivery partner was very polite');
