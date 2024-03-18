clear all;
close all;
clc;

%% exercise 1.a
A_1 = [1 1 1; 0 0 0]';
[m,~] = size(A_1);
b_1 = [5 2 4]';
[x_1, EN, SE, RMSE] = leastSquares(A_1, b_1);

disp("PROBLEM 1.a")
if isnan(x_1)
    disp("alpha2 set to = 0 since belongs to R.");
end

x_1 = [11/3, 0]; % set alpha2 to 0
r_1 = b_1-A_1*x_1';
EN = norm(r_1);
SE = EN^2;
RMSE = EN / sqrt(m);
disp("PROBLEM 1.a")
disp(["x = " x_1]);
disp(["euclidean_norm = " EN]);
disp(["SE = " SE]);
disp(["RMSE = " RMSE]);

%% exercise 1.b
A_2 = [1 1 0; 0 1 1; 1 2 1; 1 0 1];
b_2 = [2 2 3 4]';
[x_2, euclidean_norm_2, SE_2, RMSE_2] = leastSquares(A_2, b_2);

disp("PROBLEM 1.b")
disp(["x = " x_2']);
disp(["euclidean_norm = " euclidean_norm_2]);
disp(["SE = " SE_2]);
disp(["RMSE = " RMSE_2]);
