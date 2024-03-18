% DEGREE CENTRALITY
% from housegraph.mat compute degree centrality of top 5 authors

close all;
clear;
clc;

load("householder\housegraph.mat");
% A -> adjacency matrix, coauthor matrix, symmetric
% name -> name vector
% prcm -> Reverse Cuthill Mckee ordering permutation
% xy -> unknown

n = size(A,1);
auths_deg = sum(A)-ones(n,1); % calc deg and remove self reference
index_auths_deg = sortrows([1:n; auths_deg]', [2,1], {'descend', 'ascend'});
top5auths = full(index_auths_deg(1:5,:));

G = graph(A);

% retrieve coauthors
coauths = strings(5,1);
for i = 1:5
    auth_index = top5auths(i,1);
    auth_coauths = strings(top5auths(i,2),1);
    k = 1;
    for j = 1:n
        if A(j,auth_index) == 1 && j ~= auth_index
            coauth_name = name(j,:);
            auth_coauths(k) = strtrim(coauth_name);
            k = k + 1;
        end 
    end
    coauths(i) = strjoin(auth_coauths, ", ");
end

for i = 1:5
    fprintf("Author: %s | Degree: %d\t | Coauthors: %s\n", ...
        name(top5auths(i,1),:), degree(G, top5auths(i,1)), coauths(i));
end
