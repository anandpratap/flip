clear all;
addpath('../src/');

ADiMat_startup;
maxiter = 1000;
tol = 1e-10;
n = 100;
k = 1.0*ones(n, 1);

load benchmark.mat;
global T_actual;

objective = @oned_conduction_opt;

[~, ~, T_initial] = objective(k);


% gauss newton
params = struct('method', 2, 'stepsize', 0.001, 'lambda', 0.1, 'maxiter', maxiter, 'tol', tol);
k = 1.0*ones(n, 1);
[k, res] = opt(objective, k, params);
figure(1);
semilogy(res, 'r');
hold on;

% steepest descent step size = 0.001
params = struct('method', 1, 'stepsize', 0.001, 'lambda', 0.1, 'maxiter', maxiter, 'tol', tol);
k = 1.0*ones(n, 1);
[k, res] = opt(objective, k, params);
semilogy(res, 'g'); 

% steepest descent step size = 0.01
params = struct('method', 1, 'stepsize', 0.01, 'lambda', 0.1, 'maxiter', maxiter, 'tol', tol);
k = 1.0*ones(n, 1);
[k, res] = opt(objective, k, params);
semilogy(res, 'b'); 

% steepest descent step size = 0.1
params = struct('method', 1, 'stepsize', 0.10, 'lambda', 0.1, 'maxiter', maxiter, 'tol', tol);
k = 1.0*ones(n, 1);
[k, res] = opt(objective, k, params);
semilogy(res, 'c'); 

legend('GN \lambda = 0.1', 'SD stepsize = 0.001', 'SD stepsize = 0.01','SD stepsize = 0.1');
xlabel('Iterations');
ylabel('F(k)');
