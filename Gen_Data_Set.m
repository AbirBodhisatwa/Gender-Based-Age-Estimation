for i = 2:51
    name_1 = strcat('./New_Dataset/s',int2str(i),'_m.mat');
    load(name_1);
    a = trainingSpread;
    b = testSpread;
    
    train_age_1 = train_age;
    test_age_1 = test_age;
    
    name_2 = strcat('./New_Dataset/s',int2str(i),'_f.mat');
    load(name_2);
    c = trainingSpread;
    d = testSpread;
    
    train_age_2 = train_age;
    test_age_2 = test_age;
    
    trainingSpread = [a; c];
    testSpread = [b; d];
    
    train_age = [train_age_1; train_age_2];
    test_age = [test_age_1; test_age_2];
    
    o_name = strcat('combined_split',int2str(i),'.mat');
    save(o_name,'trainingSpread','testSpread','train_age','test_age');
end