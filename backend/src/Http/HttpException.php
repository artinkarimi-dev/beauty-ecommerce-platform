<?php

declare(strict_types=1);

namespace App\Http;

use RuntimeException;

final class HttpException extends RuntimeException
{
    private $statusCode;
    private $codeName;
    private $publicMessage;

    public function __construct(int $statusCode, string $codeName, string $publicMessage)
    {
        parent::__construct($codeName);
        $this->statusCode = $statusCode;
        $this->codeName = $codeName;
        $this->publicMessage = $publicMessage;
    }

    public function statusCode(): int
    {
        return $this->statusCode;
    }

    public function codeName(): string
    {
        return $this->codeName;
    }

    public function publicMessage(): string
    {
        return $this->publicMessage;
    }
}
