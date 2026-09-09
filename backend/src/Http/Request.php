<?php

declare(strict_types=1);

namespace App\Http;

use RuntimeException;

final class Request
{
    public static function json(int $maxBytes = 65536): array
    {
        $contentType = isset($_SERVER['CONTENT_TYPE']) ? strtolower((string) $_SERVER['CONTENT_TYPE']) : '';

        if (strpos($contentType, 'application/json') === false) {
            throw new RuntimeException('CONTENT_TYPE');
        }

        $raw = file_get_contents('php://input');

        if ($raw === false || trim($raw) === '') {
            return [];
        }

        if (strlen($raw) > $maxBytes) {
            throw new RuntimeException('PAYLOAD_TOO_LARGE');
        }

        $data = json_decode($raw, true);

        if (!is_array($data) || json_last_error() !== JSON_ERROR_NONE) {
            throw new RuntimeException('INVALID_JSON');
        }

        return $data;
    }

    public static function header(string $name): ?string
    {
        $key = 'HTTP_' . strtoupper(str_replace('-', '_', $name));

        if (!isset($_SERVER[$key])) {
            return null;
        }

        return trim((string) $_SERVER[$key]);
    }
}
