function [seed] = toss(argin)
if nargin == 0, argin = 0; end
tic
num = input("Seed: "); 
if isempty(num), num = rand()*1e4; end
time = toc*1e3;
num = num*rand();
seed = num+time+argin;
for i = 1:seed
    rand();
end

end