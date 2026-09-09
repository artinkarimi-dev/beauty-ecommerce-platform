<?php

declare(strict_types=1);

namespace App\Http;

final class Validator
{
    public static function string($value, string $field, int $min, int $max, bool $required = true): string
    {
        if (is_array($value) || is_object($value)) {
            throw new HttpException(422, 'VALIDATION_ERROR', $field . ' is invalid.');
        }

        $text = self::normalizeText($value);
        $length = self::length($text);

        if (($required && $length < $min) || (!$required && $length > 0 && $length < $min) || $length > $max) {
            throw new HttpException(422, 'VALIDATION_ERROR', $field . ' is invalid.');
        }

        return $text;
    }

    public static function optionalString($value, string $field, int $max): ?string
    {
        $text = self::string($value ?? '', $field, 0, $max, false);

        return $text === '' ? null : $text;
    }

    public static function int($value, string $field, int $min, int $max): int
    {
        if (is_array($value) || is_object($value)) {
            throw new HttpException(422, 'VALIDATION_ERROR', $field . ' is invalid.');
        }

        $integer = filter_var($value, FILTER_VALIDATE_INT, [
            'options' => [
                'min_range' => $min,
                'max_range' => $max,
            ],
        ]);

        if ($integer === false) {
            throw new HttpException(422, 'VALIDATION_ERROR', $field . ' is invalid.');
        }

        return (int) $integer;
    }

    public static function slug($value, string $field, bool $required = true): ?string
    {
        if (is_array($value) || is_object($value)) {
            throw new HttpException(422, 'VALIDATION_ERROR', $field . ' is invalid.');
        }

        $slug = trim((string) ($value ?? ''));

        if ($slug === '') {
            if (!$required) {
                return null;
            }

            throw new HttpException(422, 'VALIDATION_ERROR', $field . ' is invalid.');
        }

        if (preg_match('/\A[a-z0-9][a-z0-9-]{0,199}\z/', $slug) !== 1) {
            throw new HttpException(422, 'VALIDATION_ERROR', $field . ' is invalid.');
        }

        return $slug;
    }

    public static function page($value, string $field, int $default, int $min, int $max): int
    {
        return self::int($value ?? (string) $default, $field, $min, $max);
    }

    public static function oneOf(string $value, array $allowed, string $field): string
    {
        if (!in_array($value, $allowed, true)) {
            throw new HttpException(422, 'VALIDATION_ERROR', $field . ' is invalid.');
        }

        return $value;
    }

    public static function phone($value): string
    {
        $phone = self::normalizePhone(self::string($value, 'phone', 10, 30));

        if (preg_match('/\A\+?[0-9]{10,15}\z/', $phone) !== 1) {
            throw new HttpException(422, 'VALIDATION_ERROR', 'Phone number is invalid.');
        }

        return $phone;
    }

    public static function trackingCode($value): string
    {
        $trackingCode = strtoupper(self::string($value, 'tracking_code', 10, 10));

        if (preg_match('/\A[A-F0-9]{10}\z/', $trackingCode) !== 1) {
            throw new HttpException(422, 'VALIDATION_ERROR', 'Tracking code is invalid.');
        }

        return $trackingCode;
    }

    public static function searchQuery($value): string
    {
        $query = self::string($value, 'q', 2, 80);

        if (preg_match('/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/u', $query) === 1) {
            throw new HttpException(422, 'VALIDATION_ERROR', 'Search query is invalid.');
        }

        return $query;
    }

    private static function normalizeText($value): string
    {
        $text = trim((string) ($value ?? ''));
        $text = preg_replace('/[ \t\r\n]+/u', ' ', $text);

        return $text === null ? '' : $text;
    }

    private static function normalizePhone(string $phone): string
    {
        $persian = ['۰','۱','۲','۳','۴','۵','۶','۷','۸','۹'];
        $arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
        $latin = ['0','1','2','3','4','5','6','7','8','9'];
        $phone = str_replace($persian, $latin, $phone);
        $phone = str_replace($arabic, $latin, $phone);

        return preg_replace('/[\s()\-]/', '', $phone) ?? $phone;
    }

    private static function length(string $text): int
    {
        return function_exists('mb_strlen') ? mb_strlen($text) : strlen($text);
    }
}
