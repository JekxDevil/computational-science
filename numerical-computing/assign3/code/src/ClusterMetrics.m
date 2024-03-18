function [Spec_nodes,Kmeans_nodes] = ClusterMetrics(K,x_spec,x_kmeans)
%% METRICS
% 2c) Calculate the number of nodes per cluster (for k-means and spectral
%     clustering) and plot them in a histogram.
numToCount = 1:K+1;
Spec_nodes = histcounts(x_spec, numToCount);
Kmeans_nodes = histcounts(x_kmeans, numToCount);

figure;
subplot(1,2,1);
bar(Spec_nodes);
title('Spectral - nodes per cluster');
xlabel("Clusters"); ylabel("number of nodes");
subplot(1,2,2);
bar(Kmeans_nodes);
title('K-means - nodes per cluster')
xlabel("Clusters"); ylabel("number of nodes");
end