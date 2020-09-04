function v = vidwrite(a_list,b_list,c_list,Labels)

%% Produce a video of the given region of interest
%Calls the function trackmats to 
str = input('Input title of video \n','s');
nums = input('Input time steps (Format [X Y] \n');

vid = VideoWriter(str);
vid.FrameRate = 5;
open(vid)
[strain_u,strain_v, stretch_u, stretch_v, principal, rot, ap, t]=straintrack(a_list,b_list,c_list)
for i= nums(1):nums(2) 
    if i==37 || i ==38 || i ==40
    else
        str2 = sprintf('E_{1}= %.3f \n\n E_{2}=%.3f',principal(i,1),principal(i,2));

        tiledlayout(1,1)
        ax = nexttile;
        markerplot3(a_list(i,:),b_list(i,:),c_list(i,:));
%        markerplot3(p_list(i,:),q_list(i,:),r_list(i,:));

%        scatter3(sortedcent(:,1,i),sortedcent(:,2,i),sortedcent(:,3,i))
        Cardioplot(Labels(:,:,:,i));
        title('Plane Motion through Cardiac Cylce For Point E')
        xlabel('x');
        ylabel('y');
        zlabel('z');
        grid on
        dim = [.65 .5 .1 .1];
        annotation('textbox',dim,'String',str2,'FitBoxToText','on');
%        dim2 = [.4 .5 0.05 0]
%        annotation('textbox',dim2,'String','Atrial Plane','FitBoxToText','on');
%        axis tight
         xlim([200 280])
         ylim([150 190])
         zlim([80 120])
        f = getframe(gcf);
        delete(findall(gcf,'type','annotation'))
        cla(ax,'reset')
        view(3)
        writeVideo(vid,f)
    end
end
close(vid);
v= vid;
end