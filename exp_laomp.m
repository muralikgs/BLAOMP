clc;
disp('Start')
N = 500;
k = 20;
sigma = 0.005;
ce = [];
sre = [];
t = [];
for L = [20],
CE = zeros(500,21);
SRER = zeros(500,21);
time = zeros(500,21);

for i = 21:30,
    clc
    msg = ['Iteration: ', num2str(i)];
    disp(msg);
    M = (i/100)*N;
    A = normc(randn(M,N)/M);
    
    for j = 1:500,
        disp(j);
        x = zeros(N,1);
        noise = sigma*randn(M,1);
        index = randperm(N,k);
        x(index) = sign(randn(k,1));
        y = A*x + noise;
        tic;
        x_laomp = LAOMP(A,y,k,L);
        time(j,i) = toc;
        %x_omp = orthmatchingpursuit(y,A);
        CE(j,i-9) = cardError(x,x_laomp,k);
        %ce_omp = cardError(x,x_omp,k);
        SRER(j,i-9) = norm(x)/norm(x-x_laomp);
    end
end

disp('over');
sre = [sre;mean(SRER)];
ce = [ce;mean(CE)];
t = [t;mean(time)];
end