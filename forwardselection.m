function [forwardselected,new_acc] = forwardselection(TrainMat, LabelTrain, topfeatures)
%% input: TrainMat - a NxM matrix that contains the full list of features
%% of training data. N is the number of training samples and M is the
%% dimension of the feature. So each row of this matrix is the face
%% features of a single person.
%%        LabelTrain - a Nx1 vector of the class labels of training data
%%        topfeatures - a 1XK matrix that contains the information of the
%% top 1% features of the highest variance ratio. K is the number of
%% selected feature (K = ceil(M*0.01)). The first column of this matrix is
%% the index of the selected features in the original feature list. So the
%% range of topfeatures(:,1) is between 1 and M. The second column of this
%% matrix is the variance ratio of the selected features.

%% output: forwardselected - a Px1 vector that contains the index of the 
%% selected features in the original feature list, where P is the number of
%% selected features. The range of forwardselected is between 1 and M. 

%setting the accuracies to compare performance 
old_acc = 0;
new_acc = 0.0001;

%candidate_features = topfeatures(:,1)';
candidate_features = topfeatures;
forwardselected = [];

while new_acc > old_acc
  feature_acc = zeros(1,size(candidate_features,2));
  k = 1;
  tmp_feat = forwardselected;
  for i = candidate_features
      tmp_feat = [forwardselected i];
      
      new_Train = TrainMat(:,tmp_feat');
      
      %MdlLinear = fitcdiscr(new_Train,LabelTrain,'discrimType','pseudoLinear');
      %MdlLinear = fitglm(new_Train,LabelTrain);
      MdlLinear = fitctree(new_Train,LabelTrain);
      
      train_pred = predict(MdlLinear,new_Train);
      train_ConfMat = confusionmat(LabelTrain,train_pred);
      train_ClassMat = train_ConfMat./(meshgrid(countcats(categorical(LabelTrain)))');
      acc = mean(diag(train_ClassMat));
      
      feature_acc(k) = acc;
      k = k + 1;
  end
  
    old_acc = new_acc;
    [new_acc,I] = max(feature_acc);
    new_acc
    %I
    forwardselected = [forwardselected candidate_features(I)];
    candidate_features(I) = [];
    %feature_acc;
    if size(forwardselected,2) == size(topfeatures(:,1),1)
      break
    end
end
forwardselected = forwardselected';
 



