function [x, A] = levenbergMarquardt(x, lambda, func)
% Tackels eventual ill-conditioning of the Jacobian matrix
% with a regularization term lambda, hence achieving convergence
% with broader set of starting values guesses than Gauss-Newton method.
%
% Input:
% - x initial guess vector of coefficients, can be "default"
% - lambda influence of AtA and its condition number
% - func_r function describing residual
%
% Output:
% - x coefficients of non linear least squares

if isstring(x) & x == "default"
    x = [1,1];
end

x = x';

epsilon = 1e-7;
r_prev = Inf;
r = double(subs(func, symvar(func), x'));
x_prev = Inf;
iter = 1;
while norm(x-x_prev) > epsilon && iter < 100
    A_sym = jacobian(func, symvar(func));
    A = double(subs(A_sym, symvar(func), x'));
    AtA = A'*A;
    r_prev = r;
    r = double(subs(func, symvar(func), x'));
    v = -(AtA + lambda*diag(AtA))^-1 * A'*r;
    x_prev = x;
    x = x + v;
    iter = iter + 1;
end
