<?php

declare(strict_types=1);

namespace App\Security;

use App\Http\HttpException;
use App\Support\Logger;

final class RateLimiter
{
    public static function check(array $app, string $bucket, int $limit, int $windowSeconds): void
    {
        $directory = $app['rate_limit_path'] ?? null;

        if (!is_string($directory) || $directory === '') {
            return;
        }

        if (!is_dir($directory)) {
            mkdir($directory, 0775, true);
        }

        if (!is_dir($directory) || !is_writable($directory)) {
            Logger::event($app['log_file'], 'rate_limit_storage_unavailable', ['bucket' => $bucket]);
            return;
        }

        $key = hash('sha256', $bucket . '|' . self::clientKey());
        $file = rtrim($directory, '/\\') . DIRECTORY_SEPARATOR . $key . '.json';
        $now = time();
        $entry = [
            'window_start' => $now,
            'count' => 0,
        ];

        $handle = fopen($file, 'c+');

        if ($handle === false) {
            Logger::event($app['log_file'], 'rate_limit_file_unavailable', ['bucket' => $bucket]);
            return;
        }

        try {
            if (!flock($handle, LOCK_EX)) {
                return;
            }

            $raw = stream_get_contents($handle);
            $decoded = is_string($raw) && $raw !== '' ? json_decode($raw, true) : null;

            if (is_array($decoded)
                && isset($decoded['window_start'], $decoded['count'])
                && $now - (int) $decoded['window_start'] < $windowSeconds
            ) {
                $entry = [
                    'window_start' => (int) $decoded['window_start'],
                    'count' => (int) $decoded['count'],
                ];
            }

            $entry['count']++;

            ftruncate($handle, 0);
            rewind($handle);
            fwrite($handle, json_encode($entry, JSON_UNESCAPED_SLASHES));

            if ($entry['count'] > $limit) {
                Logger::event($app['log_file'], 'rate_limit_rejected', [
                    'bucket' => $bucket,
                    'limit' => $limit,
                    'window_seconds' => $windowSeconds,
                ]);
                throw new HttpException(429, 'RATE_LIMITED', 'Too many requests. Please try again later.');
            }
        } finally {
            flock($handle, LOCK_UN);
            fclose($handle);
        }
    }

    private static function clientKey(): string
    {
        $forwardedFor = $_SERVER['HTTP_X_FORWARDED_FOR'] ?? '';
        $ip = $_SERVER['REMOTE_ADDR'] ?? 'unknown';

        if (is_string($forwardedFor) && $forwardedFor !== '') {
            $parts = explode(',', $forwardedFor);
            $candidate = trim($parts[0]);

            if (filter_var($candidate, FILTER_VALIDATE_IP)) {
                $ip = $candidate;
            }
        }

        return (string) $ip;
    }
}
