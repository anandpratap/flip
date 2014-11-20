function [x, res] = opt(objective, x, params)
    % Inverse Problem Solver
    %
    % Example
    % ----------------------
    %
    % Using Gauss Newton
    % options = struct('method', 'gn', 'lambda', 0.1, 'maxiter', 100, 'tol', 1e-12);
    %
    % [x, res] = opt(@objective, x_init, params);
    %
    % see page 221 of Parameter Estimation and Inverse Problems, second
    % edition by Aster et al. for definition of f and J.
    %
    % x is a parameter vector of size n, objective function should take k as input
    % and return [f, J] where f can be a vector (say size m) then J will by m by n matrix
    %
    % Options
    % ----------------------
    %    'method'   - optimization algorithm, available options {'sd','gn'}
    %    'maxiter'  - maximum number of optimization iterations
    %    'tol'      - minimum tolerance required
    %
    % Other options depends on the algorithm in use and are as follows:
    %
    % Optimization Algorithm
    % ----------------------
    % - Steepest Descent
    %
    %   'stepsize'  - steepest descent step size, higher value => fast but
    %   unstable
    %
    % - Gauss Newton
    %
    %   'lambda' - regularization coefficient, higher value => stable but slow
    
    % read in options
    method = params.method;
    maxiter = params.maxiter;
    tol = params.tol;
    
    n = length(x);
    % open summary file
    fid = fopen('summary.md', 'w');
    
    iter = 1;
    while(1)
        [f, J] = objective(x);
        if(strcmp(method,'sd'))
            stepsize = params.stepsize;
            dx = steepest_descent(f, J, stepsize);
            
        elseif(strcmp(method,'gn'))
            lambda = params.lambda;
            dx = gauss_newton(f, J, lambda, n);
        
        elseif(strcmp(method,'experimental'))
            omega = params.omega;
            lambda = params.lambda;
            dx_new = gauss_newton(f, J, lambda, n);
            if(iter == 1)
                dx = dx_new;
            else
                dx = dx_new*omega + dx_old*(1-omega);
            end
            dx_old = dx;
            
        else
            msgID = 'opt:not_implemented';
            msg = 'The optimization method is not available';
            causeException = MException(msgID,msg);
            throw(causeException)
        end
   
        % update
        x = x + dx;
        
        res(iter) = norm(f, 2);
        fprintf(' Iteration: %d ---- Residual : %1.2E\n', iter, res(iter));
        
        if (res(iter) < tol|| res(iter)/res(1) > 1e4 || iter > maxiter - 1)
            break;
        end
        
        iter = iter + 1;
    end
    
    % write summary
    fprintf(fid, '| Timestamp | %s |\n',datestr(clock, 0));
    fprintf(fid, '| :------ | :------|\n');
    fprintf(fid, '| Optimization Algorithm | %s |\n', method);
    fprintf(fid, '| Initial residual | %1.3E |\n', res(1));
    fprintf(fid, '| Final residual | %1.3E |\n', res(iter-1));
    fprintf(fid, '| Number of iterations | %d |\n', iter);
    fclose(fid);
    
end