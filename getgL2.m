function [ gL ] = getgL2( a,L )

gL = zeros(L+1,1);
gL(1) = 0;
for j = 1:L
    gL(j+1) = a(j+1)*factorial(j)+1;
end


end


