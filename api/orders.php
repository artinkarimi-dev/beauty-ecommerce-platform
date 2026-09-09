<?php

declare(strict_types=1);

use App\Database\Connection;
use App\Http\JsonResponse;
use App\Http\Request;
use App\Repository\OrderRepository;
use App\Security\Csrf;
use App\Service\SessionCart;
use App\Service\SessionManager;
use App\Support\Logger;

$app = require __DIR__ . '/../backend/bootstrap.php';

date_default_timezone_set($app['timezone']);
SessionManager::start($app['session_name'], $app['session_save_path']);

$method = $_SERVER['REQUEST_METHOD'];

if (!in_array($method, ['GET', 'POST'], true)) {
    header('Allow: GET, POST');
    JsonResponse::error('METHOD_NOT_ALLOWED', 'Request method is not supported.', 405);
    exit;
}

if ($method === 'GET') {
    $trackingCode = isset($_GET['tracking_code']) ? strtoupper(trim((string) $_GET['tracking_code'])) : '';
    $phone = isset($_GET['phone']) ? trim((string) $_GET['phone']) : '';

    if (preg_match('/\A[A-F0-9]{10}\z/', $trackingCode) !== 1 || !isValidPhone($phone)) {
        JsonResponse::error('VALIDATION_ERROR', 'Tracking code or phone is invalid.', 422);
        exit;
    }

    try {
        $pdo = Connection::make(require __DIR__ . '/../backend/config/database.php');
        $repository = new OrderRepository($pdo);
        $order = $repository->findForTracking($trackingCode, normalizePhone($phone));

        if ($order === null) {
            JsonResponse::error('NOT_FOUND', 'Order was not found.', 404);
            exit;
        }

        JsonResponse::success(['order' => $order]);
    } catch (Throwable $exception) {
        Logger::exception($exception, $app['log_file']);
        JsonResponse::error('SERVER_ERROR', 'Orders are temporarily unavailable.', 500);
    }

    exit;
}

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

$name = trim((string) ($payload['name'] ?? ''));
$phone = trim((string) ($payload['phone'] ?? ''));
$address = trim((string) ($payload['address'] ?? ''));
$note = trim((string) ($payload['note'] ?? ''));
$nameLength = function_exists('mb_strlen') ? mb_strlen($name) : strlen($name);
$addressLength = function_exists('mb_strlen') ? mb_strlen($address) : strlen($address);
$noteLength = function_exists('mb_strlen') ? mb_strlen($note) : strlen($note);

if ($nameLength < 2 || $nameLength > 120) {
    JsonResponse::error('VALIDATION_ERROR', 'Name must be between 2 and 120 characters.', 422);
    exit;
}

if (!isValidPhone($phone)) {
    JsonResponse::error('VALIDATION_ERROR', 'Phone number is invalid.', 422);
    exit;
}

if ($addressLength < 10 || $addressLength > 500) {
    JsonResponse::error('VALIDATION_ERROR', 'Address must be between 10 and 500 characters.', 422);
    exit;
}

if ($noteLength > 500) {
    JsonResponse::error('VALIDATION_ERROR', 'Note cannot be longer than 500 characters.', 422);
    exit;
}

$cartItems = SessionCart::items();

if ($cartItems === []) {
    JsonResponse::error('EMPTY_CART', 'Cart is empty.', 409);
    exit;
}

try {
    $pdo = Connection::make(require __DIR__ . '/../backend/config/database.php');
    $repository = new OrderRepository($pdo);

    try {
        $order = $repository->create([
            'name' => $name,
            'phone' => normalizePhone($phone),
            'address' => $address,
            'note' => $note !== '' ? $note : null,
        ], $cartItems);
    } catch (RuntimeException $exception) {
        $reason = $exception->getMessage();

        if ($reason === 'EMPTY_CART') {
            JsonResponse::error('EMPTY_CART', 'Cart is empty.', 409);
            exit;
        }

        if ($reason === 'PRODUCT_UNAVAILABLE' || strpos($reason, 'INSUFFICIENT_STOCK:') === 0) {
            JsonResponse::error('INSUFFICIENT_STOCK', 'One or more products are no longer available in the requested quantity.', 409);
            exit;
        }

        if (strpos($reason, 'PRICE_UNAVAILABLE:') === 0) {
            JsonResponse::error('PRICE_UNAVAILABLE', 'One or more products require price confirmation before ordering.', 409);
            exit;
        }

        throw $exception;
    }

    SessionCart::clear();
    JsonResponse::success(['order' => $order], 201);
} catch (Throwable $exception) {
    Logger::exception($exception, $app['log_file']);
    JsonResponse::error('SERVER_ERROR', 'Orders are temporarily unavailable.', 500);
}

function isValidPhone(string $phone): bool
{
    $normalized = normalizePhone($phone);

    return preg_match('/\A\+?[0-9]{10,15}\z/', $normalized) === 1;
}

function normalizePhone(string $phone): string
{
    $persian = ['۰','۱','۲','۳','۴','۵','۶','۷','۸','۹'];
    $arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
    $latin = ['0','1','2','3','4','5','6','7','8','9'];
    $phone = str_replace($persian, $latin, $phone);
    $phone = str_replace($arabic, $latin, $phone);

    return preg_replace('/[\s()\-]/', '', $phone) ?? $phone;
}
