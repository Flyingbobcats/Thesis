%Simnple cylinder and plane VF with activation functions


classdef cndr
    
    properties
        %Cylinder properties
        x = 5;
        y = 5;
        r = 3;
        
        %Plane Properties
        z = 1;
        
        %Weights
        G = 1;
        H = 1;
        
        %Space properties
        n = 25;
        xspace = linspace(-10,10,50);
        yspace = linspace(-10,10,100);
        
        %Define the surfaces
        a1 = @(x,y,r) x^2+y^2-r^2;
        a2 = @(z) z;
        
        %Define the gradiants of the surfaces
        g1 = @(x,y) [2*x;2*y;0];
        g2 = @() [0;0;1];
        
        %Activation Function
        act = 1;
        ext = 1;
    end
    
    
    methods 
        
        function beta = head(self,posx,posy) %Generate heading for single point

             vec = -self.G*((self.a1(posx,posy,self.r)*self.g1(posx,posy)) + self.a2(self.z)*self.g2()) + self.H*(cross(self.g1(posx,posy),self.g2()));
%              out = [vec(1)/mag;vec(2)/mag;vec(3)/mag];

            beta = atan2(vec(2),vec(1));
             
        end
        
        function [u,v] = comp(self,posx,posy)
            vec = -self.G*((self.a1(posx-self.x,posy-self.y,self.r)*self.g1(posx-self.x,posy-self.y)) + self.a2(self.z)*self.g2()) + self.H*(cross(self.g1(posx-self.x,posy-self.y),self.g2()));
            mag = sqrt(vec(1)^2+vec(2)^2);
            
            
            u = self.act*sech(self.ext*sqrt((self.x-posx)^2+(self.y-posy)^2))*vec(1)/mag;
            v = self.act*sech(self.ext*sqrt((self.x-posx)^2+(self.y-posy)^2))*vec(2)/mag;
        end
      
        
        function [X,Y,u,v] = ff(self) %Output entire vector field
            u = NaN(length(self.xspace),length(self.yspace));
            v = NaN(length(self.xspace),length(self.yspace));
            X = NaN(length(self.xspace),length(self.yspace));
            Y = NaN(length(self.xspace),length(self.yspace));
            
            
            for i = 1:length(self.xspace)
                for j = 1:length(self.yspace)
                    vec = -self.G*((self.a1(self.xspace(i)-self.x,self.yspace(j)-self.y,self.r)*self.g1(self.xspace(i)-self.x,self.yspace(j)-self.y)) + self.a2(self.z)*self.g2()) + self.H*(cross(self.g1(self.xspace(i)-self.x,self.yspace(j)-self.y),self.g2()));
                    mag = sqrt(vec(1)^2+vec(2)^2);
                    
                    
                    u(i,j) =  self.act*sech(self.ext*sqrt((self.x-self.xspace(i))^2+(self.y-self.yspace(j))^2))*vec(1)/mag;
                    v(i,j) =  self.act*sech(self.ext*sqrt((self.x-self.xspace(i))^2+(self.y-self.yspace(j))^2))*vec(2)/mag;
                    X(i,j) = self.xspace(i);
                    Y(i,j) = self.yspace(j);
                end
            end
        end
        
        
        
        %Plotting Functions
        function plt(self)
           [X,Y,u,v] = self.ff;
            quiver(X,Y,u,v)
            axis equal
        end
        
        function pltfnc(self)
           theta = 0:0.01:2*pi;
           cxs = self.x+self.r*cos(theta);
           cys = self.y+self.r*sin(theta);
           plot(cxs,cys,'r','linewidth',2);
        end
        
        function pltcndr(self)
           
            theta = 0:0.05:2*pi;
            cxs = self.x+self.r*cos(theta);
            cys = self.y+self.r*sin(theta);
            plot(cxs,cys,'r','linewidth',3);
        end
        
        
    end
end
