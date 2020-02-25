%%
clear;
close all;
clc;
%% load
[file,path_a] = uigetfile('temp\*.mat','MultiSelect','on');
if ~isequal(file,0)
    
    if ischar(file)
        network = load([path_a file]);
        netGroup(1,1) = network;
        location(1,1)={[path_a file]};
    else
        [~,num_file]=size(file);
        for i=1:num_file
            netGroup(1,i)=load([path_a file{i}]);
            location(i,1)={[path_a file{i}]};
            path = path_a(1,1:numel(path_a)-1);
            if ~exist([path_a 'Acc_Check'],'dir')
                    mkdir([path_a 'Acc_Check']);
            end
        end
    end
else
    path = uigetdir;
    if path~=0
        if ~exist([path '\Acc_Check'],'dir')
                    mkdir([path '\Acc_Check']);
        end
        AllData = dir([path '\*.mat']);
        for i=1:length(AllData)
            try
                netGroup(1,i)=load([path '\' AllData(i).name]);
                location(i,1)={[path '\' AllData(i).name]};
            catch
            end
        end
    end
end
try
    fprintf('total:  %d.\n',numel(netGroup));
catch
    fprintf('No input.\n');
end
%% test ACC
classes=categorical({'A';'B';'C';'D';'Non'});

error_num=0;

if(exist('netGroup','var'))
    try
        Acc_Check_sp=check_recall('seq_sep',location,netGroup,classes,[5 9],'Y',20);
        fig = Draw_CM(Acc_Check_sp,classes,3);
        if exist('path','var')
            save_adress = [path '\Acc_Check\ACC_Check_sep.mat'];
            save(save_adress,'Acc_Check_sp');
            for h=1:(numel(fig)/2)
                saveas(fig{h,1},[path '\Acc_Check\confusionchart_sep_' num2str(h) '.png']);
                saveas(fig{h,2},[path '\Acc_Check\roc_sep_' num2str(h) '.png']);
            end
        end
    catch ME
        error_num = error_num+1;
        fprintf('Error: %d.\n',error_num);
        error(ME.message);
        pause();
    end
end
sound(sin(0.25*pi*(1:3000)));
pause(0.6);
sound(sin(0.25*pi*(1:3000)));
pause(0.6);
sound(sin(0.25*pi*(1:3000)));