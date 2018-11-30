function PolyPlots(train_data, test_data)
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

    %load cross-validation data
    %your code
    load('Synthetic/CrossValidation/Fold1/cv-train.mat');
    load('Synthetic/CrossValidation/Fold1/cv-test.mat');
    train1_x = cv_train(:, 1:2);
    train1_y = cv_train(:, 3);
    test1_x = cv_test(:, 1:2);
    test1_y = cv_test(:, 3);
    load('Synthetic/CrossValidation/Fold2/cv-train.mat');
    load('Synthetic/CrossValidation/Fold2/cv-test.mat');
    train2_x = cv_train(:, 1:2);
    train2_y = cv_train(:, 3);
    test2_x = cv_test(:, 1:2);
    test2_y = cv_test(:, 3);
    load('Synthetic/CrossValidation/Fold3/cv-train.mat');
    load('Synthetic/CrossValidation/Fold3/cv-test.mat');
    train3_x = cv_train(:, 1:2);
    train3_y = cv_train(:, 3);
    test3_x = cv_test(:, 1:2);
    test3_y = cv_test(:, 3);
    load('Synthetic/CrossValidation/Fold4/cv-train.mat');
    load('Synthetic/CrossValidation/Fold4/cv-test.mat');
    train4_x = cv_train(:, 1:2);
    train4_y = cv_train(:, 3);
    test4_x = cv_test(:, 1:2);
    test4_y = cv_test(:, 3);
    load('Synthetic/CrossValidation/Fold5/cv-train.mat');
    load('Synthetic/CrossValidation/Fold5/cv-test.mat');
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
%     c_hat = [100, 100, 1, 10, 100];
    if exist('c_hat', 'var') ~= 1
        for d = 1 : 5
            for ci = 1 : 6
                parameter = char(strcat('-t 1 -d', {' '}, int2str(d), ' -r 1 -g 1 -c', {' '}, int2str(c(ci))));
                model1 = svmtrain(train1_y, train1_x, parameter);
                [pred1] = svmpredict(test1_y, test1_x, model1, '-q');
                err1 = classification_error(pred1, test1_y);

                model2 = svmtrain(train2_y, train2_x, parameter);
                [pred2] = svmpredict(test2_y, test2_x, model2, '-q');
                err2 = classification_error(pred2, test2_y);

                model3 = svmtrain(train3_y, train3_x, parameter);
                [pred3] = svmpredict(test3_y, test3_x, model3, '-q');
                err3 = classification_error(pred3, test3_y);

                model4 = svmtrain(train4_y, train4_x, parameter);
                [pred4] = svmpredict(test4_y, test4_x, model4, '-q');
                err4 = classification_error(pred4, test4_y);

                model5 = svmtrain(train5_y, train5_x, parameter);
                [pred5] = svmpredict(test5_y, test5_x, model5, '-q');
                err5 = classification_error(pred5, test5_y);

                val_err = mean([err1 err2 err3 err4 err5]);
                val_errs(ci, d) = val_err;
            end
        end
        disp(val_errs);
        ci_hat = zeros(1, 5);
        val_err_hat = zeros(1, 5);
        for i = 1 : 5
            val_err_hat(i) = min(val_errs(:, i));
            ci_hat(i) = find(val_errs(:, i) == min(val_errs(:, i)), 1, 'first');
        end
        c_hat = c(ci_hat);
    end
    disp(c_hat)
    %Train SVM on training data for the best parameters

    %your code
    trainx = train_data(:, 1:2);
    trainy = train_data(:, 3);
    testx = test_data(:, 1:2);
    testy = test_data(:, 3);
    
    model1 = svmtrain(trainy, trainx, char(strcat('-t 1 -d 1 -r 1 -g 1 -c',{' '}, int2str(c_hat(1)))));
%     decision_boundary_SVM(trainx, trainy, model1, 200, 'poly_model1_boundary')
    [~, train_accuracy, ~] = svmpredict(trainy, trainx, model1);
    train_err1 = (100 - train_accuracy(1)) / 100;
    
    [~, test_accuracy, ~] = svmpredict(testy, testx, model1);
    test_err1 = (100 - test_accuracy(1)) / 100;
   
    
    model2 = svmtrain(trainy, trainx, char(strcat('-t 1 -d 2 -r 1 -g 1 -c',{' '}, int2str(c_hat(2)))));
%     decision_boundary_SVM(trainx, trainy, model2, 200, 'poly_model2_boundary')
    [~, train_accuracy, ~] = svmpredict(trainy, trainx, model2);
    train_err2 = (100 - train_accuracy(1)) / 100;
    
    [~, test_accuracy, ~] = svmpredict(testy, testx, model2);
    test_err2 = (100 - test_accuracy(1)) / 100; 
    
    model3 = svmtrain(trainy, trainx, char(strcat('-t 1 -d 3 -r 1 -g 1 -c',{' '}, int2str(c_hat(3)))));
%     decision_boundary_SVM(trainx, trainy, model3, 200, 'poly_model3_boundary')
    [~, train_accuracy, ~] = svmpredict(trainy, trainx, model3);
    train_err3 = (100 - train_accuracy(1)) / 100;
    
    [~, test_accuracy, ~] = svmpredict(testy, testx, model3);
    test_err3 = (100 - test_accuracy(1)) / 100;
    
    model4 = svmtrain(trainy, trainx, char(strcat('-t 1 -d 4 -r 1 -g 1 -c',{' '}, int2str(c_hat(4)))));
%     decision_boundary_SVM(trainx, trainy, model4, 200, 'poly_model4_boundary')
    [~, train_accuracy, ~] = svmpredict(trainy, trainx, model4);
    train_err4 = (100 - train_accuracy(1)) / 100;
    
    [~, test_accuracy, ~] = svmpredict(testy, testx, model4);
    test_err4 = (100 - test_accuracy(1)) / 100;
    
    model5 = svmtrain(trainy, trainx, char(strcat('-t 1 -d 5 -r 1 -g 1 -c',{' '}, int2str(c_hat(5)))));
%     decision_boundary_SVM(trainx, trainy, model5, 200, 'poly_model5_boundary')
    [~, train_accuracy, ~] = svmpredict(trainy, trainx, model5);
    train_err5 = (100 - train_accuracy(1)) / 100;
    
    [~, test_accuracy, ~] = svmpredict(testy, testx, model5);
    test_err5 = (100 - test_accuracy(1)) / 100; 
    
%   Plot Train-Test Errors over q
    train_err = [train_err1 train_err2 train_err3 train_err4 train_err5];
    test_err = [test_err1 test_err2 test_err3 test_err4 test_err5];
    disp(train_err)
    disp(test_err)
    disp(val_err_hat)
    q = [1 2 3 4 5];
    PlotErrors_Poly(train_err, test_err, val_err_hat, q, 'Poly_Val_Errs');

end
