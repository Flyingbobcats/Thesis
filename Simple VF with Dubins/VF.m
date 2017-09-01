

clc
clear
close all

r = 5;
x = linspace(-15,15,25);
y = linspace(-15,15,25);
theta = linspace(0,2*pi,100);
circx = r*cos(theta);
circy = r*sin(theta);


z = 0;
v = [];
G = 0.1;
H = 10;

x0 = 10;
y0 = 10;
beta = deg2rad(45);
vel = 0.5;
dt = 0.1;

vx = vel*cos(beta);
vy = vel*sin(beta);

%Calculate vector field for visualization 
for i = 1:length(x)
    for j = 1:length(y)
        
         vec = -G*((x(i)^2+y(j)^2-r^2)*[2*x(i);2*y(j);0]) + H*[2*y(j);-2*x(i);0];
%         vec = -1*((x(i)^2+y(j)^2-r^2)*[2*x(i);2*y(j);0]);
        
        mag = sqrt((vec(1)^2+vec(2)^2));
        u(i,j) = vec(1)/mag;
        v(i,j) = vec(2)/mag;
        X(i,j) = x(i);
        Y(i,j) = y(j);
    end
end


hold on
quiver(X,Y,u,v);
plot(circx,circy,'linewidth',3);
axis equal

x = -10;
y = 1;

for i = 1:1000
   %Calc heading
   

    vec = -G*((x^2+y^2-r^2)*[2*x;2*y;0]) + H*[2*y;-2*x;0];
    mag = sqrt((vec(1)^2+vec(2)^2));
    beta = atan2(vec(2),vec(1));
    
    
    vx = vel*cos(beta);
    vy = vel*sin(beta);
    x = x+vx*dt;
    y = y+vy*dt;
    
    plot(x,y,'.b');
    pause(0.01);
    
    xpos(i) = x;
    ypos(i) = y;
    
end





