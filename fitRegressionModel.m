function [pred_male_age,pred_female_age] = fitRegressionModel(k,X_train,Y_train,X_test,Y_test,train_labels,test_labels)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    X_train_male = [];
    Y_train_male = [];
    X_train_female = [];
    Y_train_female = [];
    
    X_test_male = [];
    Y_test_male = [];
    X_test_female = [];
    Y_test_female = [];
    
    for i = 1 : size(train_labels,1)
        if train_labels(i,:) == 0
            X_train_male = [X_train_male; X_train(i,:)];
            Y_train_male = [Y_train_male; Y_train(i,:)];
        else
            X_train_female = [X_train_female; X_train(i,:)];
            Y_train_female = [Y_train_female; Y_train(i,:)];
        end
    end
    
     for i = 1 : size(test_labels,1)
        if test_labels(i,:) == 0
            X_test_male = [X_test_male; X_test(i,:)];
            Y_test_male = [Y_test_male; Y_test(i,:)];
        else
            X_test_female = [X_test_female; X_test(i,:)];
            Y_test_female = [Y_test_female; Y_test(i,:)];
        end
     end
    
    %size(X_train_male)
    %size(Y_train_male)
    
    %size(X_train_female)
    %size(Y_train_female)
    
    %size(X_test_male)
    %size(Y_test_male)
    
    %size(X_test_female)
    %size(Y_test_female)
    
    regModel_Male = fitnlm(X_train_male,Y_train_male);
    regModel_Female = fitnlm(X_train_female,Y_train_female);
    
    pred_male_age = predict(regModel_Male,X_test_male)
    Y_test_male
    pred_female_age = predict(regModel_Female,X_test_female)
    Y_test_female
    
    
    figure(k)
    clf
    plotregression(Y_test_male,pred_male_age)
    grid on;
    set(gca,'FontWeight','bold','LineWidth',2)
    xlabel('x')
    ylabel('Male Predicted Age')
    int2str(k)
    t = strcat('Plot of Non Linear Regression Model for Age Prediction of Males(Split-',int2str(k),')');
    title(t);
    name = strcat('Regression_Plots/Non Linear_Plot_Male_',int2str(k),'.png')
    saveas(gcf,name);
    
    a = 100 + k
    figure(a)
    clf
    plotregression(Y_test_female,pred_female_age)
    grid on;
    set(gca,'FontWeight','bold','LineWidth',2)
    xlabel('x')
    ylabel('Female Predicted Age')
    int2str(k)
    t = strcat('Plot of Regression Model for Age Prediction of Females(Split-',int2str(k),')');
    title(t);
    name = strcat('./Regression_Plots/Non Linear_Plot_Female_',int2str(k),'.png')
    saveas(gcf,name);
end

