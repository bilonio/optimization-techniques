function [gamma] = armijo(s, alpha, beta,xk, dk,f)

f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));

jac = inline(jacobian(f));
jacx = @(x) jac(x(:,1), x(:,2));

mk =0;
gamma = s * (beta^mk);

%jacT = transpose(jacx(xk));
D = dk' * jacx(xk);

while fx(xk) - fx(xk + gamma * dk) < - alpha * s * (beta^mk) * D
    mk = mk + 1;
    gamma = s * (beta^mk);
end

end