function [y,grady] = quadobj(x)
y = x(end);
if nargout > 1
    T = length(x);
    grady = [zeros(T-1,1);1];
end