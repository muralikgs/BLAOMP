N = 500;
k = 20;
sigma = 0.005;
CE = zeros(500,8);
SRER = zeros(500,8);

for i = 1:8,
    M = i*k;
    clc;
    msg = ['Iteration: ', num2str(i)];
    disp(msg);
    A = normc(randn(M,N));
    index = randperm(N,k);
    
    for j = 1:500,
        disp(j)
        x = zeros(N,1);
        x(index) = sign(randn(k,1));
        %noise = sigma*randn(M,1);
        y = A*x;% + noise;

        x_hat = Alg1(y,A,k,3);
        CE(j,i) = cardError(x,x_hat,k);
        SRER(j,i) = norm(x)/norm(x-x_hat);
    end
end
disp('Over');
sre = mean(SRER);
ce_mean = mean(CE);