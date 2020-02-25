function [TrainX,TrainY,TestX,TestY,ValidationX,ValidationY]= TrainTest_seq(classes,isUpsample)
    
    
    if(exist('seed.mat','file'))
        s=load('seed.mat');    
        rng(s.s);
    else
        s = rng;
        save('seed.mat','s')
    end
    
    useDATABASE=[1,2,3,4,6,7,8];
    sel=randi(7);
    useDATABASE(sel)=[];
    [Data_sub_seq, Class_sub_seq]=Class_seq(classes,useDATABASE, isUpsample);
    n=randperm(numel(Class_sub_seq));
    for m=1:int32(numel(Class_sub_seq))
        TrainX(1,m)=Data_sub_seq(1,n(1,m));
        TrainY(1,m)=Class_sub_seq(1,n(1,m));
    end
    [ValidationX_sub_seq, ValidationY_sub_seq]=Class_seq(classes,sel);
    n=randperm(numel(ValidationY_sub_seq));
    for m=1:int32(numel(ValidationY_sub_seq))
        ValidationX(1,m)=ValidationX_sub_seq(1,n(1,m));
        ValidationY(1,m)=ValidationY_sub_seq(1,n(1,m));
    end
    [TestX,TestY]=Class_seq(classes,[5,9]);
    %n=randperm(numel(Class_sub_seq));
%     rate1 = Rate1;
%     rate2 = Rate2;
%     for m=1:int32(numel(Class_sub_seq)*rate1)
%         TrainX(1,m)=Data_sub_seq(1,n(1,m));
%         TrainY(1,m)=Class_sub_seq(1,n(1,m));
%     end
%     for m=1:int32(numel(Class_sub_seq)*rate2)
%         ValidationX(1,m)=Data_sub_seq(1,n(1,numel(TrainY)+m));
%         ValidationY(1,m)=Class_sub_seq(1,n(1,numel(TrainY)+m));
%     end
%     for m=1:numel(Class_sub_seq)-int32(numel(Class_sub_seq)*(rate1+rate2))
%         TestX(1,m)=Data_sub_seq(1,n(1,m+int32(numel(Class_sub_seq)*(rate1+rate2))));
%         TestY(1,m)=Class_sub_seq(1,n(1,m+int32(numel(Class_sub_seq)*(rate1+rate2))));
%     end
end