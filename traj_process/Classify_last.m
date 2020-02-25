function [net_last,options, acc_last, check_last]=Classify_last(Rate1,Rate2)
    
    classes=categorical({'A';'B';'C';'D1';'D2'});
    [TrainX,TrainY,TestX,TestY,ValidationX,ValidationY]= TrainTest_last(classes,Rate1,Rate2);
    Nowtime=datestr(now,'HH MM');
    mkdir(['temp/',date,' last/',Nowtime])

    
    %% network_last
    numFeatures = 6;
    numHiddenUnits = 30;
    numClasses = 5;

    layers = [ ...
        sequenceInputLayer(numFeatures)
        lstmLayer(numHiddenUnits,'OutputMode','last')
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer];

    options = trainingOptions('adam', ...
        'Shuffle','every-epoch', ...
        'MaxEpochs', 20, ...
        'ValidationData',{ValidationX,ValidationY}, ...
        'ValidationFrequency',10, ...
        'MiniBatchSize', 16, ...
        'GradientThreshold',2, ...
        'Verbose',1, ...
        'ExecutionEnvironment','auto',...
        'CheckpointPath',['temp/',date,' last/',Nowtime],... 
        'Plots','training-progress');
    net_last = trainNetwork(TrainX,TrainY,layers,options);

    %% test_last
    for i=1:numel(TestY)
        if(~isempty(TestX{i,1}))
            predY(i,1) = classify(net_last,TestX(i,1));
            check_last(i,1)=TestY(i,1);
            check_last(i,2)=predY(i,1);
            Sum(i,1)=sum(check_last(i,1) == check_last(i,2));
        end
    end

    acc_last=sum(Sum(:,1))/numel(TestY);
    
end