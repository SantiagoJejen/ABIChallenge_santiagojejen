from joblib import dump
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import Normalizer
from sklearn.svm import SVC
import pandas as pd



X = pd.read_csv('train.csv', header=None)
y = pd.read_csv('trainLabels.csv', names=['y'])


clf_pipeline = [('scaling', Normalizer()), ('clf', SVC())]
pipeline = Pipeline(clf_pipeline)

pipeline.fit(X, y)

dump(pipeline, 'ds_london_dt_v1.joblib')
