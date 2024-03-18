clear all;
close all;
clc;

type = 'max';
A = [4, 3; 4, 1; 4, 2;];
h = [12; 8; 8];
c = [3, 4];
sign = [-1, -1, -1];

[z, x_B, index_B] = simplex(type, A, h, c, sign);
