# chefiq monorepo (Go)

## サービス
| Path       | 説明 |
|------------|------|
| cmd/api    | Gin REST + gRPC Gateway (Go) |
| cmd/ml     | Go gRPC クライアント (Python ml-service をテスト呼び出し) |
| ml-service | LangChain/FastAPI (Python, 別イメージ) |

## DB
* Postgres (OLTP) ─ 仕入れ・売上・固定費・マスタ
* **ClickHouse (OLAP)** ─ 長期履歴／TB 級分析 *← スケール時に追加する 1 つの専用 DB*
  * Airbyte などで夜間 ELT、Metabase 直結

## 開発環境セットアップ

### 前提条件
- Go 1.23+
- Python 3.11+
- Docker & Docker Compose
- goose (マイグレーション管理)

### セットアップ手順

1. **依存関係のインストール**
   ```bash
   make setup
   ```

2. **データベース起動**
   ```bash
   make docker-up
   ```

3. **マイグレーション実行**
   ```bash
   make db-migrate-up
   ```

4. **API サーバー起動**
   ```bash
   make dev
   ```

5. **ML サービス起動** (別ターミナル)
   ```bash
   make dev-ml
   ```

### 利用可能なコマンド

```bash
make help  # 全コマンド一覧表示
```

### API エンドポイント

- **Go API**: http://localhost:8080 (予定)
- **Python ML API**: http://localhost:8000
  - `GET /health` - ヘルスチェック
  - `POST /predict/sales` - 売上予測
  - `POST /analyze/costs` - コスト分析

### データベース接続情報

- **PostgreSQL**: `localhost:5432`
  - DB: `chefiq`
  - User: `chefiq`
  - Password: `chefiq123`

- **ClickHouse**: `localhost:8123` (HTTP), `localhost:9000` (Native)
  - DB: `chefiq_analytics`
  - User: `chefiq`
  - Password: `chefiq123`
