
%=========================================================================
%TranslatedCylinder.m
%
% Dubins vehicle in moving VF
% Intersection of plane and cylinder
%=========================================================================

clc
clear
close all

%Simulation Constants
r = 1;  %Radius of the cylinder
G = 1;  %Weight of convergence
H = 3;  %Weight of circulation

xt = 0;
yt = 0;

%Define the surfaces
a1 = @(x,y,xt,yt) (x-xt)^2+(y-yt)^2-r^2;
a2 = @(z) z;

%Define the gradiants of the surfaces
g1 = @(x,y,xt,yt) [2*(x-xt);2*(y-yt);0];
g2 = @() [0;0;1];

%Define Simulation Space
n = 100;
x = linspace(-10,10,n);
y = linspace(-10,10,n);

%Setup Dubins Vehicle
v1 = uav();
v1.x = 35;
v1.y = 35;
v1.v = 0.25;
dt = 1;

%Generate data for quiver VF
XT = [];
YT = [];
vx = [];
vy=[];
while xt<10
    xt = xt+0.01;
    yt = yt+0.02;
% for i = 1:length(x)
%     for j = 1:length(y)
%         vec = -G*(a1(x(i),y(j),xt,yt)*g1(x(i),y(j),xt,yt) + a2(1)*g2())+H*(cross(g1(x(i),y(j),xt,yt),g2()));
%         mag = sqrt(vec(1)^2+vec(2)^2);
%         u(i,j) = vec(1)/mag;
%         v(i,j) = vec(2)/mag;
%         X(i,j) = x(i);
%         Y(i,j) = y(j);  
%     end  
% end

XT = [XT,xt];
YT = [YT,yt];
vx = [vx,v1.x];
vy = [vy,v1.y];

% quiver(X,Y,u,v)
vec = -G*(a1(v1.x,v1.y,xt,yt)*g1(v1.x,v1.y,xt,yt) + a2(1)*g2())+H*(cross(g1(v1.x,v1.y,xt,yt),g2()));
v1.angle = atan2(vec(2),vec(1));
v1.vx = v1.v*cos(v1.angle);
v1.vy = v1.v*sin(v1.angle);
v1.x = v1.x+v1.vx*dt;
v1.y = v1.y+v1.vy*dt;

plot(vx,vy,'k-',XT,YT,'b-');
grid on
axis equal
pause(0.01);

end

T = 0;
Tf = 200;
dt = 0.1;

% while T<Tf
%    
%     vec = -G*(a1(v1.x,v1.y)*g1(v1.x,v1.y))+H*(cross(g1(v1.x,v1.y),g2()));
%     v1.angle = atan2(vec(2),vec(1));
%     v1.vx = v1.v*cos(v1.angle);
%     v1.vy = v1.v*sin(v1.angle);
%     v1.x = v1.x+v1.vx*dt;
%     v1.y = v1.y+v1.vy*dt;
%     
%     plot(v1.x,v1.y,'k.');
%     pause(0.01);
%     
%     T = T+dt;
%     
%     
% end





