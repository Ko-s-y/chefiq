dev: ## Hot-reload 開発
	reflex -r '\.go$$' -- sh -c 'go run ./cmd/api'
test:
	go test ./...
lint:
	golangci-lint run
