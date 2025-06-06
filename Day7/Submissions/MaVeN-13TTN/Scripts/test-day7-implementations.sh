#!/bin/bash

# Day 7 Terraform State Isolation Testing Script
# Tests both workspace isolation and file layout isolation approaches

set -e

echo "🧪 Starting Day 7 Terraform State Isolation Testing..."
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to test terraform configuration
test_terraform_config() {
    local config_path=$1
    local test_name=$2
    
    print_status $BLUE "\n🔍 Testing: $test_name"
    print_status $YELLOW "📁 Path: $config_path"
    
    if [ ! -d "$config_path" ]; then
        print_status $RED "❌ Directory not found: $config_path"
        return 1
    fi
    
    cd "$config_path"
    
    # Initialize Terraform
    print_status $YELLOW "  Initializing Terraform..."
    if terraform init -backend=false > /dev/null 2>&1; then
        print_status $GREEN "  ✅ Terraform init successful"
    else
        print_status $RED "  ❌ Terraform init failed"
        cd - > /dev/null
        return 1
    fi
    
    # Validate configuration
    print_status $YELLOW "  Validating configuration..."
    if terraform validate > /dev/null 2>&1; then
        print_status $GREEN "  ✅ Configuration is valid"
    else
        print_status $RED "  ❌ Configuration validation failed"
        cd - > /dev/null
        return 1
    fi
    
    # Format check
    print_status $YELLOW "  Checking format..."
    if terraform fmt -check > /dev/null 2>&1; then
        print_status $GREEN "  ✅ Format is correct"
    else
        print_status $YELLOW "  ⚠️  Format needs fixing (running terraform fmt)"
        terraform fmt > /dev/null 2>&1
    fi
    
    cd - > /dev/null
    return 0
}

# Function to test workspace isolation
test_workspace_isolation() {
    print_status $BLUE "\n🏢 Testing Workspace Isolation Approach"
    print_status $BLUE "========================================"
    
    local workspace_path="Day7/Submissions/MaVeN-13TTN/terraform/workspace-isolation"
    
    if ! test_terraform_config "$workspace_path" "Workspace Isolation Configuration"; then
        return 1
    fi
    
    cd "$workspace_path"
    
    # Test workspace creation and switching
    print_status $YELLOW "\n  Testing workspace operations..."
    
    # Create test workspaces
    for workspace in test-dev test-staging test-prod; do
        print_status $YELLOW "    Creating workspace: $workspace"
        if terraform workspace new "$workspace" > /dev/null 2>&1; then
            print_status $GREEN "    ✅ Workspace $workspace created"
        else
            print_status $YELLOW "    ⚠️  Workspace $workspace already exists or failed to create"
        fi
    done
    
    # Test workspace switching
    for workspace in test-dev test-staging test-prod; do
        print_status $YELLOW "    Switching to workspace: $workspace"
        if terraform workspace select "$workspace" > /dev/null 2>&1; then
            print_status $GREEN "    ✅ Successfully switched to $workspace"
            
            # Test plan generation
            print_status $YELLOW "    Running terraform plan for $workspace..."
            if terraform plan -var="aws_region=us-west-2" -var="project_name=terraform-challenge-test" > /dev/null 2>&1; then
                print_status $GREEN "    ✅ Plan successful for $workspace"
            else
                print_status $RED "    ❌ Plan failed for $workspace"
            fi
        else
            print_status $RED "    ❌ Failed to switch to $workspace"
        fi
    done
    
    # Cleanup test workspaces
    print_status $YELLOW "\n  Cleaning up test workspaces..."
    terraform workspace select default > /dev/null 2>&1
    for workspace in test-dev test-staging test-prod; do
        if terraform workspace delete "$workspace" > /dev/null 2>&1; then
            print_status $GREEN "    ✅ Deleted workspace: $workspace"
        else
            print_status $YELLOW "    ⚠️  Could not delete workspace: $workspace"
        fi
    done
    
    cd - > /dev/null
    return 0
}

# Function to test file layout isolation
test_file_layout_isolation() {
    print_status $BLUE "\n📁 Testing File Layout Isolation Approach"
    print_status $BLUE "========================================="
    
    local base_path="Day7/Submissions/MaVeN-13TTN/terraform/file-layout-isolation"
    
    # Test module configurations
    print_status $YELLOW "\nTesting modules..."
    local modules=("vpc" "security-groups" "compute" "load-balancer")
    
    for module in "${modules[@]}"; do
        local module_path="$base_path/modules/$module"
        if ! test_terraform_config "$module_path" "Module: $module"; then
            print_status $RED "❌ Module $module failed validation"
            return 1
        fi
    done
    
    # Test environment configurations
    print_status $YELLOW "\nTesting environments..."
    local environments=("dev" "staging" "prod")
    
    for env in "${environments[@]}"; do
        local env_path="$base_path/environments/$env"
        if ! test_terraform_config "$env_path" "Environment: $env"; then
            print_status $RED "❌ Environment $env failed validation"
            return 1
        fi
        
        # Test with example variables if available
        if [ -f "$env_path/terraform.tfvars.example" ]; then
            cd "$env_path"
            print_status $YELLOW "  Testing with example variables..."
            if terraform plan -var-file="terraform.tfvars.example" > /dev/null 2>&1; then
                print_status $GREEN "  ✅ Plan with example variables successful"
            else
                print_status $RED "  ❌ Plan with example variables failed"
            fi
            cd - > /dev/null
        fi
    done
    
    return 0
}

