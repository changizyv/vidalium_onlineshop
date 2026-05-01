# Vidalium Online Shop

**A lightweight, raw PHP e-commerce solution designed for stability and simplicity.**

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![PHP Version](https://img.shields.io/badge/PHP-7.4+-green.svg)](https://php.net)
[![MySQL](https://img.shields.io/badge/Database-MySQL-4479A1.svg)](https://www.mysql.com)

## 🇮🇷 Important Notice Regarding Iran

**To the international community and fellow developers:**

As of May 1, 2026, Iran is facing a severe humanitarian and economic crisis. Due to widespread internet blackouts and strict government filtering, the digital economy has been severely impacted. Over two months have passed with limited or no reliable internet access for the majority of the population. Critical security layers, including SSL and HTTPS infrastructure, have been compromised or inaccessible for many, and common tools for bypassing restrictions are largely unavailable.

Currently, only a small fraction of individuals with significant resources or government connections can access the internet under strict surveillance. This project, **Vidalium**, is not just a piece of software; it is a testament to the resilience of Iranian developers and business owners who continue to operate despite these unprecedented challenges.

**Vidalium** is built to be extremely lightweight, secure (where possible), and functional even in low-bandwidth or restricted environments. It requires minimal dependencies and can run on standard shared hosting without complex server configurations.

**If you believe in digital freedom and human rights, please consider sharing this repository. Supporting open-source projects in regions under digital siege is a powerful way to stand for the freedom of the Iranian people.**

---

## 📖 About the Project

**Vidalium Online Shop** is a robust, modular e-commerce platform built with **Raw PHP**. It is designed to be easy to deploy, maintain, and extend.

While this project does not follow a strict MVC (Model-View-Controller) framework architecture out-of-the-box, its file structure and separation of concerns are designed to be **framework-agnostic**. This means you can easily integrate it with modern PHP frameworks (like Laravel, Symfony, or CodeIgniter) in the future if needed, or continue using it as a standalone raw PHP application.

### Key Features
*   **Raw PHP:** No heavy frameworks, ensuring high performance and low resource usage.
*   **Modular Structure:** Clear separation between Admin Panel (`/admin`), Customer Storefront (`/public`), and API (`/api`).
*   **Modern Database Schema:** Supports products, variants, inventory batches, orders, payments, and user management.
*   **Responsive UI:** Clean and functional user interfaces for both admin and customers.
*   **Security Focused:** Implements basic security practices (prepared statements, session management) suitable for raw PHP.
*   **Lightweight:** Perfect for shared hosting environments with limited resources.

## 🚀 Installation

### Prerequisites
*   PHP 7.4 or higher
*   MySQL 5.7 or higher (or MariaDB)
*   Apache/Nginx Web Server

### Steps

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/changizyv/vidalium_onlineshop.git
    cd vidalium_onlineshop
    ```

2.  **Database Setup:**
    *   Create a new MySQL database.
    *   Import the SQL schema provided in the repository (if available) or create tables based on the structure defined in the documentation.

3.  **Configuration:**
    *   Copy `config/config.php.example` to `config/config.php`.
    *   Update the database credentials:
        ```php
        define('DB_HOST', 'localhost');
        define('DB_NAME', 'your_database_name');
        define('DB_USER', 'your_username');
        define('DB_PASS', 'your_password');
        ```

4.  **Permissions:**
    *   Ensure the `uploads/` directory is writable by the web server.
        ```bash
        chmod -R 755 uploads/
        ```

5.  **Web Server Configuration:**
    *   Point your web server's document root to the `/public` directory for the storefront, or configure routing to handle `/admin` and `/api` endpoints appropriately.

## 📁 Project Structure

```
/shop-app/
├── api/                 # REST API endpoints (v1)
├── assets/              # Global static assets (CSS, JS, Images)
├── admin/               # Admin Panel UI
├── public/              # Customer Storefront UI
├── config/              # Configuration files
├── functions/           # Helper functions
├── includes/            # Reusable HTML components (Headers, Footers)
├── uploads/             # User-uploaded files (Images, etc.)
└── index.php            # Main entry point
```

## 🔧 Extensibility

Although this project uses raw PHP, its structure allows for easy extension:
*   **API Integration:** The `/api/v1/` folder contains well-defined endpoints that can be consumed by mobile apps or frontend frameworks like React/Vue.
*   **Framework Migration:** The separation of logic into `functions/` and `config/` makes it easier to refactor into a MVC structure later.

## 🛡️ Security Note

While this project implements standard security practices, it is the responsibility of the administrator to:
*   Keep PHP and MySQL updated.
*   Use strong passwords for database and admin accounts.
*   Configure SSL/HTTPS properly if available.
*   Regularly backup the database and uploads directory.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📜 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

*   Inspired by the resilience of Iranian entrepreneurs and developers.
*   Built with ❤️ for a better, more accessible digital future.

---

**Stay strong. Stay connected. Stay free.**
