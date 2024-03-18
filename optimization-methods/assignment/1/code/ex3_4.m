clc;
clear variables;
close all;

% GRADIENT METHOD: min f for mu = 1, 10 and x0 = (10,0), (0,10), (10,10)
max_iter = 100;
tol = 1e-8;
mus = [1, 10];
starting_points = [[10, 0]; [0, 10]; [10, 10]];
x0 = starting_points(2,:);
mu = mus(2);

% definition of function, gradient, hessian
syms fx fy
f = fx.^2 + mu * fy.^2;

% build optimal step length [optional, done by the steepest descent]
df_eval = subs(gradient(f, symvar(f)), symvar(f), x0);
ddf_eval = subs(hessian(f, symvar(f)), symvar(f), x0);
A = ddf_eval;
step = (df_eval' * df_eval) / (df_eval' * A * df_eval);

% calling steepest descent
[x_star, funcvals, gradient_norms, iterations] = steepest_descent(x0, f, max_iter, tol);

% plots
figure(1)
coord_sys_cube = -10:0.1:10; 
[X, Y] = meshgrid(coord_sys_cube, coord_sys_cube);
f_func = matlabFunction(f, 'Vars', symvar(f));
Z = f_func(X, Y);
sgtitle("Case \mu = 10, x_0 = (10, 10)");

subplot(2,2,1);
surf(X, Y, Z);
hold on
plot3(funcvals(:,1), funcvals(:,2), f_func(funcvals(:,1), funcvals(:,2)), ...
    'ro-', 'LineWidth', 2);
title("Energy landscape in 3D");

subplot(2,2,2);
contourf(X, Y, f_func(X, Y));
hold on;
plot(funcvals(:,1), funcvals(:,2), 'ro-', 'LineWidth', 2);
title("Energy landscape in 2D");

subplot(2,2,3);
semilogy(1:iterations, gradient_norms(1:iterations), '-ob');
hold on;
grid on;
title("Logarithmic norm of gradient values along iterations");
xlabel("iterations");
ylabel("log_{10}(||\nablaf_k||)")

subplot(2,2,4);
plot(1:iterations, f_func(funcvals(1:iterations,1), funcvals(1:iterations,2)));
hold on;
grid on;
title("Energy function along iterations");
xlabel("iterations");
ylabel("f(x_k,y_k)")

%% Steepest Descent
% works only for quadratic forms since I used its step length computation
% formula and exploits Hessian = A, true only for quadratic forms
function [x_star, funcvals, gradient_norms, iterations, alphas] = steepest_descent(start_point, f, max_iter, tol)
    % init results
    funcvals = zeros(max_iter, 2);
    gradient_norms = zeros(max_iter, 1);
    iterations = 1;
    alphas = zeros(max_iter, 1);

    % computation and conversion of gradient and hessian
    f_gradient = matlabFunction(gradient(f, symvar(f)), "Vars", symvar(f));
    f_hessian = matlabFunction(hessian(f, symvar(f)), "Vars", symvar(f));

    % store starting point in metrics
    x_star = start_point;
    funcvals(1,:) = start_point;
    gradient_norms(1,:) = norm(f_gradient(x_star(1), x_star(2)));

    while iterations < max_iter && norm(f_gradient(x_star(1), x_star(2))) > tol
        % compute alpha step length and x(k)
        df = f_gradient(x_star(1), x_star(2));
        step = (df' * df) / (df' * f_hessian(x_star(1), x_star(2)) * df);
        x_star = x_star - step * f_gradient(x_star(1), x_star(2))';

        % compute and store metrics
        funcvals(iterations+1,:) = x_star;
        gradient_norms(iterations+1,:) = norm(f_gradient(x_star(1), x_star(2)));
        alphas(iterations) = step;
        iterations = iterations + 1;
    end
end
