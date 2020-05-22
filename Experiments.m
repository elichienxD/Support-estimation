% Copyright  2020 Eli Chien <ichien3@illinois.edu>
% Distributed under terms of the MIT license.
% If you find our software useful in your work, please also cite our paper:
% @article{chien2019regularized,
%   title={Regularized Weighted Chebyshev Approximations for Support Estimation},
%   author={Chien, I and Milenkovic, Olgica},
%   journal={arXiv preprint arXiv:1901.07506},
%   year={2019}
% }

clc;
clear;


K = 10^6; % k, where 1/k is the lower bound of minimum non-zero probability
Repeat = 100; % Number of independent trials
N_max = 10^6; % maximum number of samples
c0_opt = 0.558;
c1 = 0.5;
L_opt = floor(c0_opt*log(K));
D = 10; % n = N_max/D to N_max, grid points


Result_plugin = zeros(D,Repeat);
Result_wu_copt = zeros(D,Repeat);
Result_GT = zeros(D,Repeat);
% Result_PJW = zeros(D,Repeat);
% Result_HOSW = zeros(D,Repeat);
Result_RWC = zeros(D,Repeat);


for i = 1:D
    
    n = N_max/D*i;
    % Wu's estimator
        s = c1*log(K)/n;
        t = 1/K;
        % get Chebyshev coefficients 
        a_wuopt = zeros(L_opt+1,1);
        a_wuopt(1) = -1;
        syms x
        T(x) = chebyshevT(L_opt,x);
        P(x) = -T((2*x-t-s)/(s-t))/T((-t-s)/(s-t));
        for j = 1:L_opt
            dP = diff(P,j);
            a_wuopt(j+1) = dP(0)/factorial(j);
        end

    parfor r = 1:Repeat

        % Sampling, select distribution accordingly. Support Size Kt are
        % chosen that the minimum probability is roughly 10^(-6)

        % Uniform([1,K])
%         sample = randi(K,[n,1]); 
%         Kt = K;

        % Zipf alpha=1.5
        [sample,~] = zipf_rand(K*0.005, 1.5, n); 
        Kt = K*0.005;

        % Zipf alpha=1
%         [sample,~] = zipf_rand(K*0.08, 1, n); 
%         Kt = K*0.08;
        
        % Zipf alpha=0.5
%         [sample,~] = zipf_rand(K*0.1*5, 0.5, n); 
%         Kt = K*0.1*5;

        % Zipf alpha=0.25
%         [sample,~] = zipf_rand(K*0.1*7, 0.25, n); 
%         Kt = K*0.1*7;

%         Benford
%         sample = Benford_rand(K*0.08, n)';
%         Kt = K*0.08;

        % N_vec is the histogram
        N_vec = uniquerepcount(sample(1:n));
        Input_opt = N_vec(N_vec<L_opt+1);
        Input_copt = N_vec(N_vec>L_opt);
        
        % RWC/RWC-S estimator
        nC = 1000; % number of grid points. For n =< 10^6 nC = 1000 is sufficient.
%        Result_RWC(i,r) = Supportestimation( N_vec,K,c0_opt,nC,0,1 ); % RWC
        Result_RWC(i,r) = Supportestimation( N_vec,K,c0_opt,nC,1,1 ); % RWC-S
        
        % plugin estimator
        C = unique(sample(1:n));
        Result_plugin(i,r) = size(C,1);
        
        % WY estimator
        [ gL_wuopt ] = getgL( a_wuopt,n,L_opt );
        S_wuopt = sum(gL_wuopt(Input_opt+1))+length(Input_copt);
        Result_wu_copt(i,r) = S_wuopt;

        % Good-Turing
        h_1 = sum(N_vec(:) == 1);
        Result_GT(i,r) = size(C,1)/(1-h_1/n);
        
%         % PJW estimator
%         Result_PJW(i,r) = estimate_support_from_histogram_PML_approximate(N_vec, 1/K);
        
%         % HOSW estimator
%         Result_HOSW(i,r) = HOSW_estimator( N_vec,n,K );
    end
end

Kt = K*0.005;
x = 1:D;
x = x/D*10^6;
figure
semilogy(x,mean(abs((Result_RWC-ones(D,1)*Kt)/K).^2,2),'LineWidth',2)
hold
semilogy(x,mean(abs((Result_GT-ones(D,1)*Kt)/K).^2,2),'LineWidth',2)
semilogy(x,mean(abs((Result_wu_copt-ones(D,1)*Kt)/K).^2,2),'LineWidth',2)
% semilogy(x,mean(abs((Result_PJW-ones(D,1)*Kt)/K).^2,2),'LineWidth',2)
% semilogy(x,mean(abs((Result_HOSW-ones(D,1)*Kt)/K).^2,2),'LineWidth',2)

legend('RWC','GT','WY')%,'PJW','HOSW')
xlabel('n')
ylabel('MSE normalized by k^2')
% title('Zipf(0.25)')
set(gca,'FontSize', 14)