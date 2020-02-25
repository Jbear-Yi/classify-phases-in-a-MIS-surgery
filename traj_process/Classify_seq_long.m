function [net_seq_long,options, acc_seq_long, acc_seq_long_withoutNon, check_seq_long]=Classify_seq_long(Rate1,Rate2)
    
    classes=categorical({'A';'B';'C';'D1';'D2';'Non'});
    [TrainX,TrainY,TestX,TestY,ValidationX,ValidationY]= TrainTest_seq_long(classes,Rate1,Rate2);
    Nowtime=datestr(now,'HH MM');
    mkdir(['temp/',date,' seq_long/',Nowtime])
    
    %% network_seq_long
    numFeatures = 6;
    numHiddenUnits = 50;
    numClasses = 6;

    layers = [ ...
        sequenceInputLayer(numFeatures)
        lstmLayer(numHiddenUnits,'OutputMode','sequence')
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer];

    options = trainingOptions('adam', ...
        'Shuffle','every-epoch', ...
        'MaxEpochs', 20, ...
        'ValidationData',{ValidationX,ValidationY}, ...
        'ValidationFrequency',10, ...
        'MiniBatchSize', 32, ...
        'GradientThreshold',2, ...
        'Verbose',1, ...
        'CheckpointPath',['temp/',date,' seq_long/',Nowtime],...
        'ExecutionEnvironment','auto',...
        'Plots','training-progress');

    net_seq_long = trainNetwork(TrainX,TrainY,layers,options);

    %% test_seq_long
    for i=1:numel(TestY)
        if(~isempty(TestX{1,i}))
            predY(1,i) = classify(net_seq_long,TestX(1,i));
            check_seq_long{1,i}(1,:)=TestY{1,i}(1,:);
            check_seq_long{1,i}(2,:)=predY{1,i}(1,:);
            Sum(1,i)=sum(check_seq_long{1,i}(1,:) == check_seq_long{1,i}(2,:));
            Num(1,i)=numel(TestY{1,i});
            check_seq_long{1,i}= check_seq_long{1,i}';
            Sum_withoutNon(1,i)=0;
            Num_withoutNon(1,i)=0;
            for j=1:Num(1,i)
                if(check_seq_long{1,i}(j,1)~=classes(6,1))
                    Num_withoutNon(1,i)=Num_withoutNon(1,i)+1;
                    if(check_seq_long{1,i}(j,1) == check_seq_long{1,i}(j,2))
                        Sum_withoutNon(1,i)=Sum_withoutNon(1,i)+1;
                    end
                end
            end
        end
    end

    acc_seq_long=sum(Sum(1,:))/sum(Num(1,:));
    acc_seq_long_withoutNon=sum(Sum_withoutNon(1,:))/sum(Num_withoutNon(1,:));
    
end