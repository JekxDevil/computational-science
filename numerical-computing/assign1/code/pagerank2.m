function x = pagerank2(U,G,p,alpha)
% PAGERANK  Google's PageRank - INVERSE ITERATION METHOD
% pagerank(U,G,p) uses the URLs and adjacency matrix produced by SURFER,
% together with a damping factory p, (default is .85), to compute and plot
% a bar graph of page rank, and print the dominant URLs in page rank order.
% x = pagerank(U,G,p) returns the page ranks instead of printing.
% See also SURFER, SPY.

if nargin < 3, p = .85; end
if nargin < 4, alpha = .99; end

% Eliminate any self-referential links
%G = G - diag(diag(G));

% c = out-degree, r = in-degree
[~,n] = size(G);
c = sum(G,1);
r = sum(G,2);

% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c ~= 0);
D = sparse(k,k,1./c(k),n,n);

e = ones(n,1);
I = speye(n,n);

fprintf('Inverse iteration\n');
iterations = 0;
% ------------------------ INVERSE ITERATION ------------------------------
z = ((1-p)*(c~=0) + (c==0))/n;  % probability of nodes: linkage + random
A = p*G*D + e*z;        % matrix with dampling factor and scaled column sums
x = e/n;                % unbiased init rank vector
prev_x = zeros(1, n);   % caching prev iteration rank vector
epsilon = 1e-5;         % precision of results
B = A - alpha * I;

if rcond(B) < 1e-16
    disp("rcond smaller, perturbating alpha");
    alpha = alpha - 1e-5;
    B = A - alpha * I;
    fprintf("new rcond = %f\n", rcond(B));
end

% inverse iterations
while norm(x-prev_x, 1) >= epsilon && iterations < 100
    prev_x = x;
    x = B \ x;
    x = x/norm(x);      % prevent magnitudinal error growth
    iterations = iterations + 1;
end
% -------------------------------------------------------------------------
% Normalize so that sum(x) == 1.
x = x/sum(x);
fprintf("Iterations: %d\n", iterations);
end
