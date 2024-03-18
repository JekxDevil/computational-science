% Benchmark for recursively partitioning meshes, based on various
% bisection approaches
%
% D.P & O.S for Numerical Computing at USI
addpaths_GP; % add necessary paths
nlevels_a = 3;
nlevels_b = 4;

fprintf('*********************************************\n')
fprintf('***  Recursive graph bisection benchmark  ***\n');
fprintf('*********************************************\n')

% load cases
cases = {
    'mesh1e1.mat', ...
    'bodyy4.mat', ...
    'de2010.mat', ...
    'biplane-9.mat', ...
    'L-9.mat', ...
    };

nc = length(cases);
maxlen = 0;
for c = 1:nc
    if length(cases{c}) > maxlen
        maxlen = length(cases{c});
    end
end

for c = 1:nc
    fprintf('.');
    sparse_matrices(c) = load(cases{c});
end

fprintf('\n\n Report Cases         Nodes     Edges\n');
fprintf(repmat('-', 1, 40));
fprintf('\n');
for c = 1:nc
    spacers  = repmat('.', 1, maxlen+3-length(cases{c}));
    [params] = Initialize_case(sparse_matrices(c));
    fprintf('%s %s %10d %10d\n', ...
        cases{c}, spacers, params.numberOfVertices, params.numberOfEdges);
end

%% Create results table
fprintf('\n%7s %16s %20s %16s %16s\n','Bisection','Spectral','Metis 5.0.2','Coordinate','Inertial');
fprintf('%10s %10d %6d %10d %6d %10d %6d %10d %6d\n','Partitions',8,16,8,16,8,16,8,16);
fprintf(repmat('-', 1, 100));
fprintf('\n');

for c = 1:nc
    spacers = repmat('.', 1, maxlen+3-length(cases{c}));
    fprintf('%s %s', cases{c}, spacers);
    sparse_matrix = load(cases{c});

    % Recursively bisect the loaded graphs in 8 and 16 subgraphs.
    % Steps
    % 1. Initialize the problem
    [params] = Initialize_case(sparse_matrices(c));
    W      = params.Adj;
    coords = params.coords;

    % 2. Recursive routines
    prefix_files = "../img/de2010-";
    % i. Spectral
    % f_spect_8 = figure();
    [spect_map_8, spect_sepij_8, spect_sepA_8] = rec_bisection('bisection_spectral', nlevels_a, W, coords, 0);
    % gplotmap(W, coords, spect_map_8);
    % f_spect_16 = figure();
    [spect_map_16, spect_sepij_16, spect_sepA_16] = rec_bisection('bisection_spectral', nlevels_b, W, coords, 0);
    % gplotmap(W, coords, spect_map_16);
    % pause;
    % exportgraphics(f_spect_8, prefix_files + "spect-8.eps", "BackgroundColor", "current", "ContentType", "vector");
    % exportgraphics(f_spect_16, prefix_files + "spect-16.eps", "BackgroundColor", "current", "ContentType", "vector");
    % close all;
    % ii. Metis
    % f_met_8 = figure();
    [met_map_8, met_sepij_8, met_sepA_8] = rec_bisection('bisection_metis', nlevels_a, W, coords, 0);
    % gplotmap(W, coords, met_map_8);
    % f_met_16 = figure();
    [met_map_16, met_sepij_16, met_sepA_16] = rec_bisection('bisection_metis', nlevels_b, W, coords, 0);
    % gplotmap(W, coords, met_map_16);
    % pause;
    % exportgraphics(f_met_8, prefix_files + "met-8.eps", "BackgroundColor", "current", "ContentType", "vector");
    % exportgraphics(f_met_16, prefix_files + "met-16.eps", "BackgroundColor", "current", "ContentType", "vector");
    % close all;
    % iii. Coordinate
    % f_coord_8 = figure();
    [coord_map_8, coord_sepij_8, coord_sepA_8] = rec_bisection('bisection_coordinate', nlevels_a, W, coords, 0);
    % gplotmap(W, coords, coord_map_8);
    % f_coord_16 = figure();
    [coord_map_16, coord_sepij_16, coord_sepA_16] = rec_bisection('bisection_coordinate', nlevels_b, W, coords, 0);
    % gplotmap(W, coords, coord_map_16);
    % pause;
    % exportgraphics(f_coord_8, prefix_files + "coord-8.eps", "BackgroundColor", "current", "ContentType", "vector");
    % exportgraphics(f_coord_16, prefix_files + "coord-16.eps", "BackgroundColor", "current", "ContentType", "vector");
    % close all;
    % iv. Inertial
    % f_inert_8 = figure();
    [inert_map_8, inert_sepij_8, inert_sepA_8] = rec_bisection('bisection_inertial', 3, W, coords, 0);
    % gplotmap(W, coords, inert_map_8);
    % f_inert_16 = figure();
    [inert_map_16, inert_sepij_16, inert_sepA_16] = rec_bisection('bisection_inertial', nlevels_b, W, coords, 0);
    % gplotmap(W, coords, inert_map_16);
    % pause;
    % exportgraphics(f_inert_8, prefix_files + "inert-8.eps", "BackgroundColor", "current", "ContentType", "vector");
    % exportgraphics(f_inert_16, prefix_files + "inert-16.eps", "BackgroundColor", "current", "ContentType", "vector");
    % close all;

    % 3. Calculate number of cut edges
    spect_cutedges_8 = cutsize(W, spect_map_8);
    spect_cutedges_16 = cutsize(W, spect_map_16);
    met_cutedges_8 = cutsize(W, met_map_8);
    met_cutedges_16 = cutsize(W, met_map_16);
    coord_cutedges_8 = cutsize(W, coord_map_8);
    coord_cutedges_16 = cutsize(W, coord_map_16);
    inert_cutedges_8 = cutsize(W, inert_map_8);
    inert_cutedges_16 = cutsize(W, inert_map_16);

    % 4. Visualize the partitioning result
    fprintf("%6d %6d %10d %6d %10d %6d %10d %6d\n", ...
        spect_cutedges_8, spect_cutedges_16, ...
        met_cutedges_8, met_cutedges_16, ...
        coord_cutedges_8, coord_cutedges_16, ...
        inert_cutedges_8, inert_cutedges_16);
end
