#!/bin/bash

# データベース接続設定
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_USER=${DB_USER:-chefiq}
DB_PASSWORD=${DB_PASSWORD:-chefiq123}
DB_NAME=${DB_NAME:-chefiq}

DB_URL="postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}?sslmode=disable"

case "$1" in
  up)
    echo "Running migrations up..."
    goose -dir migrations postgres "$DB_URL" up
    ;;
  down)
    echo "Running migrations down..."
    goose -dir migrations postgres "$DB_URL" down
    ;;
  status)
    echo "Migration status..."
    goose -dir migrations postgres "$DB_URL" status
    ;;
  create)
    if [ -z "$2" ]; then
      echo "Usage: $0 create <migration_name>"
      exit 1
    fi
    echo "Creating migration: $2"
    goose -dir migrations create "$2" sql
    ;;
  *)
    echo "Usage: $0 {up|down|status|create <name>}"
    exit 1
    ;;
esac
