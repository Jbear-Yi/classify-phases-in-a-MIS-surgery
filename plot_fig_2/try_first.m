clear;
clc;
app.DataSetDropDown.Value=2;

app.myData=load('data.mat');
app.myLab=load('label_all.mat');
%% will add
            app.useDATA{1,1}=app.myLab.label_all{1,app.DataSetDropDown.Value};
            if app.DataSetDropDown.Value<=5
                app.useDATA{1,2}=app.myData.proDepth{app.DataSetDropDown.Value,1};
            else
                app.useDATA{1,2}=app.myData.noviceDepth{app.DataSetDropDown.Value-5,1};
            end
            [num,~]=size(app.useDATA{1,2});
            Class={'A','B','C','D1','D2'};
            app.useDATA{1,3}(1:num,1)={'Non'};
            [~,length]=size(app.useDATA{1,1});
            length=(length-1)/2;
            for j=1:5
                for i=1:length
                    if ~isnan(app.useDATA{1,1}{j,i*2})
                        app.useDATA{1,3}(app.useDATA{1,1}{j,i*2}:app.useDATA{1,1}{j,i*2+1},1)=Class(1,j);
                    end
                end
            end
            
%%
            if exist("net.mat","file")
                load('net.mat')
                app.useDATA{1,4} = cellstr(classify(net,app.useDATA{1,2}')');
            end