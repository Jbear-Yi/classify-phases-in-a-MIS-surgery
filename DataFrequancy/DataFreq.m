clear;
clc;
%%
load('label_all.mat');
%% initial
count_A=1;
count_B=1;
count_C=1;
count_D=1;
%% count
num_database = numel(label_all);
for i=1:num_database
    [~,num]=size(label_all{1,i});
    num=(num-1)/2;
    for j=1:num
        if ~isnan(label_all{1,i}{1,2*j+1})
            num_A(1,count_A)=label_all{1,i}{1,2*j+1}-label_all{1,i}{1,2*j};
            count_A=count_A+1;
        end
        if ~isnan(label_all{1,i}{2,2*j+1})
            num_B(1,count_B)=label_all{1,i}{2,2*j+1}-label_all{1,i}{2,2*j};
            count_B=count_B+1;
        end
        if ~isnan(label_all{1,i}{3,2*j+1})
            num_C(1,count_C)=label_all{1,i}{3,2*j+1}-label_all{1,i}{3,2*j};
            count_C=count_C+1;
        end
        if ~isnan(label_all{1,i}{4,2*j+1})
            num_D(1,count_D)=label_all{1,i}{4,2*j+1}-label_all{1,i}{4,2*j};
            count_D=count_D+1;
        end
        if ~isnan(label_all{1,i}{5,2*j+1})
            num_D(1,count_D)=label_all{1,i}{5,2*j+1}-label_all{1,i}{5,2*j};
            count_D=count_D+1;
        end
    end
end
num_all=[num_A,num_B,num_C,num_D];
%% plot
figure(1);
subplot(2,2,1);
histogram(num_A,40);
title('A');
grid on;
subplot(2,2,2);
histogram(num_B,50);
title('B');
grid on;
subplot(2,2,3);
histogram(num_C,20);
title('C');
grid on;
subplot(2,2,4);
histogram(num_D,20);
title('D');
grid on;
figure(2);
histogram(num_all,20);
title('All');
grid on;