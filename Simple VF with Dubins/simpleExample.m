
clc
clear
close all

%Simulation Constants
r = 5;  %Radius of the cylinder
G = 1;  %Weight of convergence
H = 1;  %Weight of circulation

%Define the surfaces
a1 = @(x,y) x^2+y^2-r^2;
a2 = @(z) z;

%Define the gradiants of the surfaces
g1 = @(x,y) [2*x;2*y;0];
g2 = @() [0;0;1];

%Define Simulation Space
n = 25;
x = linspace(-10,10,n);
y = linspace(-10,10,n);

%Setup Dubins Vehicle
v1 = uav();
v1.x = 5;
v1.y = 5;
v1.v = 0.25;


%Generate data for quiver VF
for i = 1:length(x)
    for j = 1:length(y)
        vec = -G*(a1(x(i),y(j))*g1(x(i),y(j)) + a2(1)*g2())+H*(cross(g1(x(i),y(j)),g2()));
        mag = sqrt(vec(1)^2+vec(2)^2);
        u(i,j) = vec(1)/mag;
        v(i,j) = vec(2)/mag;
        X(i,j) = x(i);
        Y(i,j) = y(j);
    end
end

circx = r*cos(0:0.01:2*pi);
circy = r*sin(0:0.01:2*pi);
hold on
quiver(X,Y,u,v)
plot(circx,circy,'r','linewidth',2);
axis equal

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
%     H = H-0.0001;
%     plot(v1.x,v1.y,'k.');
%     pause(0.01);
%     
%     T = T+dt;
%     
%     
% end





