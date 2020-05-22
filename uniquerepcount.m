function [ c ] = uniquerepcount( a )
% a = [12 34 78 8 12 3 34 34];
% c = arrayfun(@(x)length(find(a == x)), unique(a), 'Uniform', false);
% c = cell2mat(c);
c = accumarray(a,1);
c = c(c>0);

end

