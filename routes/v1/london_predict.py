from fastapi import APIRouter
from models.schemas.london import London, LondonPredictionResponse
import models.ml.classifier as clf

app_london_predict_v1 = APIRouter()


@app_london_predict_v1.post('/london/predict',
                          tags=["Predictions"],
                          response_model=LondonPredictionResponse,
                          description="Get a classification from London DS")
async def get_prediction(london: London):
    data = dict(london)['data']
    prediction = clf.model.predict(data).tolist()
    return {"prediction": prediction}
