%% In-class exercise
% Student: Jeferson Morales Mariciano
clc; clear variables; close all;

%% Trust Region Dogleg method
max_iters = 50000;
tol = 1e-6;
x0 = [0, 0];
alpha_tilde = 1;
rho = 0.9;
c = 1e-4; % (0.5, 1e-4)

syms fx fy
f_rosenbrock_sym = (1-fx).^2 + 100*(fy - fx.^2).^2;

[x_star, f_vals, grad_norms, iters, steps] = ...
    newton(x0, f_rosenbrock_sym, max_iters, tol, alpha_tilde, rho, c);

% plottings: energy function 3d & 2d
x = linspace(-2, 2, 100);
y = linspace(-3, 3, 100);
[X,Y] = meshgrid(x, y);
Z = double(subs(f_rosenbrock_sym, [fx, fy], {X, Y}));

figure;
sgtitle("Trust Region - Dogleg Method");
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
semilogy(max(eps, grad_norms), 'bo-');
hold on; grid on;
title('Gradient norms along iterations');
xlabel('# iterations');
ylabel('$||\nabla f||$','Interpreter','latex');

subplot(2,2,4);
semilogy(max(eps, f_vals(:,3)), 'bo-');
hold on; grid on;
title('Function values along iterations');
xlabel('# iterations');
ylabel('$f(x)$', 'Interpreter','latex');

figure;
plot(f_vals(:,1), f_vals(:,2), 'bo-');
xlabel("$x_1$", "Interpreter", "latex"); 
ylabel("$x_2$", "Interpreter", "latex");
title("Convergence of Dogleg method");

%% Trust Region Dogleg method
% supports only 2 variables functions.
% iterations exclusively bounds the values inside the other metrics
function [x_star, funcvals, gradient_norms, iters, steps] = ...
    dogleg(start_point, f_sym, max_iters, tol, tau)

    % init metrics
    funcvals = zeros(max_iters, 3);
    gradient_norms = zeros(max_iters, 1);
    iters = 1;
    steps = zeros(max_iters, 1);

    delta_hat = 0.5;        % > 0
    delta = delta_hat / 2;  % (0, delta_hat)
    eta = 1/4;              % [0, 1/4)

    % computation and conversion of gradient and hessian
    f_vars = symvar(f_sym);
    f = matlabFunction(f_sym, "Vars", f_vars);
    f_gradient = matlabFunction(gradient(f_sym, f_vars), "Vars", f_vars);
    f_hessian = matlabFunction(hessian(f_sym, f_vars), "Vars", f_vars);

    % store starting point in metrics
    x_star = start_point;
    funcvals(1,:) = [start_point, f(x_star(1), x_star(2))];
    gradient_norms(1,:) = norm(f_gradient(x_star(1), x_star(2)));

    while iters <= max_iters && tol < norm(f_gradient(x_star(1), x_star(2)))
        % obtain step by approx solving (4.3)
        B = f_hessian(x_star(1), x_star(2));
        pB = - B \ f_gradient(x_star(1), x_star(2));
        step = 1;

        % evaluate rho from (4.4)
        fk = f(x_star(1), x_star(2));
        mk = @(p) fk + f_gradient' * p + 0.5 * p' * Bk * p;
        xkpk = x_star + pk;
        act_reduction = fk - f(xkpk(1), xkpk(2));
        pred_reduction = mk(0) - mk(pk);
        rho = act_reduction / pred_reduction;

        if rho < 1/4
            delta = 1/4 * delta;
        else
            if rho > 3/4 && norm(step) == delta
                delta = min(2*delta, delta_hat);
            end
        end

        if rho > eta
            x_star = x_star + step;
        end

        % compute and store metrics
        funcvals(1+iters,:) = [x_star, f(x_star(1), x_star(2))];
        gradient_norms(1+iters,:) = norm(f_gradient(x_star(1), x_star(2)));
        steps(iters) = step;
        iters = iters + 1;
    end

    % resize metrics to iters
    funcvals = funcvals(1:iters,:);
    gradient_norms = gradient_norms(1:iters);
    steps = steps(1:iters-1); % init step does not exist, hence -1
end