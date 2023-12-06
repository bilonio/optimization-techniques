function [res] = fibSearchMemo(lambda,epsilon, a, b, f)

n = inverseFib((b-a)/lambda) + 1;
x1 = a + (fibMemo(n-2)/fibMemo(n))*(b-a);
x2 = a + (fibMemo(n-1)/fibMemo(n))*(b-a);
as = a;
bs = b;
k = 1;

%Step 1
while (k ~= n - 2)
    %Step 2
    if (f(x1) - f(x2) > 0)         
        as = [as, x1];
        bs = [bs, bs(end)];
        x1 = x2;
        x2 = as(end) + (fibMemo(n-k-1) / fibMemo(n-k)) * (bs(end) - as(end));
    else 
    %Step 3
        as = [as, as(end)];
        bs = [bs, x2];
        x2 = x1;
        x1 = as(end) + (fibMemo(n-k-2) / fibMemo(n-k)) * (bs(end) - as(end));
    end
    %Step 4
    k = k + 1;
end
    
x2 = x1 + epsilon;
if (f(x1) - f(x2) > 0)
    as = [as, x1];
    bs  = [bs, bs(end)];
else
    as = [as, as(end)];
    bs = [bs, x1];
end

%return struct
res.k = k;
res.as = as;
res.bs = bs;

end

