Gender Based Age Estimation Readme

Matlab Modules
----------

*Build_Classifier.m : Runs the Classification Model and based on the output calls the Regression Model

*Check_Features.m : Finds the features which are not suitable for the classification task. Uses the Forward Selection Algorithm. Stored the unsuitable features in file bad_features.mat

*fitRegressionModel.m : Trains the linear regression model based on the output of classifier. Is invoked by Build_Classifier.

*forwardselection.m : Implementation of Forward Selection Algorithm. Is invoked by Check_Features.

*Original_Regression_Problem.m: Gender-Neural Linear Regression Model for Age Estimation.

*Gen_Data_Set.m: Makes the dataset for classification task.

*New_Dataset: intermediate datasets with labels for genders, but in separate categories.
Combined_dataset: final dataset which has gender labels and is unified for males and females. The classification task takes data from here.
