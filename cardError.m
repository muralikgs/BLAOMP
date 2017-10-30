function ce = cardError(x,x_cap,k)

[~,sI_cap] = sort(abs(x_cap),'descend');
[~,sI] = sort(abs(x),'descend');
ce = 1 - length(intersect(sI_cap(1:k),(sI(1:k))))/k;
end