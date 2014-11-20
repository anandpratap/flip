function [f, J, T, x] = oned_conduction_opt(k)
    n = length(k);
    x = linspace(0, 1, n);
    
    % bc
    Tleft = 1.0;
    Tright = 1.0;
    
    % sources
    s = zeros(size(x));
    dx = x(2) - x(1);
    s(n/4:3*n/4) = (1/dx);
    
    
    interval = 1;
    
    T = oned_conduction(x, k, s, Tleft, Tright);
    global T_actual;
    
    J = admDiffFD(@oned_conduction, 1, x, k, s, Tleft, Tright, admOptions('i', 2, 'd', 1));
    
    f = T - T_actual;

    
    T = T(1:interval:end);
    f = f(1:interval:end);
    J = J(1:interval:end,:);
    x = x(1:interval:end);
    
end