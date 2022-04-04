FROM jupyter/scipy-notebook as ml
 
RUN mkdir my-model

ENV MODEL_DIR=/home/jovyan/my-model
ENV MODEL_FILE_LDA=clf_lda.joblib
ENV MODEL_FILE_NN=clf_nn.joblib

RUN pip install joblib

COPY ./models/ml/data/train.csv ./train.csv 
COPY ./models/ml/data/trainLabels.csv ./trainLabels.csv

COPY ./models/ml/train.py ./train.py

RUN python3 train.py



FROM tiangolo/uvicorn-gunicorn:python3.8-slim

LABEL maintainer="https://github.com/rodrigo-arenas"

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive
ENV MODULE_NAME=app


ADD requirements.txt .

RUN pip install -r requirements.txt \
    && rm -rf /root/.cache

COPY . .

COPY --from=ml /home/jovyan/ds_london_dt_v1.joblib ./models/ml/