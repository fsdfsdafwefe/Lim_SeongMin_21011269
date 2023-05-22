function D = POW2ECI(a, b ,c)
    A = [cos(a) sin(a) 0; -sin(a) cos(a) 0; 0 0 1];
    B = [1 0 0; 0 cos(b) sin(b); 0 -sin(b) cos(b)];
    C = [cos(c) sin(c) 0; -sin(c) cos(c) 0; 0 0 1];
    D = A * B * C;
    