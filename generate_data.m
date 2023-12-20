clc;
clear;
close all;

A = imread('Lena.png');
A = reshape(A, size(A,1)*size(A,2),1);
A = dec2bin(A,8);
dlmwrite('test_input.txt', A, '');