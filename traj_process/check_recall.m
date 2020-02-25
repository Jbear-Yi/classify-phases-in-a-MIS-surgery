function Acc_Check_ss=check_recall(mode,location,netGroup,classes,dataset,IsUpsample,nub_sep)
    if nargin==6
        if isequal(mode , 'seq')
            [TestX, TestY]=Class_seq(classes,dataset,IsUpsample);
        elseif isequal(mode , 'seq_long')
            [TestX, TestY]=Class_seq_long(classes,dataset,IsUpsample);
        end
    elseif nargin==7
        if isequal(mode , 'seq_sep')
            [TotalX, TotalY]=Class_seq_long(classes,dataset,IsUpsample);
            count = 0;
            TestX = cell(1,nub_sep*numel(dataset));
            TestY = cell(1,nub_sep*numel(dataset));
            for i=dataset
                for j=1:nub_sep
                    TestY{j+count*nub_sep}=TotalY{i}(:,(j-1)*fix(numel(TotalY{i})/nub_sep)+1:j*fix(numel(TotalY{i})/nub_sep));
                    TestX{j+count*nub_sep}=TotalX{i}(:,(j-1)*fix(numel(TotalY{i})/nub_sep)+1:j*fix(numel(TotalY{i})/nub_sep));
                end
                count = count + 1;
            end
        end
    end
    process=0;
    fprintf('Start...\n');
    for p= 1:length(netGroup)
        tic
        net=netGroup(p).net;
        for i=1:numel(TestY)
            if ~isempty(TestY{1,i})
                predY(1,i) = classify(net,TestX(1,i));
                check{1,i}=TestY{1,i}';
                check{1,i}(:,2)=predY{1,i}';
            end
        end
        for j=1:(numel(classes)+2)
            sum_All=0;
            sum_Num=0;
            switch j
                case 1
                    for i=1:numel(TestY)
                        if ~isempty(TestY{1,i})
                            sum_All=sum_All+sum(TestY{1,i}==predY{1,i});
                            sum_Num=sum_Num+sum(numel(TestY{1,i}));
                        end
                    end
                    ACC=sum_All/sum_Num;
                case 2
                    for i=1:numel(TestY)
                        if ~isempty(TestY{1,i})
                            Index_xNon=find(ismember(TestY{1,i},classes));
                            sum_All=sum_All+sum(TestY{1,i}(Index_xNon)==predY{1,i}(Index_xNon));
                            sum_Num=sum_Num+sum(numel(TestY{1,i}(Index_xNon)));
                        end
                    end
                    ACC_xNon=sum_All/sum_Num;                    
                otherwise
                    for i=1:numel(TestY)
                        if ~isempty(TestY{1,i})
                            Index = find(ismember(TestY{1,i},classes(j-2)));
                            sum_All=sum_All+sum(TestY{1,i}(Index)==predY{1,i}(Index));
                            sum_Num=sum_Num+sum(numel(TestY{1,i}(Index)));
                        end
                    end
                    eval([char(classes(j-2)) '=sum_All/sum_Num;']);
            end
        end
        Name = location(p,1);
        Check={check};
        Acc_Check_ss(p,:) = table(Name,A,B,C,D,ACC,ACC_xNon,Check);
        process = process + 100/(length(netGroup));
        fprintf('Process:%.2f%%. Finish:%d/%d. Acc_xNon:%.2f%%. \n',process,p,numel(netGroup),ACC_xNon*100);
        toc
    end
    fprintf('Finish...\n');
end