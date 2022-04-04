docker build -t fit-model-build -f "$(git rev-parse --show-toplevel)"/development/Dockerfile.train .
docker run --name fit-model fit-model-build python3 train.py 
docker cp fit-model:/home/jovyan/ds_london_dt_v1.joblib models/ml