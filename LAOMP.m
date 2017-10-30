function x_cap = LAOMP(A, y, k, L)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[~,N] = size(A);
x_cap = zeros(N,1);
ind = [];
n = 0;
i = 1:N;
B = [];
res = y;

while n < k,
    n = n + 1;
    norm_L = [];
    [~,indx] = sort(abs(A(:,i)' * res), 'descend');
    ind_L = indx(1:L);
    for j = 1:length(ind_L),
        rr = lookAheadRes(A,B,y,k,i,ind,ind_L(j));
        norm_L = [norm_L, norm(rr)];
    end
    [~,l] = min(norm_L);
    ind = [ind, i(ind_L(l))];
    B = [B, A(:,i(ind_L(l)))];
    i(l) = [];
    x_cap(ind) = pinv(B'*B)*B'*y;
    res = y - B*x_cap(ind);
end
