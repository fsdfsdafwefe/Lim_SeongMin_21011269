function az = azimuth(ENU) % ENU [ E N U ; E N U ...] ENU  = km
    A = zeros(size(ENU,1),1);
    for a = 1:size(ENU, 1)
        A(a,1)= (acos(ENU(a,2)/((ENU(a,1)^2+ENU(a,2)^2)^(1/2)))) * 180 / pi;
    end
    az = A;
          