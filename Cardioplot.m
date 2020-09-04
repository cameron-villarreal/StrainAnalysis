function C = Cardioplot(Mat)
%% Performs 3d Plotting given input label matrixfigure()

%str = input('Input title of plot \n','s');
%figure()
is = patch(isosurface(Mat));
C = isosurface(Mat,is);
is.FaceColor = 'green';
is.EdgeColor = 'none';
daspect([0.65 0.65 1])
alpha(0.25)
% t= title(str);
% t.FontSize=10;
% t.FontWeight = 'normal';
axis tight
xlabel('x');
ylabel('y');
zlabel('z');
view(3)
grid on
hold on
end