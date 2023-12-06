function [gamma] = gammaLevenberg(a,b,xk,dk,f)
syms x1 x2;

f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));

grad=inline(gradient(f));
gradx=@(x) grad(x(:,1),x(:,2));

gamma=1;

while(true)
tdk=transpose(dk);
D=tdk*gradx(xk);
Dk=tdk*gradx(xk+gamma*tdk);
if(Dk>b*D && fx(xk+gamma*tdk)-fx(xk)<=a*gamma*tdk*gradx(xk))
    break;
end
gamma=gamma-0.1;

end


end