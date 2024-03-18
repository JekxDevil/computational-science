close all;
clear all;
clc;

% model periodic
y = @(a1,a2,a3,a4,x) a1 + a2*cos(2*pi*x) + a3*sin(2*pi*x) + a4*cos(4*pi*x);

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
A_sixty_three = ones(n, 4);
A_sixty_three(:,2) = cos(2*pi*coords(:,1));
A_sixty_three(:,3) = sin(2*pi*coords(:,1));
A_sixty_three(:,4) = cos(4*pi*coords(:,1));
b_sixty_three = coords(:,2);
[x, euclidean_norm, SE, RMSE] = leastSquares(A_sixty_three, b_sixty_three);
figure;
plot(coords(:,1), y(x(1),x(2),x(3),x(4),coords(:,1)), "red");
hold on;
scatter(coords(:,1), coords(:,2), "black");
hold on;
plot(coords(:,1), coords(:,2), "blue");
title("Switzerland mean tempature - Jan 1960 to Jan 1963");
legend("periodic model", "discrete real data", "real data trend");
hold off;

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
A_sixty_three = ones(n, 4);
A_sixty_three(:,2) = cos(2*pi*coords(:,1));
A_sixty_three(:,3) = sin(2*pi*coords(:,1));
A_sixty_three(:,4) = cos(4*pi*coords(:,1));
b_sixty_three = coords(:,2);
[x, euclidean_norm, SE, RMSE] = leastSquares(A_sixty_three, b_sixty_three);
figure;
plot(coords(:,1), y(x(1),x(2),x(3),x(4),coords(:,1)), "red");
hold on;
scatter(coords(:,1), coords(:,2), "black");
hold on;
plot(coords(:,1), coords(:,2), "blue");
title("Switzerland mean tempature - Jan 1960 to Jan 1970");
legend("periodic model", "discrete real data", "real data trend");
hold off;
