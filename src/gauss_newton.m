function [dx] = gauss_newton(f, J, lambda, n)
    % Gauss Newton update
    % p 222  Parameter Estimation and Inverse Problems, second
    % edition by Aster et al.
    dx = (J'*J + lambda*eye(n)) \ -J'*f;
end