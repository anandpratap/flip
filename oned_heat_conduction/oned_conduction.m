function [T, F] = oned_conduction(x, k, s, Tleft, Tright)
    % A T = f
    n = size(x,2);
    
    A = zeros(n-2);
    for i=1:n-2
        A(i,i) = -(k(i+2) + k(i+1)*2 + k(i))/2.0;
        if(i>1)
            A(i,i-1) = (k(i) + k(i+1))/2.0;
        end
        if(i<n-2)
            A(i,i+1) = (k(i+1) + k(i+2))/2.0;
        end
    end
    
    
    dx = x(2) - x(1);
    f = -s(2:end-1)*dx*dx;
    f(1) = f(1) - Tleft*(k(1));
    f(end) = f(end) - Tright*k(end);
         
    T = zeros(n,1);
    T(1) = Tleft;
    T(end) = Tright;
    T(2:end-1) = inv(A) * f';
   
    global T_actual;
    
    f = T - T_actual;
    F = sum(f.^2);
end


