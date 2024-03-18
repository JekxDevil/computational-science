clear all;
close all;
clc;

% Load matrix A_test
A_test = load('./test_data/A_test.mat').A_test;
eigenvalues = eig(A_test);

figure;
semilogy(eigenvalues);
title('Matrix A eigenvalues');
xlabel('Eigenvalue Index');
ylabel('Eigenvalues - logarithmic scale');
grid on;

fprintf('Condition Number of A_test: %f\n', cond(A_test));