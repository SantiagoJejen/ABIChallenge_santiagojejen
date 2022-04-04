from fastapi import APIRouter
app_home = APIRouter()


@app_home.get('/', tags=["Intro"])
async def hello():
    return {"message": "Hello!"}


@app_home.get('/health', tags=["Intro"])
async def health():
    return {"message": "health"}
