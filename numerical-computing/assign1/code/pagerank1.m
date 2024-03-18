function x = pagerank1(U,G,p)
% PAGERANK  Google's PageRank - POWER METHOD
% pagerank(U,G,p) uses the URLs and adjacency matrix produced by SURFER,
% together with a damping factor p, (default is .85), to compute and plot
% a bar graph of page rank, and print the dominant URLs in page rank order.
% x = pagerank(U,G,p) returns the page ranks instead of printing.
% See also SURFER, SPY.

if nargin < 3, p = .85; end

% Eliminate any self-referential links
%G = G - diag(diag(G));

% c = out-degree, r = in-degree
[~,n] = size(G);
c = sum(G,1);
r = sum(G,2);

% Scale column sums to be 1 (or 0 where there are no out links).
k = find(c ~= 0);
D = sparse(k, k, 1./c(k), n, n);
e = ones(n,1);
I = speye(n,n);

fprintf('Using power method\n');
iterations = 0;
% -------------------------------- POWER METHOD ---------------------------
G = p*G*D;  % matrix with dampling factor and scaled column sums
z = ((1-p)*(c~=0) + (c==0))/n;  % probability of nodes: linkage + random
x = e/n; % unbiased init rank vector
prev_x = zeros(1, n);   % caching prev iteration rank vector
epsilon = 1e-7;         % prec  ision of results
while norm(x-prev_x, 1) >= epsilon
    prev_x = x;
    x = G*x + e*(z*x);
    x = x/norm(x);      % prevent magnitudinal error growth
    iterations = iterations + 1;
end
% -------------------------------------------------------------------------
% Normalize so that sum(x) == 1.
x = x/sum(x);
fprintf("Iterations: %d\n", iterations);
end
