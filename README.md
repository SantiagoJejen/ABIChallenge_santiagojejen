# ABIChallenge Technical Test

In this Repo you can find my challenge response to technical Test

## Definition
1. Build and expose any already trained machine learning model as an API.
DS london: ```https://www.kaggle.com/kasatkinvl/ds-london-sklearn ```

2. The API might be able to make an estimation one by one or in a batch.

3. Implement Sonar Cloud.

4. Create a local Docker to run the project locally.

5.  Implement a cloud infrastructure to deploy the model (CI/CD).
## Proposed Solution

For this purpose, the API is written in Fast API and using Git Actions, the API is deployment on Cloud run than allows us runs containers and we don't need to have a server (Serverless)

The API have 3 routes 
- `GET  /`  return **Hello**
```
curl -X 'GET' \
  'http://127.0.0.1/' \
  -H 'accept: application/json'
```

- `GET  /health` , return **health**
```
curl -X 'GET' \
  'http://127.0.0.1/health' \
  -H 'accept: application/json'
```

- The model uses `40` variables to predict `0` or `1`. We can obtain the prediction using 
```
curl -X 'POST' \
  'http://127.0.0.1/v1/london/predict' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "data": [
    [
      0.299403,
      -1.226624,
      1.498425,
      -1.176150,
      5.289853,
      0.208297,
      2.404498,
      1.594506,
      -0.051608,
      0.663234,
      0.208297,
      2.404498,
      1.594506,
      -0.051608,
      0.663234,
      0.208297,
      2.404498,
      1.594506,
      -0.051608,
      0.663234,
      0.208297,
      2.404498,
      1.594506,
      -0.051608,
      0.663234,
      2.404498,
      1.594506,
      -0.051608,
      -0.051608,
      0.663234,
      -0.850465,
      -0.622990,
      -1.833057,
      0.293024,
      3.552681,
      0.717611,
      3.305972,
      -2.715559,
      -2.682409,
      0.101050
    ]
  ]
}'

```
return 
```
{
  "prediction": [
    1
  ]
}
```
- API Documentation
```
http://127.0.0.1/docs 
```

## How to use in Local
### Requirements
1. Docker
2. You must have port 80 free

We don´t need python on your computer and we can use all methods in Makefile: 
First, init:
```
make init_api_dev
```

We can stop the local server:
```
make stop_api_dev
```

And Start one more time:
```
make start_api_dev
``` 

If there are any changes, we need to restart the local server:
```
restart_api_dev
``` 

The **joblib** model is not stored in the repository but if you want to have it, we can run:
```
get_model_dev
```  

the model will appeared in `model/ml/`

## CI/CD
To create a new feature, create a new branch `feature1,feature2`, after that work on the branch and create a pull request. The pipeline is in .github/workflows/GCP-Deploy.yml. It compilates and creates a new container, stores it in the container registry (GCP) and deploys it on Cloud run.


## Things to improve
1. The data set must not be stored in the repository. I would have to store it on any object storage, datalake, db or datawarehause and on CI/CD refit the model with all data and capture metrics about the model.
1. Implement beautiful clean architectures.
2. I ran out of time but I am working on unit tests.
3. Run test over pipeline. 
4. Try with MLFlow :)


