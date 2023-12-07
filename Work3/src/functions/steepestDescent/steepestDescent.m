function [res] = steepestDescent(epsilon,x0,f,option)
arguments
    %typecast input args
    epsilon (1,1) double
    x0 (1,2) double
    f sym
    %enum for options
    option {mustBeMember(option,[0.1,0.3,3,5])} = "3" %default is 3
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


% check 4 different options for gamma
switch option
    case 0.1 %case 1
    tic
    gamma = 0.1;
    while (norm(jacx(xk)) > epsilon)
            dk = - jacx(xk);
            xk = double(xk + gamma * dk);
            xs = [xs; xk];
            gammas = [gammas; gamma];
            k = k + 1;
            if k > maxIterations
                disp('Maximum iterations reached');
                break;
            end
    end
    case 0.3 %case 2
    tic
    gamma = 0.3;
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
    case 3
    tic
    gamma=3;
     while (norm(jacx(xk)) > epsilon)
            dk = - (jacx(xk));
            xk = double(xk + gamma * dk);
            xs = [xs; xk];
            gammas = [gammas; gamma];
            k = k+1;

            if k > maxIterations
                disp('Maximum iterations reached');
                break;
            end
     end

case 5
    tic
    gamma=5;
    while (norm(jacx(xk)) > epsilon)
            dk = - (jacx(xk));
            xk = double(xk + gamma * dk);
            xs = [xs; xk];
            gammas = [gammas; gamma];
            k = k+1;

            if k > maxIterations
                disp('Maximum iterations reached');
                break;
            end
    end
    otherwise
        warning('Unexpected option');

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