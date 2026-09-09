<?php

declare(strict_types=1);

namespace App\Repository;

use PDO;

final class CategoryRepository
{
    private $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function activeTree(): array
    {
        $statement = $this->pdo->query('
            SELECT id, parent_id, name, slug
            FROM categories
            WHERE is_active = 1
            ORDER BY name ASC, id ASC
        ');
        $rows = $statement->fetchAll();
        $nodes = [];

        foreach ($rows as $row) {
            $id = (int) $row['id'];
            $nodes[$id] = [
                'id' => $id,
                'name' => $row['name'],
                'slug' => $row['slug'],
                'children' => [],
            ];
        }

        $tree = [];

        foreach ($rows as $row) {
            $id = (int) $row['id'];
            $parentId = $row['parent_id'] === null ? null : (int) $row['parent_id'];

            if ($parentId !== null && isset($nodes[$parentId])) {
                $nodes[$parentId]['children'][] = &$nodes[$id];
            } else {
                $tree[] = &$nodes[$id];
            }
        }

        return $tree;
    }
}
