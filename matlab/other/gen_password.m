function [password] = gen_password(numchars,throwaway)
% numchars (integer): length of password to generate
% throwaway (integer): number of values to call from randi before getting password
% password (string): random password with length equal to numchars

rng("shuffle")

if nargin > 1
    randi([1,length(chars)],1,throwaway);
end

if nargin == 0
    numchars = 12;
end

lett_un = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
lett_cap = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'};
symbols = {'!' '@' '#' '$' '%' '&' '*'};

chars = [lett_un lett_cap symbols];

ind = randi([1,length(chars)],1,numchars);

password = '';
for i = 1:length(ind)
    password(i) = chars{ind(i)};
end

end