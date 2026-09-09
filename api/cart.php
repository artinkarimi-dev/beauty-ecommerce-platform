<?php

declare(strict_types=1);

use App\Database\Connection;
use App\Http\JsonResponse;
use App\Http\ProductPresenter;
use App\Http\Request;
use App\Repository\ProductRepository;
use App\Security\Csrf;
use App\Service\SessionCart;
use App\Service\SessionManager;
use App\Support\Logger;

$app = require __DIR__ . '/../backend/bootstrap.php';

date_default_timezone_set($app['timezone']);
SessionManager::start($app['session_name'], $app['session_save_path']);

$method = $_SERVER['REQUEST_METHOD'];
$allowedMethods = ['GET', 'POST', 'PATCH', 'DELETE'];

if (!in_array($method, $allowedMethods, true)) {
    header('Allow: GET, POST, PATCH, DELETE');
    JsonResponse::error('METHOD_NOT_ALLOWED', 'Request method is not supported.', 405);
    exit;
}

$productId = null;
$quantity = null;

if ($method !== 'GET') {
    if (!Csrf::verify(Request::header('X-CSRF-Token'))) {
        JsonResponse::error('CSRF_FAILED', 'CSRF token is invalid.', 403);
        exit;
    }

    try {
        $payload = Request::json();
    } catch (RuntimeException $exception) {
        $code = $exception->getMessage();

        if ($code === 'PAYLOAD_TOO_LARGE') {
            JsonResponse::error('PAYLOAD_TOO_LARGE', 'Request body is too large.', 413);
            exit;
        }

        JsonResponse::error(
            $code === 'CONTENT_TYPE' ? 'UNSUPPORTED_CONTENT_TYPE' : 'INVALID_JSON',
            $code === 'CONTENT_TYPE' ? 'Content-Type must be application/json.' : 'Request body contains invalid JSON.',
            $code === 'CONTENT_TYPE' ? 415 : 400
        );
        exit;
    }

    $productId = filter_var($payload['product_id'] ?? null, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);

    if ($productId === false) {
        JsonResponse::error('VALIDATION_ERROR', 'product_id must be a positive integer.', 422);
        exit;
    }

    if ($method === 'POST' || $method === 'PATCH') {
        $quantity = filter_var($payload['quantity'] ?? null, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1, 'max_range' => 99]]);

        if ($quantity === false) {
            JsonResponse::error('VALIDATION_ERROR', 'quantity must be between 1 and 99.', 422);
            exit;
        }
    }
}

try {
    $pdo = Connection::make(require __DIR__ . '/../backend/config/database.php');
    $repository = new ProductRepository($pdo);

    if ($method === 'POST' || $method === 'PATCH') {
        $products = $repository->findActiveByIds([(int) $productId]);

        if ($products === []) {
            JsonResponse::error('NOT_FOUND', 'Product was not found.', 404);
            exit;
        }

        $availableStock = (int) $products[0]['stock'];
        $cartItems = SessionCart::items();
        $existingQuantity = isset($cartItems[(int) $productId]) ? (int) $cartItems[(int) $productId] : 0;
        $requestedQuantity = $method === 'POST' ? $existingQuantity + (int) $quantity : (int) $quantity;

        if ($requestedQuantity > $availableStock) {
            JsonResponse::error('INSUFFICIENT_STOCK', 'Requested quantity is not available.', 409);
            exit;
        }

        if ($method === 'POST') {
            SessionCart::add((int) $productId, (int) $quantity);
        } else {
            SessionCart::set((int) $productId, (int) $quantity);
        }
    } elseif ($method === 'DELETE') {
        SessionCart::remove((int) $productId);
    }

    $cartItems = SessionCart::items();
    $products = $repository->findActiveByIds(array_map('intval', array_keys($cartItems)));
    $responseItems = [];
    $total = 0;
    $count = 0;

    foreach ($products as $product) {
        $currentProductId = (int) $product['id'];
        $currentQuantity = isset($cartItems[$currentProductId]) ? (int) $cartItems[$currentProductId] : 0;

        if ($currentQuantity < 1) {
            continue;
        }

        $presented = ProductPresenter::one($product);
        $lineTotal = $presented['price_amount'] === null ? null : $presented['price_amount'] * $currentQuantity;
        $responseItems[] = [
            'product' => $presented,
            'quantity' => $currentQuantity,
            'line_total' => $lineTotal,
            'line_total_label' => $lineTotal === null ? 'تماس بگیرید' : number_format($lineTotal) . ' تومان',
        ];
        $count += $currentQuantity;

        if ($lineTotal !== null) {
            $total += $lineTotal;
        }
    }

    JsonResponse::success([
        'items' => $responseItems,
        'count' => $count,
        'total_amount' => $total,
        'total_label' => number_format($total) . ' تومان',
        'csrf_token' => Csrf::token(),
    ]);
} catch (Throwable $exception) {
    Logger::exception($exception, $app['log_file']);
    JsonResponse::error('SERVER_ERROR', 'Cart is temporarily unavailable.', 500);
}
