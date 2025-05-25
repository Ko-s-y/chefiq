from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn
import logging

# ログ設定
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="ChefIQ ML Service",
    description="機械学習による飲食店経営分析API",
    version="1.0.0"
)

# リクエスト/レスポンスモデル
class PredictionRequest(BaseModel):
    store_id: int
    period_days: int = 30

class PredictionResponse(BaseModel):
    store_id: int
    predicted_sales: float
    confidence: float
    recommendations: list[str]

@app.get("/")
async def root():
    return {"message": "ChefIQ ML Service is running"}

@app.get("/health")
async def health_check():
    return {"status": "healthy", "service": "ml-service"}

@app.post("/predict/sales", response_model=PredictionResponse)
async def predict_sales(request: PredictionRequest):
    """売上予測API（モックレスポンス）"""
    logger.info(f"Sales prediction request for store {request.store_id}")

    # TODO: 実際の機械学習モデルを実装
    mock_prediction = 150000.0  # 15万円の売上予測
    mock_confidence = 0.85
    mock_recommendations = [
        "仕入れコストを10%削減することで利益率向上が期待できます",
        "平日のランチメニューを強化することをお勧めします",
        "季節メニューの導入を検討してください"
    ]

    return PredictionResponse(
        store_id=request.store_id,
        predicted_sales=mock_prediction,
        confidence=mock_confidence,
        recommendations=mock_recommendations
    )

@app.post("/analyze/costs")
async def analyze_costs(request: PredictionRequest):
    """コスト分析API（モックレスポンス）"""
    logger.info(f"Cost analysis request for store {request.store_id}")

    return {
        "store_id": request.store_id,
        "cost_breakdown": {
            "ingredients": 45.2,
            "labor": 32.1,
            "rent": 15.0,
            "utilities": 7.7
        },
        "optimization_suggestions": [
            "食材ロスを5%削減可能",
            "シフト最適化で人件費10%削減可能"
        ]
    }

if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
        log_level="info"
    )
