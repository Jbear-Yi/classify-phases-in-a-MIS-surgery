%% load Data
clear;
clc;
load('Data_sub.mat');
if(exist('log.mat','file'))
    load('log.mat');
end
    
%Class_frame=reload_Class_frame();%reload Class_frame

%% plot
prompt1 ='Do you want plot in 3D?  Y/N [N]: ';
If_Plot = input(prompt1,'s');
if isempty(If_Plot)
    If_Plot = 'N';
end
if(If_Plot=='Y')
%     while(1)
%         prompt1 ='Which one do you want to plot? 1-5:';
%         num = int32(input(prompt1));
%         if isempty(num)
%             num = 1;
%         end
%         prompt2 ='What divieder do you want to use? int:';
%         divide = int32(input(prompt2));
%         if isempty(divide)
%             divide = 1;
%         end
%         if(num>0&&num<6&&divide>0)
%             break;
%         end
%     end
%     Plot_in_3D(num,divide,Data_sub);
    way=pwd;
    cd ..\Plot_fig;
    app2;
    pause();
    cd(way);
end

%% train
while(1)
    prompt3 ='Which one do you want to train?  seq/(last/seq_long/all)[seq]: ';
    train_mode = input(prompt3,'s');
    if ~isequal(train_mode,'quit')
        parpool('local', gpuDeviceCount);
        spmd
            try nnet.internal.cnngpu.reluForward(1); catch ME, end
        end
    end
    
    if isempty(train_mode)
        train_mode = "seq";
    end
    prompt4 ='Do upsample?  Y/N [Y]: ';
    isUpsample = input(prompt4,'s');
    if isequal(isUpsample,'')
        isUpsample = 'Y';
    end
    
    if(train_mode=="seq")
        [net_seq,options_seq, acc_seq, check_seq, Path_Save]=Classify_seq(isUpsample);
        break;
%     elseif(train_mode=="last")
%         [net_last,options_last, acc_last, check_last]=Classify_last(0.7,0.15);
%         break;
%     elseif(train_mode=="seq_long")
%         [net_seq_long,options_seq_long, acc_seq_long, acc_seq_long_withoutNon, check_seq_long]=Classify_seq_long(0.7,0.15);
%         break;
%     elseif(train_mode=="all")
%         [net_seq,options_seq, acc_seq, check_seq]=Classify_seq(0.7,0.15);
%         [net_last,options_last, acc_last, check_last]=Classify_last(0.7,0.15);
%         [net_seq_long,options_seq_long, acc_seq_long, acc_seq_long_withoutNon, check_seq_long]=Classify_seq_long(0.7,0.15);
%         break;
    elseif(train_mode=="quit")
        clear;
        clc;
        break;
    end
end
%% save
    try delete(gcp('nocreate'));
    catch EM2
    end
    
if(exist('net_last','var')||exist('net_seq','var')||exist('net_seq_long','var'))
    if(exist('log','var'))
        log=table2cell(log);
        [log_num,~]=size(log);
        log_num=log_num+1;
    else
        log_num=1;   
        log=cell([1,15]);
    end
    load('seed.mat');
    log(log_num,1)={datestr(now)};
    if(exist('net_seq','var'))
        log(log_num,2)={net_seq};
        log(log_num,3)={options_seq};
        log(log_num,4)={acc_seq};
        log(log_num,5)={check_seq};
    end
    if(exist('net_last','var'))
        log(log_num,6)={net_last};
        log(log_num,7)={options_last};
        log(log_num,8)={acc_last};
        log(log_num,9)={check_last};
    end
    if(exist('net_seq_long','var'))
        log(log_num,10)={net_seq_long};
        log(log_num,11)={options_seq_long};
        log(log_num,12)={acc_seq_long};
        log(log_num,13)={acc_seq_long_withoutNon};
        log(log_num,14)={check_seq_long};
    end
    log(log_num,15)={s};
    log=cell2table(log);
    log.Properties.VariableNames={'Time'; 'net_seq'; 'options_seq'; 'acc_seq'; 'check_seq'; 'net_last'; 'options_last'; 'acc_last'; 'check_last'; 'net_seq_long'; 'options_seq_long'; 'acc_seq_long'; 'acc_seq_long_withoutNon'; 'check_seq_long'; 'seed'};

    save('log.mat','log');
    clear;
    load('log.mat');
    [log_num,~]=size(log);
    log(log_num,:);
end
%%
sound(sin(0.25*pi*(1:3000)));
pause(0.5);
sound(sin(0.25*pi*(1:3000)));