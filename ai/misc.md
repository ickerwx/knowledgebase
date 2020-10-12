# Machine Learning

## Preprocessing

* interpolate missing data
* encode categorial data
* split into training and testset
* scale data

```python
# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

dataset = pd.read_csv('Data.csv')

# importing dataset
X = dataset.iloc[:,:-1].values
y = dataset.iloc[:, 3].values # dependent

# missing data
from sklearn.preprocessing import Imputer
imputer = Imputer(missing_values = 'NaN', strategy='mean', axis=0)
imputer = imputer.fit(X[:,1:3])
X[:,1:3] = imputer.transform(X[:,1:3])

# encoding categorial data
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_X = LabelEncoder()
X[:,0] = labelencoder_X.fit_transform(X[:,0])
onehotencoder = OneHotEncoder(categorical_features=[0])
X = onehotencoder.fit_transform(X).toarray()
labelencoder_Y = LabelEncoder()
y = labelencoder_X.fit_transform(y)

# splitting into test and training set
from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = .2, random_state=0)


# feature scaling
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test) # no fit because last set did fit on the sc_X object
```

## Augmented Random Search

### General
* research paper: https://arxiv.org/abs/1803.07055
* Google DeepMind AI Walking https://www.youtube.com/watch?v=gn4nRCC9TwQ
* Physics Simulation Lib https://pypi.org/project/pybullet/

### Overview
* notes based on artificial-intelligence-ars from udemy
* type of reinforced unsupervised learning
* implemented just with numpy library


### Idea
* uses aproximation of gradient descent to be very fast at optimizing weights towards a goal
* this only works on problems state are stateful and can be seperated in episodes (like walking)

## Generative Adverserial Networks

### General

* a generator generates data from noise, a discrimantor decides how close it is to the real data, both learn from their mistakes at the same time


## SSD: Single Shot MultiBox Detector

## Links
 * https://facebook.ai/developers

tags: #ai #machine #learning #augmented #random #search 
