<?php

declare(strict_types=1);

namespace App\Http;

use App\Support\Logger;
use Throwable;

final class ApiGuard
{
    public static function run(array $app, callable $handler): void
    {
        self::register($app);

        try {
            $handler();
        } catch (HttpException $exception) {
            JsonResponse::error($exception->codeName(), $exception->publicMessage(), $exception->statusCode());
        } catch (Throwable $exception) {
            Logger::exception($exception, $app['log_file'], [
                'event' => 'unhandled_api_exception',
                'method' => $_SERVER['REQUEST_METHOD'] ?? null,
                'uri' => self::safeUri(),
            ]);
            JsonResponse::error('SERVER_ERROR', 'Request is temporarily unavailable.', 500);
        }
    }

    public static function register(array $app): void
    {
        SecurityHeaders::apply($app);

        set_exception_handler(static function (Throwable $exception) use ($app): void {
            Logger::exception($exception, $app['log_file'], [
                'event' => 'fatal_uncaught_exception',
                'method' => $_SERVER['REQUEST_METHOD'] ?? null,
                'uri' => self::safeUri(),
            ]);
            JsonResponse::error('SERVER_ERROR', 'Request is temporarily unavailable.', 500);
        });

        set_error_handler(static function (int $severity, string $message, string $file, int $line) use ($app): bool {
            if ((error_reporting() & $severity) === 0) {
                return false;
            }

            Logger::event($app['log_file'], 'php_error', [
                'severity' => $severity,
                'message' => $message,
                'file' => basename($file),
                'line' => $line,
                'method' => $_SERVER['REQUEST_METHOD'] ?? null,
                'uri' => self::safeUri(),
            ]);

            throw new \ErrorException($message, 0, $severity, $file, $line);
        });

        register_shutdown_function(static function () use ($app): void {
            $error = error_get_last();
            $fatalTypes = [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR];

            if ($error === null || !in_array($error['type'], $fatalTypes, true)) {
                return;
            }

            Logger::event($app['log_file'], 'fatal_php_error', [
                'type' => $error['type'],
                'message' => $error['message'],
                'file' => basename((string) $error['file']),
                'line' => $error['line'],
                'method' => $_SERVER['REQUEST_METHOD'] ?? null,
                'uri' => self::safeUri(),
            ]);

            if (!headers_sent()) {
                JsonResponse::error('SERVER_ERROR', 'Request is temporarily unavailable.', 500);
            }
        });
    }

    private static function safeUri(): ?string
    {
        if (!isset($_SERVER['REQUEST_URI'])) {
            return null;
        }

        $path = parse_url((string) $_SERVER['REQUEST_URI'], PHP_URL_PATH);

        return is_string($path) ? $path : null;
    }
}
