function [x_B, c_B, index_B] = simplexSolve(type, B, D, c_B, c_D, h, x_B, x_D, index_B, index_D, itMax)
% Solving a maximization problem with the simplex method

% Initialize the number of iterations
nIter = 0;
% itMax = 1000000000; % test for exercise 4

% Compute B^{-1}*D and B^{-1}*h
BiD = B\D;
Bih = B\h;

% TODO: Compute the reduced cost coefficients
r_D = c_D - c_B * BiD;

% the optimality condition is satisfied 
% if all reduced cost coefficients are positive or negative 
% (depending on the problem)
% hence the "tollerance" is optimality condition is satisfied
% check it by counting rcc elems satisfying it
tol = length(r_D);

% TODO: Check the optimality condition to short exit if optimal solution
if(strcmp(type,'max'))
    optCheck = sum(r_D <= 0);
elseif(strcmp(type,'min'))
    optCheck = sum(r_D >= 0);
else
    error('Incorrect type specified. Choose either a maximisation (max) or minimisation (min) problem.')
end

while(optCheck ~= tol)

    % TODO: Find the index of the entering variable
    % from slide 44
    if(strcmp(type,'max'))
        [~, idxIN] = max(r_D);
    elseif(strcmp(type,'min'))
        [~, idxIN] = min(r_D); 
    else
        error('Incorrect type specified. Choose either a maximisation (max) or minimisation (min) problem.')
    end

    in = D(:, idxIN);
    c_in = c_D(1, idxIN);
    index_in = index_D(1, idxIN);
    
    % TODO: Evaluate the coefficients ratio 
    % for the column corresponding to the entering variable
    % from slide 44
    ratio = Bih ./ BiD(:, idxIN);
    
    % TODO: Find the smallest positive ratio
    % filter only positive elems in ratio, then pick the min of it
    % and retrieve the index by finding it by elem
    % from slide 44
    idxOUT = find(ratio == min(ratio(ratio >= 0)));
    
    out = B(:, idxOUT);
    c_out = c_B(1, idxOUT);
    index_out = index_B(1, idxOUT);
    
    % TODO: Update the matrices by exchanging the columns
    B(:,idxOUT) = in; % basic matrix
    D(:,idxIN) = out; % non-basic matrix
    c_B(1,idxOUT) = c_in; % basic coeff of obj func
    c_D(1,idxIN) = c_out; % non-basic coeff of obj func
    index_B(1,idxOUT) = index_in;
    index_D(1,idxIN) = index_out;
     
    % Compute B^{-1}*D and B^{-1}*h
    BiD = B\D;
    Bih = B\h;
    
    % TODO: Compute the reduced cost coefficients
    % from slide 43
    r_D = c_D - c_B * BiD;

    % TODO: Check the optimality condition 
    if(strcmp(type,'max'))
        optCheck = sum(r_D <= 0);
    elseif(strcmp(type,'min'))
        optCheck = sum(r_D >= 0);
    else
        error('Incorrect type specified. Choose either a maximisation (max) or minimisation (min) problem.')
    end
    
    % Detect inefficient looping if nIter > total number of basic solutions
    nIter = nIter + 1;
    if(nIter>itMax)
       error('Incorrect loop, more iterations than the number of basic solutions');
    end

    % TODO: Compute the new x_B
    % from slide 50
    x_B = Bih - BiD * x_D;
end

end