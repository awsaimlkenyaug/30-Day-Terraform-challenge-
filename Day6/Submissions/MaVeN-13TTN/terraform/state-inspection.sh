#!/bin/bash

# Script to inspect and analyze Terraform state

echo "=== Terraform State Inspection Tool ==="
echo

# Check if terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "Error: Terraform is not installed or not in PATH"
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Warning: jq is not installed. Some analysis features will be limited."
    HAS_JQ=false
else
    HAS_JQ=true
fi

# Function to analyze local state file
analyze_local_state() {
    echo "=== Local State Analysis ==="
    
    if [ ! -f "terraform.tfstate" ]; then
        echo "No local state file found."
        return
    fi
    
    echo "State file exists at: $(pwd)/terraform.tfstate"
    
    # Get state file size
    STATE_SIZE=$(ls -lh terraform.tfstate | awk '{print $5}')
    echo "State file size: $STATE_SIZE"
    
    # Count resources in state
    RESOURCE_COUNT=$(terraform state list | wc -l)
    echo "Resources in state: $RESOURCE_COUNT"
    
    # List all resources
    echo -e "\nResources in state:"
    terraform state list
    
    # Analyze state structure with jq if available
    if [ "$HAS_JQ" = true ]; then
        echo -e "\nState file structure:"
        echo "Terraform version: $(jq -r '.terraform_version' terraform.tfstate)"
        echo "State version: $(jq -r '.version' terraform.tfstate)"
        echo "Serial: $(jq -r '.serial' terraform.tfstate)"
        
        # Count resource types
        echo -e "\nResource types:"
        jq -r '.resources[].type' terraform.tfstate | sort | uniq -c | sort -nr
    fi
}

# Function to analyze remote state
analyze_remote_state() {
    echo "=== Remote State Analysis ==="
    
    # Check if backend is configured
    if ! grep -q "backend" *.tf; then
        echo "No backend configuration found."
        return
    fi
    
    echo "Remote backend is configured."
    
    # Pull state and analyze
    echo "Pulling remote state..."
    terraform state pull > remote_state.json
    
    if [ "$HAS_JQ" = true ]; then
        echo -e "\nRemote state structure:"
        echo "Terraform version: $(jq -r '.terraform_version' remote_state.json)"
        echo "State version: $(jq -r '.version' remote_state.json)"
        echo "Serial: $(jq -r '.serial' remote_state.json)"
        
        # Count resources
        RESOURCE_COUNT=$(jq -r '.resources | length' remote_state.json)
        echo "Resources in remote state: $RESOURCE_COUNT"
        
        # Count resource types
        echo -e "\nResource types in remote state:"
        jq -r '.resources[].type' remote_state.json | sort | uniq -c | sort -nr
    else
        echo "Install jq for more detailed remote state analysis."
    fi
    
    # Clean up
    rm -f remote_state.json
}

# Main execution
echo "Current directory: $(pwd)"
echo

# Check if we're in a Terraform directory
if [ ! -f "main.tf" ]; then
    echo "Warning: No main.tf found in current directory."
    echo "Make sure you're in a Terraform project directory."
    exit 1
fi

# Initialize Terraform if needed
if [ ! -d ".terraform" ]; then
    echo "Initializing Terraform..."
    terraform init
fi

# Analyze state
analyze_local_state
echo
analyze_remote_state

echo -e "\n=== State Inspection Complete ==="