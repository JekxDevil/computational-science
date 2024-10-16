function [part1,part2] = bisection_inertial(A,xy,picture)
% bisection_inertial: Inertial partition of a graph.
%
% [part1,part2] = bisection_inertial(A,xy,picture) returns a list of the 
%     vertices on one side of a partition obtained by bisection 
%     with a line or plane normal to a moment of inertia
%     of the vertices, considered as points in Euclidean space.
%     Input A is the adjacency matrix of the mesh (used only for the picture!);
%     each row of xy is the coordinates of a point in d-space.
%
% bisection_inertial(A,xy,1) also draws a picture.
% fprintf('\n Numerical Computing @ USI Lugano:');
% fprintf('\n Implement inertial bisection \n');

% Steps
% 1. Calculate the center of mass.
% In 2 dimensions (2D) such a line is chosen such that the sum of squares 
% of the distance of the nodes to the line is minimized
P = mean(xy);

% 2. Construct the matrix M.
%  (Consult the pdf of the assignment for the creation of M)
S_xx = sum( (xy(:,1) - P(1)).^2 );
S_yy = sum( (xy(:,2) - P(2)).^2 );
S_xy = sum( (xy(:,1) - P(1)) .* (xy(:,2) - P(2)) );
M = [S_xx, S_xy; S_xy, S_yy];

% 3. Calculate the smallest eigenvector of M.
[eigenvec_smallest, ~] = eigs(M, 1, 'smallestabs');

% 4. Find the line L on which the center of mass lies.
% l = {P + alpha * u}
u = eigenvec_smallest / norm(eigenvec_smallest);

% 5. Partition the points around the line L.
%   (you may use the function partition.m)
R = [0 1; -1 0]; % 90 clockwise
[part1, part2] = partition(xy, R*u);

if picture == 1
    gplotpart(A,xy,part1);
    title('Inertial bisection using the smallest Eigenvector');
end

end
