% Compare recursive bisection and direct k-way partitioning,
% as implemented in the Metis 5.0.2 library.
%
% D.P & O.S for Numerical Computing at USI
addpaths_GP; % Add necessary paths

% Graphs in question
data_heli = load("helicopter.mat");
data_skirt = load("skirt.mat");

% Steps
% 1. Initialize the cases
case_heli = Initialize_case(data_heli);
case_skirt = Initialize_case(data_skirt);

% 2. Call metismex to
% a) Recursively partition the graphs in 16 and 32 subsets.
[heli_rec_map_16, heli_rec_edgecut_16] = metismex('PartGraphRecursive', case_heli.Adj, 16);
[skirt_rec_map_16, skirt_rec_edgecut_16] = metismex('PartGraphRecursive', case_skirt.Adj, 16);
[heli_rec_map_32, heli_rec_edgecut_32] = metismex('PartGraphRecursive', case_heli.Adj, 32);
[skirt_rec_map_32, skirt_rec_edgecut_32] = metismex('PartGraphRecursive', case_skirt.Adj, 32);
% b) Perform direct k-way partitioning of the graphs in 16 and 32 subsets.
[heli_dir_map_16, heli_dir_edgecut_16] = metismex('PartGraphKway', case_heli.Adj, 16);
[skirt_dir_map_16, skirt_dir_edgecut_16] = metismex('PartGraphKway', case_skirt.Adj, 16);
[heli_dir_map_32, heli_dir_edgecut_32] = metismex('PartGraphKway', case_heli.Adj, 32);
[skirt_dir_map_32, skirt_dir_edgecut_32] = metismex('PartGraphKway', case_skirt.Adj, 32);

% 3. Visualize the results for 32 partitions
% generate result table for report
fprintf("Partitions \t Helicopter \t Skirt \n");
fprintf("16 rec bisect \t %d \t\t %d \n", heli_rec_edgecut_16, skirt_rec_edgecut_16); 
fprintf("16 dir part \t %d \t\t %d \n", heli_dir_edgecut_16, skirt_dir_edgecut_16);
fprintf("32 rec bisect \t %d \t\t %d \n", heli_rec_edgecut_32, skirt_rec_edgecut_32); 
fprintf("32 dir part \t %d \t\t %d \n", heli_dir_edgecut_32, skirt_dir_edgecut_32);

% save plot images
dir_img = "../img/";
if ~exist(dir_img, "dir")
    mkdir(dir_img);
end

% confront helicopters, adjust and continue save graphs
f_h_r = figure("Name", "Ex3 - Helicopter, recursive");
gplotmap(case_heli.Adj, case_heli.coords, heli_rec_map_32);
title("Helicopter recursive bisection");
rotate3d;
f_h_k = figure("Name", "Ex3 - Helicopter, kway partition");
gplotmap(case_heli.Adj, case_heli.coords, heli_dir_map_32);
title("Helicopter graph K-way partition");
rotate3d;
pause;
exportgraphics(f_h_r, dir_img+"heli-rec-32.eps", "BackgroundColor", "current", "ContentType", "vector");
exportgraphics(f_h_r, dir_img+"heli-kway-32.eps", "BackgroundColor", "current", "ContentType", "vector");
close all;

% confront skirts, adjust and continue to save graphs
f_s_r = figure("Name", "Ex3 - Skirt, recursive");
gplotmap(case_skirt.Adj, case_skirt.coords, skirt_rec_map_32);
title("Skirt recursive bisection");
rotate3d;
f_s_k = figure("Name", "Ex3 - Skirt, kway partition");
gplotmap(case_skirt.Adj, case_skirt.coords, skirt_dir_map_32);
title("Skirt graph K-way partition");
rotate3d;
pause;
exportgraphics(f_s_r, dir_img+"skirt-rec-32.eps", "BackgroundColor", "current", "ContentType", "vector");
exportgraphics(f_s_k, dir_img+"skirt-kway-32.eps", "BackgroundColor", "current", "ContentType", "vector");
close all;
