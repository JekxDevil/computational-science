%% Midterm assignment
% Student: Jeferson Morales Mariciano
clc; clear variables; close all;

%% Exercise 3.1
% define matrices
A1 = diag(1:10);
A2 = diag(ones(1,10));
A3 = diag([1, 1, 1, 3, 4, 5, 5, 5, 10, 10]);
A4 = diag([1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0]);

% Step 2: Compute the eigenvalues
eigenvalues = eig(A3);

% Extract only the real parts of the eigenvalues
real_parts = real(eigenvalues);

% Visualize the real parts using a scatter plot
figure;
scatter(1:length(real_parts), real_parts, 100, 'filled', 'MarkerFaceColor', [0.8, 0.2, 0.2]);
xlabel('Index');
ylabel('Real Part');
title('Real Parts of Eigenvalues');
grid on;

% Define a range of real numbers around the real eigenvalues
x = linspace(min(real_parts) - 2, max(real_parts) + 2, 100);
y = linspace(-2, 2, 100); % For visualization purposes, use a small imaginary range

[X, Y] = meshgrid(x, y);
Z = X + 1i * Y;

% Compute the determinant function over the grid
det_values = zeros(size(Z));
for i = 1:numel(Z)
    det_values(i) = abs(det(Z(i) * eye(size(A3)) - A3));
end

% Plot the contours of the determinant function
figure;
contourf(X, Y, log10(det_values), 20);
colorbar;
xlabel('Real Part');
ylabel('Imaginary Part');
title('Contours of log_{10}(det(zI - A1))');
grid on;
axis tight;

% Overlay the real parts of the eigenvalues
hold on;
scatter(real_parts, zeros(size(real_parts)), 100, 'r', 'filled');
legend('Contours', 'Real Eigenvalues', 'Location', 'Best');

% Compute the eigenvalues
eigenvalues = eig(A3);

% Extract only the real parts of the eigenvalues
real_parts = real(eigenvalues);

% Define a range of real numbers around the real eigenvalues
x = linspace(min(real_parts) - 2, max(real_parts) + 2, 1000);
y = linspace(-2, 2, 1000); % For visualization purposes, use a small imaginary range

[X, Y] = meshgrid(x, y);
Z = X + 1i * Y;
           
% Compute the determinant function over the grid
det_values = zeros(size(Z));
for row = 1:size(Z, 1)
    for col = 1:size(Z, 2)
        z = Z(row, col);
        det_values(row, col) = abs(det(z * eye(size(A3)) - A3));
    end
end

% Find the indices corresponding to the real parts of the eigenvalues
eigenvalue_det_values = zeros(size(real_parts));
for i = 1:length(real_parts)
    [~, idx_x] = min(abs(x - real_parts(i)));
    eigenvalue_det_values(i) = log10(max(eps, det_values(1, idx_x)));
end

% Plot the 3D surface of the determinant function
log_det = log10(det_values);
figure;
surf(X, Y, log_det, 'EdgeColor', 'none');
colorbar;
xlabel('Real Part');
ylabel('Imaginary Part');
zlabel('log_{10}(abs(det(zI - A1)))');
title('3D Visualization of log_{10}(det(zI - A1))');
grid on;
view(45, 30);

% Overlay the real parts of the eigenvalues as red dots
hold on;
xidx = zeros(size(eigenvalues,1),1);
for i=1:size(eigenvalues,1)
    val = find(abs(x-eigenvalues(i))==min(abs(x-eigenvalues(i))));
    xidx(i) = val(1);
end
yidx = find(abs(y)==min(abs(y)));
%idx = 
scatter3(real_parts, zeros(size(real_parts)), log_det(yidx(1), xidx), 100, 'r', 'filled');
legend('Surface', 'Real Eigenvalues', 'Location', 'Best');


% compute and print unique eigenvalues
myl = {A1, A2, A3, A4};
for i = 1:numel(myl)
    eigvals = eig(myl{i});
    eigvals_unique = unique(eigvals);
    fprintf('A%d eigval #: %d\n', i, numel(eigvals_unique));
end

%% Exercise 3.3
rng(20020309);
b = rand(10,1);
mysolutions = zeros(length(b),1);
myresiduals = cell(size(myl));
myvecxs = cell(size(myl));
for i = 1:numel(myl)
    guess = ones(length(b), 1);
    [mysolutions(:,i), myresiduals{i}, myvecxs{i}] = CG(myl{i}, b, guess, 50000, 1e-7);

    figure;
    sgtitle(sprintf("Conjugate Gradient of A%d", i));
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
    semilogy(1:iters, grad_norms, 'bo-');
    hold on; grid on;
    title('Gradient norms along iterations');
    xlabel('# iterations');
    ylabel('$||\nabla f||$','Interpreter','latex');
    
    subplot(2,2,4);
    %semilogy(1:iters, f_vals(:,3), 'bo-');
    mydiff = mysolutions(:,i) - myvecxs{i};
    semilogy(mydiff' * myl{i} * mydiff, 'bo-');
    hold on; grid on;
    title('Function values along iterations');
    xlabel('# iterations');
    ylabel('$f(x)$', 'Interpreter','latex');
    
    figure;
    plot(f_vals(:,1), f_vals(:,2), 'bo-');
    xlabel("$x_1$", "Interpreter", "latex"); 
    ylabel("$x_2$", "Interpreter", "latex");
    title("Convergence of Conjugate Gradient");
end

%figure;

