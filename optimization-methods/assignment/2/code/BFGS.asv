%% Assignment 2
% Student: Jeferson Morales Mariciano
clc; clear variables; close all;

%% Exercise 2
% BFGS METHOD
max_iters = 500;
tol = 1e-6;
x0 = [0, 0];
H0 = eye(size(x0,2));
alpha_tilde = 1;
rho = 0.9;
c = 1e-4; % (0.5, 1e-4)

syms fx fy
f_rosenbrock_sym = (1 - fx).^2 + 100*(fy - fx.^2).^2; 

[x_star, f_vals, grad_norms, iters, steps] = ...
    bfgs(x0, f_rosenbrock_sym, max_iters, tol, alpha_tilde, rho, c, H0);

% plottings: energy function 3d & 2d
x = linspace(-2, 2, 100);
y = linspace(-3, 3, 100);
[X,Y] = meshgrid(x, y);
Z = double(subs(f_rosenbrock_sym, [fx, fy], {X, Y}));

figure;
sgtitle("BFGS with Backtracking");
subplot(2,2,1);
sc = surfc(X,Y,Z); 
hold on; 
colorbar; sc(1).EdgeColor = 'none';
plot3(f_vals(:,1), f_vals(:,2), f_vals(:,3), 'ro-', 'LineWidth', 2);
title("Energy landscape in 3D");

subplot(2,2,2);
contourf(X, Y, Z);
hold on;
plot(f_vals(:,1), f_vals(:,2), 'ro-', 'LineWidth', 2);
title("Energy landscape in 2D");

subplot(2,2,3);
semilogy(1:iters, grad_norms, 'b-');
hold on; grid on;
title('Gradient norms along iterations');
xlabel('# iterations');
ylabel('$||\nabla f||$','Interpreter','latex');

subplot(2,2,4);
semilogy(1:iters, f_vals(:,3), 'bo-');
hold on; grid on;
title('Function values along iterations');
xlabel('# iterations');
ylabel('$f(x)$', 'Interpreter','latex');

figure;
plot(f_vals(:,1), f_vals(:,2), 'bo-');
title("Convergence of Steepest Descent with Backtracking");
xlabel("$x_1$", "Interpreter", "latex"); 
ylabel("$x_2$", "Interpreter", "latex");

%% BFGS Method with Backtracking
% supports only 2 variables functions.
% iterations exclusively bounds the values inside the other metrics
function [x_star, funcvals, gradient_norms, iters, steps] = ...
    bfgs(start_point, f_sym, max_iters, tol, alpha_tilde, rho, c, Hk)

    % init metrics
    funcvals = zeros(max_iters, 3);
    gradient_norms = zeros(max_iters, 1);
    iters = 1;
    steps = zeros(max_iters, 1);

    % computation and conversion of gradient and hessian
    f_vars = symvar(f_sym);
    f = matlabFunction(f_sym, "Vars", f_vars);
    f_gradient = matlabFunction(gradient(f_sym, f_vars), "Vars", f_vars);
    I = eye(size(f_vars,2));

    % store starting point in metrics
    x_star = start_point;
    funcvals(1,:) = [start_point, f(x_star(1), x_star(2))];
    gradient_norms(1,:) = norm(f_gradient(x_star(1), x_star(2)));

    while iters <= max_iters && tol < norm(f_gradient(x_star(1), x_star(2)))
        % compute alpha step length and x(k)
        pk = -1 * Hk * f_gradient(x_star(1), x_star(2));

        [step, ~] = ...
            backtracking(f, f_gradient, x_star, pk, alpha_tilde, rho, c);

        x_star = x_star + step * pk';
        sk = x_star - funcvals(iters, 1:2);
        yk = f_gradient(x_star(1), x_star(2))' - f_gradient(funcvals(iters, 1), funcvals(iters, 2))';
        rhok = 1 / dot(yk, sk);
        Hk = (I - rhok * sk' * yk) * Hk * (I - rhok * yk' * sk) + rhok * (sk' * sk);

        % compute and store metrics
        funcvals(1+iters,:) = [x_star, f(x_star(1), x_star(2))];
        gradient_norms(1+iters,:) = norm(f_gradient(x_star(1), x_star(2)));
        steps(iters) = step;
        iters = iters + 1;
    end

    % resize metrics to iters
    iters = iters - 1;
    funcvals = funcvals(1:iters,:);
    gradient_norms = gradient_norms(1:iters);
    steps = steps(1:iters);
end
