close all;
clear;
clc;

n = 10; %1000000;
[A, nz] = A_construct(n);
% --- 6.3 -------------------------------------------------------------

spy(A);
title("Matrix A");
disp(A);
fprintf("Num of non-zero elems: \n"); 
fprintf("\t A_construct(): \t %i \n", nz);
fprintf("\t Computing: \t\t %i \n", size(find(A ~= 0),1));

% --- 6.4 -------------------------------------------------------------

tiledlayout(1,2);
nexttile;
spy(A);
title("Matrix A");
nexttile;
spy(chol(A));
title("Cholesky decomposition of A");
