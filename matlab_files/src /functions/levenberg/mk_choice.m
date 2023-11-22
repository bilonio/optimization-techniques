function [mk] = mk_choice(f,xk)
hes = inline(hessian(f));
hesx = @(x) hes(x(:,1), x(:,2));
mk=0;
e=eig(hesx(xk));
egv=abs(max(e));
mk=egv+0.25;

end