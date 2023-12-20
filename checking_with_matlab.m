clc;
clear;
close all;

vhdl_outputs = importdata('test_output.txt');
A = imread('Lena.png');
A = reshape(A, size(A,1)*size(A,2),1);
edges = zeros(32,1);
for i = 1:32
    edges(i) = 8*i;
end
edges(32)=257;
correct_output = zeros(32,1);
for i = 1:65536
    for j = 1:32
        if (A(i)<edges(j))
            correct_output(j) = correct_output(j)+1;
            break;
        end
    end
end

sum(correct_output~= vhdl_outputs)

histogram(A)
%x = 4:8:252;
%bar(x, vhdl_outputs)