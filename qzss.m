function a = qzss()
    a = 4.2164e+07;  %m
    e = 0.0752;
    i = 0.6126; %rad
    omega = -155.65; %rad
    M0 = 0.4411; % mean anomaly
    toc = [2023 5 9 2 0 0]; %time
    RAAN = 1.6873; %rad
    u = 3.9860004418 * 10^14; % m^3s^-2
    n = sqrt(u/a^3); %rad/sec
    E0 = -1.428004667; %rad
    v0 = atan2(sqrt(1-e^2)*sin(E0),cos(E0)-e); %rad

    arg_prg = omega; %pqwtoeci
    inc_angle =i;
    A = [cos(arg_prg) sin(arg_prg) 0; -sin(arg_prg) cos(arg_prg) 0; 0 0 1];
    B = [1 0 0; 0 cos(inc_angle) sin(inc_angle); 0 -sin(inc_angle) cos(inc_angle)];
    C = [cos(RAAN) sin(RAAN) 0; -sin(RAAN) cos(RAAN) 0; 0 0 1];
    D = A * B * C;

    p = a* (1 - e^2); %pqw r
    r = p/(1+e*cos(v0));
    rangeInPQW = [r*cos(v0);r*sin(v0);0];
    
    %pqw v
    p = a*(1-e^2);
    V = ((u/p)^(1/2)) * [-sin(v0);e+cos(v0);0];
    velocityInPQW = V;

    ECIr= D*rangeInPQW;
    ECIv= D*velocityInPQW; %3x1

    %eci2ecef
    time0 = [2000 1 1 12 0 0];
    time1 = toc - time0;
    year = time1(1,1) * 365 * 24 * 60 * 60;
    month = time1(1,2) * 30 * 24 * 60 * 60;
    day = time1(1,3) * 24 * 60 * 60;
    hour = time1(1,4) * 60 * 60;
    minute = time1(1,5) * 60;
    second = time1(1,6);
    t = year + month + day + hour + minute + second;
    w = pi/12/3600;
    theta0 = 0;
    theta = theta0 + w * t; % t = t1 - t0
    eci2ecef = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1]; 

    
    ecefr = eci2ecef * ECIr;
    ecefv = eci2ecef * ECIv;



    wgs84 = wgs84Ellipsoid('kilometer');
    [lat,lon,h] = ecef2geodetic(wgs84,ecefr(1,1),ecefr(2,1),ecefr(3,1));
    E = zeros(1, 86401);
    E(1,1)=E0;
    M = zeros(1,86401);
    M(1,1)=M0;
    La = zeros(1, 86401);
    Lo = zeros(1, 86401);
    h = zeros(1, 86401);
    for z = 1:86401
        M(1,z+1) = M(1,z) + n*1;
    end

    for z = 1:86401
        E(1,z+1) = M(1,z) + e*sin(E(1,z));
    end

    for z = 1:86401
        v = atan2(sqrt(1-e^2)*sin(E(1,z)),cos(E(1,z))-e);
        r = p/(1+e*cos(v));
        range = [r*cos(v);r*sin(v);0];
        ECIr = D * range;
        ecefr = eci2ecef * ECIr;
        [La(1,z),Lo(1,z),h(1,z)] = ecef2geodetic(wgs84,ecefr(1,1),ecefr(2,1),ecefr(3,1));
    end


    seoul = [37 128];

    az = zeros(1, 86401);
    el = zeros(1, 86401);
    
    %eci2enu

    time0 = [2000 1 1 12 0 0];
    time1 = toc - time0;
    year = time1(1,1) * 365 * 24 * 60 * 60;
    month = time1(1,2) * 30 * 24 * 60 * 60;
    day = time1(1,3) * 24 * 60 * 60;
    hour = time1(1,4) * 60 * 60;
    minute = time1(1,5) * 60;
    second = time1(1,6);
    t = year + month + day + hour + minute + second;
    w = pi/12/3600;
    theta0 = 0;
    lam = theta0 + w * t+128*pi/180; 
    eci2enu = [1 0 0; 0 cos(37*pi/180) sin(37*pi/180); 0 -sin(37*pi/180) cos(37*pi/180)]*[cos(pi+lam) sin(pi+lam) 0; -sin(pi+lam) cos(pi+lam) 0; 0 0 1];
    
    for z = 1:86401
        v = atan2(sqrt(1-e^2)*sin(E(1,z)),cos(E(1,z))-e);
        r = p/(1+e*cos(v));
        range = [r*cos(v);r*sin(v);0];
        ECIr = D * range;
        enur = eci2enu * ECIr;
        az(1,z) = (acos(enur(2,1)/((enur(1,1)^2+enur(2,1)^2)^(1/2)))) * 180 / pi;
        el(1,z)= (asin(enur(3,1)/((enur(1,1)^2+enur(2,1)^2+enur(3,1)^2)^(1/2)))) * 180 / pi;
        if 0 > el(1,z)
            el(1,z) = NaN;
        end

        
    end
    skyplot(az,el);
    geoplot(La,Lo);

        
end





    