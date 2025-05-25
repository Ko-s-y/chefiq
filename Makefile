dev: ## Hot-reload 開発
	reflex -r '\.go$$' -- sh -c 'go run ./cmd/api'

dev-ml: ## Python MLサービス開発
	cd ml-service && python main.py

test:
	go test ./...

lint:
	golangci-lint run

# Docker関連
docker-up: ## Docker Compose起動
	docker-compose up -d

docker-down: ## Docker Compose停止
	docker-compose down

docker-logs: ## Docker Composeログ確認
	docker-compose logs -f

# データベース関連
db-migrate-up: ## マイグレーション実行
	./scripts/migrate.sh up

db-migrate-down: ## マイグレーション戻し
	./scripts/migrate.sh down

db-migrate-status: ## マイグレーション状態確認
	./scripts/migrate.sh status

# 開発環境セットアップ
setup: ## 開発環境セットアップ
	go mod tidy
	cd ml-service && pip install -r requirements.txt

help: ## このヘルプを表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
