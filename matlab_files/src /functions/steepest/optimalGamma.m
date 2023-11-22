function [gamma] = optimalGamma(xk,dk, f)

syms x1 x2;

f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));

syms g

f2 = fx(xk + ( g * dk));
fg = inline(f2, 'g');
[fib] = fibSearchMemo(1e-8, 1e-9, -2, 10, fg); %can be changed to (0,10), only needed for newton to work
gamma = (fib.as(end) + fib.bs(end)) / 2;

end