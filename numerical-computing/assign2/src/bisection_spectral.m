function [part1,part2] = bisection_spectral(A,xy,picture)
% bisection_spectral: Spectral partition of a graph.
% A: sparse matrix
%
% [part1,part2] = bisection_spectral(A) returns a partition of the n vertices
%                 of A into two lists part1 and part2 according to the
%                 spectral bisection algorithm of Simon et al:  
%                 Label the vertices with the components of the Fiedler vector
%                 (the second eigenvector of the Laplacian matrix) and partition
%                 them around the median value or 0.
% 
% bisection_spectral(A,xy,1) also draws a picture.
% fprintf('\n Numerical Computing @ USI Lugano:');
% fprintf('\n Implement inertial bisection \n');

% Steps
% 1. Construct the Laplacian.
W = A; % no particular weight, corresponding to edge presence
D = diag(sum(A, 2)); % diag mat containing nodes degree
L = D - W;

% 2. Calculate its eigensdecomposition.
[eigenvecs_mat, ~] = eigs(L,2,'smallestabs');
fiedler_vec = eigenvecs_mat(:,2);

% 3. Label the vertices with the components of the Fiedler vector.
% threshold is 0
part1 = find(fiedler_vec > 0)%median(fiedler_vec));

% 4. Partition them around their median value, or 0.
part2 = find(fiedler_vec <= 0)%median(fiedler_vec));

if picture == 1
    gplotpart(A,xy,part1);
    title('Spectral bisection using the Fiedler Eigenvector');
end

end
