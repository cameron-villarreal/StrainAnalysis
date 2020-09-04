function mid = markerplot3(p,q,r)
%% Plot markers and determine midpoint of the defined plane
%Given points p,q,r determine the midpoint, tangential direction, and
%normal direction for the plane defined by points, p, q, r
%Returns the midpoint of the plane and plots the given plane
markers = [p;q;r;p];

%% Place markers on given nuclei (Points input into function)
hold on
plot3(p(1),p(2),p(3),'.','MarkerSize',30)
plot3(q(1),q(2),q(3),'.','MarkerSize',30)
plot3(r(1),r(2),r(3),'.','MarkerSize',30)



%% Connect markers with lines
plot3(markers(:,1),markers(:,2),markers(:,3),'k','LineWidth',3)

x = (p(1)+q(1)+r(1))/3;
y = (p(2)+q(2)+r(2))/3;
z = (p(3)+q(3)+r(3))/3;

mid = [x,y,z];
plot3(x, y, z, '.','MarkerSize',5);

%% Define and Normal and tangential vectors with vector math
pm = p-mid;
rm = r-mid;

tang = (p-q)/norm(p-q);
normal = cross(pm,rm);
normal = normal/norm(normal);

%% Plot the normal and tangential vectors
a = quiver3(mid(1),mid(2),mid(3), normal(1), normal(2),abs(normal(3)),7,'MaxHeadSize',0.5,'LineWidth',2);
%a = quiver3(mid(1),mid(2),mid(3), mid(1)+10*normal(1), mid(2)+10*normal(2),mid(3)+10*normal(3),'k');
b = quiver3(mid(1),mid(2),mid(3),tang(1),tang(2),tang(3),7,'MaxHeadSize',0.5,'LineWidth',2);

%% Format plot
legend([a,b],'Normal to Plane','Tangent to Plane')
% axis tight
grid on
xlabel('X')
ylabel('Y')
zlabel('Z')
view(3)
end