% domain N x N
% each cell is either dead or alive
% initial state given at time t = 0
N = input("Type N for the N x N game domain: ");
M = randi([0, 1], N, N); % zeros(N); to init all cell to zeros

max_t = 10;
for i = 1:size(M, 1)
    for j = 1:size(M, 2)
        disp(M(i,j))
    end
end