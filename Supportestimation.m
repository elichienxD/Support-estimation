% Copyright  2020 Eli Chien <ichien3@illinois.edu>
% Distributed under terms of the MIT license.
% If you find our software useful in your work, please also cite our paper:
% @article{chien2019regularized,
%   title={Regularized Weighted Chebyshev Approximations for Support Estimation},
%   author={Chien, I and Milenkovic, Olgica},
%   journal={arXiv preprint arXiv:1901.07506},
%   year={2019}
% }

function [ result ] = Supportestimation( N,k,c0,nC,option,option2 )
% Input: 
%        N : a histogram of your samples. Should be a 1-dim column vector.
%        k : the parameter such that the minimum non zero probability of
%        a alphabet for underlying distribution is lower bounded by 1/k. By
%        default set it to be sum(N).
%        c0 : the parameter to determine the degree of the polynomial. By
%        default set it to be 0.558.
%        nC : number of grid points
%        option is an parameter to decide which loss function would you
%        like to optimize. 
%        Set 
%        option = 0 for RWC estimator and
%        option = 1 for RWC-S estimator.
%        option2 = 0 for heuristic interval [n/k,pi/2*L+n/k]
%        option2 = 1 for provable interval [n/k,6.5L]
%
% Output: 
%        result is the estimated support.

n = sum(N);
S_naive = size(N,1);
L = floor(c0*log(k));

if option == 0
    [ a_LPquad,~ ] = LPwQuadconstr( n,k,c0,nC,k,option2 );
    a_LPquad = [-1;a_LPquad];
elseif option == 1
    [ a_LPquad,~ ] = LPwQuadconstr( n,k,c0,nC,S_naive,option2 );
    a_LPquad = [-1;a_LPquad];
else 
    disp('invalid option value. Please read the comments for this function')
    result = -1;
    return;
end

Input = N(N<L+1);
Input_c = N(N>L);

[ gL_LPquad ] = getgL2( a_LPquad,L );
result = sum(gL_LPquad(Input+1))+length(Input_c);
end

