
syms vx vy x y

m = [(vx*x)/(2*(x^2 + y^2));
    (vx*y)/(2*(x^2 + y^2));
    vy];

pretty(m)