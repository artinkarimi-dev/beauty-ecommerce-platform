<?php

declare(strict_types=1);

use App\Database\Connection;
use App\Http\JsonResponse;
use App\Http\ProductPresenter;
use App\Repository\ProductRepository;
use App\Support\Logger;

$app = require __DIR__ . '/../backend/bootstrap.php';

date_default_timezone_set($app['timezone']);

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    header('Allow: GET');
    JsonResponse::error('METHOD_NOT_ALLOWED', 'Only GET requests are supported.', 405);
    exit;
}

$category = isset($_GET['category']) ? trim((string) $_GET['category']) : '';
$page = isset($_GET['page']) ? (string) $_GET['page'] : '1';
$perPage = isset($_GET['per_page']) ? (string) $_GET['per_page'] : '24';
$sort = isset($_GET['sort']) ? trim((string) $_GET['sort']) : 'newest';
$allowedSorts = ['newest', 'price_asc', 'price_desc', 'name_asc', 'name_desc'];

if ($category === '' || preg_match('/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/', $category) !== 1) {
    JsonResponse::error('VALIDATION_ERROR', 'A valid category slug is required.', 422);
    exit;
}

if (filter_var($page, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]) === false) {
    JsonResponse::error('VALIDATION_ERROR', 'Page must be a positive integer.', 422);
    exit;
}

if (filter_var($perPage, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1, 'max_range' => 48]]) === false) {
    JsonResponse::error('VALIDATION_ERROR', 'per_page must be between 1 and 48.', 422);
    exit;
}

if (!in_array($sort, $allowedSorts, true)) {
    JsonResponse::error('VALIDATION_ERROR', 'Sort mode is not supported.', 422);
    exit;
}

try {
    $pdo = Connection::make(require __DIR__ . '/../backend/config/database.php');
    $repository = new ProductRepository($pdo);
    $categoryIds = $repository->getActiveCategoryScopeIds($category);

    if ($categoryIds === []) {
        JsonResponse::error('NOT_FOUND', 'Category was not found.', 404);
        exit;
    }

    $total = $repository->countActiveByCategoryIds($categoryIds);
    $products = $repository->findActiveByCategoryIds($categoryIds, (int) $page, (int) $perPage, $sort);

    JsonResponse::success([
        'products' => ProductPresenter::many($products),
        'meta' => [
            'page' => (int) $page,
            'per_page' => (int) $perPage,
            'total' => $total,
            'total_pages' => (int) ceil($total / (int) $perPage),
            'count' => count($products),
            'sort' => $sort,
        ],
    ]);
} catch (Throwable $exception) {
    Logger::exception($exception, $app['log_file']);
    JsonResponse::error('SERVER_ERROR', 'Products are temporarily unavailable.', 500);
}
