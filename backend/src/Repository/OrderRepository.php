<?php

declare(strict_types=1);

namespace App\Repository;

use PDO;
use RuntimeException;

final class OrderRepository
{
    private $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function create(array $customer, array $cartItems): array
    {
        if ($cartItems === []) {
            throw new RuntimeException('EMPTY_CART');
        }

        $this->pdo->beginTransaction();

        try {
            $productIds = array_map('intval', array_keys($cartItems));
            $products = $this->lockProducts($productIds);
            $indexed = [];

            foreach ($products as $product) {
                $indexed[(int) $product['id']] = $product;
            }

            $total = 0;
            $lines = [];

            foreach ($cartItems as $productId => $quantity) {
                $productId = (int) $productId;
                $quantity = (int) $quantity;

                if ($quantity < 1 || !isset($indexed[$productId])) {
                    throw new RuntimeException('PRODUCT_UNAVAILABLE');
                }

                $product = $indexed[$productId];
                $stock = (int) $product['stock'];

                if ($stock < $quantity) {
                    throw new RuntimeException('INSUFFICIENT_STOCK:' . $productId);
                }

                if ($product['price_amount'] === null) {
                    throw new RuntimeException('PRICE_UNAVAILABLE:' . $productId);
                }

                $unitPrice = (int) $product['price_amount'];
                $lineTotal = $unitPrice * $quantity;
                $total += $lineTotal;
                $lines[] = [
                    'product_id' => $productId,
                    'product_name' => $product['name'],
                    'quantity' => $quantity,
                    'unit_price' => $unitPrice,
                    'line_total' => $lineTotal,
                ];
            }

            $trackingCode = $this->generateTrackingCode();
            $orderStatement = $this->pdo->prepare('
                INSERT INTO orders (
                    tracking_code,
                    customer_name,
                    customer_phone,
                    customer_address,
                    customer_note,
                    status,
                    total_amount
                ) VALUES (
                    :tracking_code,
                    :customer_name,
                    :customer_phone,
                    :customer_address,
                    :customer_note,
                    \'pending\',
                    :total_amount
                )
            ');
            $orderStatement->execute([
                ':tracking_code' => $trackingCode,
                ':customer_name' => $customer['name'],
                ':customer_phone' => $customer['phone'],
                ':customer_address' => $customer['address'],
                ':customer_note' => $customer['note'],
                ':total_amount' => $total,
            ]);

            $orderId = (int) $this->pdo->lastInsertId();
            $itemStatement = $this->pdo->prepare('
                INSERT INTO order_items (
                    order_id,
                    product_id,
                    product_name,
                    quantity,
                    unit_price,
                    line_total
                ) VALUES (
                    :order_id,
                    :product_id,
                    :product_name,
                    :quantity,
                    :unit_price,
                    :line_total
                )
            ');
            $stockStatement = $this->pdo->prepare('
                UPDATE products
                SET stock = stock - :decrement_quantity
                WHERE id = :product_id AND stock >= :required_quantity
            ');

            foreach ($lines as $line) {
                $itemStatement->execute([
                    ':order_id' => $orderId,
                    ':product_id' => $line['product_id'],
                    ':product_name' => $line['product_name'],
                    ':quantity' => $line['quantity'],
                    ':unit_price' => $line['unit_price'],
                    ':line_total' => $line['line_total'],
                ]);
                $stockStatement->execute([
                    ':product_id' => $line['product_id'],
                    ':decrement_quantity' => $line['quantity'],
                    ':required_quantity' => $line['quantity'],
                ]);

                if ($stockStatement->rowCount() !== 1) {
                    throw new RuntimeException('INSUFFICIENT_STOCK:' . $line['product_id']);
                }
            }

            $this->pdo->commit();

            return [
                'id' => $orderId,
                'tracking_code' => $trackingCode,
                'status' => 'pending',
                'total_amount' => $total,
                'total_label' => number_format($total) . ' تومان',
                'items' => $lines,
            ];
        } catch (\Throwable $exception) {
            if ($this->pdo->inTransaction()) {
                $this->pdo->rollBack();
            }

            throw $exception;
        }
    }

    public function findForTracking(string $trackingCode, string $phone): ?array
    {
        $statement = $this->pdo->prepare('
            SELECT
                id,
                tracking_code,
                customer_name,
                customer_phone,
                status,
                total_amount,
                created_at,
                updated_at
            FROM orders
            WHERE tracking_code = :tracking_code AND customer_phone = :customer_phone
            LIMIT 1
        ');
        $statement->execute([
            ':tracking_code' => $trackingCode,
            ':customer_phone' => $phone,
        ]);
        $order = $statement->fetch();

        if (!$order) {
            return null;
        }

        $itemsStatement = $this->pdo->prepare('
            SELECT product_id, product_name, quantity, unit_price, line_total
            FROM order_items
            WHERE order_id = :order_id
            ORDER BY id ASC
        ');
        $itemsStatement->execute([':order_id' => (int) $order['id']]);

        return [
            'tracking_code' => $order['tracking_code'],
            'customer_name' => $order['customer_name'],
            'status' => $order['status'],
            'total_amount' => (int) $order['total_amount'],
            'total_label' => number_format((int) $order['total_amount']) . ' تومان',
            'created_at' => $order['created_at'],
            'updated_at' => $order['updated_at'],
            'items' => array_map(static function (array $item): array {
                return [
                    'product_id' => (int) $item['product_id'],
                    'product_name' => $item['product_name'],
                    'quantity' => (int) $item['quantity'],
                    'unit_price' => (int) $item['unit_price'],
                    'line_total' => (int) $item['line_total'],
                ];
            }, $itemsStatement->fetchAll()),
        ];
    }

    private function lockProducts(array $productIds): array
    {
        $placeholders = [];
        $values = [];

        foreach (array_values($productIds) as $index => $productId) {
            $placeholder = ':product_' . $index;
            $placeholders[] = $placeholder;
            $values[$placeholder] = (int) $productId;
        }

        $statement = $this->pdo->prepare('
            SELECT id, name, price_amount, stock
            FROM products
            WHERE is_active = 1 AND id IN (' . implode(', ', $placeholders) . ')
            FOR UPDATE
        ');

        foreach ($values as $placeholder => $productId) {
            $statement->bindValue($placeholder, $productId, PDO::PARAM_INT);
        }

        $statement->execute();

        return $statement->fetchAll();
    }

    private function generateTrackingCode(): string
    {
        return strtoupper(bin2hex(random_bytes(5)));
    }
}
