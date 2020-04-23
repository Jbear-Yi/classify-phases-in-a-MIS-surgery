function Plot_in_3D(num,divide,Data_sub)
        F_name='Ploting num'+string(num);
        figure('name',F_name);
        xlim([min(min(Data_sub{1,num}(1,:)),min(Data_sub{1,num}(4,:))) max(max(Data_sub{1,num}(1,:)),max(Data_sub{1,num}(4,:)))]);
        ylim([min(min(Data_sub{1,num}(2,:)),min(Data_sub{1,num}(5,:))) max(max(Data_sub{1,num}(2,:)),max(Data_sub{1,num}(5,:)))]);
        zlim([min(min(Data_sub{1,num}(3,:)),min(Data_sub{1,num}(6,:))) max(max(Data_sub{1,num}(3,:)),max(Data_sub{1,num}(6,:)))]);
        [~, Cols]= size(Data_sub{1,num});
        for i=1:Cols/divide
            hold on;
            plot3(Data_sub{1,num}(1,i),Data_sub{1,num}(2,i),Data_sub{1,num}(3,i),'o');
            plot3(Data_sub{1,num}(4,i),Data_sub{1,num}(5,i),Data_sub{1,num}(6,i),'o');
            hold off;
            xlabel('X');
            ylabel('Y');
            zlabel('Z');
            title(i*divide);
            grid on
            pause(0.01);
            drawnow update;
        end
end
