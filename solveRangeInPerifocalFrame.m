function rangeInPQW = solveRangeInPerifocalFrame(a, e, v)
    p = a* (1 - e^2);
    r = p/(1+e*cos(v*pi/180));
    rangeInPQW = [r;0;0];
end


