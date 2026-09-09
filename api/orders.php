<?php

declare(strict_types=1);

use App\Database\Connection;
use App\Http\ApiGuard;
use App\Http\HttpException;
use App\Http\JsonResponse;
use App\Http\Request;
use App\Http\Validator;
use App\Repository\OrderRepository;
use App\Security\Csrf;
use App\Security\RateLimiter;
use App\Service\SessionCart;
use App\Service\SessionManager;
use App\Support\Logger;

$app = require __DIR__ . '/../backend/bootstrap.php';

date_default_timezone_set($app['timezone']);
SessionManager::start($app['session_name'], $app['session_save_path']);

ApiGuard::run($app, static function () use ($app): void {
    $method = $_SERVER['REQUEST_METHOD'];

    if (!in_array($method, ['GET', 'POST'], true)) {
        header('Allow: GET, POST');
        throw new HttpException(405, 'METHOD_NOT_ALLOWED', 'Request method is not supported.');
    }

    if ($method === 'GET') {
        RateLimiter::check($app, 'order_tracking', 30, 300);

        $trackingCode = Validator::trackingCode($_GET['tracking_code'] ?? '');
        $phone = Validator::phone($_GET['phone'] ?? '');
        $pdo = Connection::make(require __DIR__ . '/../backend/config/database.php');
        $repository = new OrderRepository($pdo);
        $order = $repository->findForTracking($trackingCode, $phone);

        if ($order === null) {
            throw new HttpException(404, 'NOT_FOUND', 'Order was not found.');
        }

        JsonResponse::success(['order' => $order]);
        return;
    }

    RateLimiter::check($app, 'checkout', 10, 300);

    if (!Csrf::verify(Request::header('X-CSRF-Token'))) {
        Logger::event($app['log_file'], 'csrf_rejected', ['endpoint' => 'orders']);
        throw new HttpException(403, 'CSRF_FAILED', 'CSRF token is invalid.');
    }

    $payload = Request::json();
    $name = Validator::string($payload['name'] ?? null, 'name', 2, 120);
    $phone = Validator::phone($payload['phone'] ?? null);
    $address = Validator::string($payload['address'] ?? null, 'address', 10, 500);
    $note = Validator::optionalString($payload['note'] ?? '', 'note', 500);
    $cartItems = SessionCart::items();

    if ($cartItems === []) {
        throw new HttpException(409, 'EMPTY_CART', 'Cart is empty.');
    }

    $pdo = Connection::make(require __DIR__ . '/../backend/config/database.php');
    $repository = new OrderRepository($pdo);

    try {
        $order = $repository->create([
            'name' => $name,
            'phone' => $phone,
            'address' => $address,
            'note' => $note,
        ], $cartItems);
    } catch (RuntimeException $exception) {
        $reason = $exception->getMessage();

        if ($reason === 'EMPTY_CART') {
            throw new HttpException(409, 'EMPTY_CART', 'Cart is empty.');
        }

        if ($reason === 'PRODUCT_UNAVAILABLE' || strpos($reason, 'INSUFFICIENT_STOCK:') === 0) {
            throw new HttpException(409, 'INSUFFICIENT_STOCK', 'One or more products are no longer available in the requested quantity.');
        }

        if (strpos($reason, 'PRICE_UNAVAILABLE:') === 0) {
            throw new HttpException(409, 'PRICE_UNAVAILABLE', 'One or more products require price confirmation before ordering.');
        }

        throw $exception;
    }

    SessionCart::clear();
    JsonResponse::success(['order' => $order], 201);
});
