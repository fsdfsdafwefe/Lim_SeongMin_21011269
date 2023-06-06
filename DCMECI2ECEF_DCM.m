function DCM = DCMECI2ECEF_DCM(time) % time = [year, month, day, hour , minute, second]
    time0 = [2000 1 1 12 0 0];
    time1 = time - time0;
    year = time1(1,1) * 365 * 24 * 60 * 60;
    month = time1(1,2) * 30 * 24 * 60 * 60;
    day = time1(1,3) * 24 * 60 * 60;
    hour = time1(1,4) * 60 * 60;
    minute = time1(1,5) * 60;
    second = time1(1,6);
    t = year + month + day + hour + minute + second;
    w = pi/12;
    theta0 = 0;
    theta = w * t; % t = t1 - t0
    DCM = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];

end



