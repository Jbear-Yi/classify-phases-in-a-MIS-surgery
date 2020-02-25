clear;
clc;
load('data.mat');
for i=1:5
    proDepth_fix{i,1}(:,:)=proDepth{i,1}(:,:)';
end
for i=1:4
    noviceDepth_fix{i,1}(:,:)=noviceDepth{i,1}(:,:)';
end
Data_sub(1,1:5)=proDepth_fix(1:5,1);
Data_sub(1,6:9)=noviceDepth_fix(1:4,1);
save('Data_sub.mat','Data_sub');