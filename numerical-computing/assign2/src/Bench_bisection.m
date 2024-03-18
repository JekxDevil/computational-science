function Bench_bisection()
% Compare various graph bisection algorithms
%
% D.P & O.S for Numerical Computing at USI
addpaths_GP; % add the necessary paths
warning('off','all');
picture = 1;

format compact;

disp('*********************************************')
disp('***      Graph bisection benchmark        ***');
disp('*********************************************')
fprintf('\n The file "Toy_meshes.mat" contains sample meshes with coordinates. \n');

% load meshes
load Toy_meshes; % [1->12,]
whos;

for nmesh = 8:8
    close all; clf reset;
    
    switch nmesh
        case 1
        fprintf('\n Function "grid5rec" produces a rectangular grid:');
        fprintf('\n [A,xy] = grid5rec(12, 100); \n');
        [W,coords] = grid5rec(12, 100);
        case 2
        fprintf('\n Function "grid5rec" produces a rectangular grid:');
        fprintf('\n [A,xy] = grid5rec(100, 12); \n');
        [W,coords] = grid5rec(100, 12);
        case 3
        disp('\n Function "grid5recRotate" produces a rotated rectangular grid:');
        disp('\n [A,xy] = grid5recRotate(100, 12, -45); \n');
        [W,coords] = grid5recRotate(100, 12, -45);
        case 4
        fprintf('\n Function "gridt" produces a triangular grid:');
        fprintf('\n (See also grid5, grid7, grid9, grid3d, grid3dt.)');
        fprintf('\n [A,xy] = gridt(50); \n');
        [W,coords] = gridt(50);
        case 5
        fprintf('\n Function "gridt" produces a triangular grid:');
        fprintf('\n (See also grid5, grid7, grid9, grid3d, grid3dt.)');
        fprintf('\n [A,xy] = grid9(40); \n');
        [W,coords] = grid9(40);
        case 6
        W       = Smallmesh;
        coords = Smallmesh_coords;
        case 7
         W       = Tapir;
        coords  = Tapir_coords;
        case 8
        W       = Eppstein;
        coords  = Eppstein_coords;
    end 
    
    fprintf('\n*********************************************\n')
    disp('***        Various Bisection Methods      ***');
    fprintf('*********************************************\n\n')
    
    switch nmesh
        case 1
        disp('A rectangular  grid5rec(12, 100) mesh');
        case 2
        disp('A rectangular  grid5rec(100,12) mesh');
        case 3
        disp('A rectangular  grid5rec(100,12) mesh, rotated by 45 degree');
        case 4
        disp('A triangular gridt(50) mesh');
        case 5
        disp('A square gridt9(40) mesh');
        case 6
        disp('The Smallmesh');
        case 7
        disp('The Tapir mesh');
        case 8
        disp('The Eppstein mesh');
    end
    

    fprintf('Plot the graph using gplotg(W,coords); \n');
    figure(1)
    gplotg(W,coords);
    nvtx  = size(W,1);
    nedge = (nnz(W)-nvtx)/2;
    xlabel([int2str(nvtx) ' vertices, ' int2str(nedge) ' edges'],'visible','on');
    % disp('Hit space to continue ...');
    % pause;

    disp('1. Coordinate bisection of a mesh.  ');
    f_coord = figure(2);
    [p1,p2] = bisection_coordinate(W,coords,picture);
    [cut_coord] = cutsize(W,p1);
    % disp('Space to continue ...');
    % pause;

    f_met = figure(3);
    fprintf('2. A multilevel method from the "Metis 5.0.2" package.');
    fprintf('This will only work if you have Metis and its Matlab interface. \n');
    [p1,p2] = bisection_metis(W,coords,picture);
    [cut_metis] = cutsize(W,p1);
    % fprintf('\n Hit space to continue ...');
    % pause;

    fprintf('3. Spectral partitioning, which uses the second eigenvector of');
    fprintf('the Laplacian matrix of the graph, also known as the "Fiedler vector". \n');
    f_spect = figure(4);
    [p1,p2] = bisection_spectral(W,coords,picture);
    [cut_spectral] = cutsize(W,p1);
    % fprintf('\n Hit space to continue ...');
    % pause;
    
    f_inert = figure(5);
    fprintf('4. Inertial partitioning, which uses the coordinates to find');
    fprintf('a separating line in the plane.\n');
    [p1,p2] = bisection_inertial(W,coords,picture);
    [cut_inertial] = cutsize(W,p1);
    fprintf('Hit space to continue ...');
    pause;
    
    close all;
    format;

    if picture == 0
        lambda_coord = @() bisection_coordinate(W, coords, picture);
        lambda_metis = @() bisection_metis(W, coords, picture);
        lambda_spectral = @() bisection_spectral(W, coords, picture);
        lambda_inertial = @() bisection_inertial(W, coords, picture);
        fprintf("*** TIMINGS **************************************");
        timeit(lambda_coord)
        timeit(lambda_metis)
        timeit(lambda_spectral)
        timeit(lambda_inertial)
        fprintf("**************************************************");
    end
    
    fprintf('\n*****************************************************************\n')
    disp('***                    Bisection Benchmark                    ***');
    disp('***        D.P. & O.S. for Numerical Computing, USI Lugano    ***');
    fprintf('*****************************************************************\n\n')
end
