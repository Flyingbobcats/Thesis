
%==========================================================================
%main.m
%
%Replicates the VF 
%
%==========================================================================
clc
clear 
xc = 0;
yc = 0;

x = linspace(-10,10,50);
y = linspace(-10,10,50);
z = 1;

vx = -5;
vy = 0;

r = 5;

for i=1:length(x)
    for j =1:length(y)
        
%============= Convergence ===============%
        g1 = [2*(x(i)-xc);2*(y(j)-yc);0];
        g2 = [0;0;1];
        
        
        Vconv = -(   (x(i)-xc)^2   + (y(j)-yc)^2-r^2)*g1 + z*g2;
      
        
         convmag = sqrt(Vconv(1)^2+Vconv(2)^2+Vconv(3)^2);        
%        V = Vconv/convmag;
         
%============= Circulation ===============%
         Vcirc = [2*(y(j)-yc);-2*(x(i)-xc);0];
         circmag = sqrt(Vcirc(1)^2+Vcirc(2)^2+Vcirc(3)^2);
%        V = Vcirc/circmag;

%============= Time Variance ==============%
        Vtv = ((-2*vx*(x(i)-xc)-2*vy*(y(j)-yc)) / ((2*(x(i)-xc))^2 +(2*(y(j)-yc))^2))*[2*(x(i)-xc);2*(y(j)-yc);0];
        tvmag = sqrt(Vtv(1)^2+Vtv(2)^2+Vtv(3)^2);
%         V = Vtv/tvmag;



%======== Total Normalized Field ===========%
         
%         mag = sqrt(Vtv^2+Vconv^2+Vcirc^2);
%         V = Vtv/tvmag+Vconv/convmag+Vcirc/circmag;


        V = Vtv/tvmag+Vconv/convmag+Vcirc/circmag;
        
        mag = sqrt(V(1)^2+V(2)^2);
        
        u(i,j) = V(1)/mag;
        v(i,j) = V(2)/mag;
        X(i,j) = x(i);
        Y(i,j) = y(j);
       
    end
end

quiver(X,Y,u,v);
axis equal
