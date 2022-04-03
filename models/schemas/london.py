from pydantic import BaseModel, conlist
from typing import List, Any


class London(BaseModel):
    data: List[conlist(float, min_items=40, max_items=40)]


class LondonPredictionResponse(BaseModel):
    prediction: List[int]