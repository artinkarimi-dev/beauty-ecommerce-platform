<?php

declare(strict_types=1);

namespace App\Support;

use Throwable;

final class Logger
{
    public static function exception(Throwable $exception, string $logFile): void
    {
        $directory = dirname($logFile);

        if (!is_dir($directory)) {
            return;
        }

        $message = sprintf(
            "[%s] %s: %s in %s:%d\n",
            date('c'),
            get_class($exception),
            $exception->getMessage(),
            $exception->getFile(),
            $exception->getLine()
        );

        error_log($message, 3, $logFile);
    }
}
