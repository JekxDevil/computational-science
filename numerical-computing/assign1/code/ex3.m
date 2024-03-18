close all;
clear;
clc;

U = ["alpha", "beta", "gamma", "delta", "rho", "sigma"];
n = size(U,2);
inlinks = [[1,4]; [2,1]; [3,1]; [3,2]; [4,2]; [4,3]; [5,6]; [6,5]];     
G = sparse(inlinks(:, 1), inlinks(:, 2), ones(1, size(inlinks, 1)));
p = .9999999999; %.85;

r0 = pagerank1(U,G,p);
c = sum(G,1);
r = sum(G,2);
pr_print(U, r0, r, c);
bar(r0);
xlabel("Page number")
ylabel("PageRank value")
