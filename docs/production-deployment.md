# Production Deployment Requirements

This project is a plain PHP/MySQL storefront with static HTML pages and PHP API endpoints. It does not require a JavaScript build step.

## Runtime

- PHP 7.4 or newer.
- MySQL or MariaDB with InnoDB support.
- Required PHP extensions: `pdo`, `pdo_mysql`, `json`, `session`, `mbstring`, `openssl`.
- Apache is supported. Keep `backend/.htaccess` enabled so backend source files are not directly downloadable.
- HTTPS is strongly recommended for production. Set `APP_HSTS=true` only after HTTPS is correctly configured for the final host.

## Database Setup

Create an empty database with `utf8mb4` charset, then apply migrations in this order:

1. `backend/database/schema.sql`
2. `backend/database/002_commerce.sql`
3. `backend/database/003_catalog_expansion.sql`
4. `backend/database/004_catalog_completion.sql`

The catalog expansion migrations are written to be repeatable and should not overwrite live stock on duplicate products.

## Configuration

Do not commit production credentials.

Production can be configured with environment variables:

- `DB_HOST`
- `DB_PORT`
- `DB_DATABASE`
- `DB_USERNAME`
- `DB_PASSWORD`
- `DB_CHARSET`
- `APP_DEBUG=false`
- `APP_TIMEZONE=Asia/Tehran`
- `APP_LOG_FILE`
- `APP_SESSION_SAVE_PATH`
- `APP_RATE_LIMIT_PATH`
- `APP_SESSION_NAME`
- `APP_HSTS=false` until HTTPS is confirmed

For local development only, copy `backend/config/local.example.php` to `backend/config/local.php` and edit it locally. `local.php` is ignored by Git.

## Writable Directories

The web server user must be able to write to:

- `backend/storage/logs`
- `backend/storage/sessions`
- `backend/storage/rate_limits`

Runtime files in these directories must not be committed. `backend/storage/.htaccess` denies direct public download when Apache honors `.htaccess` files.

## Document Root

The simplest deployment serves this repository root as the document root. If the host supports a separate public document root, expose only the storefront HTML, `assets/`, and `api/`, while keeping `backend/` private and readable by PHP.

## Deferred Owner Inputs

Payment provider, shipping rules, admin scope, real inventory, real contact-price values, missing product image assets, legal policy text, and notification providers are intentionally outside this technical deployment setup.
