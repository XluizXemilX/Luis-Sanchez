# -*- coding: utf-8 -*-
"""
Created on Wed Nov 18 19:19:06 2020

@author: night

Machine Learning Research Project
"""
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import LabelBinarizer
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn import linear_model
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import cross_val_predict
from sklearn.metrics import confusion_matrix
from sklearn.metrics import precision_score, recall_score

if __name__ == '__main__':
    """
        main driver
    """
    
    """
    Data Pre-Processing
    """
    #Open file
    seed = 127843
    np.random.seed(seed)
    data_dir = '../data'
    file_name = 'titanic_passengers.csv'
    path = os.path.join(data_dir, file_name)
    
    df = pd.read_csv(path)
    df.info()
    
    #cleanup
    df = df.drop(df.loc[:,['PassengerId', 'Cabin', 'Name', 'Ticket', 'Embarked']], axis=1)
    df.info()
    df = df.dropna()
    df.info()
    
    
    enc = LabelBinarizer()
    data =df['Sex']
    one_hot = enc.fit_transform(data)
    df = pd.concat([df, pd.DataFrame(one_hot, columns=['Sex-dummy'])], axis=1)  #female =0 male = 1
    df.info()
    
    df = df.dropna()
    df.info()
    
    """
    EDA
    """
    
    survived = 'survived'
    not_survived = 'not survived'
    fig, axes = plt.subplots(nrows=1, ncols=2,figsize=(10, 4))
    women = df[df['Sex']=='female']
    men = df[df['Sex']=='male']
    ax = sns.distplot(women[women['Survived']==1].Age.dropna(), bins=18, label = survived, ax = axes[0], kde =False)
    ax = sns.distplot(women[women['Survived']==0].Age.dropna(), bins=40, label = not_survived, ax = axes[0], kde =False)
    ax.legend()
    ax.set_title('Female')
    ax = sns.distplot(men[men['Survived']==1].Age.dropna(), bins=18, label = survived, ax = axes[1], kde = False)
    ax = sns.distplot(men[men['Survived']==0].Age.dropna(), bins=40, label = not_survived, ax = axes[1], kde = False)
    ax.legend()
    _ = ax.set_title('Male')
    plt.show()
    
    df = df.drop('Sex', axis=1)
    #correlational Plot
    corr = df.corr()
    sns.heatmap(corr, annot=True)
    plt.show()
    
    # Pairplot
    sns.pairplot(df)
    plt.show()
    
    # collinearity Plot
    corr = corr.abs()
    sns.heatmap(corr, vmin=0.9, vmax=1, annot=True)
    plt.show()
    
    
    
    """
    Data Processing
    """
    X = df.drop('Survived', axis = 1)
    y = df['Survived']
    
    X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=seed)
    
    """
    Train
    """
    
    # Decision Tree
    decision_tree = DecisionTreeClassifier() 
    decision_tree.fit(X_train, y_train)  
    y_pred = decision_tree.predict(X_test)  
    acc_decision_tree = round(decision_tree.score(X_train, y_train) * 100, 2)
    
    # Stochastic Gradient Descent
    sgd = linear_model.SGDClassifier(max_iter=5, tol=None)
    sgd.fit(X_train, y_train)
    Y_pred = sgd.predict(X_test)
    sgd.score(X_train, y_train)
    acc_sgd = round(sgd.score(X_train, y_train) * 100, 2)
    
    # Random Forest
    random_forest = RandomForestClassifier(n_estimators=100)
    random_forest.fit(X_train, y_train)
    Y_prediction = random_forest.predict(X_test)
    random_forest.score(X_train, y_train)
    acc_random_forest = round(random_forest.score(X_train, y_train) * 100, 2)
    
    # Logistic Regression
    logreg = LogisticRegression()
    logreg.fit(X_train, y_train)
    Y_pred = logreg.predict(X_test)
    acc_log = round(logreg.score(X_train, y_train) * 100, 2)
    
    #KNN
    knn = KNeighborsClassifier(n_neighbors = 3) 
    knn.fit(X_train, y_train)  
    Y_pred = knn.predict(X_test) 
    acc_knn = round(knn.score(X_train, y_train) * 100, 2)
    
    # Decision Tree
    decision_tree = DecisionTreeClassifier() 
    decision_tree.fit(X_train, y_train)  
    Y_pred = decision_tree.predict(X_test)  
    acc_decision_tree = round(decision_tree.score(X_train, y_train) * 100, 2)
    
    # Gaussian NB
    gaussian = GaussianNB() 
    gaussian.fit(X_train, y_train)  
    Y_pred = gaussian.predict(X_test)  
    acc_gaussian = round(gaussian.score(X_train, y_train) * 100, 2)
    
    # check whic model is better
    results = pd.DataFrame({
    'Model': ['KNN', 'Logistic Regression', 
              'Random Forest', 'Naive Bayes', 
              'Stochastic Gradient Decent', 
              'Decision Tree'],
    'Score': [acc_knn, acc_log, 
              acc_random_forest, acc_gaussian, 
              acc_sgd, acc_decision_tree]})
    result_df = results.sort_values(by='Score', ascending=False)
    result_df = result_df.set_index('Score')
    print(result_df.head(9))

    """
    Validation
    """
    rf = RandomForestClassifier(n_estimators=100)
    scores = cross_val_score(rf, X_train, y_train, cv=10, scoring = "accuracy")
    print("Scores:", scores)
    print("Mean:", scores.mean())
    print("Standard Deviation:", scores.std())
    
    # Confusion Matrix
    predictions = cross_val_predict(random_forest, X_train, y_train, cv=3)
    print(confusion_matrix(y_train, predictions))
    
    # Precision and Recall
    print("Precision:", precision_score(y_train, predictions))
    print("Recall:",recall_score(y_train, predictions))
    