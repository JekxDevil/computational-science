close all;
clear;
clc;

% Bar graph of page rank.
load('householder\housegraph.mat');
x = pagerank(A, .85);
[x_sort, p] = sort(x, 'descend');

% plot graph
shg;
barh(x_sort, 0.4, 'red');
title('housegraph matrix');
ylabel("Position");
xlabel("Page Rank");
set(gca, 'XAxisLocation', 'top', ...
    'YAxisLocation', 'left', ...
    'ydir', 'reverse');

% add text labels for each author
for i = 1:length(x)
    text(x_sort(i)*1.05, i, name(p(i),:), ...
        'VerticalAlignment', 'middle', ...
        'FontSize',6, ...
        'FontWeight','bold');
end

function x = pagerank(G,p)
    % PAGERANK  Google's PageRank - POWER METHOD
    if nargin < 3, p = .85; end
    
    [~,n] = size(G);
    c = sum(G,1); % c = out-degree
    r = sum(G,2); % r = in-degree
    
    % Scale column sums to be 1 (or 0 where there are no out links).
    k = find(c~=0);
    D = sparse(k,k,1./c(k),n,n);
    e = ones(n,1);
    I = speye(n,n);
    G = p*G*D;  % matrix with dampling factor and scaled column sums
    z = ((1-p)*(c~=0) + (c==0))/n;  % probability of nodes: linkage + random
    x = e/n; % unbiased init rank vector
    prev_x = zeros(1, n);   % caching prev iteration rank vector
    epsilon = 1e-5;         % precision of results
    while norm(x-prev_x, 1) >= epsilon
        prev_x = x;
        x = G*x + e*(z*x);
        x = x/norm(x);      % prevent magnitudinal error growth
    end
    
    x = x/sum(x); % Normalize so that sum(x) == 1.
end
