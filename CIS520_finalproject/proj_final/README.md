# Group: Kernel Mustard & Lt.-Norm
# Members: Tom Amon, Halley Young, and Zeyu Zhao
We adapted KNN, logistic regression, and naive bayes, some trained on augmented and projected feature space, for our project. 
Each of our models have 2 functions(1 to train the model and 1 to make predictions) and 1 script that can be used for easy testing.

Below, I will write a short description of each file, but the short version is: run the "test_*.m" files. 
These files train the model, print out the testing error, and then will compute the Y_hat using the X_validation_bag. Y_hat wil then be in your workspace, and you can use it to test our performance. Alternatively, if you want to run the training and predicting functions yourself, reading through those "test_*.m" files should show you how. 

# General helper function used by our other functions: 
 - least_expected_cost.m: This function takes a matrix of probability estimates, and returns the class with the least expected cost. 
 - compress.m: This function takes a feature set X and merges features based on the contents of the matrix "include/stemmed_projections". This is used as a means of feature selection, where we first find all the features that share a stem, like "swim" and "swimming", and then merge those features by adding those columns together. 
 - porterStemmer.m: Given a word, uses the porter algorithm to find its stems 


# Logistic regression:
For this, we used LibLinear's logistic regression implementation, so make sure that library is in your path. 
 - train_logreg.m: Function that trains the logistic regression model. The input training data is compressed by stemming mentioned above. The indicies of original features, which each represents which stemmed feature the original feature is mapped to, are stored in the file "include/stemmed_projections.mat".  The trained model is saved to "include/logreg_model.mat".
 - predict_labels_logreg.m: Uses the logistic regression model adapted from lib_linear, stored at "include/logreg_model.mat" to predict the classes of the input. 
 - test_logreg.m:  A simple script that can be used to test the model. The script:   
1) Calls train_logreg function to train the model
2) Calls predict_labels_logreg with the training data, to estimate Y_train. 
3) Calls performance_measure to get the training error, which is printed to the command line. 
4) Calls predict_labels_logreg again, with the validation data. 
After calling the script, Y_hat should be in your workspace with our predictions for the validation data. 

# Native Bayes:
For this, we used the fitcnb built into matlab. 
 - train_nb.m: Function that trains the naive bayes model. No feature selection is done to the inputs. The trained model is saved to "include/nb_model.mat".
 - predict_labels_nb.m: Uses the naive bayes model stored at "include/nb_model.mat" to predict the classes of the input.
 - test_nb.m:  A simple script that can be used to test the model. The script:   
1) Calls train_nb function to train the model
2) Calls predict_labels_nb with the training data, to estimate Y_train. 
3) Calls performance_measure to get the training error. 
4) Calls predict_labels_nb again, with the validation data. 
After calling the script, Y_hat should be in your workspace with the predictions for the validation data. 

# K-Nearest Neighbors:
For this, we used the fitcknn built into matlab. 
 - train_knn.m: Function that trains the KNN model. The inputed training data is compressed by combining words that have the same stems. The indicies of features that contain the same stems are stored in the file "include/stemmed_projections.mat". SVD is then performed on the stems to project the input to features of 200 dimensions. The "V" matrix of the SVD algorithm's output is stored in "include/V.mat". The trained model is saved to "include/knn_model.mat".
 - predict_labels_knn.m: Uses the KNN model stored at "include/knn_model.mat" to predict the classes of the input. 
 - test_nb.m:  A simple script that can be used to test the model. The script:   
1) Calls train_knn function to train the model
2) Calls predict_labels_knn with the training data, to estimate Y_train. 
3) Calls performance_measure to get the training error. 
4) Calls predict_labels_knn again, with the validation data. 
After calling the script, Y_hat should be in your workspace with the predictions for the validation data.

# Final Model:

We weren't sure if we were expected to turn in our final model training and testing code, so we included it just to be safe.
 - train_models.m: Trains all the models we use for our final submission. This includes: Logistic regression, KNN, naive bayes, SVM, and ridge regression. This saves the models in the same locations mentioned above, as well as "include/svm_model.m" for the SVM, and "include/w1.m", "include/w2.m", "include/w3.m", "include/w4.m", "include/w5.m" for five one-vs-all ridge regressions.
 - predict_labels.m: Predict's the labels using all the models trained from train_models. 
 - test.m:  A simple script that can be used to test our final model. The script:   
1) Calls train_models function to train the model
2) Calls predict_labels with the training data, to estimate Y_train. 
3) Calls performance_measure to get the training error. 
4) Calls predict_labels again, with the validation data. 
After calling the script, Y_hat should be in your workspace with the predictions for the validation data.