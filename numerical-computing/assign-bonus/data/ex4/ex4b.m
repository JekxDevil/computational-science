clear all;
close all;
clc;

data_table = readtable("nuclear.txt", "Delimiter", "\t");
data = table2array(data_table(:,1:2));
% use levenbergMarquardt()
x = data(:,1) - 1998;
y = data(:,2);
syms a1 a2
% if lambda = 0 then gauss-newton
[alpha_star, A_lm] = levenbergMarquardt([1 1], 0, a1*x.^a2 - y);

% result quality metrics
euclidean_norm = norm(y - A_lm*alpha_star);
SE = euclidean_norm ^ 2;
RMSE = euclidean_norm / sqrt(length(data));

f_power = @(a1, a2, x) a1*x.^a2;

% test also linear
addpath ../
A = ones(length(data),2);
A(:,2) = log(x);
b = log(y);
[x_l, en_l, se_l, rmse_l] = leastSquares(A, b);
y_l = @(a1, a2, x) a1*x.^a2;
alpha1 = exp(x_l(1));
coords = [x, y_l(alpha1, x_l(2), x)];
figure();
plot(coords(:,1), coords(:,2), "green");
hold on;

% plot
plot(x, f_power(alpha_star(1), alpha_star(2), x), "red");
hold on;
scatter(x, y, "black");
hold on;
plot(x, y, "blue");
legend("log lin","levenberg-marquardt", "discrete data", "real data trend");
title("nuclear dataset - linearized least square vs iterative method");
% plotting also linear