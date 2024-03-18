function [x, euclidean_norm, SE, RMSE] = leastSquares (A, b)
% Calculate least squares of generic system Ax=b
%
% input:
% - A matrix
% - b vector
%
% output:
% - x vector solution to system of equations
% - euclidean_norm metric number
% - SE square error metric number
% - RMSE root mean square error metric number

    [num_eqs, ~] = size(A);

    % find minimal solution x
    AtA = A' * A;
    Atb = A' * b;
    x =  linsolve(AtA, Atb);

    % result quality metrics
    residual = b - A*x;
    euclidean_norm = norm(residual);
    SE = euclidean_norm ^ 2;
    RMSE = euclidean_norm / sqrt(num_eqs);
end