function [res] = DescentProjection(epsilon,x0,f,gamma,sk,a,b)
arguments
    %typecast input args
    epsilon (1,1) double
    x0 (1,2) double
    f sym
    gamma double;
    sk double;
    a (1,2) double;
    b (1,2) double;
end
% set maximum iterations to break if exceeded
maxIterations = 500;


xk = [x0(1), x0(2)];
f1 = inline(f); % Returns an inline function of f, similar to an anonymous function
fx = @(x) f1(x(:,1), x(:,2)); % Returns a 1x2 array that can evaluate the function for 1x2 xk

jac = inline(jacobian(f));
jacx = @(x) jac(x(:,1), x(:,2));

k = 1;



xs = xk;
gammas = [];



tic;
while (norm(jacx(xk)) > epsilon)
            dk = - jacx(xk);
            v = xk + sk * dk;

            xk_bar = projVector(a,b,v);

            xk = double(xk + gamma * (xk_bar-xk));
            xs = [xs; xk];
            gammas = [gammas; gamma];
            
            k = k + 1;

            if k > maxIterations
                disp('Maximum iterations reached');
                break;
            end
            
end

% truncate xs and gammas
xs = xs(1:k, :);
gammas = gammas(1:k-1);

res.k = k;
res.gammas = gammas;
res.xs = xs;
res.xmin = fminsearch(fx, x0);
res.dist = norm(res.xmin - xk);
res.time = toc;

end