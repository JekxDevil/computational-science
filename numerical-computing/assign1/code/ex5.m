close all;
clear;
clc;

% computing
load("A_SymPosDef.mat");
A = A_SymPosDef;
p = symrcm(A);
A_symrcm = A(p,p);
R = chol(A);
R_symrcm = chol(A_symrcm);

% plotting
tiledlayout(2,2);
nexttile;
spy(A);
title('Matrix A');

nexttile;
spy(A_symrcm);
title('R.C.M. reordered A');

nexttile;
spy(R);
title('Cholesky of reordered A');

nexttile;
spy(R_symrcm);
title('Cholesky of R.C.M. reodered A');

f_A = @() chol(A);
f_A_symrcm = @() chol(A_symrcm);
timeit(f_A)
timeit(f_A_symrcm)

