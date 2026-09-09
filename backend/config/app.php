<?php

declare(strict_types=1);

return [
    'debug' => filter_var(getenv('APP_DEBUG') ?: 'false', FILTER_VALIDATE_BOOLEAN),
    'timezone' => getenv('APP_TIMEZONE') ?: 'Asia/Tehran',
    'log_file' => getenv('APP_LOG_FILE') ?: __DIR__ . '/../storage/logs/app.log',
    'session_save_path' => getenv('APP_SESSION_SAVE_PATH') ?: __DIR__ . '/../storage/sessions',
    'session_name' => getenv('APP_SESSION_NAME') ?: 'alkamoone_session',
    'rate_limit_path' => getenv('APP_RATE_LIMIT_PATH') ?: __DIR__ . '/../storage/rate_limits',
    'hsts' => filter_var(getenv('APP_HSTS') ?: 'false', FILTER_VALIDATE_BOOLEAN),
];
