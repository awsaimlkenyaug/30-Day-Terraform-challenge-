@echo off
setlocal enabledelayedexpansion

echo 🚀 Starting Terraform Test Suite

cd tests

echo [INFO] Installing Go dependencies...
go mod tidy
if !errorlevel! neq 0 (
    echo [ERROR] Failed to install dependencies
    exit /b 1
)

echo [INFO] Running Unit Tests...
go test -v -run TestTerraformSyntax
if !errorlevel! neq 0 (
    echo [ERROR] Unit tests failed
    exit /b 1
)
echo [INFO] ✅ Unit tests passed

echo [INFO] Running Mock Tests...
go test -v -run TestModuleWithMocks
if !errorlevel! neq 0 (
    echo [ERROR] Mock tests failed
    exit /b 1
)
echo [INFO] ✅ Mock tests passed

echo [INFO] Running VPC Module Tests...
go test -v -run TestVpcModule
if !errorlevel! neq 0 (
    echo [ERROR] VPC module tests failed
    exit /b 1
)
echo [INFO] ✅ VPC module tests passed

echo [INFO] Running Integration Tests...
go test -v -timeout 10m -run TestModuleCompatibility
if !errorlevel! neq 0 (
    echo [ERROR] Integration tests failed
    exit /b 1
)
echo [INFO] ✅ Integration tests passed

if "%RUN_E2E_TESTS%"=="true" (
    echo [WARN] Running E2E Tests (this may take a while and incur AWS costs)...
    go test -v -timeout 30m -run TestE2E
    if !errorlevel! neq 0 (
        echo [ERROR] E2E tests failed
        exit /b 1
    )
    echo [INFO] ✅ E2E tests passed
) else (
    echo [WARN] ⏭️  E2E tests skipped (set RUN_E2E_TESTS=true to enable)
)

echo [INFO] 🎉 All tests completed successfully!