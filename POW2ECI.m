function D = POW2ECI(w, i ,n)
    arg_prg = w;
    inc_angle =i;
    RAAN = n;
    A = [cos(arg_prg) sin(arg_prg) 0; -sin(arg_prg) cos(arg_prg) 0; 0 0 1];
    B = [1 0 0; 0 cos(inc_angle) sin(inc_angle); 0 -sin(inc_angle) cos(inc_angle)];
    C = [cos(RAAN) sin(RAAN) 0; -sin(RAAN) cos(RAAN) 0; 0 0 1];
    D = A * B * C; 
end


