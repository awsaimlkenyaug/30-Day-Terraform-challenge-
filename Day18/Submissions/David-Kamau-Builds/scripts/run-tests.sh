#!/bin/bash

set -e

echo "🚀 Starting Terraform Test Suite"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Change to tests directory
cd tests

print_status "Installing Go dependencies..."
go mod tidy

print_status "Running Unit Tests..."
if go test -v -run TestTerraformSyntax; then
    print_status "✅ Unit tests passed"
else
    print_error "❌ Unit tests failed"
    exit 1
fi

print_status "Running Mock Tests..."
if go test -v -run TestModuleWithMocks; then
    print_status "✅ Mock tests passed"
else
    print_error "❌ Mock tests failed"
    exit 1
fi

print_status "Running VPC Module Tests..."
if go test -v -run TestVpcModule; then
    print_status "✅ VPC module tests passed"
else
    print_error "❌ VPC module tests failed"
    exit 1
fi

print_status "Running Integration Tests..."
if go test -v -timeout 10m -run TestModuleCompatibility; then
    print_status "✅ Integration tests passed"
else
    print_error "❌ Integration tests failed"
    exit 1
fi

# Optional: Run E2E tests if enabled
if [ "$RUN_E2E_TESTS" = "true" ]; then
    print_warning "Running E2E Tests (this may take a while and incur AWS costs)..."
    if go test -v -timeout 30m -run TestE2E; then
        print_status "✅ E2E tests passed"
    else
        print_error "❌ E2E tests failed"
        exit 1
    fi
else
    print_warning "⏭️  E2E tests skipped (set RUN_E2E_TESTS=true to enable)"
fi

print_status "🎉 All tests completed successfully!"