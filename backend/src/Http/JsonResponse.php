<?php

declare(strict_types=1);

namespace App\Http;

final class JsonResponse
{
    public static function success($data, int $statusCode = 200): void
    {
        self::send([
            'success' => true,
            'data' => $data,
        ], $statusCode);
    }

    public static function error(string $code, string $message, int $statusCode): void
    {
        self::send([
            'success' => false,
            'error' => [
                'code' => $code,
                'message' => $message,
            ],
        ], $statusCode);
    }

    private static function send(array $payload, int $statusCode): void
    {
        $reasonPhrases = [
            200 => 'OK',
            201 => 'Created',
            400 => 'Bad Request',
            401 => 'Unauthorized',
            403 => 'Forbidden',
            404 => 'Not Found',
            405 => 'Method Not Allowed',
            409 => 'Conflict',
            413 => 'Payload Too Large',
            415 => 'Unsupported Media Type',
            422 => 'Unprocessable Entity',
            429 => 'Too Many Requests',
            500 => 'Internal Server Error',
        ];

        http_response_code($statusCode);
        header(sprintf(
            'HTTP/1.1 %d %s',
            $statusCode,
            $reasonPhrases[$statusCode] ?? 'Status'
        ));
        header_remove('X-Powered-By');
        header('Content-Type: application/json; charset=utf-8');
        header('X-Content-Type-Options: nosniff');

        $json = json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

        if ($json === false) {
            http_response_code(500);
            header('HTTP/1.1 500 Internal Server Error');
            $json = '{"success":false,"error":{"code":"SERVER_ERROR","message":"Response could not be encoded."}}';
        }

        echo $json;
    }
}
