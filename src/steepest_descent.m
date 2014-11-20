function [dx] = steepest_descent(f, J, stepsize)
    % Steepest Descent update
    % p 223  Parameter Estimation and Inverse Problems, second
    % edition by Aster et al.
    dx = -(J'*f)./norm(J'*f, 2).*stepsize;
end