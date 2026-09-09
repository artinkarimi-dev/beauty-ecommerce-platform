<?php

declare(strict_types=1);

use App\Database\Connection;
use App\Http\JsonResponse;
use App\Repository\CategoryRepository;
use App\Support\Logger;

$app = require __DIR__ . '/../backend/bootstrap.php';

date_default_timezone_set($app['timezone']);

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    header('Allow: GET');
    JsonResponse::error('METHOD_NOT_ALLOWED', 'Only GET requests are supported.', 405);
    exit;
}

try {
    $pdo = Connection::make(require __DIR__ . '/../backend/config/database.php');
    $repository = new CategoryRepository($pdo);

    JsonResponse::success([
        'categories' => $repository->activeTree(),
    ]);
} catch (Throwable $exception) {
    Logger::exception($exception, $app['log_file']);
    JsonResponse::error('SERVER_ERROR', 'Categories are temporarily unavailable.', 500);
}
