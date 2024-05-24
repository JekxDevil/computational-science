%% Midterm assignment
% Student: Jeferson Morales Mariciano
clc; clear variables; close all;

%% Exercise 3.1
% define matrices
A1 = diag(1:10);
A2 = diag(ones(1,10));
A3 = diag([1, 1, 1, 3, 4, 5, 5, 5, 10, 10]);
A4 = diag([1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0]);

% compute and print unique eigenvalues
myl = {A1, A2, A3, A4};
for i = 1:numel(myl)
    eigvals = eig(myl{i});
    eigvals_unique = unique(eigvals);
    fprintf('A%d eigval #: %d\n', i, numel(eigvals_unique));
end

%% Exercise 3.3
rng(20020309); % for reproducibility
b = rand(10,1);
mysolutions = zeros(length(b),1);
myresiduals = cell(size(myl));
myvecxs = cell(size(myl));

for i = 1:numel(myl)
    guess = ones(length(b), 1);
    [mysolutions(:,i), myresiduals{i}, myvecxs{i}] = CG(myl{i}, b, guess, 50000, 1e-7);

    figure;
    mydiff = mysolutions(:,i) - myvecxs{i};
    semilogy(1:size(mydiff,2), mydiff' * myl{i} * mydiff, 'bo-');
    hold on; grid on;
    title(sprintf('Log scale of energy norm of the error for matrix A%d', i));
    xlabel('# iterations');
    ylabel('Energy norm of the error in log scale', 'Interpreter','latex');
    hold off;
end

