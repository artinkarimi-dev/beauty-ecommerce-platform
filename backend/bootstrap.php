<?php

declare(strict_types=1);

error_reporting(E_ALL);

spl_autoload_register(static function (string $className): void {
    $prefix = 'App\\';
    $baseDir = __DIR__ . '/src/';

    if (strncmp($className, $prefix, strlen($prefix)) !== 0) {
        return;
    }

    $relativeClass = substr($className, strlen($prefix));
    $file = $baseDir . str_replace('\\', '/', $relativeClass) . '.php';

    if (is_file($file)) {
        require $file;
    }
});

$appConfig = require __DIR__ . '/config/app.php';

ini_set('display_errors', $appConfig['debug'] ? '1' : '0');
ini_set('log_errors', '1');

return $appConfig;
