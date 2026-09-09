USE alkamoone;

INSERT INTO categories (parent_id, name, slug, is_active)
VALUES (NULL, 'مراقبت بدن', 'body-care', 1)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
VALUES (NULL, 'محصولات مو', 'hair-products', 1)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
VALUES (NULL, 'مراقبت لب', 'lip-care', 1)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    is_active = VALUES(is_active);

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

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'کره بدن', 'body-butter', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شوینده بدن', 'body-cleanser', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'کرم بدن', 'body-cream', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'لوسیون بدن', 'body-lotion', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'ماسک و اسکراب بدن', 'body-mask-scrub', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'روغن بدن', 'body-oil', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'ضد ترک بدن', 'body-stretch-mark', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'ضدآفتاب بدن', 'body-sunscreen', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'مکمل و قرص', 'body-supplements', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شوینده بدن', 'body-wash', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'ژل کرم', 'gel-cream', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'کرم دست و پا', 'hand-foot-cream', 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'روغن و بالم پاک کننده', 'cleaning-oil-balm', 1
FROM categories
WHERE slug = 'face-cleanser'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شامپو ضدشوره', 'anti-dandruff-shampoo', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شامپو ضدریزش', 'anti-hair-loss-shampoo', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شامپو موهای رنگ شده', 'colored-hair-shampoo', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شامپو موهای فر', 'curly-hair-shampoo', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شامپو موهای آسیب دیده', 'damaged-hair-shampoo', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شامپو موهای خشک', 'dry-hair-shampoo', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شامپو خشک', 'dry-shampoo', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'مراقبت از مو', 'hair-care', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'نرم کننده مو', 'hair-conditioner', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'کرم مو', 'hair-cream', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'ماسک مو', 'hair-mask', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شیر مو', 'hair-milk', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'میست مو', 'hair-mist', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'روغن مو', 'hair-oil', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'سرم مو', 'hair-serum', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شامپو کراتین', 'keratin-shampoo', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شامپو انواع مو', 'shampoo-all-hair-types', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'شامپو بدون سولفات', 'sulfate-free-shampoo', 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'بالم و مرطوب کننده لب', 'lip-balm-moisturizer', 1
FROM categories
WHERE slug = 'lip-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO categories (parent_id, name, slug, is_active)
SELECT id, 'ماسک و اسکراب لب', 'lip-mask-scrub', 1
FROM categories
WHERE slug = 'lip-care'
ON DUPLICATE KEY UPDATE
    parent_id = VALUES(parent_id),
    name = VALUES(name),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کره مرطوب کننده بدن', 'body-butter-ee2cd5f92d', 'بافت غنی برای حفظ رطوبت و نرمی پوست بدن.', NULL, 'تماس بگیرید', '🧈', 0, 1
