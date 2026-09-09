# Backend progress

## Phase 1
- PHP/MySQL bootstrap and configuration
- PDO connection
- JSON response helper
- basic logging
- initial product/category schema

## Phase 2
- category-based product API
- pagination and server-side sorting
- product repository
- category/product indexes
- shared product-listing JavaScript for the connected catalog pages

## Phase 3 — completed in this build
- reusable product presenter
- active category tree API
- multi-level active category scope resolution
- search API across product name, description, and category
- optional category-scoped search
- nullable product prices plus `price_label` support for items such as `تماس بگیرید`
- migration file for upgrading the Phase 2 database

### Categories
`GET /api/categories.php`

### Search
`GET /api/search.php?q=شامپو`

Optional query parameters:
- `category`
- `page`
- `per_page`
- `sort`: `newest`, `price_asc`, `price_desc`, `name_asc`, `name_desc`

## Phase 4 — completed in this build
- server-side session cart
- CSRF token endpoint
- add/update/remove/read cart API
- order creation API
- transactional stock validation and decrement
- immutable order-item price/name snapshots
- order tracking by tracking code + phone
- the existing `HAIR/hair-shampoo.html` add-to-cart button now writes to the real server-side cart without changing its visual layout
- order/order_items schema and useful indexes

### Session / CSRF
`GET /api/session.php`

Returns `csrf_token`. Send it as `X-CSRF-Token` for cart mutations and order creation.

### Cart
- `GET /api/cart.php`
- `POST /api/cart.php` JSON: `{ "product_id": 1, "quantity": 1 }`
- `PATCH /api/cart.php` JSON: `{ "product_id": 1, "quantity": 2 }`
- `DELETE /api/cart.php` JSON: `{ "product_id": 1 }`

### Orders
Create:

`POST /api/orders.php`

JSON body:

```json
{
  "name": "نام مشتری",
  "phone": "09120000000",
  "address": "آدرس کامل مشتری",
  "note": "اختیاری"
}
```

Track:

`GET /api/orders.php?tracking_code=XXXXXXXXXX&phone=09120000000`

## Database upgrade from the previous build
If the Phase 2 database already exists, import this file once before using the new APIs:

`backend/database/002_commerce.sql`

For a fresh database, import:
1. `backend/database/schema.sql`
2. `backend/database/seed.sql`

## Not connected to the UI yet
The existing visual layout was intentionally left unchanged. The dynamic shampoo page is connected to the real cart. Search forms, the remaining static cart buttons, checkout UI, account UI, and order-tracking UI can be connected to these backend endpoints in the next phase without redesigning the pages.
