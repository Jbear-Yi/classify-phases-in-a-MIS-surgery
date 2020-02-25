function [Data_sub_seq_long, Class_sub_seq_long]=Class_seq_long(classes, dataset, isUpsample)
    Class_frame=struct2cell(load('Class_frame.mat'));
    Data_sub=struct2cell(load('Data_sub.mat'));
    [~, Class]=size(Class_frame{1,1});
    [~, Num]=size(Data_sub{1,1});
    for j=1:Num
        if ismember(j,dataset)
            [~,length]=size(Data_sub{1,1}{1,j});
            Data_sub_seq_long{1,j}(:,1:length)=Data_sub{1,1}{1,j}(:,:);
            Class_sub_seq_long{1,j}(1,1:length)=classes(5,1);
        end
    end
    for i=1:Class
        for j=1:Num
            if ismember(j,dataset)
                for k=1:numel(Class_frame{1,1}{j,i})/2
    %                 if(Class_frame{1,1}{j,i}(1,k)>numel(Data_sub{1,1}{1,j})/Vec||Class_frame{1,1}{j,i}(2,k)>numel(Data_sub{1,1}{1,j})/Vec)
    %                     Class_frame{1,1}{j,i}(1,k)=numel(Data_sub{1,1}{1,j})/Vec;
    %                     Class_frame{1,1}{j,i}(2,k)=numel(Data_sub{1,1}{1,j})/Vec;
    %                 end
    %                 if(Class_frame{1,1}{j,i}(1,k)<numel(Data_sub{1,1}{1,j})/Vec&&Class_frame{1,1}{j,i}(2,k)~=0)
                        Class_sub_seq_long{1,j}(1,Class_frame{1,1}{j,i}(1,k):Class_frame{1,1}{j,i}(2,k))=classes(i,1);
    %                 end
                end
            end
        end
    end
    if isequal(isUpsample,'Y')
        [Class_sub_seq_long , Data_sub_seq_long] = UpSample(Class_sub_seq_long , Data_sub_seq_long);
    end
end