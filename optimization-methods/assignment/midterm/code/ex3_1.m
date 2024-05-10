%% In-class exercise
% Student: Jeferson Morales Mariciano
clc; clear variables; close all;

%% Exercise 3.1
% define matrices
A1 = diag(1:10);
A2 = diag(ones(1,10));
A3 = diag([1, 1, 1, 3, 4, 5, 5, 5, 10, 10]);
A4 = diag([1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0]);

% compute eigenvalues
myl = {A1, A2, A3, A4};
for i = 1:numel(myl)
    eigvals = eig(myl{i});
    eigvals_unique = unique(eigvals);
    fprintf('A%d eigval #: %d\n', i, numel(eigvals_unique));
end