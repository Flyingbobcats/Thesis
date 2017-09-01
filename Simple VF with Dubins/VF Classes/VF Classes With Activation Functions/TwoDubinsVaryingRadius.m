%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%TwoDubinsVaryingRadius.m
%
%
%//////////////////////////////////////////////////////////////////////////

r = 0:0.1:10;

vf = cndr;
posx1 = 0;
posy1 = 0;
posx2 = 5;
posy2 = -3;

V = 5;
dt = 0.1;
PX1 = [];
PY1 = [];
PX2 = [];
PY2 = [];

vf.H = 5;
for i = 1:length(r)
    vf.r = r(i);
    [x,y,u,v] = vf.ff;
    
    beta = vf.head(posx1,posy1);
    gamma = vf.head(posx2,posy2);
    
    posx1 = posx1+V*cos(beta)*dt;
    posy1 = posy1+V*sin(beta)*dt;
    
    posx2 = posx2+V*cos(gamma)*dt;
    posy2 = posy2+V*sin(gamma)*dt;
    
    PX1 = [PX1,posx1];
    PY1 = [PY1,posy1];
    PX2 = [PX2,posx2];
    PY2 = [PY2,posy2];
    
    clf
    hold on
    quiver(x,y,u,v);
    plot(PX1,PY1,'r',PX2,PY2,'g','linewidth',3);
    axis equal
    pause(0.01);
    
   
    
    
    
end