function [password] = gen_password(numchars,throwaway)
% numchars (integer): length of password to generate
% throwaway (integer): number of values to call from randi before getting password
% password (string): random password with length equal to numchars

% seed generator with current time
rng("shuffle")

% default character length
if nargin == 0, numchars = 15; end

% throw away user specified amount of numbers from sequence
if nargin < 2
    throwaway = input("Throwaway: "); 
    throwaway = throwaway*rand();
end
for i = 1:length(throwaway)
    rand();
end
threshold = rand();

% define <chars> that password can consist of and randomize them
lett_un = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
lett_cap = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'};
symbols = {'!' '@' '#' '$' '%' '&' '*'};
numbers = {'0','1','2','3','4','5','6','7','8','9'};
chars = [lett_un lett_cap symbols numbers];
chars = random_order(chars);

% define a larger character pool
ind = randi(length(chars),[1,100*length(chars)]);
char_pool = chars(ind);
char_pool = random_order(char_pool);

% generate passwords until a strong password is obtained
% a strong password is a password with one of each character type within <chars>
pause(rand());
rng("shuffle")
for i = 1:length(throwaway)
    rand();
end
strong = false;
while ~strong
    % generate password
    password = '';
    generated = false;
    iter = 0;
    while ~generated
        val = randi(length(char_pool));
        if rand() < threshold
            iter = iter + 1;
            password(iter) = char_pool{val};
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

% randomize order of characters but make sure it starts with a letter
startswithletter = false;
while ~startswithletter
    password = random_order(password);
    if max(strcmp([lett_un lett_cap],password(1))) == 1, startswithletter = true; end
end

end