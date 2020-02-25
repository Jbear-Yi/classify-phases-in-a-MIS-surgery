function [net_seq,options, acc_seq, check_seq,Path_save]=Classify_seq(isUpsample)
    
    classes=categorical({'A';'B';'C';'D'});
    [TrainX,TrainY,TestX,TestY,ValidationX,ValidationY]= TrainTest_seq(classes, isUpsample);
    Nowtime=datestr(now,'HH MM');
    mkdir(['temp/',date,' seq/',Nowtime])
    Path_save = ['temp/',date,' seq/',Nowtime];
    %% network_seq
    numFeatures = 6;
%     numHiddenUnits = 500;
    numClasses = numel(classes);

    layers = [ ...
        sequenceInputLayer(numFeatures)
        bilstmLayer(200,'OutputMode','sequence')
        dropoutLayer(0.5,'Name','drop_1')
%         lstmLayer(400,'OutputMode','sequence')
%         dropoutLayer(0.5,'Name','drop_2')
%         lstmLayer(100,'OutputMode','sequence')
%         dropoutLayer(0.5,'Name','drop_3')
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer
        ];

    options = trainingOptions('adam', ...
        'Shuffle','every-epoch', ...
        'MaxEpochs', 100, ...
        'ValidationData',{ValidationX,ValidationY}, ...
        'ValidationFrequency',30, ...
        'MiniBatchSize', 8, ...
        'GradientThreshold',2, ...
        'Verbose',1, ...
        'CheckpointPath',Path_save,...
        'InitialLearnRate',0.0001,...
        'ExecutionEnvironment','auto',...
        'Plots','training-progress');

    net_seq = trainNetwork(TrainX,TrainY,layers,options);
    pic=figure(1);
    plot(net_seq);
    saveas(pic, [Path_save '/layers.png']);
    pause(2);
    close(pic);
    saveas(findall(groot, 'Type', 'Figure'),[Path_save '/training_process.jpg']);
    %% test_seq
    for i=1:numel(TestY)
        if(~isempty(TestX{1,i}))
            predY(1,i) = classify(net_seq,TestX(1,i));
            check_seq{1,i}(1,:)=TestY{1,i}(1,:);
            check_seq{1,i}(2,:)=predY{1,i}(1,:);
            Sum(1,i)=sum(check_seq{1,i}(1,:) == check_seq{1,i}(2,:));
            Num(1,i)=numel(TestY{1,i});
            check_seq{1,i}= check_seq{1,i}';
        end
    end

    acc_seq=sum(Sum(1,:))/sum(Num(1,:));
    
end
