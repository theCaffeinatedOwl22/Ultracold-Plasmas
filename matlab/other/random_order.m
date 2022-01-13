function [argout] = random_order(argin)
threshold = rand();
order = zeros(size(argin));
iter = 0;
randomized = false;
while ~randomized
    if rand() < threshold
        iter = iter + 1;
        order(iter) = randi([1,10*length(argin)]);
    end
    if iter == length(order), randomized = true; end 
end
[~,sortind] = sort(order);
argout = argin(sortind);
end