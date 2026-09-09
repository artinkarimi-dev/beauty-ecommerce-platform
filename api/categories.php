<?php

declare(strict_types=1);

use App\Database\Connection;
use App\Http\ApiGuard;
use App\Http\HttpException;
use App\Http\JsonResponse;
use App\Repository\CategoryRepository;

$app = require __DIR__ . '/../backend/bootstrap.php';

date_default_timezone_set($app['timezone']);

ApiGuard::run($app, static function (): void {
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        header('Allow: GET');
        throw new HttpException(405, 'METHOD_NOT_ALLOWED', 'Only GET requests are supported.');
    }

    $pdo = Connection::make(require __DIR__ . '/../backend/config/database.php');
    $repository = new CategoryRepository($pdo);

    JsonResponse::success([
        'categories' => $repository->activeTree(),
    ]);
});
