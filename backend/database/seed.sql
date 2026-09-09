USE alkamoone;

INSERT INTO categories (parent_id, name, slug, is_active)
VALUES (NULL, 'پاک کننده صورت', 'face-cleanser', 1)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شوینده صورت', 'facial-cleanser', 1
FROM categories
WHERE slug = 'face-cleanser'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'میسلار واتر', 'micellar-water', 1
FROM categories
WHERE slug = 'face-cleanser'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
VALUES (NULL, 'دسته بدون محصول', 'empty-category', 1)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
VALUES (NULL, 'دسته غیرفعال', 'inactive-category', 0)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
VALUES (NULL, 'شامپو', 'hair-shampoo', 1)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل شوینده ملایم صورت', 'gentle-facial-cleanser', 'شوینده روزانه ملایم برای پاکسازی پوست بدون ایجاد خشکی.', 690000, NULL, '○', 18, 1
FROM categories
WHERE slug = 'facial-cleanser'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    stock = VALUES(stock),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو روزانه انواع مو', 'daily-all-hair-shampoo', 'شامپو مناسب استفاده روزانه برای انواع مو.', 540000, NULL, '🧴', 21, 1
FROM categories
WHERE slug = 'hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    stock = VALUES(stock),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو تقویت کننده ریشه مو', 'root-strengthening-shampoo', 'فرمول مراقبتی برای موهای ضعیف و مستعد ریزش.', 880000, NULL, '🌿', 15, 1
FROM categories
WHERE slug = 'hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    stock = VALUES(stock),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو ضدشوره ملایم', 'gentle-anti-dandruff-shampoo', 'شامپو مناسب مراقبت از پوست سر و کاهش پوسته‌ریزی.', 760000, NULL, '✨', 10, 1
FROM categories
WHERE slug = 'hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    stock = VALUES(stock),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو بسیار ملایم مخصوص موهای خشک، شکننده و نیازمند مراقبت روزانه طولانی‌مدت', 'long-name-dry-hair-shampoo', 'نام طولانی برای بررسی نمایش امن و پایدار کارت محصول در صفحه.', 990000, NULL, '◇', 6, 1
FROM categories
WHERE slug = 'hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    stock = VALUES(stock),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'فوم پاک کننده پوست حساس', 'sensitive-skin-cleansing-foam', 'پاک کننده سبک برای پوست حساس و استفاده منظم روزانه.', 750000, NULL, '◌', 12, 1
FROM categories
WHERE slug = 'facial-cleanser'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    stock = VALUES(stock),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'میسلار واتر آبرسان', 'hydrating-micellar-water', 'محلول پاک کننده آرایش و آلودگی با حس سبک و آبرسان.', 820000, NULL, '◇', 9, 1
FROM categories
WHERE slug = 'micellar-water'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    stock = VALUES(stock),
    is_active = VALUES(is_active);
