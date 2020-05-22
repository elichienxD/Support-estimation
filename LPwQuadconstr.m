function [ a,t ] = LPwQuadconstr( n,K,c0,nC,S_hat,option )
L = floor(c0*log(K));
if option == 0
    interval = [n/K,n/K+pi/2*L];
else
    interval = [n/K,6.5*L];
end

% nC = 10;% number of constraints
Lambda = linspace(interval(1),interval(2),nC);

H = cell(nC,1);
k = cell(nC,1);
d = cell(nC,1);

for i = 1:nC
   [ H{i},k{i},d{i} ] = Quadconstrconstruction( S_hat,Lambda(i),L );
end

options = optimoptions(@fmincon,'Algorithm','interior-point',...
    'SpecifyObjectiveGradient',true,'SpecifyConstraintGradient',true,...
    'HessianFcn',@(x,lambda)quadhess(x,lambda,zeros(L+1,L+1),H),'TolCon',10^(-12)*exp(-2*n/K),'TolFun',10^(-12)*exp(-2*n/K));

% Variables  x = [a1,a2,...aL,t]
% lb = [-100*ones(L,1);0];
% ub = [100*ones(L,1);100];
fun = @(x)quadobj(x);
nonlconstr = @(x)quadconstr(x,H,k,d);
x0 = zeros(L+1,1); % column vector
[x,~,~,~,~] = fmincon(fun,x0,...
    [],[],[],[],[],[],nonlconstr,options);
a = x(1:end-1);
t = x(end);

end

