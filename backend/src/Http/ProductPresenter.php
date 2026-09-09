<?php

declare(strict_types=1);

namespace App\Http;

final class ProductPresenter
{
    public static function one(array $product): array
    {
        $priceAmount = $product['price_amount'] === null ? null : (int) $product['price_amount'];
        $priceLabel = isset($product['price_label']) && $product['price_label'] !== null && $product['price_label'] !== ''
            ? $product['price_label']
            : ($priceAmount === null ? 'تماس بگیرید' : number_format($priceAmount) . ' تومان');

        return [
            'id' => (int) $product['id'],
            'name' => $product['name'],
            'slug' => $product['slug'],
            'description' => $product['description'],
            'price_amount' => $priceAmount,
            'price_label' => $priceLabel,
            'image' => $product['image'],
            'stock' => (int) $product['stock'],
            'category' => [
                'name' => $product['category_name'],
                'slug' => $product['category_slug'],
            ],
        ];
    }

    public static function many(array $products): array
    {
        return array_map([self::class, 'one'], $products);
    }
}
