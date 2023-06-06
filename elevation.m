function el = elevation(ENU, el_mask)
    A = zeros(1, size(ENU,1));
    for a = 1:size(ENU, 1)
        A(1,a)= (asin(ENU(a,3)/((ENU(a,1)^2+ENU(a,2)^2+ENU(a,3)^2)^(1/2)))) * 180 / pi;
        if el_mask >= A(1,a)
            A(1,a) = NaN;
        end
    end
    el = A;