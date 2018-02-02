function [pred_labels] = SVM_train(test_data, kerneltype)
    % INPUT : 
    % test_data   - m X n matrix, where m is the number of test points and n is number of features
    % kerneltype  - one of strings 'poly', 'rbf'
    %               corresponding to polynomial, and RBF kernels
    %               respectively.
    
    % OUTPUT
    % returns a m X 1 vector predicted labels for each of the test points. The labels should be +1/-1 doubles

    
    % Default code below. Fill in your code on all the relevant positions

    m = size(test_data , 1);
    n = size(test_data, 2);

    %load train_data

    datadir = 'Breast-Cancer/';

    load(strcat(datadir,'train.mat'));
    

    %load cross-validation data
    %your code
    load('Breast-Cancer/CrossValidation/Fold1/cv-train.mat');
    load('Breast-Cancer/CrossValidation/Fold1/cv-test.mat');
    train1_x = cv_train(:, 1:2);
    train1_y = cv_train(:, 3);
    test1_x = cv_test(:, 1:2);
    test1_y = cv_test(:, 3);
    load('Breast-Cancer/CrossValidation/Fold2/cv-train.mat');
    load('Breast-Cancer/CrossValidation/Fold2/cv-test.mat');
    train2_x = cv_train(:, 1:2);
    train2_y = cv_train(:, 3);
    test2_x = cv_test(:, 1:2);
    test2_y = cv_test(:, 3);
    load('Breast-Cancer/CrossValidation/Fold3/cv-train.mat');
    load('Breast-Cancer/CrossValidation/Fold3/cv-test.mat');
    train3_x = cv_train(:, 1:2);
    train3_y = cv_train(:, 3);
    test3_x = cv_test(:, 1:2);
    test3_y = cv_test(:, 3);
    load('Breast-Cancer/CrossValidation/Fold4/cv-train.mat');
    load('Breast-Cancer/CrossValidation/Fold4/cv-test.mat');
    train4_x = cv_train(:, 1:2);
    train4_y = cv_train(:, 3);
    test4_x = cv_test(:, 1:2);
    test4_y = cv_test(:, 3);
    load('Breast-Cancer/CrossValidation/Fold5/cv-train.mat');
    load('Breast-Cancer/CrossValidation/Fold5/cv-test.mat');
    train5_x = cv_train(:, 1:2);
    train5_y = cv_train(:, 3);
    test5_x = cv_test(:, 1:2);
    test5_y = cv_test(:, 3);



    % Do cross-validation
    % For all c
    % For all kernel parameters
    % Calculate the average cross-validation error for the 5-folds

    %your code
    c = [1, 10, 100, 1000, 10000, 100000];
    val_errs = zeros(6, 5);
    if kerneltype == 'poly'
        for d = 1 : 5
            for ci = 1 : 6
                model1 = svmtrain(train1_y, train1_x, strcat('-t 1 -d ', int2str(d), ' -r 1 -g 1 -c ', int2str(c(ci))));
                [pred1] = svmpredict(test1_y, test1_x, model1);
                err1 = classification_error(pred1, test1_y);
                
                model2 = svmtrain(train2_y, train2_x, strcat('-t 1 -d ', int2str(d), ' -r 1 -g 1 -c ', int2str(c(ci))));
                [pred2] = svmpredict(test2_y, test2_x, model2);
                err2 = classification_error(pred2, test2_y);
                
                model3 = svmtrain(train3_y, train3_x, strcat('-t 1 -d ', int2str(d), ' -r 1 -g 1 -c ', int2str(c(ci)));
                [pred3] = svmpredict(test3_y, test3_x, model3);
                err3 = classification_error(pred3, test3_y);
                
                model4 = svmtrain(train4_y, train4_x, strcat('-t 1 -d ', int2str(d), ' -r 1 -g 1 -c ', int2str(c(ci))));
                [pred4] = svmpredict(test4_y, test4_x, model4);
                err4 = classification_error(pred4, test4_y);
                
                model5 = svmtrain(train5_y, train5_x, strcat('-t 1 -d ', int2str(d), ' -r 1 -g 1 -c ', int2str(c(ci))));
                [pred5] = svmpredict(test5_y, test5_x, model5);
                err5 = classification_error(pred5, test5_y);
                
                model6 = svmtrain(train6_y, train6_x, strcat('-t 1 -d ', int2str(d), ' -r 1 -g 1 -c ', int2str(c(ci))));
                [pred6] = svmpredict(test6_y, test6_x, model6);
                err6 = classification_error(pred6, test6_y);
                
                val_err = mean([err1 err2 err3 err4 err5 err6]);
                val_errs(ci, d) = val_err;
            end
        end
        [ci_hat, ~] = find(val_errs == min(val_errs));
        c_hat = c(ci_hat);
    end
    %Train SVM on training data for the best parameters
    
    %your code
    trainx = train(:, 1:2);
    trainy = train(:, 3);
    if kerneltype == 'poly'
        model1 = svmtrain(trainy, trainx, strcat('-t 1 -d 1 -r 1 -g 1 -c ', int2str(c_hat(1))));
        [pred1] = svmpredict(trainy, trainx, model1);
        err1 = classification_error(pred1, trainy);
        model2 = svmtrain(trainy, trainx, strcat('-t 1 -d 2 -r 1 -g 1 -c ', int2str(c_hat(2))));
        [pred2] = svmpredict(trainy, trainx, model2);
        err2 = classification_error(pred2, trainy);
        model3 = svmtrain(trainy, trainx, strcat('-t 1 -d 3 -r 1 -g 1 -c ', int2str(c_hat(3))));
        [pred3] = svmpredict(trainy, trainx, model3);
        err3 = classification_error(pred3, trainy);
        model4 = svmtrain(trainy, trainx, strcat('-t 1 -d 4 -r 1 -g 1 -c ', int2str(c_hat(4))));
        [pred4] = svmpredict(trainy, trainx, model4);
        err4 = classification_error(pred4, trainy);
        model5 = svmtrain(trainy, trainx, strcat('-t 1 -d 5 -r 1 -g 1 -c ', int2str(c_hat(5))));
        [pred5] = svmpredict(trainy, trainx, model5);
        err5 = classification_error(pred5, trainy);
        errs = [err1 err2 err3 err4 err5];
        models = [model1 model2 model3 model4 model5];
        di_hat = errs == min(errs);
        model = models(di_hat);
    end
    


    % Do prediction on the test data
    % pred_labels = your prediction on the test data
    % your code
    if kerneltype == 'poly'
        [pred_labels] = svmpredict(zeros(m, 1), test_data, model);
    end
    














end
