<?php

declare(strict_types=1);

use App\Database\Connection;
use App\Http\ApiGuard;
use App\Http\HttpException;
use App\Http\JsonResponse;
use App\Http\ProductPresenter;
use App\Http\Request;
use App\Http\Validator;
use App\Repository\ProductRepository;
use App\Security\Csrf;
use App\Service\SessionCart;
use App\Service\SessionManager;

$app = require __DIR__ . '/../backend/bootstrap.php';

date_default_timezone_set($app['timezone']);
SessionManager::start($app['session_name'], $app['session_save_path']);

ApiGuard::run($app, static function () use ($app): void {
    $method = $_SERVER['REQUEST_METHOD'];
    $allowedMethods = ['GET', 'POST', 'PATCH', 'DELETE'];

    if (!in_array($method, $allowedMethods, true)) {
        header('Allow: GET, POST, PATCH, DELETE');
        throw new HttpException(405, 'METHOD_NOT_ALLOWED', 'Request method is not supported.');
    }

    $productId = null;
    $productSlug = null;
    $quantity = null;

    if ($method !== 'GET') {
        if (!Csrf::verify(Request::header('X-CSRF-Token'))) {
            throw new HttpException(403, 'CSRF_FAILED', 'CSRF token is invalid.');
        }

        $payload = Request::json();
        $hasProductId = array_key_exists('product_id', $payload) && $payload['product_id'] !== null && $payload['product_id'] !== '';
        $hasProductSlug = array_key_exists('product_slug', $payload) && $payload['product_slug'] !== null && $payload['product_slug'] !== '';

        if ($hasProductId) {
            $productId = Validator::int($payload['product_id'], 'product_id', 1, 2147483647);
        } elseif ($hasProductSlug) {
            $productSlug = Validator::slug($payload['product_slug'], 'product_slug');
        } else {
            throw new HttpException(422, 'VALIDATION_ERROR', 'product_id or product_slug is required.');
        }

        if ($method === 'POST' || $method === 'PATCH') {
            $quantity = Validator::int($payload['quantity'] ?? null, 'quantity', 1, 99);
        }
    }

    $pdo = Connection::make(require __DIR__ . '/../backend/config/database.php');
    $repository = new ProductRepository($pdo);

    if ($method === 'POST' || $method === 'PATCH') {
        if ($productId !== null) {
            $products = $repository->findActiveByIds([$productId]);
            $product = $products[0] ?? null;
        } else {
            $product = $productSlug === null ? null : $repository->findActiveBySlug($productSlug);
        }

        if ($product === null) {
            throw new HttpException(404, 'NOT_FOUND', 'Product was not found.');
        }

        if ($product['price_amount'] === null) {
            throw new HttpException(409, 'PRICE_UNAVAILABLE', 'Product requires price confirmation before ordering.');
        }

        $productId = (int) $product['id'];
        $availableStock = (int) $product['stock'];
        $cartItems = SessionCart::items();
        $existingQuantity = isset($cartItems[$productId]) ? (int) $cartItems[$productId] : 0;
        $requestedQuantity = $method === 'POST' ? $existingQuantity + (int) $quantity : (int) $quantity;

        if ($requestedQuantity > $availableStock) {
            throw new HttpException(409, 'INSUFFICIENT_STOCK', 'Requested quantity is not available.');
        }

        if ($method === 'POST') {
            SessionCart::add($productId, (int) $quantity);
        } else {
            SessionCart::set($productId, (int) $quantity);
        }
    } elseif ($method === 'DELETE') {
        if ($productId === null && $productSlug !== null) {
            $product = $repository->findActiveBySlug($productSlug);
            $productId = $product === null ? null : (int) $product['id'];
        }

        if ($productId !== null) {
            SessionCart::remove($productId);
        }
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
});
