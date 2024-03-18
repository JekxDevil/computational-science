function [A, nz] = A_construct(n)
% n = matrix size
% computes matrix defined in assingment 1, ex 6
% return matrix and non-zero elements
% A = zeros(n); if normal allocated matrix is used
A = sparse(n, n);

if n ~= 1
    nz = 5*n - 6;
else
    nz = 0;
end

for i = 1:n
    for j = 1:n
        % the condition in the assignment is wrong,
        % AND has precedence over OR and assignment neglects it
        % only by doing cholesky and A not being positive definite 
        % the error is spotted.
        if (i == 1 || i == n || j == 1 || j == n) && i ~= j
            A(i,j) = 1;
        elseif i == j
            A(i,j) = n+i-1;
        else
            A(i,j) = 0;
        end
    end
end

end
