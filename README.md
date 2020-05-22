# Support-estimation
Support estimation via regularized weighted Chebyshev approximation. 
Link to our work:https://www.ideals.illinois.edu/bitstream/handle/2142/106187/CHIEN-THESIS-2019.pdf?sequence=1

If you find our software useful in your work, please also cite our paper:
@article{chien2019regularized,
  title={Regularized Weighted Chebyshev Approximations for Support Estimation},
  author={Chien, I and Milenkovic, Olgica},
  journal={arXiv preprint arXiv:1901.07506},
  year={2019}
}

The algorithm for our method is implement as the function:
[ result ] = Supportestimation( N,k,c0,nC,option,option2 )

For experiment one can either run Experiments.m or directly use the function above. Set the distribution for Experiments.m in line 44-67. 
All the other parameter setting can be found in the beginning of the file.

% Input: 
%        N : a histogram of your samples. Should be a 1-dim column vector.
%        k : the parameter such that the minimum non zero probability of
%        a alphabet for underlying distribution is lower bounded by 1/k. 
%        By default set it to be n = sum(N).
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

Remark: For RWC estimator, it can be run before the generation of samples, but not for RWC-S.
