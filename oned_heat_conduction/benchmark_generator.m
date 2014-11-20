clear all;
ADiMat_startup;

n = 100;
x = linspace(0, 1, n);

% bc
Tleft = 1.0;
Tright = 1.0;

% sources
s = zeros(size(x));
dx = x(2) - x(1);
%s((n+1)/4) = 10.0/dx;
%s((n+1)/2) = 15.0/dx;
%s(3*(n+1)/4) = 10.0/dx;
%s = (-x.*x + x + 1)*15;
s(n/4:3*n/4) = (1/dx);



% variable k
h = 0.005;
k = 10*exp(-(x-0.5).^2./h) + 1;
T = oned_conduction(x, k, s, Tleft, Tright);

figure(1);
plot(x, T, 'r-');
hold on;

sigma = 0.05;
T_benchmark = T + randn(size(T))*sigma;
T_benchmark(1) = Tleft;
T_benchmark(end) = Tright;
plot(x, T_benchmark, 'go-');
xlabel('x');
ylabel('T');
print('-dpdf', 'figures/benchmark_T.pdf');
print('-dpng', 'figures/benchmark_T.png');


figure(2);
plot(x, k);
T_actual = T;
xlabel('x');
ylabel('k');
print('-dpdf', 'figures/benchmark_k.pdf');
print('-dpng', 'figures/benchmark_k.png');

save benchmark.mat T_benchmark T_actual;