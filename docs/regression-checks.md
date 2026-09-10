# Lightweight Regression Checks

Use `tools/regression-check.ps1` for fast, repeatable verification during hardening work.

The default run is read-only:

```powershell
powershell -ExecutionPolicy Bypass -File tools/regression-check.ps1
```

When a local web server is running, include representative storefront and session endpoint checks:

```powershell
powershell -ExecutionPolicy Bypass -File tools/regression-check.ps1 -BaseUrl http://127.0.0.1:8097
```

The script checks PHP syntax, shared JavaScript syntax when Node.js is available, known broken storefront patterns, tracked runtime files, and optional HTTP smoke URLs. It does not create orders, mutate inventory, or require database credentials.
