-- Database Schema for Online Shop

-- 1. Geographic Data
CREATE TABLE provinces (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name)
);

CREATE TABLE cities (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL,
    province_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (province_id) REFERENCES provinces(id) ON DELETE CASCADE,
    INDEX idx_name (name),
    INDEX idx_province (province_id)
);

-- 2. Core System Settings & Brands
CREATE TABLE brands (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    logo_path VARCHAR(255) NULL,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_slug (slug)
);

CREATE TABLE settings_key (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    key_name VARCHAR(100) UNIQUE NOT NULL,
    title TEXT NOT NULL,
    description VARCHAR(255)
);
-- General Settings
INSERT INTO settings_key (key_name, title, description) VALUES 
('general.site_url', 'Site URL', 'Base URL of the website (e.g., https://example.com)'),
('general.site_name', 'Site Name', 'Name of the shop displayed in header and title'),
('general.site_slogan', 'Site Slogan', 'Short slogan for the shop'),
('general.site_description', 'Site Description', 'Short description for SEO Meta Tags'),
('general.about_us_content', 'About Us Content', 'HTML content for the About Us page'),
('general.copyright_text', 'Copyright Text', 'Text displayed in the footer'),
('general.logo_url', 'Logo URL', 'URL path to the shop logo'),
('general.favicon_url', 'Favicon URL', 'URL path to the site favicon'),
('general.enable_registration', 'Enable Registration', 'Allow new users to register (1 for Yes, 0 for No)'),
('general.require_email_verification', 'Require Email Verification', 'Force users to verify email (1 for Yes, 0 for No)');

-- Contact & Social Settings
INSERT INTO settings_key (key_name, title, description) VALUES 
('contact.address', 'Physical Address', 'Shop physical address'),
('contact.phone', 'Main Phone Number', 'Main contact phone number'),
('contact.email', 'Support Email', 'Support email address'),
('contact.support_phone', 'Support Phone', 'Specific phone number for support'),
('contact.social_telegram', 'Telegram Link', 'URL to Telegram channel or group'),
('contact.social_instagram', 'Instagram Link', 'URL to Instagram profile'),
('contact.social_whatsapp', 'WhatsApp Link', 'URL to WhatsApp chat or number'),
('contact.social_linkedin', 'LinkedIn Link', 'URL to LinkedIn page');

-- Financial & Payment Settings
INSERT INTO settings_key (key_name, title, description) VALUES 
('financial.default_currency', 'Default Currency', 'Code of the default currency (e.g., IRR, Toman)'),
('financial.tax_rate', 'Tax Rate', 'Default VAT percentage (e.g., 9 for 9%)'),
('financial.bank_account_number', 'Bank Account Number', 'Account number for manual transfers'),
('financial.payment_gateway_api_key', 'Payment Gateway API Key', 'API Key for payment gateway (Encrypted)');

-- Shipping Settings
INSERT INTO settings_key (key_name, title, description) VALUES 
('shipping.free_shipping_threshold', 'Free Shipping Threshold', 'Minimum order amount for free shipping'),
('shipping.default_shipping_cost', 'Default Shipping Cost', 'Base cost for shipping'),
('shipping.shipping_methods_config', 'Shipping Methods Config', 'JSON configuration for shipping methods');

-- SEO & Marketing Settings
INSERT INTO settings_key (key_name, title, description) VALUES 
('seo.keywords', 'SEO Keywords', 'Comma-separated keywords for the site'),
('seo.google_analytics_id', 'Google Analytics ID', 'Tracking ID for Google Analytics'),
('seo.facebook_pixel_id', 'Facebook Pixel ID', 'Pixel ID for Facebook/Instagram ads');

CREATE TABLE settings (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    key_id CHAR(36) UNIQUE NOT NULL,
    value TEXT NOT NULL,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (key_id) REFERENCES settings_key(id) ON DELETE CASCADE
);

