function [x_cap,suppx] = CoSaMP(y,A,k,index)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
[~,N] = size(A);
ind = [];
res = y;
n = 0;
threshold = 0.001;
normR = [norm(res), norm(res)];
flag = 0;
X_cap = [];
RES = [];
IND = [];
while normR(:,end) <= normR(:,end-1) && n < k && norm(res) > threshold,
    n = n + 1;
    a = zeros(N,1);
    [~,indx] = sort(abs(A' * res), 'descend');
    omega = indx(1:2*k);
    ind = union(ind, omega);
    B = A(:,ind);
    a(ind) = pinv(B'*B)*B'*y;
    x_cap = zeros(N,1);
    [~,i] = sort(abs(a),'descend');
    x_cap(i(1:k)) = a(i(1:k));
    IND = [IND, i(1:k)];
    disp(length(intersect(index, IND(:,end))));
    X_cap = [X_cap, x_cap];
    res = y - A*x_cap;
    RES = [RES, res];
    normR = [normR, norm(res)];
    if normR(:,end) > normR(:,end-1),
        flag = 1
    end
end
suppx = IND(:,end);
if flag == 1,
    x_cap = X_cap(:,end-1);
    suppx = IND(:,end-1);
end
end
