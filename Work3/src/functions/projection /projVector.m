function [projection] = projVector(a,b,x)
projection=[0 0];

for i=1:length(x)
    if(x(i)<=a(i))
        projection(i)=a(i);
    
    elseif(x(i)>=b(i))
        projection(i)=b(i);

    elseif(a(i)<x(i) && x(i)<b(i))
        projection(i)=x(i);

    end        
end

end