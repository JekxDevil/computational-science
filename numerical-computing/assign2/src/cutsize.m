function [ne,edges] = cutsize(A,map)
% CUTSIZE : Edges cut by a vertex partition.
%
% ne = cutsize(A,part)        : part is a list of vertices of A;
%                               ne is the number of edges crossing the cut.
% [ne,edges] = cutsize(A,part): Same, edges is the crossing edges as rows [i j].
%
% "part" may also be a map, with one entry per vertex.

% Take input in either order unless A is 1 by 1.
if size(map,1) == size(map,2) & size(map,1) > 1
    t = A;
    A = map;
    map = t;
end

% Convert input to a map in any case.
if length(map) ~= length(A) | max(map) == length(A)
    [~, map] = other(map,A);
end

[i,j] = find(A);
f = find(map(i) > map(j));
ne = length(f);
edges = [i(f) j(f)];
