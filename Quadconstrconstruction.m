function [ H,k,d ] = Quadconstrconstruction( K,lambda,L )
    
    H = zeros(L+1,L+1);
    k = zeros(L+1,1);
    
    for i = 1:L-1
        for j = i+1:L
            H(i,j) = exp(-2*lambda)*lambda^(i+j);
        end
    end
    H = H+H'; 
    

        for i = 1:L
            H(i,i) = 1/K*exp(-lambda)*lambda^i*factorial(i)+exp(-2*lambda)*lambda^(2*i);
            k(i) = -2*exp(-2*lambda)*lambda^i;
        end
        k(L+1) = -1;
        d = exp(-lambda)/K+exp(-2*lambda);
        H = 2*H;

end

