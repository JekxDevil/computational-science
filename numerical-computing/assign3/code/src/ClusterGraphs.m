% Cluster 2D real-world graphs with spectral clustering and compare with k-means
% USI, ICS, Lugano
% Numerical Computing 
rng(20020309);
clear all;close all;
warning OFF;

addpath ../datasets
addpath ../datasets/Meshes

load airfoil1.mat
%load barth.mat
%load grid2.mat
%load 3elt.mat

% Specify the number of clusters
K = 4;
% Read graph
W   = Problem.A;
Pts = Problem.aux.coord;
n   = size(Pts,1);

% figure;
% spy(W)
% title('Adjacency matrix')

%% 2.1) Create the Laplacian matrix and plot the graphs using the 2nd and 3rd eigenvectors
L = CreateLapl(W);
% Eigen-decomposition
[eig_vecs, ~] = eigs(L, K, 1e-7); % ill conditioned, set threshold

% Plot and compare
% figure;
% subplot(1,2,1);
% gplot(W, Pts)
% xlabel('Nodal coordinates')
% subplot(1,2,2);
% gplot(W, eig_vecs(:,[2 3]))
% xlabel('Eigenvector coordinates')
% pause;

%% 2.2) Cluster each graph in K = 4 clusters with the spectral and the 
% k-means method, and compare your results visually for each case.
[D_kmeans, x_kmeans] = kmeans_mod(Pts, K, n);
[D_spec, x_spec] = kmeans_mod(eig_vecs, K, n);

% visualization of meaning of spectral clusters in eigenvector coordinates
%figure; gplotmap(W, eig_vecs(:, [2, 3]), x_spec);

figure;
subplot(1,2,1);
gplotmap(W, Pts, x_spec);
title('Spectral clusters');
subplot(1,2,2);
gplotmap(W, Pts, x_kmeans);
title('K-means clusters');

%% 2.3) Calculate the number of nodes per cluster
[Spec_nodes,Kmeans_nodes] = ClusterMetrics(K, x_spec, x_kmeans);
