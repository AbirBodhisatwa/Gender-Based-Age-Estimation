for i = 2:51
    name = strcat('./Combined_Dataset/combined_split',int2str(i),'.mat');
    load(name);
    
    X_train = trainingSpread(:,1:1001);
    Y_train = train_age;
    %Y_train = trainingSpread(:,1002);
    
    X_test = testSpread(:,1:1001);
    Y_test = test_age;
    %Y_test = testSpread(:,1002);
    
    regModel = polyfit(X_train,Y_train,'3');
    pred = predict(regModel,X_test);
     
    figure(i)
    clf
    plotregression(Y_test,pred)
    grid on;
    set(gca,'FontWeight','bold','LineWidth',2)
    xlabel('x')
    ylabel('Subject Predicted Age')
    t = strcat('Plot of Cubic Regression Model for Original Age Prediction(Split-',int2str(i),')');
    title(t);
    name = strcat('Regression_Plots/Linear_Original_',int2str(i),'.png')
    saveas(gcf,name);
    
end