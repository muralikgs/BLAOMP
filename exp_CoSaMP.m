clc;
disp('Start')
N = 500;
k = 20;
sigma = 0.005;
CE = zeros(500,8);
SRER = zeros(500,8);

for i = [6 7 8],
    clc
    msg = ['Iteration: ', num2str(i)];
    disp(msg);
    M = i*k;
    A = normc(randn(M,N));
    for j = 1:500,
        disp(j);
        x = zeros(N,1);
        index = randperm(N,k);
        x(index) = randn(k,1);
        %noise = sigma*randn(M,1);
        y = A*x; % + noise;

        [x_cap,res] = CoSaMP(y,A,k,0.01);
        CE(j,i) = cardError(x,x_cap,k);
        SRER(j,i) = norm(x)/norm(x-x_cap);
    end
end
disp('Over');
sre = mean(SRER);
