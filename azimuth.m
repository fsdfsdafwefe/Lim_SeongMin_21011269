function az = azimuth(ENU) % ENU [ E N U ; E N U ...]nx3,  ENU  = km
    A = zeros(1, size(ENU,1));
    for a = 1:size(ENU, 1)
        A(1,a)= (acos(ENU(a,2)/((ENU(a,1)^2+ENU(a,2)^2)^(1/2)))) * 180 / pi;
    end
    az = A;
          