-- 3. User Management & Auth
CREATE TABLE users (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    display_name VARCHAR(255),
    national_id VARCHAR(36) NULL,
    phone VARCHAR(25) UNIQUE,
    phone_2 VARCHAR(25) NULL,
    telegram VARCHAR(50) NULL,
    whatapp VARCHAR(50) NULL,
    city_id CHAR(36) NULL,
    address text NULL,
    role ENUM('admin', 'cashier', 'warehouse', 'customer', 'supplier') DEFAULT 'customer',
    is_active tinyint(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE SET NULL,
    INDEX idx_phone (phone),
    INDEX idx_role (role)
);

-- Password Reset Tokens
CREATE TABLE password_resets (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id CHAR(36) NOT NULL,
    token VARCHAR(255) NOT NULL,
    expires_at DATETIME NOT NULL,
    used TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_token (token),
    INDEX idx_user_expires (user_id, expires_at)
);

-- Wallet & Transactions
CREATE TABLE user_wallets (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id CHAR(36) NOT NULL,
    balance DECIMAL(15, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_wallet (user_id)
);

CREATE TABLE wallet_transactions (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id CHAR(36) NOT NULL,
    type ENUM('credit', 'debit') NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    reference_id CHAR(36) NULL,
    description TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user (user_id)
);

-- 4. Product Catalog
CREATE TABLE categories (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(50) UNIQUE NOT NULL,
    parent_id CHAR(36) NULL,
    icon varchar(50),
    is_active tinyint(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL,
    INDEX idx_slug (slug),
    INDEX idx_parent (parent_id)
);

CREATE TABLE attributes (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_slug (slug)
);

CREATE TABLE products (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    slug VARCHAR(50) UNIQUE NOT NULL,
    category_id CHAR(36) NULL,
    brand_id CHAR(36) NULL, -- Foreign key to brands
    price DECIMAL(15, 2) DEFAULT 0.00,
    discount_percent decimal(5,2) DEFAULT 0.00,
    discount_start DATETIME NULL,
    discount_end DATETIME NULL,
    short_description text NULL,
    description text NULL,
    image_path varchar(255) NULL,
    status ENUM('draft', 'published', 'archived') DEFAULT 'published',
    is_featured TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
    FOREIGN KEY (brand_id) REFERENCES brands(id) ON DELETE SET NULL,
    INDEX idx_sku (sku),
    INDEX idx_slug (slug),
    INDEX idx_status (status),
    INDEX idx_brand (brand_id)
);

CREATE TABLE product_variants (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    product_id CHAR(36) NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(255),
    attributes JSON, -- {"color": "red", "size": "L"}
    price DECIMAL(15, 2) NOT NULL,
    cost_price DECIMAL(15, 2) NOT NULL,
    stock_quantity DECIMAL(15, 4) DEFAULT 0, -- Current total stock
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    INDEX idx_sku (sku),
    INDEX idx_product (product_id)
);

CREATE TABLE inventory_batches (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),    
    product_id CHAR(36) NOT NULL,
    variation_id CHAR(36) NULL, -- NULL if simple product
    batch_number VARCHAR(50),
    quantity DECIMAL(15, 4) DEFAULT 0,
    expiry_date DATE NULL,
    purchase_price DECIMAL(15, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (variation_id) REFERENCES product_variants(id) ON DELETE CASCADE,
    INDEX idx_expiry (expiry_date),
    INDEX idx_product (product_id)
);

CREATE TABLE product_images (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    product_id CHAR(36) NOT NULL,
    variation_id CHAR(36) NULL,
    image_path varchar(255),
    is_main tinyint(1) DEFAULT 0,
    sort_order int,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (variation_id) REFERENCES product_variants(id) ON DELETE CASCADE
);

CREATE TABLE product_attribute_map (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),    
    product_id CHAR(36) NOT NULL,
    variation_id CHAR(36) NULL,
    attribute_id CHAR(36) NOT NULL,
    attribute_value VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (variation_id) REFERENCES product_variants(id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_id) REFERENCES attributes(id) ON DELETE CASCADE
);

-- Units
CREATE TABLE units (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(50) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    is_base_unit BOOLEAN DEFAULT FALSE
);

CREATE TABLE product_unit_mapping (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    product_id CHAR(36) NOT NULL,
    unit_id CHAR(36) NOT NULL,
    conversion_rate DECIMAL(10, 4) DEFAULT 1.0000,
    is_default BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE CASCADE,
    INDEX idx_product (product_id)
);

-- Reviews
CREATE TABLE product_reviews (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    product_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title VARCHAR(255) NULL,
    comment TEXT NULL,
    is_approved TINYINT(1) DEFAULT 0,
    helpful_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_product_approved (product_id, is_approved)
);

-- 5. Shopping & Wishlist
CREATE TABLE carts (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id CHAR(36) NULL,
    guest_token VARCHAR(255) NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE cart_items (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    cart_id CHAR(36) NOT NULL,
    product_id CHAR(36) NOT NULL,
    variation_id CHAR(36) NULL,
    quantity INT NOT NULL DEFAULT 1,
    price_at_add DECIMAL(15, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (variation_id) REFERENCES product_variants(id) ON DELETE CASCADE,
    INDEX idx_cart (cart_id)
);

CREATE TABLE wishlists (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_wishlist (user_id)
);

CREATE TABLE wishlist_items (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    wishlist_id CHAR(36) NOT NULL,
    product_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (wishlist_id) REFERENCES wishlists(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE KEY unique_product_wishlist (wishlist_id, product_id)
);

-- 6. Orders & Logistics
CREATE TABLE coupons (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),   
    code VARCHAR(50) UNIQUE NOT NULL,
    type ENUM('percentage', 'fixed') NOT NULL,
    value DECIMAL(15, 2) NOT NULL,
    min_order_amount DECIMAL(15, 2) DEFAULT 0.00,
    max_uses INT DEFAULT NULL,
    used_count INT DEFAULT 0,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    INDEX idx_code (code),
    INDEX idx_validity (valid_from, valid_to)
);

CREATE TABLE shipping_methods (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL,
    base_price DECIMAL(15, 2) DEFAULT 0.00,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE sales_orders (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id CHAR(36) NULL,
    order_date DATETIME NOT NULL,
    status ENUM('draft', 'completed', 'returned', 'cancelled') DEFAULT 'draft',
    payment_status ENUM('unpaid', 'partial', 'paid') DEFAULT 'unpaid',
    total_amount DECIMAL(15, 2) DEFAULT 0.00,
    coupon_id CHAR(36) NULL,
    discount_amount DECIMAL(15, 2) DEFAULT 0.00,
    discount_total DECIMAL(15, 2) DEFAULT 0.00,
    tax_amount DECIMAL(15, 2) DEFAULT 0.00,
    final_amount DECIMAL(15, 2) DEFAULT 0.00,
    need_shipping tinyint(1) DEFAULT 1,
    shipping_price DECIMAL(15, 2) DEFAULT 0.00,
    shipping_method_id CHAR(36) NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON DELETE CASCADE,
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_methods(id) ON DELETE SET NULL,
    INDEX idx_user (user_id),
    INDEX idx_status (status),
    INDEX idx_date (order_date)
);

CREATE TABLE order_shipments (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    sales_order_id CHAR(36) NOT NULL,
    tracking_number VARCHAR(100) NULL,
    courier_name VARCHAR(100) NULL,
    tracking_url VARCHAR(255) NULL,
    shipped_at TIMESTAMP NULL,
    delivered_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sales_order_id) REFERENCES sales_orders(id) ON DELETE CASCADE
);

CREATE TABLE sales_order_items (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    sales_order_id CHAR(36) NOT NULL,
    product_id CHAR(36) NOT NULL,
    variation_id CHAR(36) NULL,
    quantity DECIMAL(15, 4) NOT NULL,
    unit_price DECIMAL(15, 2) NOT NULL,
    item_discount DECIMAL(15, 2) DEFAULT 0.00,
    total_price DECIMAL(15, 2) NOT NULL,
    cost_price_at_sale DECIMAL(15, 2) NULL,
    batch_id CHAR(36) NULL,
    FOREIGN KEY (sales_order_id) REFERENCES sales_orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (variation_id) REFERENCES product_variants(id) ON DELETE CASCADE,
    FOREIGN KEY (batch_id) REFERENCES inventory_batches(id) ON DELETE SET NULL
);

CREATE TABLE purchase_orders (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id  CHAR(36) NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('pending', 'confirmed', 'received', 'cancelled') DEFAULT 'pending',
    total_amount DECIMAL(15, 2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_status (status),
    INDEX idx_date (order_date)
);

CREATE TABLE purchase_order_items (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    purchase_order_id CHAR(36)  NOT NULL,
    product_id CHAR(36) NOT NULL,
    variation_id CHAR(36) NULL,
    quantity DECIMAL(15, 4) NOT NULL,
    unit_price DECIMAL(15, 2) NOT NULL,
    expiry_date DATE NULL,
    batch_number VARCHAR(50),
    payment_status ENUM('unpaid', 'partial', 'paid') DEFAULT 'paid',    
    FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (variation_id) REFERENCES product_variants(id) ON DELETE CASCADE
);

-- 7. Payments & Financials
CREATE TABLE payment_methods (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name ENUM('cash', 'cheque', 'Card_to_card', 'wallet_withdraw') NOT NULL,
    code VARCHAR(20) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE payments (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    sales_order_id CHAR(36)  NOT NULL,
    payment_method_id CHAR(36)  NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    payment_date DATETIME NOT NULL,
    reference_number VARCHAR(100) NULL,
    notes TEXT NULL,
    status_card_to_card ENUM('pending','approve','reject') NULL,
    FOREIGN KEY (sales_order_id) REFERENCES sales_orders(id) ON DELETE CASCADE,
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id) ON DELETE RESTRICT,
    INDEX idx_order (sales_order_id)
);

CREATE TABLE cheques (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    related_party_id CHAR(36) NOT NULL,
    type ENUM('received', 'given') NOT NULL,
    check_number VARCHAR(50) NOT NULL,
    bank_name VARCHAR(100),
    amount DECIMAL(15, 2) NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    status ENUM('pending', 'paid', 'returned', 'bounced') DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (related_party_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_due_date (due_date),
    INDEX idx_status (status)
);

-- 8. Support & Communication
CREATE TABLE tickets (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id CHAR(36) NOT NULL,
    subject VARCHAR(255) NOT NULL,
    status ENUM('open', 'pending', 'answered', 'resolved', 'closed', 'spam') DEFAULT 'open',
    priority ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
    assigned_to CHAR(36) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    closed_at TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE ticket_messages (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    ticket_id CHAR(36)  NOT NULL,
    user_id CHAR(36) NOT NULL,
    message_type ENUM('customer', 'agent', 'system') DEFAULT 'customer',
    message TEXT NOT NULL,
    attachments JSON NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE notifications (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    user_id CHAR(36) NULL,
    type ENUM('system', 'ticket', 'order', 'sales', 'comment') NOT NULL,
    title VARCHAR(255) NOT NULL DEFAULT '',
    content TEXT,
    metadata JSON NULL,
    is_read TINYINT(1) NOT NULL DEFAULT 0,
    read_at TIMESTAMP NULL DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_read (user_id, is_read),
    INDEX idx_created (created_at)
);

CREATE TABLE faqs (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    question VARCHAR(500) NOT NULL,
    answer TEXT NOT NULL,
    is_active TINYINT(1) DEFAULT 1,
    sort_order INT DEFAULT 0, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    faqable_type ENUM('product', 'category', 'brand', 'global') NOT NULL DEFAULT 'global',
    faqable_id CHAR(36) NULL,
    
    INDEX idx_type_id (faqable_type, faqable_id),
    INDEX idx_active (is_active)
);

CREATE TABLE contact_forms (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(25) NULL, -- Optional if not required by form
    subject VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    ip_address VARCHAR(45) NULL, -- For tracking where the message came from
    is_read TINYINT(1) DEFAULT 0,
    reply TEXT NULL, -- Admin reply (optional, or use tickets table)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_read (is_read)
);
