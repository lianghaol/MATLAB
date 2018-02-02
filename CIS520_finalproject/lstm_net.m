function [P] = lstm_net(inputArg1,inputArg2)
%LSTM_NET Summary of this function goes here
%   Detailed explanation goes here
    inputSize = number_of_features;
    outputSize = 100;
    outputMode = 'last';
    numClasses = 5;

    layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(outputSize,'OutputMode',outputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

    maxEpochs = 150;
    miniBatchSize = 100;
    shuffle = 'never';
    options = trainingOptions('sgdm', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle', shuffle);

    net_x = num2cell(X_train_part, 2);
    net_x = cellfun(@transpose,net_x,'UniformOutput',false);
    net_y = categorical(Y_train_part);
    net = trainNetwork(net_x, net_y, layers, options);
    
    net_test = num2cell(X_test_part, 2);
    net_test = cellfun(@transpose,net_test,'UniformOutput',false);
    P = predict(net, net_test);
end

