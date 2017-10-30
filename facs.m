% Fusion of Algorithms for Compressed Sensing
clc;
k = 20;
N = 500;
sigma = 0.005;
CE = zeros(500,8);
SRER = zeros(500,8);
for i = [1 3 4 5 6 7 8],
    M = i*k;
    clc
    msg = ['Iteration: ', num2str(i)];
    disp(msg);
    
    A = normc(randn(M,N)/M);
    for j = 1:500,
        disp(j);
        x = zeros(N,1);
        index = randperm(N,k);
        x(index) = randn(k,1);
        %noise = sigma*randn(M,1);
        y = A*x;% + noise;
        
        [x_sp,ind_sp] = subspursuit(A,y,k);
        [x_cosamp,ind_cosamp] = CoSaMP(y,A,k,0.001);
        
        gamma = union(ind_sp,ind_cosamp);
        B = A(:,gamma);
        vec = zeros(N,1);
        vec(gamma) = pinv(B'*B)*B'*y;
        [~,indx] = sort(abs(vec),'descend');
        x_cap = zeros(N,1);
        B = A(:,indx(1:k));
        x_cap(indx(1:k)) = pinv(B'*B)*B'*y;
        CE(j,i) = cardError(x,x_cap,k);
        SRER(j,i) = norm(x)/norm(x-x_cap);
    end
end
clc;
disp('Over');
sre = mean(SRER);