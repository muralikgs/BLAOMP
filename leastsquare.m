% Least Squares Reconstruction for Non Sparse Vectors
x1 = randn(60,1);
A = randn(30,60);
y1 = A*x1;
x1_cap = pinv(A'*A)*A'*y1;
e = sqrt((x1 - x1_cap)'*(x1 - x1_cap)/length(x1));
disp(e);
figure, plot(x1, 'o-');
hold on
plot(x1_cap, 'o--');
title('Least Square Reconstruction for Non Sparse Vectors');
legend('Original Vector', 'Reconstructed Vector');
hold off

% Least Square reconstruction for Sparse Vectors
N = 60;
k = 15;
x2 = zeros(N,1);
x2(randperm(N,k)) = randn(k,1);
y2 = A*x2;
x2_cap = pinv(A'*A)*A'*y2;
e = sqrt((x2 - x2_cap)'*(x2 - x2_cap)/length(x2));
disp(e);
figure, stem(x2);
hold on
stem(x2_cap);
title('Least Square Reconstruction for Sparse Vectors');
legend('Original Vector', 'Reconstructed Vector');
hold off
