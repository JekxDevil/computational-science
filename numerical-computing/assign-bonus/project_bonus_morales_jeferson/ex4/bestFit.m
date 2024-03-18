clear all;
close all;
clc;

addpath ../

data_table = readtable("nuclear.txt", "Delimiter", "\t");
data = table2array(data_table(:,1:2));
data(:,1) = data(:,1) - 1998;

%% Least squares: data linearization power law model ln(y)=k1+a2*ln(x), k1=ln(a1)
A = ones(length(data),2);
A(:,2) = log(data(:,1));
b = log(data(:,2));
[x, EN, SE, RMSE] = leastSquares(A, b);

y = @(a1, a2, x) a1*x.^a2;

% convert to power law
alpha1 = exp(x(1));

coords = [data(:,1), y(alpha1, x(2), data(:,1))];
figure();
plot(coords(:,1), coords(:,2), "red");
hold on;
scatter(data(:,1), data(:,2), "black");
legend("discrete points")
hold on;
plot(data(:,1), data(:,2), "blue");
legend("best fit - power law","real discrete data samples","real data function")

%% RMSE
fprintf("RMSE:\n");

% log linearized model of power law
disp(["- log linearized: ",RMSE]);

% exponential model
A_exp = [coords(:,2)];
b_exp = data(:,2);
[~,~,~,RMSE_power] = leastSquares(A_exp, b_exp);
disp(["- power law model: ", RMSE_power]);

