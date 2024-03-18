clear all;
close all;
clc;

% load crudeOil.txt and kerosene.txt for year in [1980, 2011]
file_oil = fopen("readcrudeOil.txt", "r");
data_oil = fscanf(file_oil, "%d %f %f", [3, Inf]);
data_oil = data_oil';
fclose(file_oil);

file_kerosene = fopen('readkerosene.txt','r');
data_kerosene = fscanf(file_kerosene, "%d %f %f", [3, Inf]);
data_kerosene = data_kerosene';
fclose(file_kerosene);

% linear model y = a1 + a2*x
model_quadratic = @(a1, a2, a3, x) a1 + a2*x + a3*x.^2;
[n, m] = size(data_oil);
A_oil = ones(n, 3);
A_oil(:,2) = data_oil(:,1);
A_oil(:,3) = data_oil(:,1) .* data_oil(:,1);
b_oil = data_oil(:,2);
[x_oil, euclidean_norm_oil, SE_oil, RMSE_oil] = leastSquares(A_oil, b_oil);

[n, m] = size(data_kerosene);
A_kero = ones(n, 3);
A_kero(:,2) = data_kerosene(:,1);
A_kero(:,3) = data_kerosene(:,1) .* data_kerosene(:,1);
b_kero = data_kerosene(:,2);
[x_kero, euclidean_norm_kero, SE_kero, RMSE_kero] = leastSquares(A_kero, b_kero);

% visualize data results
figure;
plot(data_oil(:,1), model_quadratic(x_oil(1), x_oil(2), x_oil(3), data_oil(:,1)), "red");
hold on;
scatter(data_oil(:,1), data_oil(:,2), "black");
hold on;
plot(data_oil(:,1), data_oil(:,2), "blue");
title("crude oil dataset - quadratic model")
legend("quadratic least square", "discrete real data", "real data trend");
hold off;

figure;
plot(data_kerosene(:,1), model_quadratic(x_kero(1), x_kero(2), x_kero(3), data_kerosene(:,1)), "red");
hold on;
scatter(data_kerosene(:,1), data_kerosene(:,2), "black");
hold on;
plot(data_kerosene(:,1), data_kerosene(:,2), "blue");
title("kerosene dataset - quadratic model");
legend("quadratic least square", "discrete real data", "real data trend");
hold off;

fprintf("\t\t Oil \t kerosene\n");
fprintf("Quaratic: %f \t %f \n", ...
    model_quadratic(x_oil(1), x_oil(2), x_oil(3), [2012]), ...
    model_quadratic(x_kero(1), x_kero(2), x_kero(3), [2012]));