function [vecx, itr, vecgrad] = trustRegion(f, grad, hess, x0, delta_max, ...
    delta0, eta, maxitr, tol)
%TRUSTREGION TrustRegion
%   Reference: J. Nocedal and S. Wright, Numerical optimization, page 69
%   Algorithm 4.1
%   Input:
%           * f = function
%           * grad = gradient of function
%           * hess = Hessian matrix of function
%           * x0 = starting point
%           * delta_max = maximum value of delta (must be > 0)
%           * delta0 = starting delta in interval (0, delta_max)
%           * eta = parameter in interval [0, 1/4)
%           * maxitr = maximum number of iterations allowed
%           * tol = tolerance threshold

x = x0;
delta = delta0;
itr = 1;

% Vector to save iterates
vecx = zeros(size(x0, 1), maxitr + 1);
vecx(:, itr) = x0;

% Vector to save norm of gradients
vecgrad = zeros(1, maxitr + 1);

for i = 1 : maxitr
    fx = f(x(1), x(2));
    g = grad(x(1), x(2));
    h = hess(x(1), x(2));
    % Vector to save norm of gradients
    vecgrad(itr) = norm(g);

    if norm(g) < tol 
        break;
    end

    %p = dogleg(h, g, delta);
    p = cauchyPoint(h, g, delta);

    mp = fx + g'*p + 1/2*p'*h*p;
    xp = x+p;
    fxp = f(xp(1), xp(2));
    act_reduction = fx - fxp;
    pred_reduction = fx - mp;
    rho = act_reduction / pred_reduction;

    if rho < 1 / 4
        delta = 1/4 * delta;
    elseif rho > 3 / 4 && norm(p) == delta
        delta = min(2 * delta, delta_max);
    end
    
    if rho > eta
        x = x + p;
    end
    
    itr = i + 1;
    
    % Vector to save iterates
    vecx(:, itr) = x;
end

vecx = vecx(:, 1:itr);
vecgrad = vecgrad(:, 1:itr);
end