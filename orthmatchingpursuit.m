function x_cap = orthmatchingpursuit(y,A,k)
N = size(A,2);
ind = [];
i = 1:N;
B = [];
R = y;
n = 0;
while n < k,
    n = n + 1;
    [~,indx] = max(abs(A(:,i)'*R));
    vec = A(:,i(indx));
    B = [B, vec];
    P = B*pinv(B'*B)*B';
    ind = [ind;i(indx)];
    i(indx) = [];
    a_n = pinv(B'*B)*B'*y;
    R = (eye(size(P,1)) - P)*R;
end
x_cap = zeros(N,1);
x_cap(ind) = a_n;
end

