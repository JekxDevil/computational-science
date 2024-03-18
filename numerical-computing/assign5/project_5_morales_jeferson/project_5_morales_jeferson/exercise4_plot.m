clear all;
close all;
clc;

% Define the constraints as anonymous functions
constraint1 = @(x1) (12 - 4*x1) / 3;
constraint2 = @(x1) 8 - 4*x1;
constraint3 = @(x1) (8 - 4*x1) / 2;

% Define the range for x1
x1 = linspace(0, 3, 400);

% Calculate the constraint lines
y1 = constraint1(x1);
y2 = constraint2(x1);
y3 = constraint3(x1);

% Create a new figure
figure;

% Plot the constraints
plot(x1, y1, 'b', 'DisplayName', '4x1 + 3x2 <= 12');
hold on; % Hold on to the current figure
plot(x1, y2, 'r--', 'DisplayName', '4x1 + x2 <= 8');
plot(x1, y3, 'g-.', 'DisplayName', '4x1 + 2x2 <= 8');

% Define the feasible region
% Find the minimum of the constraints at each x1
y_min = min([y1; y2; y3]);

% Fill the feasible region
fill_between = @(x, y1, y2, color) fill([x fliplr(x)], [y1 fliplr(y2)], color);
fill_between(x1, zeros(size(x1)), y_min, 'y');

% Add labels and title
xlabel('x1');
ylabel('x2');
title('Feasible Region with Constraints');
legend('show'); % Show the legend

% Add axes through the origin
line([0, max(x1)], [0, 0], 'Color', 'k');
line([0, 0], [0, max(y_min)], 'Color', 'k');

% Set the limits of the plot
xlim([0, 3]);
ylim([0, 8]);

% Hold off the current figure
hold off;

% Display the plot
grid on;
