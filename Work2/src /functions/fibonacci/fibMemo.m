function [fibn] = fibMemo(n)
fs = [1,1]; %0-th Fibonacci is one

for i = 1:n-2
    fs = [fs, fs(end) + fs(end-1)];
end

fibn = fs(end);
end