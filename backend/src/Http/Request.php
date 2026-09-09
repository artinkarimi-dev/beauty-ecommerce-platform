<?php

declare(strict_types=1);

namespace App\Http;

final class Request
{
    public static function json(int $maxBytes = 65536): array
    {
        $contentType = isset($_SERVER['CONTENT_TYPE']) ? strtolower((string) $_SERVER['CONTENT_TYPE']) : '';

        if (strpos($contentType, 'application/json') === false) {
            throw new HttpException(415, 'UNSUPPORTED_CONTENT_TYPE', 'Content-Type must be application/json.');
        }

        $raw = file_get_contents('php://input');

        if ($raw === false) {
            throw new HttpException(400, 'INVALID_JSON', 'Request body could not be read.');
        }

        if (strlen($raw) > $maxBytes) {
            throw new HttpException(413, 'PAYLOAD_TOO_LARGE', 'Request body is too large.');
        }

        if (trim($raw) === '') {
            return [];
        }

        $data = json_decode($raw, true);

        if (!is_array($data) || json_last_error() !== JSON_ERROR_NONE) {
            throw new HttpException(400, 'INVALID_JSON', 'Request body contains invalid JSON.');
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
