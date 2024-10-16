clear all;
close all;
clc;

% at least 10 different alpha for regularized Xreg

% plot norm of error ||Xexact - Xreg||_2 against alpha

% plot ||Hx - b||_2 against ||x||_2 for differents alpha

% regularizedHilbert.m

% Initialize random number generator to its startup configuration
rng('default');

% Value of n
n = 100;

% Generate Hilbert matrix H
H = zeros(n, n);
for row = 1:n
    for col = 1:n
        H(row, col) = 1 / (row + col - 1);
    end
end

% Generate xexact using rand(n, 1)
xexact = rand(n, 1);

% Generate b = H * xexact
b = H * xexact;

% Values of alpha -5, 2,10; -10, 1,10
alpha_values = logspace(-15, -8,8); % Using logarithmic scale for alpha

% Initialize vectors to store results
errors_norm = zeros(1, length(alpha_values));
residual_norms = zeros(1, length(alpha_values));

% Loop through different values of alpha
for i = 1:length(alpha_values)
    alpha = alpha_values(i);
    
    % Solve the regularized system Hx = b with alpha
    xreg = (H' * H + alpha * eye(n)) \ (H' * b);
    
    % Calculate the norm of the error
    errors_norm(i) = norm(xexact - xreg);
    
    % Calculate the norm of the residual Hx - b
    residual_norms(i) = norm(H * xreg - b);
    array_regs(i) = norm(xreg);
end

% Plotting the results
figure;

% Figure 1: Norm of the error ||xexact - xreg|| against alpha
subplot(2, 1, 1);
loglog(alpha_values, errors_norm, 'o-', 'LineWidth', 2);
title('Norm of the Error against \alpha');
xlabel('\alpha');
ylabel('||xexact - xreg||');

% Figure 2: Norm of the residual ||Hx - b|| against ||x||
subplot(2, 1, 2);
loglog(residual_norms, array_regs, 'o-', 'LineWidth', 2);
title('Norm of the Residual against Norm of x');
xlabel('||Hx - b||');
ylabel('||x||');

% Adjusting the layout
sgtitle('Regularized Hilbert Matrix for n = 100');
