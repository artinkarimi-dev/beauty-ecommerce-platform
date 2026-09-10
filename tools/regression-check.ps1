param(
    [string]$PhpExe = "",
    [string]$NodeExe = "node",
    [string]$BaseUrl = "",
    [switch]$SkipJavaScript
)

$ErrorActionPreference = "Stop"
$failures = New-Object System.Collections.Generic.List[string]

function Write-Section {
    param([string]$Name)
    Write-Host ""
    Write-Host "== $Name =="
}

function Add-Failure {
    param([string]$Message)
    $failures.Add($Message) | Out-Null
    Write-Host "FAIL $Message" -ForegroundColor Red
}

function Resolve-Php {
    if ($PhpExe -and (Test-Path -LiteralPath $PhpExe -PathType Leaf)) {
        return $PhpExe
    }

    $xamppPhp = "C:\xampp\php\php.exe"
    if (Test-Path -LiteralPath $xamppPhp -PathType Leaf) {
        return $xamppPhp
    }

    return "php"
}

function Test-CommandAvailable {
    param([string]$Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

Write-Section "PHP lint"
$php = Resolve-Php
$phpFiles = Get-ChildItem -Recurse -Filter *.php |
    Where-Object { $_.FullName -notmatch "\\backend\\config\\local\.php$" }

foreach ($file in $phpFiles) {
    & $php -l $file.FullName | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Add-Failure "PHP syntax error in $($file.FullName)"
    }
}

if ($failures.Count -eq 0) {
    Write-Host "PASS PHP lint"
}

Write-Section "JavaScript syntax"
if ($SkipJavaScript) {
    Write-Host "SKIP JavaScript syntax checks"
} elseif (-not (Test-CommandAvailable $NodeExe)) {
    Write-Host "SKIP JavaScript syntax checks; '$NodeExe' was not found"
} else {
    $jsFiles = @(
        "assets/js/commerce.js",
        "assets/js/product-listing.js",
        "assets/js/static-cart-integration.js",
        "assets/js/cart-page.js",
        "assets/js/order-tracking.js"
    )

    foreach ($file in $jsFiles) {
        if (Test-Path -LiteralPath $file -PathType Leaf) {
            & $NodeExe --check $file | Out-Null
            if ($LASTEXITCODE -ne 0) {
                Add-Failure "JavaScript syntax error in $file"
            }
        } else {
            Add-Failure "Missing shared JavaScript file $file"
        }
    }

    if ($failures.Count -eq 0) {
        Write-Host "PASS JavaScript syntax"
    }
}

Write-Section "Static storefront scans"
$scanFailures = 0
$scanPatterns = @(
    'href="#"',
    'javascript:void(0)',
    'toggleWishlist',
    [regex]::Unescape('\u0642\u06CC\u0645\u062A \u0645\u062D\u0635\u0648\u0644'),
    [regex]::Unescape('\u0645\u062D\u0644 \u0646\u0645\u0627\u06CC\u0634 \u062A\u0648\u0636\u06CC\u062D\u0627\u062A \u0645\u062D\u0635\u0648\u0644')
)

$scanFiles = Get-ChildItem -Recurse -File -Include *.html,*.js,*.css |
    Where-Object { $_.FullName -notmatch "\\backend\\storage\\" }

foreach ($pattern in $scanPatterns) {
    $matches = Select-String -Path $scanFiles.FullName -SimpleMatch -Pattern $pattern -ErrorAction SilentlyContinue
    if ($matches) {
        $scanFailures++
        Add-Failure "Found disallowed storefront pattern '$pattern'"
        $matches | Select-Object -First 10 | ForEach-Object {
            Write-Host "  $($_.Path):$($_.LineNumber)"
        }
    }
}

if ($scanFailures -eq 0) {
    Write-Host "PASS static storefront scans"
}

Write-Section "Git hygiene"
$trackedForbidden = git ls-files backend/config/local.php backend/storage/logs backend/storage/sessions backend/storage/rate_limits
if ($LASTEXITCODE -ne 0) {
    Add-Failure "Unable to inspect tracked runtime files"
} else {
    $badTracked = $trackedForbidden | Where-Object { $_ -notmatch "\.gitkeep$" }
    if ($badTracked) {
        Add-Failure "Runtime/local files are tracked unexpectedly"
        $badTracked | ForEach-Object { Write-Host "  $_" }
    } else {
        Write-Host "PASS no tracked local config or runtime files"
    }
}

Write-Section "HTTP smoke"
if (-not $BaseUrl) {
    Write-Host "SKIP HTTP smoke checks; pass -BaseUrl http://host:port to enable"
} else {
    $paths = @(
        "/index.html",
        "/cart.html",
        "/order-tracking.html",
        "/care/care.html",
        "/FACE-CLEANSER/face-wash-gel.html",
        "/api/session.php"
    )

    foreach ($path in $paths) {
        $uri = $BaseUrl.TrimEnd("/") + $path
        try {
            $response = Invoke-WebRequest -Uri $uri -UseBasicParsing -TimeoutSec 10
            if ($response.StatusCode -lt 200 -or $response.StatusCode -ge 300) {
                Add-Failure "Unexpected HTTP $($response.StatusCode) for $uri"
            } else {
                Write-Host "PASS $uri"
            }
        } catch {
            Add-Failure "HTTP check failed for ${uri}: $($_.Exception.Message)"
        }
    }
}

Write-Section "Result"
if ($failures.Count -gt 0) {
    Write-Host "$($failures.Count) regression check(s) failed" -ForegroundColor Red
    exit 1
}

Write-Host "All enabled regression checks passed" -ForegroundColor Green
