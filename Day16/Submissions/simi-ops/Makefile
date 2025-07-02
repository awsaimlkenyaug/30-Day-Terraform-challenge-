.PHONY: help init validate plan apply destroy test fmt clean

# Default environment
ENV ?= dev

help: ## Show this help message
	@echo 'Usage: make [target] ENV=[dev|staging|production]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Initialize Terraform
	cd terraform && terraform init

validate: ## Validate Terraform configuration
	cd terraform && terraform validate
	cd terraform && terraform fmt -check -recursive

fmt: ## Format Terraform files
	cd terraform && terraform fmt -recursive

plan: ## Plan Terraform deployment
	cd terraform && terraform plan -var-file="environments/$(ENV)/terraform.tfvars"

apply: ## Apply Terraform configuration
	cd terraform && terraform apply -var-file="environments/$(ENV)/terraform.tfvars" -auto-approve

destroy: ## Destroy Terraform resources
	cd terraform && terraform destroy -var-file="environments/$(ENV)/terraform.tfvars" -auto-approve

test: ## Run Terratest
	cd tests && go test -v -timeout 30m

test-unit: ## Run unit tests only
	cd tests && go test -v -run TestALBModule

clean: ## Clean Terraform files
	find . -name ".terraform" -type d -exec rm -rf {} +
	find . -name "*.tfplan" -delete
	find . -name "*.tfstate*" -delete

docker-deploy: ## Deploy with Docker
	./deploy-docker.sh $(ENV)

docker-update: ## Update Docker containers
	./update-docker-instances.sh $(ENV)

validate-deployment: ## Validate deployment
	./validate-deployment.sh $(ENV)

# Environment-specific targets
dev: ENV=dev
dev: plan

staging: ENV=staging  
staging: plan

production: ENV=production
production: plan