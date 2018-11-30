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
    train1_x = cv_train(:, 1:9);
    train1_y = cv_train(:, 10);
    test1_x = cv_test(:, 1:9);
    test1_y = cv_test(:, 10);
    load('Breast-Cancer/CrossValidation/Fold2/cv-train.mat');
    load('Breast-Cancer/CrossValidation/Fold2/cv-test.mat');
    train2_x = cv_train(:, 1:9);
    train2_y = cv_train(:, 10);
    test2_x = cv_test(:, 1:9);
    test2_y = cv_test(:, 10);
    load('Breast-Cancer/CrossValidation/Fold3/cv-train.mat');
    load('Breast-Cancer/CrossValidation/Fold3/cv-test.mat');
    train3_x = cv_train(:, 1:9);
    train3_y = cv_train(:, 10);
    test3_x = cv_test(:, 1:9);
    test3_y = cv_test(:, 10);
    load('Breast-Cancer/CrossValidation/Fold4/cv-train.mat');
    load('Breast-Cancer/CrossValidation/Fold4/cv-test.mat');
    train4_x = cv_train(:, 1:9);
    train4_y = cv_train(:, 10);
    test4_x = cv_test(:, 1:9);
    test4_y = cv_test(:, 10);
    load('Breast-Cancer/CrossValidation/Fold5/cv-train.mat');
    load('Breast-Cancer/CrossValidation/Fold5/cv-test.mat');
    train5_x = cv_train(:, 1:9);
    train5_y = cv_train(:, 10);
    test5_x = cv_test(:, 1:9);
    test5_y = cv_test(:, 10);



    % Do cross-validation
    % For all c
    % For all kernel parameters
    % Calculate the average cross-validation error for the 5-folds

    %your code
    c = [1, 10, 100, 1000, 10000, 100000];
    val_errs = zeros(6, 5);
    if strcmp(kerneltype, 'poly')
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
        [ci_hat, d_hat] = find(val_errs == min(val_errs(:)), 1, 'first');
        c_hat = c(ci_hat);
    elseif strcmp(kerneltype,'rbf')
        sigma = [0.01, 1, 10, 100, 1000];
        for sigmai = 1 : 5
            for ci = 1 : 6
                parameter = char(strcat('-t 2 -g', {' '}, int2str(sigma(sigmai)), ' -c', {' '}, int2str(c(ci))));
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
                val_errs(ci, sigmai) = val_err;
            end
        end
        [ci_hat, sigmai_hat] = find(val_errs == min(val_errs(:)), 1, 'first');
        c_hat = c(ci_hat);
        sigma_hat = sigma(sigmai_hat);
    end
        
        
    
    %Train SVM on training data for the best parameters
    
    %your code
    trainx = train(:, 1:9);
    trainy = train(:, 10);
    if strcmp(kerneltype,'poly')
        model = svmtrain(trainy, trainx, char(strcat('-t 1 -d', {' '}, int2str(d_hat),' -r 1 -g 1 -c', {' '}, int2str(c_hat))));
    elseif strcmp(kerneltype,'rbf')
        model = svmtrain(trainy, trainx, char(strcat('-t 2 -g', {' '}, num2str(sigma_hat), ' -c', {' '}, int2str(c_hat))));
    end
    
    % Do prediction on the test data
    % pred_labels = your prediction on the test data
    % your code
  
    [pred_labels] = svmpredict(zeros(m, 1), test_data, model);
  
    
end
