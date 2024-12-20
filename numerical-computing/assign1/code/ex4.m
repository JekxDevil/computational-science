close all;
clear;
clc;


U = ["alpha", "beta", "gamma", "delta", "rho", "sigma"];
n = size(U,2);
inlinks = [[1,4]; [1,6]; [2,1]; [3,2]; [4,2]; [4,3]; [5,3]; [6,3]; [6,1]];
G = sparse(inlinks(:, 1), inlinks(:, 2), ones(1, size(inlinks, 1)));
p = .85;

% --- 4.2 ----------------------------------------------------------------
r0 = pagerank(U,G);
r1 = pagerank1(U,G);
r2 = pagerank2(U,G);

% measuring time for each method
f0 = @() pagerank(U,G);
f1 = @() pagerank1(U,G);
f2 = @() pagerank2(U,G);
timeit(f0)
timeit(f1)
timeit(f2)

% --- 4.3 ----------------------------------------------------------------
load("ETH500.mat");

%ethx = pagerank2(U,G, 0.85, 0.8);
%ethx = pagerank2(U,G, 0.85, 0.9);
%ethx = pagerank2(U,G, 0.85, 0.95); % 14 iterations
ethx = pagerank2(U,G, 0.85, 1);
bar(ethx);
title("Pagerank alpha = 1");
xlabel("webpages index");
ylabel("Pagerank value");


% --- 4.4 ----------------------------------------------------------------
load("web1.mat");
web1_G = G;
web1_U = U;
load("web2.mat");
web2_G = G;
web2_U = U;
load("web3.mat");
web3_G = G;
web3_U = U;


web1r1 = pagerank1(web1_U,web1_G);
web1r2 = pagerank2(web1_U,web1_G);
web2r1 = pagerank1(web2_U,web2_G);
web2r2 = pagerank2(web2_U,web2_G);
web3r1 = pagerank1(web3_U,web3_G);
web3r2 = pagerank2(web3_U,web3_G);

tiledlayout(3,2);
nexttile;
bar(web1r1);
title("Web1 - Power Method");
xlabel("webpages index");
ylabel("Pagerank value");
nexttile;
bar(web1r2);
title("Web1 - Inverse Iteration");
xlabel("webpages index");
ylabel("Pagerank value");
nexttile;
bar(web2r1);
title("Web2 - Power Method");
xlabel("webpages index");
ylabel("Pagerank value");
nexttile;
bar(web2r2);
title("Web2 - Inverse Iteration");
xlabel("webpages index");
ylabel("Pagerank value");
nexttile;
bar(web3r1);
title("Web3 - Power Method");
xlabel("webpages index");
ylabel("Pagerank value");
nexttile;
bar(web3r2);
title("Web3 - Inverse Iteration");
xlabel("webpages index");
ylabel("Pagerank value");


f_web1r1 = @() pagerank1(web1_U,web1_G);
f_web1r2 = @() pagerank2(web1_U,web1_G);
f_web2r1 = @() pagerank1(web2_U,web2_G);
f_web2r2 = @() pagerank2(web2_U,web2_G);
f_web3r1 = @() pagerank1(web3_U,web3_G);
f_web3r2 = @() pagerank2(web3_U,web3_G);
timeit(f_web1r1)
timeit(f_web1r2)
timeit(f_web2r1)
timeit(f_web2r2)
timeit(f_web3r1)
timeit(f_web3r2)
