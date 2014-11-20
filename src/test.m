clear all;
addpath('/home/anandps/local/adimat/');
addpath('./test_functions/');

ADiMat_startup;

x = ones(2,1);
x(1) = 100.0;
x(2) = 10.0;

objective = @rosenbrock_opt;
params = struct('method', 'sor', 'stepsize', 1e-2, 'lambda', 0.1, 'maxiter', 1000, 'tol', 1e-12);
[x, res] = opt(objective, x, params);
[f, J] = objective(x);


figure(2);
semilogy(res);