# Function to test documentation
test_documentation() {
    print_status $BLUE "\n📚 Testing Documentation"
    print_status $BLUE "========================"
    
    local docs_to_check=(
        "Day7/Submissions/MaVeN-13TTN/terraform/workspace-isolation/README.md"
        "Day7/Submissions/MaVeN-13TTN/terraform/file-layout-isolation/README.md"
        "Day7/Submissions/MaVeN-13TTN/docs/blog-post-state-isolation.md"
        "Day7/day7-update-MaVeN-13TTN.md"
    )
    
    for doc in "${docs_to_check[@]}"; do
        if [ -f "$doc" ]; then
            local word_count=$(wc -w < "$doc")
            print_status $GREEN "✅ Found: $(basename "$doc") ($word_count words)"
        else
            print_status $RED "❌ Missing: $doc"
            return 1
        fi
    done
    
    return 0
}

# Function to check file structure
check_file_structure() {
    print_status $BLUE "\n🏗️  Checking File Structure"
    print_status $BLUE "=========================="
    
    local required_files=(
        # Workspace isolation files
        "Day7/Submissions/MaVeN-13TTN/terraform/workspace-isolation/main.tf"
        "Day7/Submissions/MaVeN-13TTN/terraform/workspace-isolation/variables.tf"
        "Day7/Submissions/MaVeN-13TTN/terraform/workspace-isolation/outputs.tf"
        "Day7/Submissions/MaVeN-13TTN/terraform/workspace-isolation/user_data.sh"
        "Day7/Submissions/MaVeN-13TTN/terraform/workspace-isolation/terraform.tfvars.example"
        
        # File layout isolation files
        "Day7/Submissions/MaVeN-13TTN/terraform/file-layout-isolation/environments/dev/main.tf"
        "Day7/Submissions/MaVeN-13TTN/terraform/file-layout-isolation/environments/staging/main.tf"
        "Day7/Submissions/MaVeN-13TTN/terraform/file-layout-isolation/environments/prod/main.tf"
        
        # Module files
        "Day7/Submissions/MaVeN-13TTN/terraform/file-layout-isolation/modules/vpc/main.tf"
        "Day7/Submissions/MaVeN-13TTN/terraform/file-layout-isolation/modules/compute/main.tf"
        "Day7/Submissions/MaVeN-13TTN/terraform/file-layout-isolation/modules/security-groups/main.tf"
        "Day7/Submissions/MaVeN-13TTN/terraform/file-layout-isolation/modules/load-balancer/main.tf"
    )
    
    local missing_files=0
    
    for file in "${required_files[@]}"; do
        if [ -f "$file" ]; then
            print_status $GREEN "✅ $file"
        else
            print_status $RED "❌ Missing: $file"
            ((missing_files++))
        fi
    done
    
    if [ $missing_files -eq 0 ]; then
        print_status $GREEN "\n✅ All required files present"
        return 0
    else
        print_status $RED "\n❌ $missing_files files missing"
        return 1
    fi
}

# Function to generate summary
generate_summary() {
    print_status $BLUE "\n📊 Test Summary"
    print_status $BLUE "==============="
    
    echo "Test Results:"
    echo "  - File Structure: $file_structure_result"
    echo "  - Documentation: $documentation_result"
    echo "  - Workspace Isolation: $workspace_result"
    echo "  - File Layout Isolation: $file_layout_result"
    
    if [ "$file_structure_result" = "✅" ] && [ "$documentation_result" = "✅" ] && [ "$workspace_result" = "✅" ] && [ "$file_layout_result" = "✅" ]; then
        print_status $GREEN "\n🎉 All tests passed! Day 7 implementation is ready for deployment."
        return 0
    else
        print_status $RED "\n❌ Some tests failed. Please review the output above."
        return 1
    fi
}

# Main execution
main() {
    local start_time=$(date +%s)
    
    print_status $BLUE "Starting comprehensive testing of Day 7 implementations..."
    
    # Test file structure
    if check_file_structure; then
        file_structure_result="✅"
    else
        file_structure_result="❌"
    fi
    
    # Test documentation
    if test_documentation; then
        documentation_result="✅"
    else
        documentation_result="❌"
    fi
    
    # Test workspace isolation
    if test_workspace_isolation; then
        workspace_result="✅"
    else
        workspace_result="❌"
    fi
    
    # Test file layout isolation
    if test_file_layout_isolation; then
        file_layout_result="✅"
    else
        file_layout_result="❌"
    fi
    
    # Generate summary
    generate_summary
    local exit_code=$?
    
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    print_status $BLUE "\n⏱️  Total testing time: ${duration} seconds"
    
    return $exit_code
}

# Run main function
main "$@"
