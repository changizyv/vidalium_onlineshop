# file architeced
/vidalium_onlineshop/
│
── api/
│ └── v1/
│ ├── attributes.php
│   ├── GET /api/v1/attributes
│     └── Description: Retrieve a list of all product attributes (e.g., Color, Size). Supports filtering and pagination.
│   └── POST /api/v1/attributes
│   └── Description: Create a new product attribute. Requires admin role.
│  
│ ├── auth.php
│   ├── POST /api/v1/auth/forgot-password
│     └── Description: Request a password reset link for a registered user email.
│   ├── POST /api/v1/auth/login
│     └── Description: Authenticate user and return JWT access token and refresh token.
│   ├── POST /api/v1/auth/logout
│     └── Description: Invalidate the current JWT token and end the user session.
│   ├── POST /api/v1/auth/register
│     └── Description: Register a new admin user. Only available if no admin exists yet.
│   └── POST /api/v1/auth/reset-password
│   └── Description: Reset user password using the token received via email.
│  
│ ├── brands.php
│   ├── GET /api/v1/brands
│     └── Description: Retrieve a list of all brands with pagination and search.
│   ├── POST /api/v1/brands
│     └── Description: Create a new brand. Requires admin role.
│   ├── PUT /api/v1/brands/{id}
│     └── Description: Update brand details. Requires admin role.
│   └── DELETE /api/v1/brands/{id}
│   └── Description: Delete a brand. Requires admin role.
│  
│ ├── carts.php
│   ├── GET /api/v1/cart
│     └── Description: Retrieve the current user's cart items with totals. Supports guest users via token.
│   ├── POST /api/v1/cart/items
│     └── Description: Add a product or variant to the cart. Creates cart if not exists.
│   ├── PUT /api/v1/cart/items/{cart_item_id}
│     └── Description: Update quantity of a specific item in the cart.
│   └── DELETE /api/v1/cart/items/{cart_item_id}
│   └── Description: Remove an item from the cart.
│  
│ ├── categories.php
│   ├── DELETE /api/v1/categories/{id}
│     └── Description: Permanently delete a category. Fails if category has associated products.
│   ├── GET /api/v1/categories
│     └── Description: Retrieve a list of all product categories with hierarchy information.
│   ├── POST /api/v1/categories
│     └── Description: Create a new product category. Requires admin role.
│   └── PUT /api/v1/categories/{id}
│   └── Description: Update the details of an existing category. Requires admin role.
│  
│ ├── cheques.php
│   ├── GET /api/v1/checks/bounced
│     └── Description: Retrieve a list of all cheques that have been returned/bounced by the bank.
│   ├── GET /api/v1/checks/upcoming
│     └── Description: Retrieve a list of cheques that are due within the next 7 days.
│   ├── POST /api/v1/checks
│     └── Description: Register a new cheque (Received from customer or Given to supplier).
│   └── PUT /api/v1/checks/{id}/status
│   └── Description: Update the status of a cheque (e.g., to 'Paid', 'Bounced', or 'Cancelled').
│  
│ ├── contact.php
│   ├── POST /api/v1/contact
│     └── Description: Submit a contact form message from the public storefront.
│   └── GET /api/v1/contact/messages
│   └── Description: Retrieve messages submitted via contact form. Requires admin role.
│  
│ ├── customers.php
│   ├── GET /api/v1/customers
│     └── Description: Retrieve a paginated list of all customers. Supports search by name/phone.
│   ├── GET /api/v1/customers/{id}/cheques
│     └── Description: Retrieve a list of all cheques received from a specific customer.
│   ├── GET /api/v1/customers/{id}/orders
│     └── Description: Retrieve the order history for a specific customer.
│   ├── GET /api/v1/customers/{id}/summary
│     └── Description: Retrieve financial summary for a customer (Total Debt, Total Credit, Total Spent).
│   ├── POST /api/v1/customers
│     └── Description: Add a new customer to the system.
│   └── PUT /api/v1/customers/{id}
│   └── Description: Update contact information or details of an existing customer.
│  
│ ├── faqs.php
│   ├── GET /api/v1/faqs
│     └── Description: Retrieve FAQ list. Supports filtering by type (product, category, brand, global) and id (entity_id).
│   ├── POST /api/v1/faqs
│     └── Description: Create a new FAQ entry. Requires admin role.
│   ├── PUT /api/v1/faqs/{id}
│     └── Description: Update an existing FAQ. Requires admin role.
│   └── DELETE /api/v1/faqs/{id}
│   └── Description: Delete an FAQ. Requires admin role.
│  
│ ├── inventory.php
│   ├── GET /api/v1/inventory/batches
│     └── Description: Retrieve a list of inventory batches with stock levels and expiry dates.
│   ├── GET /api/v1/inventory/expiring-soon
│     └── Description: Retrieve a list of products whose batches are expiring within the next 30 days.
│   ├── GET /api/v1/inventory/low-stock
│     └── Description: Retrieve a list of products that are below their minimum stock threshold.
│   └── POST /api/v1/inventory/batches
│   └── Description: Add a new inventory batch (usually triggered after a purchase order is received).
│  
│ ├── notifications.php
│   ├── GET /api/v1/notifications
│     └── Description: Retrieve a list of notifications for the authenticated user.
│   └── PUT /api/v1/notifications/{id}/read
│   └── Description: Mark a specific notification as read.
│  
│ ├── payments.php
│   ├── GET /api/v1/payments/recent
│     └── Description: Retrieve a list of the most recent payments made in the system.
│   ├── POST /api/v1/payments
│     └── Description: Register a new payment against an invoice or debt (Cash, Card, Cheque).
│   └── PUT /api/v1/payments/{id}/verify
│   └── Description: Verify a pending card-to-card payment after manual confirmation by admin.
│  
│ ├── products.php
│   ├── DELETE /api/v1/products/{id}
│     └── Description: Soft delete a product from the catalog.
│   ├── GET /api/v1/products
│     └── Description: Retrieve a list of products with filters (category, search, stock status, brand).
│   ├── GET /api/v1/products/{id}
│     └── Description: Retrieve detailed information of a specific product including variants.
│   ├── POST /api/v1/products
│     └── Description: Create a new product with its initial variants and attributes.
│   └── PUT /api/v1/products/{id}
│   └── Description: Update details, price, or attributes of an existing product.
│  
│ ├── profiles.php
│   ├── GET /api/v1/profile/me
│     └── Description: Retrieve the full profile details of the currently authenticated user.
│   ├── POST /api/v1/profile/upload-avatar
│     └── Description: Upload a new avatar image for the currently authenticated user.
│   └── PUT /api/v1/profile/me
│   └── Description: Update the current user's profile information (display name, phone, etc.).
│  
│ ├── reports.php
│   ├── GET /api/v1/reports/debts
│     └── Description: Generate a report of total debts owed by customers.
│   ├── GET /api/v1/reports/inventory/value
│     └── Description: Calculate the total monetary value of current inventory stock.
│   ├── GET /api/v1/reports/profit
│     └── Description: Generate a Profit & Loss report for a specified date range.
│   ├── GET /api/v1/reports/sales/daily
│     └── Description: Retrieve sales statistics for a specific day.
│   └── GET /api/v1/reports/sales/monthly
│   └── Description: Retrieve sales statistics for a specific month.
│  
│ ├── sales.php
│   ├── GET /api/v1/sales
│     └── Description: Retrieve a list of all sales invoices with status and date filters.
│   ├── GET /api/v1/sales/{id}
│     └── Description: Retrieve full details of a specific invoice including items and payments.
│   ├── POST /api/v1/sales
│     └── Description: Register a new sales invoice. Decreases inventory and updates customer debt.
│   └── POST /api/v1/sales/{id}/return
│   └── Description: Register a return for a specific invoice. Increases inventory and adjusts debt.
│  
│ ├── settings.php
│   ├── GET /api/v1/settings
│     └── Description: Retrieve all shop configuration settings (Name, Address, Tax Rate, etc.).
│   └── PUT /api/v1/settings
│   └── Description: Update shop configuration settings. Requires admin role.
│  
│ ├── shop.php
│   ├── GET /api/v1/shop/orders
│     └── Description: Retrieve order history for the authenticated customer.
│   ├── GET /api/v1/shop/orders/{id}
│     └── Description: Retrieve status and details of a specific customer order.
│   ├── GET /api/v1/shop/products
│     └── Description: Retrieve public product list for the storefront.
│   ├── GET /api/v1/shop/products/{id}
│     └── Description: Retrieve public details for a specific product.
│   ├── POST /api/v1/shop/login
│     └── Description: Authenticate a customer and return JWT token.
│   ├── POST /api/v1/shop/orders
│     └── Description: Register a new order from the public storefront. Clears cart and updates inventory.
│   └── POST /api/v1/shop/register
│   └── Description: Register a new customer account.
│  
│ ├── upload_avatar.php
│   └── POST /api/v1/upload_avatar
│   └── Description: Upload an avatar image for any user (requires admin role for system users, or self for customers).
│  
│ ├── upload_brand_logo.php
│   └── POST /api/v1/upload_brand_logo
│   └── Description: Upload an image file to be associated with a product. Returns the image URL.
│ ├── upload_product_image.php
│   └── POST /api/v1/upload_product_image
│   └── Description: Upload an image file to be associated with a product. Returns the image URL.
│  
│ ├── users.php
│   ├── DELETE /api/v1/admin/users/{id}
│     └── Description: Delete a system user account. Requires Super Admin role.
│   ├── GET /api/v1/admin/users
│     └── Description: Retrieve a list of all system users (Admins, Cashiers, etc.).
│   ├── POST /api/v1/admin/users
│     └── Description: Create a new system user account. Requires Super Admin role.
│   └── PUT /api/v1/admin/users/{id}
│   └── Description: Update role, status, or permissions of a system user. Requires Super Admin role.
│  
│ └── wishlists.php
│ ├── GET /api/v1/wishlist
│   └── Description: Retrieve all products in the user's wishlist.
│ ├── POST /api/v1/wishlist
│   └── Description: Add a product to the wishlist.
│ └── DELETE /api/v1/wishlist/{product_id}
│ └── Description: Remove a product from the wishlist.
│
├── assets/ # Static Assets for Admin/Web
│ ├── css/ # CSS Stylesheets
│   ├── admin.css # Admin Panel Styles
│   ├── fontawesome.min.css # Icons
│   ├── main.css # Global Styles
│   └── shop.css # Storefront Styles
│ ├── fonts/ # Web Fonts
│ └── js/ # JavaScript Files
│   ├── api_client.js # Central AJAX/Fetch Wrapper
│   ├── auth_module.js # Logic for Login/Register Pages
│   ├── cart_module.js # Logic for Cart interactions (Add/Update/Remove items)
│   ├── contact_module.js # Logic for Contact Form submission
│   ├── dom_helper.js # DOM Manipulation Helpers
│   ├── form_helper.js # Form Validation Helpers
│   ├── main.js # Main App Router & State Manager
│   ├── modules/ # Modular JS Scripts
│     ├── product_module.js # Logic for Product Management UI
│     ├── sales_module.js # Logic for Sales/Invoice UI
│     ├── toast.js
│     ├── utils.js # General Utilities (Date, Money Formatting)
│     └── wishlist_module.js # Logic for Wishlist interactions (Add/Remove/Move to Cart)
│   ├── shop/
│     ├──cart.js            # Cart Logic
│     ├── main.js            # Main Store Logic
│     ├── product.js         # Product Page Logic
│     └── utils.js           # Store Utilities

