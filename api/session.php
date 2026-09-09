<?php

declare(strict_types=1);

use App\Http\JsonResponse;
use App\Security\Csrf;
use App\Service\SessionCart;
use App\Service\SessionManager;

$app = require __DIR__ . '/../backend/bootstrap.php';

date_default_timezone_set($app['timezone']);

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    header('Allow: GET');
    JsonResponse::error('METHOD_NOT_ALLOWED', 'Only GET requests are supported.', 405);
    exit;
}

SessionManager::start($app['session_name'], $app['session_save_path']);

JsonResponse::success([
    'csrf_token' => Csrf::token(),
    'cart_count' => array_sum(array_map('intval', SessionCart::items())),
]);
