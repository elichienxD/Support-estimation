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

The algorithm for our method is implement as the function: \n
[ result ] = Supportestimation( N,k,c0,nC,option,option2 )

For experiment one can either run Experiments.m or directly use the function above. Set the distribution for Experiments.m in line 44-67. 
All the other parameter setting can be found in the beginning of the file.

% Input: \n
%        N : a histogram of your samples. Should be a 1-dim column vector. \n
%        k : the parameter such that the minimum non zero probability of
%        a alphabet for underlying distribution is lower bounded by 1/k. 
%        By default set it to be n = sum(N). \n
%        c0 : the parameter to determine the degree of the polynomial. By
%        default set it to be 0.558. \n
%        nC : number of grid points. \n
%        option is an parameter to decide which loss function would you
%        like to optimize. \n
%        Set \n
%        option = 0 for RWC estimator and \n
%        option = 1 for RWC-S estimator. \n
%        option2 = 0 for heuristic interval [n/k,pi/2*L+n/k] \n
%        option2 = 1 for provable interval [n/k,6.5L] \n
%
% Output:  \n
%        result is the estimated support. \n
\n
Remark: For RWC estimator, it can be run before the generation of samples, but not for RWC-S.
