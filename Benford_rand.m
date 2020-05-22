function [ x ] = Benford_rand( N, M )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% if nargin == 2
%     M = 1;
% end

ranks = 1:1:N;

pmf = (log(ranks+1)-log(ranks))/log(N+1);

samples = rand(1,M);

p = cumsum(pmf(:));

[~,x] = histc(samples,[0;p/p(end)]);


end

