

clear
clc
close all
f1 = cndr;
f1.H = 0;
f1.G = -1;
f2 = f1;


g = goal;
g.H = -1;

f1.x = 3;
f1.y = 3;
f1.act = 1;
f1.ext = 1;
f1.r = 0.01;

f2.x = 0;
f2.y = 0;
f2.act = 1;
f2.ext = 1;
f2.r = 0.01;

g.x   =  5;
g.y   = -5;
g.act = 1;


posx = 0;
posy = 4;
vel = 1;
dt = 0.1;
hold on

i = 0;

while true
    
    i = i+1;
    g.x = g.x-0.01;
    g.y = g.y+0.01;
    
    
    [u1,v1] = f1.comp(posx,posy);
    [u2,v2] = g.comp(posx,posy);
    [u3,v3] = f2.comp(posx,posy);
    
    ut = u1+u2+u3;
    vt = v1+v2+v3;
    
    beta = atan2(vt,ut);
    rad2deg(beta)
    posx = posx+vel*cos(beta)*dt;
    posy = posy+vel*sin(beta)*dt;
    
    %     quiver(posx,posy,ut,vt,'r');
    
    if mod(i,5)==0;
    [x,y,U1,V1] = f1.ff;
    [x,y,U2,V2] = g.ff;
    [x,y,U3,V3] = f2.ff;
    
    
    hold on
    Ut = U1+U2+U3;
    Vt = V1+V2+V3;

    quiver(x,y,Ut,Vt);
    plot(posx,posy,'*r');
    f1.pltcndr;
    f2.pltcndr;
    axis equal
    pause();
    end
    
end