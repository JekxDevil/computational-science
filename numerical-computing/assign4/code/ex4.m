clear all;
close all;
clc;

max_iter = 200;
tol = 10^-6;

% greyscale imshow
imshow_greyscale = @(M) imshow(M, [min(min(M)), max(max(M))]);

% data
load('blur_data/A.mat');
load('blur_data/B.mat');
A = double(A);
B = double(B);

% image show
imshow_greyscale(B);
title('Blurred Image')

% row-wise vectorization
b=B';
b=b(:);

A_aug = A'*A;
b_aug = A'*b;

condest(A_aug)
guess = zeros(length(b), 1);
[x, rvec] = myCG(A_aug, b_aug, guess, max_iter, tol);
X = reshape(x, size(B))';

%% myCG method deblurring
figure();
imshow_greyscale(B);
title("Image blurred");

figure();
imshow_greyscale(X);
title("Image deblurred using Conjugate Gradient method");

figure();
semilogy(rvec);
title("Residual squared magnitude using CG method");
xlabel("Iterations");
ylabel("Residual squared magnitude");

%% pcg method deblurring
L = ichol(A_aug, struct('type','nofill','diagcomp', 0.01));
[x, flag, relvec, iterz, rvec] = pcg(A_aug, b_aug, tol, max_iter, L, L');
rvec = rvec.^2; % squared magnitude: get same metric as calculated in cg
X = reshape(x,size(B))';

figure();
imshow_greyscale(B);
title("Image Blurred");

figure();
imshow_greyscale(X);
title("Image deblurred using pcg");

figure();
semilogy(rvec);
title("Residual squared magnitude using PCG method");
xlabel("Iterations");
ylabel("Residuals");