clear all;
close all;
clc;

%% exercise 1.1
% x_values = linspace(0, 100, 1000);
% y1 = @(x) 20 - 0.5 * x;
% y2 = @(x) 30 - x;
% y3 = @(x) 24 - (2/3) * x;
% y4 = @(x) zeros(size(x));
% x1 = zeros(size(x_values));
% 
% % Plot
% figure();
% hold on;
% 
% % Plot y <= 20 - 0.5 * x
% plot(x_values, y1(x_values), 'r', 'LineWidth', 2);
% % Plot y >= 30 - x
% plot(x_values, y2(x_values), 'g', 'LineWidth', 2);
% % Plot y >= 24 - 2/3 * x
% plot(x_values, y3(x_values), 'b', 'LineWidth', 2);
% % Plot y >= 0
% plot(x_values, y4(x_values), 'black', 'LineWidth', 2);
% % Plot x >= 0
% plot(x1, x_values, 'black', 'LineWidth', 2);
% 
% % Set axis limits
% xlim([0 45]);
% ylim([0 35]);
% text(11, 20, 'y = 30 - x', 'BackgroundColor', 'white');
% text(35, 3, 'y = 20 - 1/2 x', 'BackgroundColor', 'white');
% text(1, 24, 'y = 24 - 2/3 x', 'BackgroundColor', 'white');
% 
% % Add labels and title
% xlabel('X-axis');
% ylabel('Y-axis');
% title('Feasible region for minimisation problem');
% 
% % Display the grid
% grid on;
% hold off;
% 
% objective_func = @(x,y) 4*x + y;
% p1 = [40 0];
% p2 = [36 0];
% p3 = [24 8];
% z1 = objective_func(p1(1), p1(2));
% z2 = objective_func(p2(1), p2(2));
% z3 = objective_func(p3(1), p3(2));
% z_min = min([z1, z2, z3]);
% fprintf("ex1.1 => z min is %d", z_min);

%% exercise 1.2
x_values = linspace(0, 400, 1000);
r1 = @(x) 175 - 5/8 * x;
r2 = @(x) 265 - x;
r3 = @(x) zeros(size(x)); % y >= 0
r4 = zeros(size(x_values)); % x >= 0

% Plot
figure();
hold on;

plot(x_values, r1(x_values), 'r', 'LineWidth', 2);
plot(x_values, r2(x_values), 'g', 'LineWidth', 2);
plot(x_values, r3(x_values), 'black', 'LineWidth', 2);
plot(r4, x_values, 'black', 'LineWidth', 2);

% Set axis limits
xlim([0 300]);
ylim([0 300]);
text(50, 150, 'y = 175 - 5/8 x', 'BackgroundColor', 'white');
text(65, 200, 'y = 265 - x', 'BackgroundColor', 'white');

% Add labels and title
xlabel('X-axis');
ylabel('Y-axis');
title('Feasible region for maximisation problem');

% Display the grid
grid on;
hold off;

objective_func = @(x,y) 60*x + 70*y;
p1 = [0 175];
p2 = [265 0];
p3 = [240 25];
z1 = objective_func(p1(1), p1(2));
z2 = objective_func(p2(1), p2(2));
z3 = objective_func(p3(1), p3(2));
z_min = min([z1, z2, z3]);
fprintf("ex1.2 => z min is %d", z_min);
