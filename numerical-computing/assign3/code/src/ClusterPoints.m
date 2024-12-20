% Cluster 2D pointclouds with spectral clustering and compare with k-means
% USI, ICS, Lugano
% Numerical Computing 
rng(20020309);  % setting the seed for replicability
clear all;close all;
warning OFF;

addpath ../datasets
addpath ../datasets/Meshes
% Specify the number of clusters
% K = 2; 
K = 4;

%% 1.1) Get coordinate list from pointclouds
% halfkernel(), twospirals(), clusterincluster(), crescentfullmoon() -> K=2
% corners(), outlier() -> K=4
Pts = corners();
n = size(Pts,1);

tiledlayout(3,3);
nexttile([3 2])
scatter(Pts(:,1),Pts(:,2));
title('Half kernel from coordinate list');

% "A Tutorial on Spectral Clustering - Ulrike von Luxburg" rule of thumb
% epsilon from spanning tree, then sigma~=epsilon, logn
% Create Gaussian similarity function for full graph
[S] = similarityfunc(Pts(:, 1:2));
% uncomment for crecentfullmooon() and outlier()
% sigma = exp(K);
% [S] = similarityfunc(Pts(:,1:2), sigma);

%% 1.2) Find the minimal spanning tree of the full graph. 
% Use the information to determine a valid value for epsilon
mst = minSpanTree(S);
% ϵ s.t. resulting graph is safely connected, i.e length of the longest
% edge in a minimal spanning tree of fully connected graph on data points.
epsilon = max(mst, [], "all");

%% 1.3) Create the epsilon similarity graph
% epsilon neighbordhood graph
[G] = epsilonSimGraph(epsilon, Pts);

%% 1.4) Create the adjacency matrix for the epsilon case
% S matrix = full similarity matrix constructed using the Gaussian similarity function. 
% G matrix represents an ϵ connectivity graph. 
% .* operator performs element-wise multiplication.
% W sparse matrix = only contains elems in places where G contains elems.
W = S .* G;

% nexttile;
% gplotg(W, Pts(:,1:2));
% title('Visualize adjacency matrix');

%% 1.5) Create the Laplacian matrix and implement spectral clustering
[L, ~] = CreateLapl(W);
% Cluster rows of eigenvector matrix of L corresponding to K smallest
% eigenvalues. Use kmeans for that.
[U, ~] = eigs(L, K, 1e-11);
[~, x_spec] = kmeans_mod(U, K, n);

%% 1.6) Run K-means on input data
[D_centroids_kmeans, x_kmeans] = kmeans_mod(Pts, K, n);

%% 1.7) Visualize spectral and k-means clustering results
tiledlayout(1,2);nexttile;% nexttile;
gplotmap(W, Pts, x_spec)
title('Spectral clusters')

nexttile;
gplotmap(W, Pts, x_kmeans)
title('K-means clusters')
