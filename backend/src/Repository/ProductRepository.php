<?php

declare(strict_types=1);

namespace App\Repository;

use PDO;

final class ProductRepository
{
    private $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function getActiveCategoryScopeIds(string $categorySlug): array
    {
        $root = $this->pdo->prepare('
            SELECT id
            FROM categories
            WHERE slug = :category_slug AND is_active = 1
            LIMIT 1
        ');
        $root->execute([':category_slug' => $categorySlug]);
        $rootId = $root->fetchColumn();

        if ($rootId === false) {
            return [];
        }

        $scope = [(int) $rootId];
        $frontier = [(int) $rootId];

        while ($frontier !== []) {
            $placeholders = [];

            foreach (array_values($frontier) as $index => $categoryId) {
                $placeholders[':parent_' . $index] = $categoryId;
            }

            $statement = $this->pdo->prepare('
                SELECT id
                FROM categories
                WHERE is_active = 1
                    AND parent_id IN (' . implode(', ', array_keys($placeholders)) . ')
            ');

            foreach ($placeholders as $placeholder => $categoryId) {
                $statement->bindValue($placeholder, $categoryId, PDO::PARAM_INT);
            }

            $statement->execute();
            $children = array_map('intval', $statement->fetchAll(PDO::FETCH_COLUMN));
            $frontier = [];

            foreach ($children as $categoryId) {
                if (!in_array($categoryId, $scope, true)) {
                    $scope[] = $categoryId;
                    $frontier[] = $categoryId;
                }
            }
        }

        return $scope;
    }

    public function countActiveByCategoryIds(array $categoryIds): int
    {
        if ($categoryIds === []) {
            return 0;
        }

        $placeholders = $this->categoryPlaceholders($categoryIds);
        $statement = $this->pdo->prepare('
            SELECT COUNT(*)
            FROM products p
            WHERE p.is_active = 1
                AND p.category_id IN (' . implode(', ', array_keys($placeholders)) . ')
        ');
        $this->bindCategoryIds($statement, $placeholders);
        $statement->execute();

        return (int) $statement->fetchColumn();
    }

    public function findActiveByCategoryIds(array $categoryIds, int $page, int $perPage, string $sort): array
    {
        if ($categoryIds === []) {
            return [];
        }

        $placeholders = $this->categoryPlaceholders($categoryIds);
        $where = 'p.is_active = 1 AND p.category_id IN (' . implode(', ', array_keys($placeholders)) . ')';

        return $this->findByWhere($where, $placeholders, $page, $perPage, $sort);
    }

    public function countSearch(string $query, ?array $categoryIds = null): int
    {
        [$where, $bindings] = $this->searchWhere($query, $categoryIds);
        $statement = $this->pdo->prepare('SELECT COUNT(*) FROM products p INNER JOIN categories c ON c.id = p.category_id WHERE ' . $where);
        $this->bindValues($statement, $bindings);
        $statement->execute();

        return (int) $statement->fetchColumn();
    }

    public function search(string $query, int $page, int $perPage, string $sort, ?array $categoryIds = null): array
    {
        [$where, $bindings] = $this->searchWhere($query, $categoryIds);

        return $this->findByWhere($where, $bindings, $page, $perPage, $sort);
    }

    public function findActiveByIds(array $productIds): array
    {
        if ($productIds === []) {
            return [];
        }

        $placeholders = [];

        foreach (array_values($productIds) as $index => $productId) {
            $placeholders[':product_' . $index] = (int) $productId;
        }

        $statement = $this->pdo->prepare('
            SELECT
                p.id,
                p.name,
                p.slug,
                p.description,
                p.price_amount,
                p.price_label,
                p.image,
                p.stock,
                c.name AS category_name,
                c.slug AS category_slug
            FROM products p
            INNER JOIN categories c ON c.id = p.category_id
            WHERE p.is_active = 1
                AND p.id IN (' . implode(', ', array_keys($placeholders)) . ')
        ');
        $this->bindValues($statement, $placeholders);
        $statement->execute();

        return $statement->fetchAll();
    }


    public function findActiveBySlug(string $slug): ?array
    {
        $statement = $this->pdo->prepare('
            SELECT
                p.id,
                p.name,
                p.slug,
                p.description,
                p.price_amount,
                p.price_label,
                p.image,
                p.stock,
                c.name AS category_name,
                c.slug AS category_slug
            FROM products p
            INNER JOIN categories c ON c.id = p.category_id
            WHERE p.is_active = 1
                AND p.slug = :slug
            LIMIT 1
        ');
        $statement->execute([':slug' => $slug]);
        $product = $statement->fetch();

        return $product === false ? null : $product;
    }
    private function findByWhere(string $where, array $bindings, int $page, int $perPage, string $sort): array
    {
        $offset = ($page - 1) * $perPage;
        $sortClauses = [
            'newest' => 'p.created_at DESC, p.id DESC',
            'price_asc' => '(p.price_amount IS NULL) ASC, p.price_amount ASC, p.id DESC',
            'price_desc' => '(p.price_amount IS NULL) ASC, p.price_amount DESC, p.id DESC',
            'name_asc' => 'p.name ASC, p.id DESC',
            'name_desc' => 'p.name DESC, p.id DESC',
        ];
        $orderBy = $sortClauses[$sort] ?? $sortClauses['newest'];

        $sql = '
            SELECT
                p.id,
                p.name,
                p.slug,
                p.description,
                p.price_amount,
                p.price_label,
                p.image,
                p.stock,
                c.name AS category_name,
                c.slug AS category_slug
            FROM products p
            INNER JOIN categories c ON c.id = p.category_id
            WHERE ' . $where . '
            ORDER BY ' . $orderBy . '
            LIMIT :limit OFFSET :offset
        ';

        $statement = $this->pdo->prepare($sql);
        $this->bindValues($statement, $bindings);
        $statement->bindValue(':limit', $perPage, PDO::PARAM_INT);
        $statement->bindValue(':offset', $offset, PDO::PARAM_INT);
        $statement->execute();

        return $statement->fetchAll();
    }

    private function searchWhere(string $query, ?array $categoryIds): array
    {
        $escaped = str_replace(['\\', '%', '_'], ['\\\\', '\\%', '\\_'], $query);
        $term = '%' . $escaped . '%';
        $bindings = [
            ':search_name' => $term,
            ':search_description' => $term,
            ':search_category' => $term,
        ];
        $where = "p.is_active = 1 AND (p.name LIKE :search_name ESCAPE '\\\\' OR p.description LIKE :search_description ESCAPE '\\\\' OR c.name LIKE :search_category ESCAPE '\\\\')";

        if ($categoryIds !== null) {
            if ($categoryIds === []) {
                return ['1 = 0', []];
            }

            $categoryBindings = $this->categoryPlaceholders($categoryIds);
            $bindings = array_merge($bindings, $categoryBindings);
            $where .= ' AND p.category_id IN (' . implode(', ', array_keys($categoryBindings)) . ')';
        }

        return [$where, $bindings];
    }

    private function categoryPlaceholders(array $categoryIds): array
    {
        $placeholders = [];

        foreach (array_values($categoryIds) as $index => $categoryId) {
            $placeholders[':category_' . $index] = (int) $categoryId;
        }

        return $placeholders;
    }

    private function bindCategoryIds(\PDOStatement $statement, array $placeholders): void
    {
        $this->bindValues($statement, $placeholders);
    }

    private function bindValues(\PDOStatement $statement, array $bindings): void
    {
        foreach ($bindings as $placeholder => $value) {
            $statement->bindValue($placeholder, $value, is_int($value) ? PDO::PARAM_INT : PDO::PARAM_STR);
        }
    }
}
