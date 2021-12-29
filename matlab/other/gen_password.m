function [password] = gen_password(numchars)
% numchars (integer): length of password to generate
% throwaway (integer): number of values to call from randi before getting password
% password (string): random password with length equal to numchars

% seed generator with current time
rng("shuffle")

% default character length
if nargin == 0, numchars = 15; end

% define <chars> that password can consist of
lett_un = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
lett_cap = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'};
symbols = {'!' '@' '#' '$' '%' '&' '*'};
numbers = {'0','1','2','3','4','5','6','7','8','9'};
chars = [lett_un lett_cap symbols numbers];

% generate passwords until a strong password is obtained
% a strong password is a password with one of each character type within <chars>
strong = false;
while ~strong
    % generate password
    password = '';
    generated = false;
    iter = 0;
    while ~generated
        val = randi([1,length(chars)]);
        if rand() > rand()
            iter = iter + 1;
            password(iter) = chars{val};
        end
        if length(password) == numchars, generated = true; end
    end
    % check to see whether password is strong
    lett_un_ind = false;
    lett_cap_ind = false;
    symbols_ind = false;
    numbers_ind = false;
    for i = 1:length(password)
        if max(strcmp(password(i),lett_un)) == 1, lett_un_ind = true; end
        if max(strcmp(password(i),lett_cap)) == 1, lett_cap_ind = true; end
        if max(strcmp(password(i),symbols)) == 1, symbols_ind = true; end
        if max(strcmp(password(i),numbers)) == 1, numbers_ind = true; end
    end
    strong = lett_un_ind && lett_cap_ind && symbols_ind && numbers_ind;
end

% randomize the order of the characters
pause(rand());
rng("shuffle")
order = zeros(size(password));
iter = 0;
randomized = false;
while ~randomized
    if rand() < rand()
        iter = iter + 1;
        order(iter) = randi([1,10*numchars]);
    end
    if iter == length(order), randomized = true; end 
end
[~,sortind] = sort(order);
password = password(sortind);

end