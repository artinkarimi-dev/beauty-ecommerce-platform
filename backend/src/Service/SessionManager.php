<?php

declare(strict_types=1);

namespace App\Service;

final class SessionManager
{
    public static function start(string $name, ?string $savePath = null): void
    {
        if (session_status() === PHP_SESSION_ACTIVE) {
            return;
        }

        if ($savePath !== null && $savePath !== '') {
            if (!is_dir($savePath)) {
                mkdir($savePath, 0775, true);
            }

            if (is_dir($savePath) && is_writable($savePath)) {
                session_save_path($savePath);
            }
        }

        session_name($name);
        session_set_cookie_params([
            'lifetime' => 0,
            'path' => '/',
            'secure' => self::isHttps(),
            'httponly' => true,
            'samesite' => 'Lax',
        ]);
        session_start();
    }

    private static function isHttps(): bool
    {
        if (!empty($_SERVER['HTTPS']) && strtolower((string) $_SERVER['HTTPS']) !== 'off') {
            return true;
        }

        return isset($_SERVER['HTTP_X_FORWARDED_PROTO'])
            && strtolower((string) $_SERVER['HTTP_X_FORWARDED_PROTO']) === 'https';
    }
}
