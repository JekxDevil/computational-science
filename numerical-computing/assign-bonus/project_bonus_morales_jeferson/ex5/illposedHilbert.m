clear all;
close all;
clc;


% Initialize random number generator to its startup configuration
rng('default');

% Values of n
n_values = [50, 100, 200, 300, 400, 500, 1000];

% Initialize vectors to store condition numbers and errors
condition_numbers = zeros(1, length(n_values));
errors = zeros(1, length(n_values));

% Loop through different values of n
for i = 1:length(n_values)
    n = n_values(i);
    
    % Generate Hilbert matrix H
    H = zeros(n, n);
    for row = 1:n
        for col = 1:n
            H(row, col) = 1 / (row + col - 1);
        end
    end
    
    % Generate xexact using rand(n, 1)
    xexact = rand(n, 1);
    
    % Generate b = H * xexact
    b = H * xexact;
    
    % Solve the system Hx = b
    x = H \ b;
    
    % Calculate condition number of H
    condition_numbers(i) = cond(H);
    
    % Calculate the norm of the error
    errors(i) = norm(xexact - x);
end

% Plotting the results
figure;

% Figure 1: Condition number of H against n
subplot(2, 1, 1);
plot(n_values, condition_numbers, 'o-', 'LineWidth', 2);
title('Condition Number of H against n');
xlabel('n');
ylabel('Condition Number');

% Figure 2: Norm of the error ||x - xexact|| against n
subplot(2, 1, 2);
plot(n_values, errors, 'o-', 'LineWidth', 2);
title('Norm of the Error against n');
xlabel('n');
ylabel('||x - xexact||');

% Adjusting the layout
sgtitle('Hilbert Matrix Properties for Different n');