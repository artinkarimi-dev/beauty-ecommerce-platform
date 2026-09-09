<?php

declare(strict_types=1);

use App\Http\ApiGuard;
use App\Http\HttpException;
use App\Http\JsonResponse;
use App\Security\Csrf;
use App\Service\SessionCart;
use App\Service\SessionManager;

$app = require __DIR__ . '/../backend/bootstrap.php';

date_default_timezone_set($app['timezone']);
SessionManager::start($app['session_name'], $app['session_save_path']);

ApiGuard::run($app, static function (): void {
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        header('Allow: GET');
        throw new HttpException(405, 'METHOD_NOT_ALLOWED', 'Only GET requests are supported.');
    }

    JsonResponse::success([
        'csrf_token' => Csrf::token(),
        'cart_count' => array_sum(array_map('intval', SessionCart::items())),
    ]);
});
