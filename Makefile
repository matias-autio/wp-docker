.PHONY: help up down restart logs composer-install composer-require composer-update

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

up: ## Start the containers
	docker-compose up -d

down: ## Stop and remove containers
	docker-compose down

restart: ## Restart containers
	docker-compose down && docker-compose up -d

logs: ## Show container logs
	docker-compose logs -f

composer-install: ## Install Composer dependencies
	docker-compose --profile tools run --rm composer install

composer-require: ## Install a new package (usage: make composer-require PACKAGE=wpackagist-plugin/plugin-name)
	docker-compose --profile tools run --rm composer require $(PACKAGE)

composer-update: ## Update Composer dependencies
	docker-compose --profile tools run --rm composer update

composer-remove: ## Remove a package (usage: make composer-remove PACKAGE=wpackagist-plugin/plugin-name)
	docker-compose --profile tools run --rm composer remove $(PACKAGE)
