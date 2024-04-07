%% Assignment 2
% Student: Jeferson Morales Mariciano
clc; clear variables; close all;

%% Exercise 1.1
% Rosenbrock function, global minima [1,1]
f_rosenbrock = @(x) (1 - x(:,1)).^2 + 100*(x(:,2) - x(:,1).^2).^2;

x = linspace(-2, 2, 100);
y = linspace(-3, 3, 100);
[X,Y] = meshgrid(x, y);
Z = f_rosenbrock([X(:), Y(:)]);
Z = reshape(Z, size(X)); % get back the f vals in X MxN size

% plottings: energy function 3d & 2d, 
figure;
subplot(1,2,1);
sc = surf(X,Y,Z);
colorbar;
sc.EdgeColor = 'none';

subplot(1,2,2);
contourf(X, Y, Z);
