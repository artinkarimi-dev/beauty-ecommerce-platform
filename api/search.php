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

$query = isset($_GET['q']) ? trim((string) $_GET['q']) : '';
$category = isset($_GET['category']) ? trim((string) $_GET['category']) : '';
$page = isset($_GET['page']) ? (string) $_GET['page'] : '1';
$perPage = isset($_GET['per_page']) ? (string) $_GET['per_page'] : '24';
$sort = isset($_GET['sort']) ? trim((string) $_GET['sort']) : 'newest';
$allowedSorts = ['newest', 'price_asc', 'price_desc', 'name_asc', 'name_desc'];

$queryLength = function_exists('mb_strlen') ? mb_strlen($query) : strlen($query);

if ($query === '' || $queryLength < 2 || $queryLength > 80) {
    JsonResponse::error('VALIDATION_ERROR', 'Search query must be between 2 and 80 characters.', 422);
    exit;
}

if ($category !== '' && preg_match('/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/', $category) !== 1) {
    JsonResponse::error('VALIDATION_ERROR', 'Category slug is invalid.', 422);
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
    $categoryIds = null;

    if ($category !== '') {
        $categoryIds = $repository->getActiveCategoryScopeIds($category);

        if ($categoryIds === []) {
            JsonResponse::error('NOT_FOUND', 'Category was not found.', 404);
            exit;
        }
    }

    $total = $repository->countSearch($query, $categoryIds);
    $products = $repository->search($query, (int) $page, (int) $perPage, $sort, $categoryIds);

    JsonResponse::success([
        'products' => ProductPresenter::many($products),
        'meta' => [
            'query' => $query,
            'category' => $category !== '' ? $category : null,
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
    JsonResponse::error('SERVER_ERROR', 'Search is temporarily unavailable.', 500);
}
