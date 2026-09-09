<?php

declare(strict_types=1);

namespace App\Service;

final class SessionCart
{
    private const SESSION_KEY = 'cart_items';
    private const MAX_QUANTITY = 99;

    public static function items(): array
    {
        $items = $_SESSION[self::SESSION_KEY] ?? [];

        return is_array($items) ? $items : [];
    }

    public static function add(int $productId, int $quantity): void
    {
        $items = self::items();
        $current = isset($items[$productId]) ? (int) $items[$productId] : 0;
        $items[$productId] = min(self::MAX_QUANTITY, $current + $quantity);
        $_SESSION[self::SESSION_KEY] = $items;
    }

    public static function set(int $productId, int $quantity): void
    {
        $items = self::items();

        if ($quantity <= 0) {
            unset($items[$productId]);
        } else {
            $items[$productId] = min(self::MAX_QUANTITY, $quantity);
        }

        $_SESSION[self::SESSION_KEY] = $items;
    }

    public static function remove(int $productId): void
    {
        $items = self::items();
        unset($items[$productId]);
        $_SESSION[self::SESSION_KEY] = $items;
    }

    public static function clear(): void
    {
        $_SESSION[self::SESSION_KEY] = [];
    }
}
