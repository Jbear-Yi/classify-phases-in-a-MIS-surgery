function [Data_sub_last, Class_sub_last]=Class_last(classes)
    Class_frame=struct2cell(load('Class_frame.mat'));
    Data_sub=struct2cell(load('Data_sub.mat'));
    count=1;
    [~, Class]=size(Class_frame{1,1});
    [~, Num]=size(Data_sub{1,1});
    for i=1:Class
        for j=1:Num
            for k=1:numel(Class_frame{1,1}{j,i})/2
                %if(Class_frame{1,1}{j,i}(2,k)>numel(Data_sub{1,1}{1,j})/Vec)
                    %Class_frame{1,1}{j,i}(2,k)=numel(Data_sub{1,1}{1,j})/Vec;
                %end
                %if(Class_frame{1,1}{j,i}(1,k)<numel(Data_sub{1,1}{1,j})/Vec&&Class_frame{1,1}{j,i}(2,k)~=0)
                    Data_sub_last{1,count}=Data_sub{1,1}{1,j}(:,Class_frame{1,1}{j,i}(1,k):Class_frame{1,1}{j,i}(2,k));  
                    Class_sub_last{1,count}=classes(i,1);
                    count=count+1;
                %end
            end
        end
    end
end