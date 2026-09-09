<?php

declare(strict_types=1);

$localConfig = __DIR__ . '/local.php';

if (is_file($localConfig)) {
    return require $localConfig;
}

$required = [
    'DB_HOST',
    'DB_DATABASE',
    'DB_USERNAME',
    'DB_PASSWORD',
];

$values = [];

foreach ($required as $name) {
    $value = getenv($name);

    if ($value === false || $value === '') {
        throw new RuntimeException('Database configuration is incomplete.');
    }

    $values[$name] = $value;
}

$port = getenv('DB_PORT');
$charset = getenv('DB_CHARSET');

return [
    'host' => $values['DB_HOST'],
    'port' => $port !== false && $port !== '' ? (int) $port : 3306,
    'database' => $values['DB_DATABASE'],
    'username' => $values['DB_USERNAME'],
    'password' => $values['DB_PASSWORD'],
    'charset' => $charset !== false && $charset !== '' ? $charset : 'utf8mb4',
];
