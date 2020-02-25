function [TrainX,TrainY,TestX,TestY,ValidationX,ValidationY]= TrainTest_last(classes,Rate1,Rate2)
    [Data_sub_last, Class_sub_last]=Class_last(classes);
    if(exist('seed.mat','file'))
        s=load('seed.mat');    
        rng(s.s);
    else
        s = rng;
        save('seed.mat','s')
    end

    n=randperm(numel(Class_sub_last));
    rate1 = Rate1;
    rate2 = Rate2;
   for m=1:int32(numel(Class_sub_last)*rate1)
       TrainX(m,1)=Data_sub_last(1,n(1,m));
       TrainY(m,1)=Class_sub_last{1,n(1,m)}(1,1);
       
   end
   for m=1:int32(numel(Class_sub_last)*rate2)
       ValidationX(m,1)=Data_sub_last(1,n(1,numel(TrainY)+m));
       ValidationY(m,1)=Class_sub_last{1,n(1,numel(TrainY)+m)}(1,1);
   end
   for m=1:numel(Class_sub_last)-int32(numel(Class_sub_last)*(rate1+rate2))
       TestX(m,1)=Data_sub_last(1,n(1,m+int32(numel(Class_sub_last)*(rate1+rate2))));
       TestY(m,1)=Class_sub_last{1,n(1,m+int32(numel(Class_sub_last)*(rate1+rate2)))}(1,1);
   end
end