<?php

declare(strict_types=1);

namespace App\Service;

final class SessionManager
{
    private const INIT_KEY = '_session_initialized';

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

        ini_set('session.use_strict_mode', '1');
        ini_set('session.use_only_cookies', '1');
        ini_set('session.cookie_httponly', '1');
        ini_set('session.cookie_samesite', 'Lax');

        session_name($name);
        session_set_cookie_params([
            'lifetime' => 0,
            'path' => '/',
            'secure' => self::isHttps(),
            'httponly' => true,
            'samesite' => 'Lax',
        ]);
        session_start();

        if (empty($_SESSION[self::INIT_KEY])) {
            session_regenerate_id(true);
            $_SESSION[self::INIT_KEY] = time();
        }
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
