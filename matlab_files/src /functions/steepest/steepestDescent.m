function [res] = steepestDescent(epsilon,x0,f, option)

arguments
    %typecast input args
    epsilon (1,1) double
    x0 (1,2) double
    f sym
    %enum for options
    option {mustBeMember(option,["optimal", "constant", "armijo"])} = "optimal" %default is optimal
end

% set maximum iterations to break if exceeded
maxIterations = 1000;


xk = [x0(1), x0(2)];
f1 = inline(f); % Returns an inline function of f, similar to an anonymous function
fx = @(x) f1(x(:,1), x(:,2)); % Returns a 1x2 array that can evaluate the function for 1x2 xk

jac = inline(jacobian(f));
jacx = @(x) jac(x(:,1), x(:,2));

k = 1;



xs = xk;
gammas = [];

% case switch doesn't work with strigs
% check 3 different options
if  option == 'optimal' %case 1
    tic
    while (norm(jacx(xk)) > epsilon)
            dk = - jacx(xk);
            [gamma] = optimalGamma(xk, dk, f);
            xk = double(xk + gamma * dk);
            xs = [xs; xk];
            gammas = [gammas; gamma];
            k = k + 1;
            if k > maxIterations
                disp('Maximum iterations reached');
                break;
            end
    end
elseif option == 'constant' %case 2
    tic
    gamma = 0.5;
    while (norm(jacx(xk)) > epsilon)
            dk = - (jacx(xk));
            xk = double(xk + gamma * dk);
            xs = [xs; xk];
            gammas = [gammas; gamma];
            k = k + 1;

            if k > maxIterations
                disp('Maximum iterations reached');
                break;
            end
    end
else %case 3
    tic
     while (norm(jacx(xk)) > epsilon)
            dk = - (jacx(xk));
            [gamma] = armijo(10,0.01, 0.2, xk, dk, f);
            xk = double(xk + gamma * dk);
            xs = [xs; xk];
            gammas = [gammas; gamma];
            k = k+1;

            if k > maxIterations
                disp('Maximum iterations reached');
                break;
            end
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
res.method = option;

end  


