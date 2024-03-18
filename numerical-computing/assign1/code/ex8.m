close all;
clear;
clc;

load("householder\housegraph.mat");
pairs = [["Golub", "Moler"]; ["Golub", "Saunders"]; ["TChan", "Demmel"]];

for t = 1:length(pairs)
    a1 = evalin('base', pairs(t,1));
    a2 = evalin('base', pairs(t,2));
    c1 = A(:,a1);
    c2 = A(:,a2);
    
    cc = strings(c1'*c2 - c1(a2) - c2(a1), 1); % common coauthors
    k = 1;
    for i = 1:length(A)
        % check intersection of columns does not include authors
        if c1(i) == 1 && c2(i) == 1 && i ~= a1 && i ~= a2
            cc(k) = strtrim(name(i,:));
            k = k + 1;
        end
    end
    
    fprintf("(%s, %s): %s\n", pairs(t,1), pairs(t,2), strjoin(cc, ", "));
end