├── admin/ # Admin Panel UI
│ ├── index.php # Admin Dashboard Home
│ ├── notifications.php # Admin Notifications List
│ ├── forgot_password.php # Forgot Password Form
│ ├── login.php # Admin Login
│ ├── reset_password.php # Reset Password Form
│ ├── attributes/ # Attribute Management
│   ├── edit.php # Edit Attribute
│   └── index.php # List Attributes
│ ├── brands/ # Brand Management
│   ├── edit.php # Edit Brand
│   └── index.php # List Brands
│ ├── category/ # Category Management
│   ├── edit.php # Edit Category
│   └── index.php # List Categories
│ ├── contact/ # Contact Form Management
│   ├── contact.php # View details and reply to a specific message
│   └── index.php # List all contact form submissions
│ ├── faq/ # FAQ Management
│   ├── faq.php # Create/Edit a single FAQ entry
│   └── index.php # List all FAQs with filters
│ ├── includes/ # Reusable HTML Components
│   ├── footer.php # Common Footer
│   ├── header.php # Common Header
│   └── sidebar.php # Admin Sidebar
│ ├── products/ # Product Management
│   ├── edit.php # Edit/Add Product
│   └── index.php # List Products
│ ├── reports/ # Reporting
│   ├── index.php # Main Reports Dashboard (Charts/Tables)
│   └── report.php # Detailed view for specific report types
│ ├── sales/ # Sales Management
│   ├── edit.php # Register/Edit Invoice
│   └── index.php # List Invoices
│ ├── settings.php # Shop Settings Page
│ ├── tickets/ # Support Tickets
│   ├── ticket.php # View/Create Ticket
│   └── tickets.php # List Tickets
│ ├── users/ # User Management
│   ├── edit.php # Edit User
│   ├── index.php # List Users
│   ├── user_cheques.php # User's Cheques
│   ├── user_orders.php # User's Orders
│   └── user_payments.php # User's Payments

