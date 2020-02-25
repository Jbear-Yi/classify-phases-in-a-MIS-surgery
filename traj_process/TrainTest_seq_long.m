function [TrainX,TrainY,TestX,TestY,ValidationX,ValidationY]= TrainTest_seq_long(classes,Rate1,Rate2)
    [Data_sub_seq_long, Class_sub_seq_long]=Class_seq_long(classes);
    if(exist('seed.mat','file'))
        s=load('seed.mat');    
        rng(s.s);
    else
        s = rng;
        save('seed.mat','s')
    end

    n=randperm(numel(Class_sub_seq_long));
    rate1 = Rate1;
    rate2 = Rate2;
    for m=1:int32(numel(Class_sub_seq_long)*rate1)
        TrainX(1,m)=Data_sub_seq_long(1,n(1,m));
        TrainY(1,m)=Class_sub_seq_long(1,n(1,m));
    end
    for m=1:int32(numel(Class_sub_seq_long)*rate2)
        ValidationX(1,m)=Data_sub_seq_long(1,n(1,numel(TrainY)+m));
        ValidationY(1,m)=Class_sub_seq_long(1,n(1,numel(TrainY)+m));
    end
    for m=1:numel(Class_sub_seq_long)-int32(numel(Class_sub_seq_long)*(rate1+rate2))
        TestX(1,m)=Data_sub_seq_long(1,n(1,m+int32(numel(Class_sub_seq_long)*(rate1+rate2))));
        TestY(1,m)=Class_sub_seq_long(1,n(1,m+int32(numel(Class_sub_seq_long)*(rate1+rate2))));
    end
end