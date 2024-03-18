clc;
clear variables;
close all;

% gradient method: min f for mu = 1, 10 and x0 = (10,0), (0,10), (10,10)
max_iter = 100;
tol = 1e-8;
mus = [1, 10];
starting_points = [[10, 0]; [0, 10]; [10, 10]];

% definition of function and its gradient
syms fx fy
f = fx.^2 + mus(2) * fy.^2;
f_gradient = gradient(f, symvar(f));
f_hessian = hessian(f, symvar(f));

% build optimal step length [optional, done by the steepest descent]
x0 = starting_points(3,:);
f_gradient_eval = subs(f_gradient, symvar(f), x0);
f_hessian_eval = subs(f_hessian, symvar(f), x0);
A = f_hessian_eval;
step = (f_gradient_eval' * f_gradient_eval) ...
        / (f_gradient_eval' * A * f_gradient_eval);

[x_star, funcvals, gradient_norms, iterations] = steepest_descent(x0, f, max_iter, tol);

% plot
figure(1)
x0 = -10:0.1:10; 
y0 = -10:0.1:10;
[X, Y] = meshgrid(linspace(-10, 10, 100), linspace(-10, 10, 100));
% For the surface plot
f_func = matlabFunction(f, 'Vars', symvar(f));
Z = f_func(X, Y);
subplot(2,2,1);
surf(X, Y, Z);
hold on
plot3(funcvals(:,1), funcvals(:,2), f_func(funcvals(:,1), funcvals(:,2)), ...
    'ro-', 'LineWidth', 1);
subplot(2,2,2);
contourf(X, Y, f_func(X, Y));
hold on;
plot(funcvals(:,1), funcvals(:,2), 'ro-');


subplot(2,2,3);
semilogy(gradient_norms(1:iterations));

subplot(2,2,4);
plot(1:iterations, f_func(funcvals(1:iterations,1), funcvals(1:iterations,2)));


%% Steepest Descent
% works only for quadratic forms since I used its step length computation
% formula and exploits Hessian = A, true only for quadratic forms
function [x_star, funcvals, gradient_norms, iterations, alphas] = steepest_descent(start_point, f, max_iter, tol)
    funcvals = zeros(max_iter, 2);
    gradient_norms = zeros(max_iter, 1);
    f_gradient = matlabFunction(gradient(f, symvar(f)), "Vars", symvar(f));
    f_hessian = matlabFunction(hessian(f, symvar(f)), "Vars", symvar(f));
    alphas = zeros(max_iter, 1);
    iterations = 1;

    x_star = start_point;
    funcvals(1,:) = start_point;
    gradient_norms(1,:) = norm(f_gradient(x_star(1), x_star(2)));
    df = f_gradient(x_star(1), x_star(2));


    while iterations < max_iter && norm(f_gradient(x_star(1), x_star(2))) > tol
        df = f_gradient(x_star(1), x_star(2));
        step = (df' * df) / (df' * f_hessian(x_star(1), x_star(2)) * df);

        x_star = x_star - step * f_gradient(x_star(1), x_star(2))';
        funcvals(iterations+1,:) = x_star;
        gradient_norms(iterations+1,:) = norm(f_gradient(x_star(1), x_star(2)));
        alphas(iterations) = step;

        iterations = iterations + 1;
    end
end
