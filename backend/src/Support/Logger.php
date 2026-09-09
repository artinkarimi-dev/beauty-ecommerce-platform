<?php

declare(strict_types=1);

namespace App\Support;

use Throwable;

final class Logger
{
    public static function exception(Throwable $exception, string $logFile, array $context = []): void
    {
        self::event($logFile, 'exception', array_merge($context, [
            'class' => get_class($exception),
            'message' => $exception->getMessage(),
            'file' => basename($exception->getFile()),
            'line' => $exception->getLine(),
        ]));
    }

    public static function event(string $logFile, string $event, array $context = []): void
    {
        $directory = dirname($logFile);

        if (!is_dir($directory)) {
            mkdir($directory, 0775, true);
        }

        if (!is_dir($directory) || !is_writable($directory)) {
            return;
        }

        $payload = [
            'time' => date('c'),
            'event' => $event,
            'context' => self::sanitize($context),
        ];

        error_log(json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . PHP_EOL, 3, $logFile);
    }

    private static function sanitize(array $context): array
    {
        $blockedKeys = ['password', 'csrf', 'csrf_token', 'token', 'session', 'session_id', 'secret', 'credential'];
        $safe = [];

        foreach ($context as $key => $value) {
            $normalizedKey = strtolower((string) $key);
            $isSensitive = false;

            foreach ($blockedKeys as $blockedKey) {
                if (strpos($normalizedKey, $blockedKey) !== false) {
                    $isSensitive = true;
                    break;
                }
            }

            if ($isSensitive) {
                $safe[$key] = '[redacted]';
                continue;
            }

            if (is_array($value)) {
                $safe[$key] = self::sanitize($value);
            } elseif (is_scalar($value) || $value === null) {
                $text = (string) $value;
                $safe[$key] = strlen($text) > 500 ? substr($text, 0, 500) . '...' : $value;
            } else {
                $safe[$key] = '[unsupported]';
            }
        }

        return $safe;
    }
}
