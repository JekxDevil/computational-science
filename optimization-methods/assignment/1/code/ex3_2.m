% Assignment 1
% exercise 3.2
f = @(x, y, mu) x.^2 + mu .* y.^2;

% use square [-10, 10] x [-10, 10]
x0 = -10:0.1:10;
y0 = -10:0.1:10;
[X, Y] = meshgrid(x0, y0);

figure(1)
subplot(2,2,1)
surf(X, Y, f(X, Y, 1));
title("function for \mu = 1")

subplot(2,2,2)
contour(X, Y, f(X, Y, 1));
title("isocontours for \mu = 1")

subplot(2,2,3)
surf(X, Y, f(X, Y, 10));
title("function for \mu = 10")

subplot(2,2,4)
contour(X, Y, f(X, Y, 10));
title("isocontours for \mu = 10")
