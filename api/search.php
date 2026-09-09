<?php

declare(strict_types=1);

use App\Database\Connection;
use App\Http\ApiGuard;
use App\Http\HttpException;
use App\Http\JsonResponse;
use App\Http\ProductPresenter;
use App\Http\Validator;
use App\Repository\ProductRepository;

$app = require __DIR__ . '/../backend/bootstrap.php';

date_default_timezone_set($app['timezone']);

ApiGuard::run($app, static function (): void {
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        header('Allow: GET');
        throw new HttpException(405, 'METHOD_NOT_ALLOWED', 'Only GET requests are supported.');
    }

    $query = Validator::searchQuery($_GET['q'] ?? '');
    $category = Validator::slug($_GET['category'] ?? '', 'category', false);
    $page = Validator::page($_GET['page'] ?? '1', 'page', 1, 1, 10000);
    $perPage = Validator::page($_GET['per_page'] ?? '24', 'per_page', 24, 1, 48);
    $sort = Validator::oneOf(trim((string) ($_GET['sort'] ?? 'newest')), ['newest', 'price_asc', 'price_desc', 'name_asc', 'name_desc'], 'sort');
    $pdo = Connection::make(require __DIR__ . '/../backend/config/database.php');
    $repository = new ProductRepository($pdo);
    $categoryIds = null;

    if ($category !== null) {
        $categoryIds = $repository->getActiveCategoryScopeIds($category);

        if ($categoryIds === []) {
            throw new HttpException(404, 'NOT_FOUND', 'Category was not found.');
        }
    }

    $total = $repository->countSearch($query, $categoryIds);
    $products = $repository->search($query, $page, $perPage, $sort, $categoryIds);

    JsonResponse::success([
        'products' => ProductPresenter::many($products),
        'meta' => [
            'query' => $query,
            'category' => $category,
            'page' => $page,
            'per_page' => $perPage,
            'total' => $total,
            'total_pages' => (int) ceil($total / $perPage),
            'count' => count($products),
            'sort' => $sort,
        ],
    ]);
});
