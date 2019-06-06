name = './Combined_Dataset/combined_split2.mat'
load(name);
X_train = trainingSpread(:,1:1001);
Y_train = trainingSpread(:,1002);
topfeatures = linspace(1,1001,1001);
b = 1;
bad_f1 = [];
load('bad_features.mat')
for i = 1:size(bad_f,2)
    X_train(:,bad_f(1,i)) = 0;
end

while b
    b = 0;
    [a,c] = forwardselection(X_train,Y_train,topfeatures);
    a
    if c > 0.95 
       b = 1
       if size(a,2) == 1
         for i = 1:size(a,2)
           index = a(1,i);
           bad_f1 = [bad_f1 a(1,i)]
           X_train(:,index) = 0;
         end
       end 
    end
end