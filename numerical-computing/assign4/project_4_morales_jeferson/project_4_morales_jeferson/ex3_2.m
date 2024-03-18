clear all;
close all;
clc;

% Load test data
A_test = load('./test_data/A_test.mat').A_test;
b_test = load('./test_data/b_test.mat').b_test;

% Run myCG() on B_test
guess = ones(length(b_test), 1);
[x, residuals] = myCG(A_test, b_test, guess, 1000, 1e-7);

% Plot convergence
figure;
bar(residuals);
title('Conjugate Gradient convergence');
xlabel('Iterations');
ylabel('Residual Value squared magnitude');
grid on;

figure;
semilogy(residuals);
title('Conjugate Gradient convergence');
xlabel('Iterations');
ylabel('Residual Value squared magnitude - log scale');
grid on;
