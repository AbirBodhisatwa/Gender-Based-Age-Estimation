avg_train_acc = 0;
avg_train_std = 0;

avg_test_acc = 0;
avg_test_std = 0;

avg_conf_mat = zeros(2,2);
avg_class_mat = zeros(2,2);

load('bad_features.mat')


for i = 2:51
    name = strcat('./Combined_Dataset/combined_split',int2str(i),'.mat');
    load(name);
    
    X_train = trainingSpread(:,1:1001);
    o_X_train = X_train; 
    Y_train = trainingSpread(:,1002);
    
    X_test = testSpread(:,1:1001);
    o_X_test = X_test;
    Y_test = testSpread(:,1002);
     
     for j = 1:size(bad_f,2)
      X_train(:,bad_f(1,j)) = 0;
      X_test(:,bad_f(1,j)) = 0;
     end
    
    %model = fitcsvm(X_train,Y_train);
    %model = fitcdiscr(X_train,Y_train);
    
    model = fitctree(X_train,Y_train);
    
    %Training Stats
    %train_pred = predict(model,X_train);
    %train_ConfMat = confusionmat(Y_train,train_pred);
    %train_ClassMat = train_ConfMat./(meshgrid(countcats(categorical(Y_train)))');
    %train_acc = mean(diag(train_ClassMat))
    %train_std = std(diag(train_ClassMat))
    
    %avg_train_acc = avg_train_acc + train_acc;
    %avg_train_std = avg_train_std + train_std;
     
    %Testing Stats
    test_pred = predict(model,X_test);
    test_ConfMat = confusionmat(Y_test,test_pred);
     
    test_ClassMat = test_ConfMat./(meshgrid(countcats(categorical(Y_test)))');
    test_acc = mean(diag(test_ClassMat));
    test_std = std(diag(test_ClassMat));
     
    avg_test_acc = avg_test_acc + test_acc;
    avg_test_std = avg_test_std + test_std;    
     
    avg_conf_mat = avg_conf_mat + test_ConfMat;
    avg_class_mat = avg_class_mat + test_ClassMat;    
    
    fitRegressionModel(i,o_X_train,train_age,o_X_test,test_age,Y_train,test_pred)
end

%calculating the average train accuracy and std over 50 iteration
%avg_train_acc = avg_train_acc / 50
%avg_train_std = avg_train_std / 50

%calculating the average test accuracy and std over 100 iteration
avg_test_acc = avg_test_acc / 50
avg_test_std = avg_test_std / 50

avg_class_mat =  avg_class_mat / 50
avg_conf_mat  =  avg_conf_mat / 50



