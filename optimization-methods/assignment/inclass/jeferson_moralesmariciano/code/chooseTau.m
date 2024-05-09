function [tau] = chooseTau(pN, pu, delta)
%CHOOSETAU Choose Tau
%   Choose Tau such that ||p||^2 = delta^2
%   Where p = pu + tau * (pN - pu)
syms taux
eqn = norm(pu + taux * (pN - pu))^2 == delta^2;
tau = solve(eqn, taux);

tau = double(max(tau));
end