
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
n = 50;
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


xt1 = 0;
yt1 = 0;

xt2 = 5;
yt2 = 5;
for i = 1:length(x)
    for j = 1:length(y)
        vec1 = -G*(a1(x(i),y(j),xt1,yt1)*g1(x(i),y(j),xt1,yt1) + a2(1)*g2())+H*(cross(g1(x(i),y(j),xt1,yt1),g2()));
        vec2 =  G*(a1(x(i),y(j),xt2,yt2)*g1(x(i),y(j),xt2,yt2) + a2(1)*g2())+H*(cross(g1(x(i),y(j),xt2,yt2),g2())); 
        
        dist1 = sqrt((xt1-x(i))^2+(yt1-y(j))^2);
        dist2 = sqrt((xt2-x(i))^2+(yt2-y(j))^2);
        
        act1 = -1/5*(r)*dist1+1;
        act2 = -1/5*(r)*dist2+1;
        
        if act1 < 0
            act1 =0;
        end
        
        if act1 > 1
            act1 = 1;
        end
        
        if act2 < 0
            act2 =0;
        end
        
        if act2 > 1
            act2 = 1;
        end
        vec = vec1*act1+vec2*act2;
        
        
        mag = sqrt(vec(1)^2+vec(2)^2);
        u(i,j) = vec(1)/mag;
        v(i,j) = vec(2)/mag;
        X(i,j) = x(i);
        Y(i,j) = y(j);
    end
end

theta = 0:0.01:2*pi;
circx1 = r*cos(theta)+xt1;
circy1 = r*sin(theta)+yt1;

circx2 = r*cos(theta)+xt2;
circy2 = r*sin(theta)+yt2;


hold on
quiver(X,Y,u,v);
plot(circx1,circy1,circx2,circy2);
axis equal










