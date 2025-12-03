#  Blinkit Database Management System (DBMS) Project

This repository contains a complete DBMS project designed using the operational structure of **Blinkit**, a quick-commerce grocery delivery company. 
---

##  Project Overview

The objective of this project is to design and model a real-world database system for a hyperlocal delivery platform.  
The design covers:

- Customers  
- Orders & Order Items  
- Payments  
- Delivery Partners & Assignments  
- Products & Categories  
- Stores & Inventory  
- Coupons & Usage  
- Ratings  
- City Zones  

# Database Schema

The database is structured into five logical modules based on the Blinkit EER diagram.

## 1. Location & Store Operations
This module manages the geographical mapping and operational structure of Blinkit dark stores.

### City_Zone
- Defines delivery zones for each city.
- Used for assigning delivery partners and routing orders.

### Store
- Represents Blinkit dark stores linked to specific zones.
- Includes store timings and active/inactive operational status.

### Store_Inventory
- Tracks stock levels for each product in a store.
- Maintains selling price, reorder levels, and last updated timestamps.
  

## 2. Customer & Engagement
Handles customer information, addresses, and promotional activity.

### Customer
- Stores personal details such as name, phone, and email.
- Includes account status (active/inactive/banned).

### Customer_Address
- Stores multiple delivery addresses linked to a customer.
- Contains labels (Home/Work/Other) and default address selection.

### Coupon
- Represents available coupons with discount details.
- Includes value, type, validity period, and usage limits.

### Customer_Coupon_Usage
- Tracks coupon usage for each customer.
- Ensures customers do not exceed the allowed limit.


## 3. Product & Category Management
Maintains the product catalog and classification.

### Product_Category
- Implements a hierarchical category system.
- Supports parent → subcategory structure.

### Product
- Represents items available on Blinkit.
- Includes brand, unit size, description, and MRP.


## 4. Order Lifecycle
Covers order placement, fulfillment, and feedback.

### Order
- Master record for each purchase.
- Stores timestamps, store reference, coupon applied, and financial breakdown.

### Order_Item
- Detailed line items for each order.
- Tracks product quantity, unit price, and total per item.

### Delivery_Assignment
- Assigns delivery partners to orders.
- Tracks timestamps: assigned, picked, and delivered.

### Order_Rating
- Customer feedback for the order.
- Includes store rating, delivery rating, and comments.


## 5. Payment & Settlement
Handles financial processing and transaction tracking.

### Payment
- Records payment details for each order.
- Includes payment mode (UPI/Card/COD), transaction reference, and status.

## Group 19 (Section B, PGDM-34)
341088 - Naman Jain
341089 - Navya Mahindru
341114 - Vaishali Singhania
