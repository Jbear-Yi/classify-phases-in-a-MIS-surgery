clear;
clc;
%%
load("label_all.mat")
[file,path_a] = uigetfile('E:\Personal Files\Courses\Final Year Proj\VideoRecordings\Video_hospital\*.mp4','MultiSelect','on');

%%
Pro_num = 5;
ID_pro = cell(1,Pro_num);
num = zeros(1,numel(file));
index = zeros(1,Pro_num);
for i = 1:numel(file)
    num(i) = file{i}(8);
end
for i = 1:Pro_num
    ID_pro{i} = label{1,i}{1}(4);
    idx=find(num == ID_pro{i});
    index(i) = idx(1);
    
end

classes=cell({'A';'B';'C';'D'});
%%
for i = 1:Pro_num
    
    v = VideoReader([path_a file{index(i)}]);
    h = v.Height;
    w = v.Width;
    h_new = h/2;
    w_new = w/2;
    [class,len]= size(label_all{i});
    switch i
        case 1 
            delay = 0;
        case 2
            delay = 12*25;
        case 3 
            delay = 0;
        case 4
            delay = 6*25;
        case 5
            delay = 1*25;
    end
    fprintf("sub%c:\n",ID_pro{i})
    for l = 1:class
        if l==5
            k=l-1;
        else
            k=l;
        end
        fprintf("phase %c:\n",classes{k});
        for j = 1:(len-1)/2
            
            name = ['video\Pro' num2str(ID_pro{i}) '_' classes{k} '_' num2str(j) '.mp4'];
            if ~exist(name,'file')
                if ~isnan(label_all{1,i}{k,2*j+1})
                    tic
                    new = VideoWriter(name,'MPEG-4');
                    new.FrameRate = 25;
                    open(new)
                        for m = label_all{1,i}{k,2*j}+delay:label_all{1,i}{k,2*j+1}+delay
                            try
                                input_frame = read(v,m);
                                output_frame = imresize(input_frame,[h_new w_new]);
                                %imshow(output_frame);
                                writeVideo(new, output_frame);
                            catch ME
                            end
                        end
                     close(new)
                     toc
                end
             end
        end
    end
end