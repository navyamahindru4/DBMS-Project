-- OBJECTIVE: Business Analytics & Decision Support Queries for Blinkit
-- ===================================================================

USE blinkit_db;

-- ---------------------------------------------------------
-- BUSINESS QUERY 1: "Store Performance Summary"
-- Logic: Shows orders, revenue, and average order value per store.
-- Why? Helps Blinkit see which dark store is performing better.
-- ---------------------------------------------------------
SELECT 
    s.store_id,
    s.store_name,
    cz.city,
    cz.zone_name,
    COUNT(o.order_id) AS Total_Orders,
    SUM(o.total_payable) AS Total_Revenue,
    ROUND(AVG(o.total_payable), 2) AS Avg_Order_Value
FROM store s
JOIN city_zone cz 
    ON s.zone_id = cz.zone_id
JOIN `order` o 
    ON o.store_id = s.store_id
WHERE o.order_status IN ('PLACED', 'CONFIRMED', 'PICKED', 'OUT_FOR_DELIVERY', 'DELIVERED')
GROUP BY s.store_id, s.store_name, cz.city, cz.zone_name
ORDER BY Total_Revenue DESC;


-- ---------------------------------------------------------
-- BUSINESS QUERY 2: "Top-Selling Products Report"
-- Logic: Calculates quantity sold and revenue per product.
-- Why? Helps decide which items to stock more / promote.
-- ---------------------------------------------------------
SELECT 
    p.product_id,
    p.product_name,
    p.brand_name,
    pc.category_name,
    SUM(oi.quantity) AS Total_Quantity_Sold,
    SUM(oi.line_total) AS Total_Sales_Value
FROM product p
JOIN product_category pc 
    ON p.category_id = pc.category_id
JOIN order_item oi 
    ON p.product_id = oi.product_id
JOIN `order` o 
    ON oi.order_id = o.order_id
WHERE o.order_status IN ('CONFIRMED', 'PICKED', 'OUT_FOR_DELIVERY', 'DELIVERED')
GROUP BY p.product_id, p.product_name, p.brand_name, pc.category_name
ORDER BY Total_Quantity_Sold DESC, Total_Sales_Value DESC;


-- ---------------------------------------------------------
-- BUSINESS QUERY 3: "Coupon Effectiveness Analysis"
-- Logic: Compares orders with coupons vs without, and impact on revenue.
-- Why? Helps Blinkit decide whether coupons are profitable.
-- ---------------------------------------------------------
SELECT
    CASE 
        WHEN o.coupon_id IS NULL THEN 'NO_COUPON_USED'
        ELSE c.coupon_code
    END AS Coupon_Code_Or_None,
    COUNT(o.order_id) AS Total_Orders,
    SUM(o.subtotal_amount) AS Gross_Order_Value,
    SUM(o.discount_amount) AS Total_Discount_Given,
    SUM(o.total_payable) AS Net_Revenue_Collected,
    ROUND(AVG(o.discount_amount), 2) AS Avg_Discount_Per_Order
FROM `order` o
LEFT JOIN coupon c 
    ON o.coupon_id = c.coupon_id
WHERE o.order_status IN ('PLACED', 'CONFIRMED', 'PICKED', 'OUT_FOR_DELIVERY', 'DELIVERED')
GROUP BY Coupon_Code_Or_None
ORDER BY Net_Revenue_Collected DESC;


-- ---------------------------------------------------------
-- BUSINESS QUERY 4: "Delivery Partner Performance"
-- Logic: Calculates average delivery time per partner (in minutes).
-- Why? Helps evaluate riders and optimize logistics.
-- ---------------------------------------------------------
SELECT
    dp.partner_id,
    dp.full_name AS Delivery_Partner_Name,
    cz.city,
    cz.zone_name,
    COUNT(da.assignment_id) AS Total_Assignments,
    AVG(
        CASE 
            WHEN da.delivered_at IS NOT NULL AND da.picked_at IS NOT NULL 
            THEN TIMESTAMPDIFF(MINUTE, da.picked_at, da.delivered_at)
            ELSE NULL
        END
    ) AS Avg_Delivery_Time_Minutes
FROM delivery_partner dp
LEFT JOIN city_zone cz 
    ON dp.current_zone_id = cz.zone_id
JOIN delivery_assignment da 
    ON dp.partner_id = da.partner_id
JOIN `order` o 
    ON da.order_id = o.order_id
WHERE da.status = 'DELIVERED'
GROUP BY dp.partner_id, dp.full_name, cz.city, cz.zone_name
ORDER BY Avg_Delivery_Time_Minutes;


-- ---------------------------------------------------------
-- BUSINESS QUERY 5: "Customer Value & Engagement"
-- Logic: Shows total orders and total spend per customer.
-- Why? Helps identify high-value customers for loyalty programs.
-- ---------------------------------------------------------
SELECT
    c.customer_id,
    c.full_name,
    c.email,
    c.phone_no,
    COUNT(o.order_id) AS Total_Orders,
    SUM(o.total_payable) AS Total_Spent,
    ROUND(AVG(o.total_payable), 2) AS Avg_Spend_Per_Order
FROM customer c
JOIN `order` o 
    ON c.customer_id = o.customer_id
WHERE o.order_status IN ('PLACED', 'CONFIRMED', 'PICKED', 'OUT_FOR_DELIVERY', 'DELIVERED')
GROUP BY c.customer_id, c.full_name, c.email, c.phone_no
ORDER BY Total_Spent DESC;


-- ---------------------------------------------------------
-- BUSINESS QUERY 6: "Store & Delivery Experience Rating"
-- Logic: Average store and delivery rating per store.
-- Why? Links operations with customer satisfaction.
-- ---------------------------------------------------------
SELECT
    s.store_id,
    s.store_name,
    cz.city,
    cz.zone_name,
    ROUND(AVG(r.store_rating), 2) AS Avg_Store_Rating,
    ROUND(AVG(r.delivery_rating), 2) AS Avg_Delivery_Rating,
    COUNT(r.rating_id) AS Total_Ratings
FROM order_rating r
JOIN `order` o 
    ON r.order_id = o.order_id
JOIN store s 
    ON o.store_id = s.store_id
JOIN city_zone cz 
    ON s.zone_id = cz.zone_id
GROUP BY s.store_id, s.store_name, cz.city, cz.zone_name
ORDER BY Avg_Store_Rating DESC, Avg_Delivery_Rating DESC;
