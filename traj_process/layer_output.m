clear;
close all
clc;
%%
classes=categorical({'A';'B';'C';'D'});
[TestX,TestY]=Class_seq(classes,[5,9]);
%% load
[file,path_a] = uigetfile('temp\*.mat');
if ~isequal(file,0)
    net = load([path_a file]).net;
    location(1,1)={[path_a file]};
end
%%
str='';
for i=1:numel(TestX)
    features(i) = activations(net,TestX(i),'softmax');
    label_hot(i)=hotencoding(TestY{i}',classes);
    str{i,1}=['label_hot{' num2str(i) '} '];
    str{i,2}=['features{' num2str(i) '} '];
end
eval(['forROC{1}=[' str{:,1} '];']);
eval(['forROC{2}=[' str{:,2} '];']);

for k=1:length(forROC{2})
    var_sm(k)=var(forROC{2}(:,k));
end
[var_min,var_min_idx]=min(var_sm);

figure(1);
plotroc(forROC(1),forROC(2));
hold on;
[tpr,fpr,thresholds] = roc(forROC(1),forROC(2));
for j=1:numel(classes)
    t0_5{j}=find(thresholds{j}<0.5);
    plot_x(j)=fpr{j}(t0_5{j}(1));
    plot_y(j)=tpr{j}(t0_5{j}(1));
end
plot(plot_x,plot_y,'or');

figure(2);
plotconfusion(forROC(1),forROC(2));