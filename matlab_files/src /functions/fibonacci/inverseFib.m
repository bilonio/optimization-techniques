function [n] = inverseFib(fibn)
phi = (1 + sqrt(5)) / 2;

n = floor(log(fibn * sqrt(5) + 1/2) / log(phi));

end