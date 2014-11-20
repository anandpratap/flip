function [f, J] = sample_1(x)
    n = 100;
    f = zeros(n, 1);
    for i = 1:n
       f(i, 1) = x(i)^3 - i;
    end
    
    J = zeros(n, n);
    for i=1:n
            J(i,i) = 3*x(i)^2;
    end
           
end