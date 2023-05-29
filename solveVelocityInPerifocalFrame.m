function velocityInPQW = solveVelocityInPerifocalFrame(a, e, v)
    u = 3.9860004418 * 10^14; % m^3s^-2
    p = a*(1-e^2);
    v = ((u/p)^(1/2)) * [-sin(v*pi/180);e+cos(v*pi/180);0];
    velocityInPQW = v;

end
