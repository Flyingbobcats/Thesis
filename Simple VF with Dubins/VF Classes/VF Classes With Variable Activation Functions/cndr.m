%Simnple cylinder and plane VF with activation functions


classdef cndr
    
    properties
        %Cylinder properties
        x = 0;
        y = 0;
        r = 3;
        
   
        vx = 1;
        vy = 0;
        
        %Plane Properties
        z = 1;
        
        %Weights
        G = 1;
        H = 1;
        
        %Space properties
        n = 25;
        xspace = linspace(-10,10,25);
        yspace = linspace(-10,10,25);
        
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
    
    properties (Constant)
        funct = {   @(self,R) R*1;
                    @(self,R) R*0;
                    @(self,R) self.r/10*sech(R)};
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
            
            
            u = vec(1)/mag;
            v = vec(2)/mag;
        end
      
        
        function [X,Y,u,v] = ff(self) %Output entire vector field
            u = NaN(length(self.xspace),length(self.yspace));
            v = NaN(length(self.xspace),length(self.yspace));
            X = NaN(length(self.xspace),length(self.yspace));
            Y = NaN(length(self.xspace),length(self.yspace));
            
            
            for i = 1:length(self.xspace)
                for j = 1:length(self.yspace)
                    
                    Minv = [ self.xspace(i) / (2*(self.xspace(i)^2 + self.yspace(j)^2)), 0 , self.yspace(j)/(2*(self.xspace(i)^2+self.yspace(j)^2));
                             self.yspace(j)/(2*(self.xspace(i)^2+self.yspace(j)^2)),     0,  self.xspace(i) / (2*(self.xspace(i)^2 + self.yspace(j)^2));
                             0,1,0];
                         
                    
                    
                    vec1 = -self.G*((self.a1(self.xspace(i)-self.x,self.yspace(j)-self.y,self.r)*self.g1(self.xspace(i)-self.x,self.yspace(j)-self.y)) + self.a2(self.z)*self.g2()) + self.H*(cross(self.g1(self.xspace(i)-self.x,self.yspace(j)-self.y),self.g2()));
                   
                    
%                     vec2 = 10*Minv*self.a;
                    vec2 = (( (-2*self.vx*(self.xspace(i)-self.x))-2*self.vy*(self.yspace(j)-self.y))/(   (2*(self.xspace(i)-self.x))^2  +  (2*(self.yspace(j)-self.y))^2))*[2*(self.xspace(i)-self.x);
                        2*(self.yspace(j)-self.y);
                        0];
                    
                    
                    vec = vec2;
                    mag = sqrt(vec(1)^2+vec(2)^2);
                    
                    
                    R = sqrt((self.xspace(i)-self.x)^2+(self.yspace(j)-self.y)^2);
                    self.funct{self.act}(self,R);
                    u(i,j) =  self.funct{self.act}(self,R)*vec(1)/mag;
                    v(i,j) =  self.funct{self.act}(self,R)*vec(2)/mag;
                    X(i,j) = self.xspace(i);
                    Y(i,j) = self.yspace(j);
                end
            end
        end
        
        
        
        % = = = = = = = =  Activation Functions = = = = = = = = = %
        
        function  obj = modact(obj,arg)
           switch arg
               case 'on'
                   obj.act = 1;
                   
               case 'off'
                   obj.act = 2;
                   
               case 'hyper'
                   obj.act = 3;
           end
                  
            
        end
        

        
        % = = = = = = = = Plotting Functions = = = = = = = = = =  %
        function pltr(self)
           [X,Y,u,v] = self.ff;
            quiver(X,Y,u,v,'r')
            axis equal
        end
        
          function pltb(self)
           [X,Y,u,v] = self.ff;
            quiver(X,Y,u,v,'b')
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
