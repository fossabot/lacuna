# Lacuna Makefile
# Convenience commands for development

.PHONY: help install dev test test-cov test-integration lint format docker-up docker-down docker-test clean

help:
	@echo "Lacuna Development Commands"
	@echo ""
	@echo "  install          Install package in production mode"
	@echo "  dev              Install package with dev dependencies"
	@echo "  test             Run unit tests"
	@echo "  test-cov         Run tests with coverage report"
	@echo "  test-integration Run integration tests (requires Docker)"
	@echo "  lint             Run linters (ruff, mypy)"
	@echo "  format           Format code with black"
	@echo "  docker-up        Start development environment"
	@echo "  docker-down      Stop development environment"
	@echo "  docker-test      Run tests in Docker"
	@echo "  clean            Clean build artifacts"

install:
	pip install -e .

dev:
	pip install -e ".[dev]"

test:
	python -m pytest tests/ -v

test-cov:
	python -m pytest tests/ --cov=lacuna --cov-report=term-missing --cov-report=html

test-integration:
	LACUNA_RUN_INTEGRATION_TESTS=true ./scripts/run-integration-tests.sh

lint:
	ruff check lacuna/ tests/
	mypy lacuna/ --ignore-missing-imports

format:
	black lacuna/ tests/
	ruff check --fix lacuna/ tests/

docker-up:
	docker compose up -d postgres redis opa

docker-down:
	docker compose down -v

docker-test:
	docker compose -f docker-compose.test.yaml up --build --abort-on-container-exit integration-tests
	docker compose -f docker-compose.test.yaml down -v

migrate:
	alembic upgrade head

clean:
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	rm -rf .pytest_cache/
	rm -rf .coverage
	rm -rf htmlcov/
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

