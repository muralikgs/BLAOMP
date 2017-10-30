function x_cap = BLAOMP(A, y, k, L)

[~,N] = size(A);
x_cap = zeros(N,1);
ind = [];
n = 0;
i = (1:N)';
B = [];
res = y;
%index_set = [];
%iter = 0;
while n < k,
    %iter = iter + 1;
    norm_L = [];
    index_set = [];
    setd = setdiff(i,ind);
    [~,indx] = sort(abs(A(:,setd)' * res), 'descend');
    ind_L = indx(1:L);
    %disp(setd(ind_L))
    for j = 1:length(ind_L),
        [rr,index] = modlookAheadRes(A,B,y,k,setd,ind,ind_L(j));
        index_set = [index_set, index];
        norm_L = [norm_L, norm(rr)];
    end
    [~,l] = min(norm_L);
    %disp(l);
    indx = intersect(setd(ind_L), index_set(:,l));
    %disp(index_set(:,l));
    ind = [ind; indx];
    B = [B, A(:,indx)];
    x_cap(ind) = pinv(B'*B)*B'*y;
    res = y - B*x_cap(ind);
    n = length(ind);
end
