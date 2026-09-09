USE alkamoone;

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'پاک کننده آرایش چشم', 'eye-makeup-remover', 1
FROM categories
WHERE slug = 'face-cleanser'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'فوم شست‌وشوی صورت', 'face-wash-foam', 1
FROM categories
WHERE slug = 'face-cleanser'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'ژل شست‌وشوی صورت', 'face-wash-gel', 1
FROM categories
WHERE slug = 'face-cleanser'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'پاک کننده دو فاز آرایش چشم', 'eye-makeup-remover-01', 'پاک کننده دو فاز آرایش چشم از دسته پاک کننده آرایش چشم.', 690000, NULL, '/assets/images/products/eye-makeup-remover-01.jpg', 10, 1
FROM categories
WHERE slug = 'eye-makeup-remover'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'پاک کننده ملایم آرایش چشم برای پوست حساس', 'eye-makeup-remover-02', 'پاک کننده ملایم آرایش چشم برای پوست حساس از دسته پاک کننده آرایش چشم.', 790000, NULL, '/assets/images/products/eye-makeup-remover-02.jpg', 10, 1
FROM categories
WHERE slug = 'eye-makeup-remover'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'پاک کننده مخصوص آرایش ضدآب چشم', 'eye-makeup-remover-03', 'پاک کننده مخصوص آرایش ضدآب چشم از دسته پاک کننده آرایش چشم.', 920000, NULL, '/assets/images/products/eye-makeup-remover-03.jpg', 10, 1
FROM categories
WHERE slug = 'eye-makeup-remover'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'محلول پاک کننده آرایش چشم بدون عطر', 'eye-makeup-remover-04', 'محلول پاک کننده آرایش چشم بدون عطر از دسته پاک کننده آرایش چشم.', 860000, NULL, '/assets/images/products/eye-makeup-remover-04.jpg', 10, 1
FROM categories
WHERE slug = 'eye-makeup-remover'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'محلول پاک کننده روزانه آرایش چشم', 'eye-makeup-remover-05', 'محلول پاک کننده روزانه آرایش چشم از دسته پاک کننده آرایش چشم.', 610000, NULL, '/assets/images/products/eye-makeup-remover-05.jpg', 10, 1
FROM categories
WHERE slug = 'eye-makeup-remover'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'پاک کننده دو فاز برای آرایش چشم ضدآب', 'eye-makeup-remover-06', 'پاک کننده دو فاز برای آرایش چشم ضدآب از دسته پاک کننده آرایش چشم.', 1050000, NULL, '/assets/images/products/eye-makeup-remover-06.jpg', 10, 1
FROM categories
WHERE slug = 'eye-makeup-remover'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'فوم شست‌وشوی صورت آبرسان مناسب انواع پوست', 'face-wash-foam-01', 'فوم شست‌وشوی صورت آبرسان مناسب انواع پوست از دسته فوم شست‌وشوی صورت.', 790000, NULL, '/assets/images/products/face-wash-foam-01.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-foam'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'فوم پاک کننده صورت مناسب پوست چرب', 'face-wash-foam-02', 'فوم پاک کننده صورت مناسب پوست چرب از دسته فوم شست‌وشوی صورت.', 850000, NULL, '/assets/images/products/face-wash-foam-02.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-foam'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'فوم شست‌وشوی ملایم مخصوص پوست حساس', 'face-wash-foam-03', 'فوم شست‌وشوی ملایم مخصوص پوست حساس از دسته فوم شست‌وشوی صورت.', 930000, NULL, '/assets/images/products/face-wash-foam-03.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-foam'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'فوم شست‌وشوی کرمی مناسب پوست خشک', 'face-wash-foam-04', 'فوم شست‌وشوی کرمی مناسب پوست خشک از دسته فوم شست‌وشوی صورت.', 880000, NULL, '/assets/images/products/face-wash-foam-04.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-foam'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'فوم پاک کننده روزانه مناسب انواع پوست', 'face-wash-foam-05', 'فوم پاک کننده روزانه مناسب انواع پوست از دسته فوم شست‌وشوی صورت.', 650000, NULL, '/assets/images/products/face-wash-foam-05.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-foam'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'فوم پاک کننده و کنترل کننده چربی پوست', 'face-wash-foam-06', 'فوم پاک کننده و کنترل کننده چربی پوست از دسته فوم شست‌وشوی صورت.', 1020000, NULL, '/assets/images/products/face-wash-foam-06.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-foam'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل شست‌وشوی صورت آبرسان مناسب انواع پوست', 'face-wash-gel-01', 'ژل شست‌وشوی صورت آبرسان مناسب انواع پوست از دسته ژل شست‌وشوی صورت.', 780000, NULL, '/assets/images/products/face-wash-gel-01.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-gel'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل شست‌وشوی صورت کنترل کننده چربی پوست', 'face-wash-gel-02', 'ژل شست‌وشوی صورت کنترل کننده چربی پوست از دسته ژل شست‌وشوی صورت.', 850000, NULL, '/assets/images/products/face-wash-gel-02.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-gel'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل شست‌وشوی ملایم مخصوص پوست حساس', 'face-wash-gel-03', 'ژل شست‌وشوی ملایم مخصوص پوست حساس از دسته ژل شست‌وشوی صورت.', 920000, NULL, '/assets/images/products/face-wash-gel-03.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-gel'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل شوینده و آبرسان مخصوص پوست خشک', 'face-wash-gel-04', 'ژل شوینده و آبرسان مخصوص پوست خشک از دسته ژل شست‌وشوی صورت.', 890000, NULL, '/assets/images/products/face-wash-gel-04.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-gel'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل شست‌وشوی روزانه صورت برای انواع پوست', 'face-wash-gel-05', 'ژل شست‌وشوی روزانه صورت برای انواع پوست از دسته ژل شست‌وشوی صورت.', 640000, NULL, '/assets/images/products/face-wash-gel-05.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-gel'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل پاک کننده صورت با تمرکز بر شفافیت پوست', 'face-wash-gel-06', 'ژل پاک کننده صورت با تمرکز بر شفافیت پوست از دسته ژل شست‌وشوی صورت.', 970000, NULL, '/assets/images/products/face-wash-gel-06.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-gel'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل شست‌وشوی عمیق مناسب پوست مختلط و چرب', 'face-wash-gel-07', 'ژل شست‌وشوی عمیق مناسب پوست مختلط و چرب از دسته ژل شست‌وشوی صورت.', 1050000, NULL, '/assets/images/products/face-wash-gel-07.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-gel'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل شست‌وشوی صورت بدون سولفات برای مصرف روزانه', 'face-wash-gel-08', 'ژل شست‌وشوی صورت بدون سولفات برای مصرف روزانه از دسته ژل شست‌وشوی صورت.', 990000, NULL, '/assets/images/products/face-wash-gel-08.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-gel'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل پاک کننده مینرال مناسب روتین روزانه', 'face-wash-gel-09', 'ژل پاک کننده مینرال مناسب روتین روزانه از دسته ژل شست‌وشوی صورت.', 1150000, NULL, '/assets/images/products/face-wash-gel-09.jpg', 10, 1
FROM categories
WHERE slug = 'face-wash-gel'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);