FROM categories
WHERE slug = 'body-butter'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کره مغذی بدن', 'body-butter-5471bf5459', 'محصول مراقبتی با بافت غنی برای پوست بدن.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'body-butter'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کره آبرسان بدن', 'body-butter-d0d1e22eb3', 'مناسب برای مراقبت روزانه و نرم نگه داشتن پوست.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'body-butter'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'روغن بدن', 'body-care-4cd4a2b93e', 'محصول مراقبتی برای نرمی و رطوبت پوست بدن.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ضدآفتاب بدن', 'body-care-8262ffa6b9', 'محصولات محافظت از پوست بدن در برابر نور خورشید.', NULL, 'تماس بگیرید', '☀️', 0, 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم بدن', 'body-care-ace744d1e8', 'کرم‌های مراقبتی برای نرمی و آبرسانی پوست بدن.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کره بدن', 'body-care-04674dbdb3', 'بافت غنی برای مراقبت و نرم کردن پوست بدن.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'مراقبت روزانه بدن', 'body-care-b1d5bc956e', 'محصولات مناسب برای تکمیل روتین مراقبت بدن.', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'body-care'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم مرطوب کننده بدن', 'body-cream-2d4956f8f3', 'کرم روزانه برای حفظ رطوبت و نرمی پوست بدن.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'body-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم مغذی بدن', 'body-cream-439a80874c', 'بافت مغذی برای مراقبت و نرم کردن پوست بدن.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'body-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم آبرسان بدن', 'body-cream-4c50cde3e9', 'مناسب برای مراقبت روزانه و حفظ رطوبت پوست.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'body-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لوسیون مرطوب‌کننده بدن', 'body-lotion-0321ef2864', 'مناسب مراقبت روزانه و کمک به حفظ لطافت پوست بدن.', NULL, 'تماس بگیرید', 'پرفروش ♡ 🧴 BODY LOTION', 0, 1
FROM categories
WHERE slug = 'body-lotion'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لوسیون آبرسان بدن', 'body-lotion-457c62864f', 'بافت سبک برای استفاده روزانه و ایجاد حس نرمی پوست.', NULL, 'تماس بگیرید', '♡ 🧴 HYDRATING', 0, 1
FROM categories
WHERE slug = 'body-lotion'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لوسیون سبک بدن برای استفاده روزانه', 'body-lotion-530d4b9828', 'انتخابی مناسب برای روتین روزانه مراقبت از بدن.', NULL, 'تماس بگیرید', 'جدید ♡ 🧴 DAILY CARE', 0, 1
FROM categories
WHERE slug = 'body-lotion'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لوسیون ترمیم‌کننده بدن', 'body-lotion-2136dd0ae9', 'مناسب مراقبت از پوست و کمک به حفظ نرمی آن.', NULL, 'تماس بگیرید', '♡ 🧴 REPAIR', 0, 1
FROM categories
WHERE slug = 'body-lotion'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لوسیون بدن مناسب پوست حساس', 'body-lotion-5b76bb67bf', 'بافت لطیف برای روتین مراقبت از پوست حساس.', NULL, 'تماس بگیرید', '♡ 🧴 SENSITIVE', 0, 1
FROM categories
WHERE slug = 'body-lotion'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لوسیون مغذی بدن', 'body-lotion-d76b5e7723', 'مناسب استفاده روزانه برای مراقبت و نرم نگه داشتن پوست.', NULL, 'تماس بگیرید', '♡ 🧴 NOURISH', 0, 1
FROM categories
WHERE slug = 'body-lotion'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لوسیون نرم‌کننده بدن', 'body-lotion-fccd638dd8', 'محصولی برای تکمیل روتین مراقبت روزانه بدن.', NULL, 'تماس بگیرید', 'محبوب ♡ 🧴 SOFT SKIN', 0, 1
FROM categories
WHERE slug = 'body-lotion'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لوسیون مرطوب‌کننده قوی بدن', 'body-lotion-32ab9852a0', 'انتخابی برای روتین مراقبت و تأمین رطوبت پوست بدن.', NULL, 'تماس بگیرید', '♡ 🧴 ULTRA MOISTURE', 0, 1
FROM categories
WHERE slug = 'body-lotion'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'اسکراب بدن با بافت ملایم', 'body-mask-scrub-3eeaffd41a', 'مناسب پاکسازی و تکمیل روتین مراقبت از پوست بدن.', NULL, 'تماس بگیرید', 'پرفروش ♡ 🫙 BODY SCRUB', 0, 1
FROM categories
WHERE slug = 'body-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'اسکراب بدن با رایحه قهوه', 'body-mask-scrub-5fa0986779', 'انتخابی برای روتین پاکسازی و مراقبت هفتگی بدن.', NULL, 'تماس بگیرید', '♡ ☕ COFFEE SCRUB', 0, 1
FROM categories
WHERE slug = 'body-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ماسک بدن برای مراقبت و نرمی پوست', 'body-mask-scrub-9840ed013b', 'محصولی مناسب برای تکمیل روتین مراقبت از بدن.', NULL, 'تماس بگیرید', 'جدید ♡ 🫙 BODY MASK', 0, 1
FROM categories
WHERE slug = 'body-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'اسکراب نرم‌کننده بدن', 'body-mask-scrub-23101e84ce', 'مناسب استفاده هفتگی در روتین مراقبت از بدن.', NULL, 'تماس بگیرید', '♡ 🫙 SMOOTH SKIN', 0, 1
FROM categories
WHERE slug = 'body-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'اسکراب پاک‌کننده بدن', 'body-mask-scrub-95726668f5', 'مناسب برای پاکسازی و مراقبت از سطح پوست بدن.', NULL, 'تماس بگیرید', '♡ 🧼 DEEP CLEAN', 0, 1
FROM categories
WHERE slug = 'body-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ماسک آبرسان بدن', 'body-mask-scrub-15791761a4', 'انتخابی برای روتین مراقبت و حفظ لطافت پوست.', NULL, 'تماس بگیرید', '♡ 💧 HYDRATE MASK', 0, 1
FROM categories
WHERE slug = 'body-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لایه‌بردار بدن', 'body-mask-scrub-3f86ceb53e', 'مناسب تکمیل روتین مراقبت و پاکسازی پوست بدن.', NULL, 'تماس بگیرید', 'محبوب ♡ 🫙 BODY POLISH', 0, 1
FROM categories
WHERE slug = 'body-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'اسکراب بدن برای مراقبت روزانه', 'body-mask-scrub-67a1bb6709', 'محصولی برای تکمیل روتین مراقبت و پاکسازی بدن.', NULL, 'تماس بگیرید', '♡ 🫙 CARE SCRUB', 0, 1
FROM categories
WHERE slug = 'body-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'روغن بدن مرطوب کننده', 'body-oil-98ad72d58d', 'روغن مراقبتی برای نرم و مرطوب نگه داشتن پوست بدن.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'body-oil'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'روغن خشک بدن', 'body-oil-945a285e5e', 'بافت سبک برای مراقبت روزانه از پوست بدن.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'body-oil'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'روغن مراقبتی بدن', 'body-oil-bfb77d6da9', 'مناسب برای تکمیل روتین مراقبت و نرمی پوست.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'body-oil'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم مراقبت ضد ترک بدن', 'body-stretch-mark-3ef3c85528', 'مناسب برای مراقبت و آبرسانی پوست بدن.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'body-stretch-mark'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'روغن مراقبت ضد ترک', 'body-stretch-mark-b58e5c6240', 'روغن بدن برای مراقبت و حفظ رطوبت پوست.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'body-stretch-mark'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لوسیون مراقبت ضد ترک بدن', 'body-stretch-mark-3896dffb4e', 'بافت مناسب برای استفاده روزانه روی پوست بدن.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'body-stretch-mark'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'لوسیون ضدآفتاب بدن SPF 50', 'body-sunscreen-83afa6f064', 'محافظت روزانه از پوست بدن در برابر نور خورشید.', NULL, 'تماس بگیرید', '☀️', 0, 1
FROM categories
WHERE slug = 'body-sunscreen'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شیر ضدآفتاب بدن', 'body-sunscreen-7c8c37a53e', 'بافت سبک برای استفاده راحت در روتین مراقبت بدن.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'body-sunscreen'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'اسپری ضدآفتاب بدن SPF 50+', 'body-sunscreen-21e967354e', 'فرم اسپری برای استفاده سریع و آسان روی بدن.', NULL, 'تماس بگیرید', '🌤️', 0, 1
FROM categories
WHERE slug = 'body-sunscreen'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'مکمل مراقبت بدن', 'body-supplements-ebab0383cc', 'مکمل مناسب برای قرار گرفتن در روتین روزانه.', NULL, 'تماس بگیرید', '💊', 0, 1
FROM categories
WHERE slug = 'body-supplements'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'مکمل روزانه بدن', 'body-supplements-1d3df83e11', 'محصولی برای تکمیل روتین مراقبت از بدن.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'body-supplements'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'مکمل مراقبتی', 'body-supplements-f222d08ec3', 'مناسب برای استفاده در برنامه مراقبت روزانه.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'body-supplements'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شوینده بدن روزانه', 'body-wash-3e616e2384', 'شوینده ملایم برای استفاده روزانه.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'body-wash'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل کرم آبرسان بدن', 'gel-cream-08c0bc4d06', 'بافت سبک برای رطوبت‌رسانی و مراقبت روزانه از پوست بدن.', NULL, 'تماس بگیرید', 'پرفروش ♡ 🧴 GEL CREAM', 0, 1
FROM categories
WHERE slug = 'gel-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل کرم مرطوب‌کننده', 'gel-cream-35a6ef6a09', 'مناسب روتین روزانه و ایجاد حس نرمی و رطوبت روی پوست.', NULL, 'تماس بگیرید', '♡ 💧 HYDRATING GEL', 0, 1
FROM categories
WHERE slug = 'gel-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل کرم سبک بدن', 'gel-cream-ac494e67ed', 'بافت سبک و مناسب برای استفاده در روتین روزانه.', NULL, 'تماس بگیرید', 'جدید ♡ 🫧 LIGHT TEXTURE', 0, 1
FROM categories
WHERE slug = 'gel-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل کرم خنک‌کننده بدن', 'gel-cream-448da7f363', 'انتخابی سبک برای ایجاد حس تازگی در روتین مراقبت بدن.', NULL, 'تماس بگیرید', '♡ 💧 FRESH MOISTURE', 0, 1
FROM categories
WHERE slug = 'gel-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل کرم روزانه بدن', 'gel-cream-1a572b8623', 'مناسب استفاده روزانه برای تکمیل روتین مراقبتی بدن.', NULL, 'تماس بگیرید', '♡ 🧴 DAILY HYDRATION', 0, 1
FROM categories
WHERE slug = 'gel-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل کرم آرامش‌بخش پوست', 'gel-cream-52010a90ac', 'بافت سبک برای استفاده در روتین مراقبت و لطافت پوست.', NULL, 'تماس بگیرید', '♡ 🌿 SOOTHING GEL', 0, 1
FROM categories
WHERE slug = 'gel-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل کرم آبرسان قوی', 'gel-cream-10a68f8c8d', 'انتخابی برای روتین مراقبتی پوست‌هایی که به رطوبت نیاز دارند.', NULL, 'تماس بگیرید', 'محبوب ♡ 💧 INTENSE HYDRATION', 0, 1
FROM categories
WHERE slug = 'gel-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ژل کرم نرم‌کننده بدن', 'gel-cream-5b97d2f43e', 'مناسب استفاده روزانه برای داشتن پوستی نرم و لطیف.', NULL, 'تماس بگیرید', '♡ 🧴 BODY GEL CREAM', 0, 1
FROM categories
WHERE slug = 'gel-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم مرطوب‌کننده دست', 'hand-foot-cream-b2510e622c', 'مناسب استفاده روزانه برای حفظ نرمی و لطافت پوست دست.', NULL, 'تماس بگیرید', 'پرفروش ♡ 🧴 HAND CREAM', 0, 1
FROM categories
WHERE slug = 'hand-foot-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم نرم‌کننده پا', 'hand-foot-cream-98d68b9062', 'انتخابی برای مراقبت روزانه و نرم نگه داشتن پوست پا.', NULL, 'تماس بگیرید', '♡ 🧴 FOOT CREAM', 0, 1
FROM categories
WHERE slug = 'hand-foot-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم ترمیم‌کننده دست و پا', 'hand-foot-cream-b84b9f57a1', 'مناسب تکمیل روتین مراقبتی برای پوست خشک و آسیب‌پذیر.', NULL, 'تماس بگیرید', 'جدید ♡ 🧴 REPAIR CARE', 0, 1
FROM categories
WHERE slug = 'hand-foot-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم آبرسان دست', 'hand-foot-cream-d35265cd5f', 'بافت مناسب برای استفاده روزانه و مراقبت از پوست دست.', NULL, 'تماس بگیرید', '♡ 🧴 MOISTURE', 0, 1
FROM categories
WHERE slug = 'hand-foot-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم مراقبت از پاشنه پا', 'hand-foot-cream-e0a2cfb0fc', 'مناسب استفاده در روتین مراقبت از پوست پا و پاشنه.', NULL, 'تماس بگیرید', '♡ 🧴 HEEL CARE', 0, 1
FROM categories
WHERE slug = 'hand-foot-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم نرم‌کننده دست', 'hand-foot-cream-0f69f0c8ec', 'محصولی مناسب برای روتین روزانه مراقبت از دست‌ها.', NULL, 'تماس بگیرید', '♡ 🧴 SOFT HANDS', 0, 1
FROM categories
WHERE slug = 'hand-foot-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم مراقبت عمیق دست و پا', 'hand-foot-cream-740fdf2080', 'مناسب روتین مراقبتی پوست خشک و نیازمند رطوبت بیشتر.', NULL, 'تماس بگیرید', 'محبوب ♡ 🧴 INTENSIVE CARE', 0, 1
FROM categories
WHERE slug = 'hand-foot-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم روزانه دست و پا', 'hand-foot-cream-c138f5dab9', 'انتخابی ساده برای مراقبت روزانه از پوست دست و پا.', NULL, 'تماس بگیرید', '♡ 🧴 DAILY CARE', 0, 1
FROM categories
WHERE slug = 'hand-foot-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو ضدشوره روزانه', 'anti-dandruff-shampoo-9b5708a5c0', 'پاکسازی پوست سر و مراقبت از مو در روتین روزانه.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'anti-dandruff-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو مراقبت از پوست سر', 'anti-dandruff-shampoo-9ea8a6e208', 'مناسب روتین پاکسازی و مراقبت از پوست سر.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'anti-dandruff-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو ضدریزش مو', 'anti-hair-loss-shampoo-eb3da1aa41', 'مناسب روتین مراقبت از موهای ضعیف و شکننده.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'anti-hair-loss-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو تقویت کننده مو', 'anti-hair-loss-shampoo-294d9bca9d', 'برای مراقبت روزانه و کمک به حفظ ظاهر سالم مو.', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'anti-hair-loss-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو مراقبت از مو و پوست سر', 'anti-hair-loss-shampoo-ee922bf034', 'پاکسازی و مراقبت از مو و پوست سر در روتین روزانه.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'anti-hair-loss-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو محافظ رنگ مو', 'colored-hair-shampoo-cc5bb85b62', 'مناسب روتین شست‌وشو و مراقبت از موهای رنگ‌شده.', NULL, 'تماس بگیرید', '🎨', 0, 1
FROM categories
WHERE slug = 'colored-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو درخشان کننده موهای رنگ شده', 'colored-hair-shampoo-49b50ab1d0', 'کمک به حفظ ظاهر براق و مرتب موهای رنگ‌شده.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'colored-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو مراقبت از موهای رنگ شده', 'colored-hair-shampoo-36ebc79dc0', 'پاکسازی ملایم و مناسب روتین مراقبت از موهای رنگ‌شده.', NULL, 'تماس بگیرید', '🌸', 0, 1
FROM categories
WHERE slug = 'colored-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو موهای فر', 'curly-hair-shampoo-175d687a3a', 'مناسب پاکسازی و مراقبت روزانه از موهای فر و موج‌دار.', NULL, 'تماس بگیرید', '🌀', 0, 1
FROM categories
WHERE slug = 'curly-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو آبرسان موهای فر', 'curly-hair-shampoo-daf01a291e', 'کمک به حفظ رطوبت و نرمی موهای فر و خشک.', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'curly-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو ضد وز موهای فر', 'curly-hair-shampoo-b10d0f25b7', 'مناسب روتین مراقبت از موهای فر و مستعد وز شدن.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'curly-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو ترمیم کننده مو', 'damaged-hair-shampoo-e7baf6fa7c', 'مناسب روتین مراقبت از موهای خشک و آسیب‌دیده.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'damaged-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو بازسازی مو', 'damaged-hair-shampoo-f3b3b5e6af', 'برای مراقبت از موهای ضعیف و آسیب‌دیده در روتین روزانه.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'damaged-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو تغذیه کننده مو', 'damaged-hair-shampoo-96f39fc0c4', 'کمک به حفظ نرمی و ظاهر سالم موهای آسیب‌دیده.', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'damaged-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو موهای خشک', 'dry-hair-shampoo-19749cb33a', 'پاکسازی و مراقبت روزانه از موهای خشک و کم‌آب.', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'dry-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو تغذیه‌کننده موهای خشک', 'dry-hair-shampoo-ce370a69f9', 'مناسب روتین مراقبتی موهای خشک و نیازمند تغذیه.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'dry-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو آبرسان موهای خشک', 'dry-hair-shampoo-87517b0719', 'کمک به حفظ نرمی و لطافت مو در روتین مراقبت از مو.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'dry-hair-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو خشک روزانه', 'dry-shampoo-c7c0330a91', 'کمک به تازه‌تر شدن ظاهر مو و جذب چربی اضافه.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'dry-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو خشک حجم دهنده', 'dry-shampoo-2d3ade7989', 'کمک به ایجاد ظاهر پرحجم‌تر و تازه‌تر برای مو.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'dry-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو خشک بدون سفیدک', 'dry-shampoo-d59c302ac5', 'مناسب برای تازه کردن ظاهر مو بدون ایجاد ظاهر سفید روی مو.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'dry-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'محصولات مراقبت روزانه مو', 'hair-care-e5adfeb367', 'مناسب روتین روزانه برای مراقبت و حفظ نرمی مو.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'hair-care'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'محصولات تغذیه و تقویت مو', 'hair-care-27d823ec33', 'برای مراقبت از موهای خشک، ضعیف و آسیب‌دیده.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'hair-care'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'محصولات ترمیم و نرمی مو', 'hair-care-79c2801186', 'کمک به حفظ ظاهر مرتب، نرم و سالم مو.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'hair-care'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'نرم کننده آبرسان مو', 'hair-conditioner-ee19d12133', 'مناسب موهای خشک برای کمک به نرمی و حفظ رطوبت.', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'hair-conditioner'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'نرم کننده ترمیم کننده مو', 'hair-conditioner-8c14765a12', 'مناسب مراقبت از موهای خشک و آسیب‌دیده.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'hair-conditioner'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'نرم کننده موهای رنگ شده', 'hair-conditioner-4fb54c3f03', 'مناسب مراقبت روزانه و افزایش نرمی موهای رنگ‌شده.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'hair-conditioner'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم آبرسان مو', 'hair-cream-1846517efa', 'مناسب موهای خشک برای کمک به نرمی و حفظ رطوبت.', NULL, 'تماس بگیرید', '🥥', 0, 1
FROM categories
WHERE slug = 'hair-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم ضد وز مو', 'hair-cream-8e7fbc71df', 'کمک به کنترل وز و ایجاد ظاهر صاف و مرتب مو.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'hair-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'کرم ترمیم کننده مو', 'hair-cream-cc86ffdce8', 'مناسب مراقبت از موهای خشک و آسیب‌دیده.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'hair-cream'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ماسک آبرسان مو', 'hair-mask-b7c910d7e7', 'کمک به حفظ رطوبت و نرمی موهای خشک و کم‌آب.', NULL, 'تماس بگیرید', '🥑', 0, 1
FROM categories
WHERE slug = 'hair-mask'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ماسک ترمیم کننده مو', 'hair-mask-0d2d4ab318', 'مناسب مراقبت از موهای آسیب‌دیده و ضعیف.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'hair-mask'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ماسک تغذیه کننده مو', 'hair-mask-f5575eda7f', 'برای افزایش نرمی و مراقبت از ظاهر مو.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'hair-mask'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شیر آبرسان مو', 'hair-milk-5d4c0341ab', 'مناسب موهای خشک برای کمک به نرمی و حفظ رطوبت.', NULL, 'تماس بگیرید', '🥛', 0, 1
FROM categories
WHERE slug = 'hair-milk'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شیر تغذیه کننده مو', 'hair-milk-31293d2b37', 'کمک به مراقبت و افزایش نرمی موهای خشک و ضعیف.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'hair-milk'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شیر ضد وز مو', 'hair-milk-c758d97a5c', 'کمک به کنترل وز و ایجاد ظاهر مرتب‌تر و نرم‌تر.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'hair-milk'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'میست آبرسان مو', 'hair-mist-b3db2d5df9', 'مناسب برای ایجاد حس طراوت و کمک به حفظ رطوبت مو.', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'hair-mist'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'میست معطر مو', 'hair-mist-0a1b7c9682', 'برای تازه کردن مو و ایجاد رایحه‌ای لطیف و دلپذیر.', NULL, 'تماس بگیرید', '🌸', 0, 1
FROM categories
WHERE slug = 'hair-mist'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'میست تازه کننده مو', 'hair-mist-5fa7731752', 'کمک به تازه شدن ظاهر مو و ایجاد حس سبکی و طراوت.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'hair-mist'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'روغن آرگان مو', 'hair-oil-ff0749aa13', 'مناسب مراقبت از موهای خشک و افزایش نرمی و درخشندگی.', NULL, 'تماس بگیرید', '🥥', 0, 1
FROM categories
WHERE slug = 'hair-oil'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'روغن ترمیم کننده مو', 'hair-oil-b5e6a4819f', 'برای مراقبت از ساقه موهای خشک و آسیب‌دیده.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'hair-oil'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'روغن براق کننده مو', 'hair-oil-6ba6252dc6', 'کمک به افزایش نرمی و ظاهر براق و مرتب مو.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'hair-oil'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو مو', 'hair-products-3f2e643f51', 'انواع شامپو برای مراقبت و پاکسازی مو.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'مراقبت مو', 'hair-products-fa6c7a2c9e', 'محصولات مراقبتی برای حفظ سلامت و لطافت مو.', NULL, 'تماس بگیرید', '🫧', 0, 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ماسک مو', 'hair-products-47d15c0f49', 'محصولات مراقبتی برای تغذیه و مراقبت از مو.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'hair-products'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'سرم آبرسان مو', 'hair-serum-f3980c2682', 'مناسب موهای خشک برای کمک به نرمی و حفظ رطوبت مو.', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'hair-serum'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'سرم ضد وز مو', 'hair-serum-b5b10a655e', 'کمک به کنترل وز و ایجاد ظاهر صاف و مرتب‌تر.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'hair-serum'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'سرم ترمیم کننده مو', 'hair-serum-f7bda0d194', 'مناسب مراقبت از موهای خشک، ضعیف و آسیب‌دیده.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'hair-serum'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو کراتین مو', 'keratin-shampoo-d20a202051', 'مناسب روتین مراقبت از موهای خشک و آسیب‌دیده.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'keratin-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو کراتین و آرگان', 'keratin-shampoo-b21c1a3c18', 'برای مراقبت و نرمی بیشتر موهای خشک و آسیب‌پذیر.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'keratin-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو صاف‌کننده کراتین', 'keratin-shampoo-a5911900b1', 'مناسب مراقبت از مو و کمک به حفظ نرمی و ظاهر مرتب آن.', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'keratin-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو مناسب انواع مو', 'shampoo-all-hair-types-922fca51fe', 'پاکسازی ملایم و مناسب روتین روزانه انواع مو.', NULL, 'تماس بگیرید', '🧴', 0, 1
FROM categories
WHERE slug = 'shampoo-all-hair-types'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو روزانه مو', 'shampoo-all-hair-types-cb1d25df07', 'گزینه‌ای مناسب برای پاکسازی و مراقبت روزمره مو.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'shampoo-all-hair-types'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو مراقبت مو', 'shampoo-all-hair-types-19f28fde14', 'برای پاکسازی مو و حفظ ظاهر نرم و تمیز آن.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'shampoo-all-hair-types'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو بدون سولفات', 'sulfate-free-shampoo-f563ad0f99', 'پاکسازی ملایم و مناسب روتین مراقبت از انواع مو.', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'sulfate-free-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو بدون سولفات آبرسان', 'sulfate-free-shampoo-142234a9a6', 'مناسب موهای خشک و نیازمند مراقبت و رطوبت بیشتر.', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'sulfate-free-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'شامپو بدون سولفات موهای رنگ‌شده', 'sulfate-free-shampoo-23ce492b1c', 'پاکسازی ملایم برای روتین مراقبت از موهای رنگ‌شده.', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'sulfate-free-shampoo'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'بالم آبرسان لب', 'lip-balm-moisturizer-8b38dc06be', 'کمک به حفظ رطوبت و نرمی لب‌ها', NULL, 'تماس بگیرید', '💧', 0, 1
FROM categories
WHERE slug = 'lip-balm-moisturizer'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'مرطوب کننده لب', 'lip-balm-moisturizer-9f35f94b83', 'مناسب استفاده روزانه برای لب‌های خشک', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'lip-balm-moisturizer'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'بالم نرم کننده لب', 'lip-balm-moisturizer-4e97525727', 'کمک به حفظ لطافت و نرمی لب‌ها', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'lip-balm-moisturizer'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ماسک آبرسان لب', 'lip-mask-scrub-61e74f6da6', 'کمک به حفظ رطوبت و لطافت لب‌ها', NULL, 'تماس بگیرید', '🌙', 0, 1
FROM categories
WHERE slug = 'lip-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'اسکراب لب', 'lip-mask-scrub-95b6d85ea6', 'لایه‌برداری ملایم برای مراقبت از لب‌ها', NULL, 'تماس بگیرید', '✨', 0, 1
FROM categories
WHERE slug = 'lip-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);

INSERT INTO products (category_id, name, slug, description, price_amount, price_label, image, stock, is_active)
SELECT id, 'ماسک و اسکراب لب', 'lip-mask-scrub-95c2634de8', 'مراقبت کامل‌تر برای لب‌های خشک و نیازمند مراقبت', NULL, 'تماس بگیرید', '🌿', 0, 1
FROM categories
WHERE slug = 'lip-mask-scrub'
ON DUPLICATE KEY UPDATE
    category_id = VALUES(category_id),
    name = VALUES(name),
    description = VALUES(description),
    price_amount = VALUES(price_amount),
    price_label = VALUES(price_label),
    image = VALUES(image),
    is_active = VALUES(is_active);
