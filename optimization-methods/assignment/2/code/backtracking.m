% Student: Jeferson Morales Mariciano

function [alpha, iters] = backtracking(f, gradient, x, p, alpha0, rho, c)
% INPUTS
% - f: function
% - g: gradient
% - x: start point
% - p: directional derivative row-wise (-gradient)
% - n: init alpha
% - rho: contraction factor
% - c: sufficient decrease constant factor on l(alpha)
%      suggested val 1e-4 from pag 33 Nocedal book

alpha = alpha0; % initial alpha
iters = 0;

while f( x(1) + alpha*p(1) , x(2) + alpha*p(2) ) ...
        > f(x(1), x(2)) + c*alpha* dot(gradient(x(1), x(2)), p) ...
        && iters < 1000
    % loop on Armijo Condition and max_iters
    alpha = rho*alpha;
    iters = iters + 1;
end

end
