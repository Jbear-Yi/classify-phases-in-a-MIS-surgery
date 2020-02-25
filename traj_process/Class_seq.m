function [Data_sub_seq, Class_sub_seq]=Class_seq(classes, dataset ,isUpsample)
    Class_frame=struct2cell(load('Class_frame.mat'));
    Data_sub=struct2cell(load('Data_sub.mat'));
    count=1;    
    [~, Class]=size(Class_frame{1,1});
    [~, Num]=size(Data_sub{1,1});
    for i=1:Class
        for j=1:Num
            if ismember(j,dataset)
                for k=1:numel(Class_frame{1,1}{j,i})/2
                    %if(Class_frame{1,1}{j,i}(2,k)>numel(Data_sub{1,1}{1,j})/Vec)
                        %Class_frame{1,1}{j,i}(2,k)=numel(Data_sub{1,1}{1,j})/Vec;
                    %end
                    %if(Class_frame{1,1}{j,i}(1,k)<numel(Data_sub{1,1}{1,j})/Vec&&Class_frame{1,1}{j,i}(2,k)~=0)
                        Data_sub_seq{1,count}=Data_sub{1,1}{1,j}(:,fix(Class_frame{1,1}{j,i}(1,k)):fix(Class_frame{1,1}{j,i}(2,k)));  
                        Class_sub_seq{1,count}(1,1:(Class_frame{1,1}{j,i}(2,k)-Class_frame{1,1}{j,i}(1,k)+1))=classes(i,1);
                        count=count+1;
                    %end
                end
            end
        end
    end
    if isequal(isUpsample,'Y')
        [Class_sub_seq , Data_sub_seq] = UpSample(Class_sub_seq , Data_sub_seq);
    end
end