close all;
clear all;
clc;

addpath ../ex2/

% model periodic
%1960	-3.9	-1.59	1.2	3.2	8.85	11.94	10.81	11.73	7.94	4.2	1.63	-3.03	
%1961	-3.14	0.78	1.77	6.11	6.21	11.66	11.61	12.29	13.32	6.43	0.69	-1.39
%1962	-2.4	-3.74	-3.49	2.81	5.61	10.05	12.14	14.25	9.65	6.12	-1.2	-5.39
%1963	-8.59	
y = @(a1, a2, a3, x) a1 + a2*cos(2*pi*x) + a3*sin(2*pi*x);

% years [1960, 1963]
data = readtable("readtemperature.txt");
range = 1960 <= data(:,1) & data(:,1) <= 1963;
data_sixty_three = table2array(data(table2array(range),:));

coords = ones(3*12+1, 2);
acc = 1;
count = 1;
for i=1:length(coords)
    if count < 12
        coords(i,1) = i/12;
        coords(i,2) = data_sixty_three(acc, count+1);
        count = count + 1;
    else
        coords(i,1) = i/12;
        coords(i,2) = data_sixty_three(acc, count+1);
        count = 1;
        acc = acc + 1;
    end
end

[n,m] = size(coords);
A_sixty_three = ones(n, 3);
A_sixty_three(:,2) = cos(2*pi*coords(:,1));
A_sixty_three(:,3) = sin(2*pi*coords(:,1));
b_sixty_three = coords(:,2);
[x, euclidean_norm, SE, RMSE] = leastSquares(A_sixty_three, b_sixty_three);
figure;
plot(coords(:,1), y(x(1), x(2), x(3), coords(:,1)), "red");
hold on;
scatter(coords(:,1), coords(:,2), "black");
hold on;
plot(coords(:,1), coords(:,2), "blue");
title("Switzerland mean tempature - Jan 1960 to Jan 1963");
legend("periodic model", "discrete real data", "real data trend");

% years [1960, 1970]
range = 1960 <= data(:,1) & data(:,1) <= 1970;
data_sixty_seventy = table2array(data(table2array(range),:));

coords = ones(10*12+1, 2);
acc = 1;
count = 1;
for i=1:length(coords)
    if count < 12
        coords(i,1) = i/12;
        coords(i,2) = data_sixty_seventy(acc, count+1);
        count = count + 1;
    else
        coords(i,1) = i/12;
        coords(i,2) = data_sixty_seventy(acc, count+1);
        count = 1;
        acc = acc + 1;
    end
end

[n,m] = size(coords);
A_sixty_three = ones(n, 3);
A_sixty_three(:,2) = cos(2*pi*coords(:,1));
A_sixty_three(:,3) = sin(2*pi*coords(:,1));
b_sixty_three = coords(:,2);
[x, euclidean_norm, SE, RMSE] = leastSquares(A_sixty_three, b_sixty_three);
figure;
plot(coords(:,1), y(x(1), x(2), x(3), coords(:,1)), "red");
hold on;
scatter(coords(:,1), coords(:,2), "black");
hold on;
plot(coords(:,1), coords(:,2), "blue");
title("Switzerland mean tempature - Jan 1960 to Jan 1970");
legend("periodic model", "discrete real data", "real data trend");