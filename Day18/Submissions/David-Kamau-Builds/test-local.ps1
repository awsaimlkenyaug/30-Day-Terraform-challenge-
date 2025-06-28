# Local Testing Script
Write-Host "Starting local tests..." -ForegroundColor Green

# Test Go dependencies
Write-Host "Testing Go dependencies..." -ForegroundColor Yellow
Set-Location tests
go mod verify
if ($LASTEXITCODE -ne 0) { exit 1 }

# Run Go tests (only validation tests that don't require variables)
Write-Host "Running Go tests..." -ForegroundColor Yellow
go test -v -run "TestTerraformSyntax|TestVpcModuleValidation|TestModuleCompatibility"
if ($LASTEXITCODE -ne 0) { exit 1 }

Set-Location ..

# Test Terraform formatting
Write-Host "Checking Terraform formatting..." -ForegroundColor Yellow
terraform fmt -check -recursive
if ($LASTEXITCODE -ne 0) { 
    Write-Host "Terraform formatting issues found. Run 'terraform fmt -recursive' to fix." -ForegroundColor Red
    exit 1 
}

# Validate modules
Write-Host "Validating Terraform modules..." -ForegroundColor Yellow
$modules = @("modules/vpc-module", "modules/rds-module", "modules/eks-module", "modules/secrets-module", "modules/blue-green-module", "modules/gcp-module")

foreach ($module in $modules) {
    Write-Host "Validating $module..." -ForegroundColor Cyan
    Set-Location $module
    terraform init -backend=false
    if ($LASTEXITCODE -ne 0) { exit 1 }
    terraform validate
    if ($LASTEXITCODE -ne 0) { exit 1 }
    Set-Location ..\..
}

Write-Host "All local tests passed!" -ForegroundColor Green