├── config/ # Configuration Files
│ ├── config.php # General App Settings
│ ├── constants.php # Constants & Paths
│ └── db.php # Database Connection

├── functions/ # Helper Functions
│ ├── auth.php # Authentication Helpers
│ ├── functions.php # General Helper Functions
│ ├── helpers.php # Formatting Helpers (Date/Money)
│ ├── logger.php # Error Logging
│ └── validation.php # Input Validation

├── admin/ # Admin Panel UI
│ ├── index.php #  Admin Dashboard
│ ├── notifications.php # Admin Notifications List
│ ├── attributes/ # Attribute Management
│   ├── edit.php # Edit Attribute
│   └── index.php # List Attributes
│ ├── auth/ # Web Admin Authentication Pages
│   ├── login.php  # Admin Login Page
│   ├── forgot_pasword.php
│   ├── reset_pasword.php
│   └── logout.php # Logout Handler
│ ├── brands/ # Brand Management
│   ├── edit.php # Edit Brand
│   └── index.php # List Brands
│ ├── category/ # Category Management
│   ├── edit.php # Edit Category
│   └── index.php # List Categories
│ ├── contact/ # Contact Form Management
│   ├── contact.php # View details and reply to a specific message
│   └── index.php # List all contact form submissions
│ ├── faq/ # FAQ Management
│   ├── faq.php # Create/Edit a single FAQ entry
│   └── index.php # List all FAQs with filters
│ ├── products/ # Product Management
│   ├── edit.php # Edit/Add Product
│   └── index.php # List Products
│ ├── reports/ # Reporting
│   ├── index.php # Main Reports Dashboard (Charts/Tables)
│   └── report.php # Detailed view for specific report types
│ ├── sales/ # Sales Management
│   ├── edit.php # Register/Edit Invoice
│   └── index.php # List Invoices
│ ├── settings/ #Shop Settings Managements
│   ├── edit_keys.php # create/Edit keys & value 
│   └── index.php # List keys
│ ├── tickets/ # Support Tickets
│   ├── ticket.php # View/Create Ticket
│   └── tickets.php # List Tickets
│ ├── users/ # User Management
│   ├── edit.php # Edit User
│   ├── index.php # List Users
│   ├── user_cheques.php # User's Cheques
│   ├── user_orders.php # User's Orders
│   └── user_payments.php # User's Payments
│ ├── includes/ 
│   ├── admin_footer.php
│   ├── admin_header.php 
│ └ └── admin_sidebar.php

