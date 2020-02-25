clc;
clear;
%%
if(~exist('label_all.mat','file'))
    label_all{1,1}=labelS1;
    label_all{1,2}=labelS2;
    label_all{1,3}=labelS3;
    label_all{1,4}=labelS4;
    label_all{1,5}=labelS5;
    label_all{1,6}=labelS6;
    label_all{1,7}=labelS7;
    label_all{1,8}=labelS8;
    label_all{1,9}=labelS9;
    save('label_all.mat','label_all','label');
end
%%
clc;
clear;
load('label_all.mat');
for i=1:9
    for j=1:4
        count=1;
        for k=1:((numel(label_all{1,i})/5)-1)/2
            if(~isnan(label_all{1,i}{j,k*2}))
                Class_frame{i,j}(1,count)=label_all{1,i}{j,k*2};
                Class_frame{i,j}(2,count)=label_all{1,i}{j,k*2+1};
                count=count+1;
            end
        end
    end
    for k=1:((numel(label_all{1,i})/5)-1)/2
            if(~isnan(label_all{1,i}{j+1,k*2}))
                Class_frame{i,j}(1,count)=label_all{1,i}{j+1,k*2};
                Class_frame{i,j}(2,count)=label_all{1,i}{j+1,k*2+1};
            end
    end
end
%%
save('Class_frame.mat','Class_frame');