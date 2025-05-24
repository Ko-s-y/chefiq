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