├── public/                        # Customer Storefront UI
│   ├── 404.php                    # Not Found Page
│   ├── about.php                  # About Us
│   ├── cart.php                   # Shopping Cart
│   ├── checkout.php               # Checkout Process
│   ├── contact.php                # Contact Us
│   ├── faq.php                    # FAQs
│   ├── index.php                  # Homepage
│   ├── product.php                # Product Detail Page
│   ├── search.php                 # Search Results
│   ├── shop.php                   # Product Archive/Listing
│   ├── auth/                      # Customer Authentication
│       ├── forgot-password.php
│       ├── login.php
│       ├── register.php
│       └── reset-password.php
│    
│   ├── dashboard/ # Customer Panel
│       ├── index.php # Dashboard Overview
│       ├── wishlist.php # Wishlist Page
│       ├── profile.php # Edit Profile
│          ├── orders/ # Order Management
│          ├── index.php # Order History List
│          └── order.php # Single Order Detail View
│       ├── tickets/ # Support Tickets
│           ├── index.php # Ticket List
│   └   └   └── ticket.php # Single Ticket Thread View

│   ├── includes/                  # Store Templates
│       ├── footer.php             # Store Footer
│       ├── header.php             # Store Header (Cart/User)
│       └── sidebar.php            # logined user

├── uploads/
│   ├── images/ #favicon, logo site
│   ├── products/
│       └── {product_id}/
│   ├── brands/
│       └── {barand_id}/
│   ├── users/
│       └── {user_id}/
│           ├── avatar
│           └── uploads
└── index.php                      # Root Router (Redirects to public)
