function [ gL ] = getgL( a,n,L )

gL = zeros(L+1,1);
gL(1) = 0;
for j = 1:L
    gL(j+1) = a(j+1)*factorial(j)/n^j+1;
end


end

