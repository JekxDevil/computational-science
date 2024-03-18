clc;
clear all;
close all;

% gradient method: min f for mu = (1, 10) and x0 = (10,0), (0,10), (10,10)
max_iter = 100;
tol = 1e-8;
mus = [1 10];
start_points = [[10, 0], [0, 10], [10, 10]];

% definition of function and its gradient
syms fx fy
f = fx.^2 + mus(1) .* fy.^2; % TODO mus
f_gradient = gradient(f, [fx, fy]);

% ex3.5 stats
% plot energy landscape in 2D (colored isocontours)
log10norms = zeros(max_iter, 2);
energyfunctionvalues = zeros(max_iter, 2);

xvec = steepest_descent([10, 10], 0.1, f_gradient, [fx, fy], max_iter, tol);


% PLOT
figure(1)
x0 = -10:0.1:10; 
y0 = -10:0.1:10;
[X, Y] = meshgrid(x0, y0);

% Convert symbolic gradient to function handle for numerical computation
f_gradient_func = matlabFunction(f_gradient, 'Vars', [fx, fy]);

% Then, in your steepest_descent function, replace symbolic subs with the function handle call
% Example:
% Instead of this: subs(f_gradient, f_vars, x)
% Use this: f_gradient_func(x(1), x(2))

% For the surface plot
f_func = matlabFunction(f, 'Vars', [fx, fy]);
Z = f_func(X, Y);

surf(X, Y, Z);
% ...

%surf(X, Y, subs(f, [fx fy], [X,Y]));
hold on
disp(size(xvec))
for i=0:size(xvec)[1]
    disp(i);
end
plot3(xvec(:,1),xvec(:,2),f_func(xvec(:,1),xvec(:,2)),'ro','LineWidth',5)

function xvec = steepest_descent(start_point, step, f_gradient, f_vars, max_iter, tol)
    x = start_point;
    xvec = zeros(max_iter, 2);
    xvec(1,:) = start_point;
    for i = 1:max_iter
        x = x - step * subs(f_gradient, f_vars, x)';
        xvec(i+1,:) = x;
        if norm(subs(f_gradient, f_vars, x), 2) <= tol
            break;
        end
    end
end
