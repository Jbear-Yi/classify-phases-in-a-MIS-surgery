function [Class_Upsample, Data_Upsample] = UpSample(Class_sub_seq , Data_sub_seq)
    for i =1:numel(Class_sub_seq)
        for j=1:numel(Class_sub_seq{i})
            Class_Upsample{i}(1,2*j-1)=Class_sub_seq{i}(1,j);
            Data_Upsample{i}(:,2*j-1)=Data_sub_seq{i}(:,j);
            if j~=numel(Class_sub_seq{i})
                Class_Upsample{i}(1,2*j)=Class_sub_seq{i}(1,j);
                Data_Upsample{i}(:,2*j)=(Data_sub_seq{i}(:,j)+Data_sub_seq{i}(:,j+1))/2;
            end
        end
    end
end