function [output] = InPlaneStrain(P1,P2)
%    Function InPlaneStrain determines the strain state given between
%    Planes defined using P1 and P2
%    Where P1 and P2 are both 3x3 matrices of [X,Y,Z] coordinates for
%    points defining the plane
%    Performs LSQ to determine the Matrix 
%       F11 F12
%       F22 F21
%Then determines strain using the equation e = .5 {I-F'*F(inverse)}
%Then determines principal strain and direction using standard
%equation/Mohr's circle
%Principal strain reported in units of microstrain

scale = [.65 .65 1];

A = P1(1,:).*scale;
B = P1(2,:).*scale;
C = P1(3,:).*scale;

P = P2(1,:).*scale;
Q = P2(2,:).*scale;
R = P2(3,:).*scale;

%Determine midpoints of each plane position
x1 = (A(1)+B(1)+C(1))/3;
y1 = (A(2)+B(2)+C(2))/3;
z1 = (A(3)+B(3)+C(3))/3;
Mid1 = [x1,y1,z1];

x2 = (P(1)+Q(1)+R(1))/3;
y2 = (P(2)+Q(2)+R(2))/3;
z2 = (P(3)+Q(3)+R(3))/3;
Mid2 = [x2,y2,z2];

clear x1 y1 z1 x2 y2 z2 scale P1 P2


%Find the vector normal to the surface passing through the midpoint
%Define midpoint vectors
AM = A-Mid1;
BM = B-Mid1;
%Define Tangent Vector
BC = B-C;
%Normal vector is the cross product of the vectors defining the midpoint of
%the plane relative to the corners of the plane.
N = cross(AM,BM)/norm(cross(AM,BM));
clear AM BM


%Repeat steps for plane 2
PM = P-Mid2;
QM = Q-Mid2;
QR = Q-R;
n = cross(PM,QM)/norm(cross(PM,QM));
clear PM QM


%establish unit vectors 
U = BC./norm(BC);
u = QR./norm(QR);
clear BC QR

V = cross(N,U);
v = cross(n,u);

MAT1 = round([U;V],2);
MAT2 = round([u;v],2);

F = round(MAT2/MAT1,2);
%Find right stretch tensor
rst = real(sqrt((F.')*F));

Fs = F*(F.');
%Find principal angle from deformation matrix
ap = atand((2*Fs(1,2))/(Fs(1,1)-Fs(2,2)))/2;
rot = [cosd(ap) sind(ap); -sind(ap) cosd(ap)];

vp = rot*Fs*(rot.');
rotb = [cosd(-ap) sind(-ap); -sind(-ap) cosd(-ap)];
V = rotb * sqrt(vp) * (rotb.');
Rotation_mat = real(V\F);
right_stretch_tensor = Rotation_mat\F;

%Calculate strain from right stretch tensor
strain_u = 0.5*((rst(1,1)*rst(1,1))-1);
strain_v = 0.5*((rst(2,2)*rst(2,2))-1);
strain_uv = 0.5*((right_stretch_tensor(1,2)*right_stretch_tensor(1,2))-1);
ep1 = ((strain_u+strain_v)/2)+sqrt(((strain_v-strain_u)/2)^2+strain_uv^2);
ep2 = ((strain_u+strain_v)/2)-sqrt(((strain_v-strain_u)/2)^2+strain_uv^2);

ap_s = atand(2*strain_uv/(strain_u-strain_v))/2;
if ap_s <0
    ap_s = ap_s+180;
end

field1 = 'rotation_matrix'; v1 = rot;
field2 = 'right_stretch_tensor'; v2 = right_stretch_tensor;
field3 = 'strain'; v3 = [strain_u strain_uv; strain_uv strain_v];
field4 = 'principal_strain'; v4 = [ep1 ep2];
field5 = 'principal_strain_angle'; v5 = ap_s;

output = struct(field1,v1,field2,v2,field3,v3,field4,v4,field5,v5);
end