clear all;
addpath('../src/');

ADiMat_startup;

global T_actual;
load benchmark.mat;
% match exact solution
% T_actual = T_actual;

% match randomly perturbed solution
% T_actual = T_benchmark;

% set objective function

objective = @oned_conduction_opt;

% number of parameters
n = 100;

% initial value of parameter k
% h = 0.005;
% x = linspace(0, 1, n)';
% ki = 10*exp(-(x-0.5).^2./h) + 1 + randn(n,1)*0.05;
ki = 1.0*ones(n, 1);

% run optimization
params = struct('method', 'gn', 'lambda', 0.1, 'maxiter', 1000, 'tol', 1e-12);
[kf, res] = opt(objective, ki, params);


% calculation of bounds
x = linspace(0, 1, n);
[~, J, T_final, xi] = objective(kf);
sigma = 0.05;
alpha = 0.33;
cm = inv(J'*J/sigma^2 + eye(size(J'*J))/alpha^2);
R = chol(cm);
kpsigma = 3*R'*ones(n, 1) + kf;
kmsigma = -3*R'*ones(n, 1) + kf;
[~, ~, Tmsigma] = objective(kmsigma);
[~, ~, Tpsigma] = objective(kpsigma);



% plotting stuff
h = 0.005;
kb = 10*exp(-(x-0.5).^2./h) + 1;
[~, ~, T_initial] = objective(kb);

figure(1);
plot(x, ki, 'b*',...
    x,kb,'g+',...
    x,kf,'r-',...
    x,kmsigma,'r:',...
    x,kpsigma,'r:', 'markers',5);
xlabel('x');
ylabel('k');
print('-dpdf', 'figures/k.pdf');
print('-dpng', 'figures/k.png');

figure(2);
plot(x,T_actual,'g+',...
    xi,T_final,'r-',...
    xi,Tmsigma,'r:',...
    xi,Tpsigma,'r:');

xlabel('x');
ylabel('T');
print('-dpdf', 'figures/T.pdf');
print('-dpng', 'figures/T.png');

figure(3);
loglog(res);
xlabel('Iterations');
ylabel('F(k)');
print('-dpdf', 'figures/res.pdf');
print('-dpng', 'figures/res.png');
