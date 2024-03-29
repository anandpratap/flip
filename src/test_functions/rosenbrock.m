function [f, J] = rosenbrock(x)
    f(1:2, 1) = (1 - x(1))^2 + 100*(x(2) - x(1)^2)^2;
    J = zeros(1, 2);
    J(1, 1) = -2*(1 - x(1)) - 400*x(1)*(x(2) - x(1)^2);
    J(1, 2) = 200*(x(2) - x(1)^2);
    
    J(2, 1) = -2*(1 - x(1)) - 400*x(1)*(x(2) - x(1)^2);
    J(2, 2) = 200*(x(2) - x(1)^2);
end