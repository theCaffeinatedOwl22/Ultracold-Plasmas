function [location] = strfindfirst(lookin,lookfor)
% lookin (string): string to be searched through
% lookfor (string): string to be searched for
% location (double): 
%   - if lookfor found: returns first index of lookfor(1)
%   - if lookfor not found: empty

% Notes:
%   - This is a case-sensitive search function.

location = [];
imax = length(lookin) - length(lookfor) + 1;
for i = 1:imax
    if strcmp(lookin(i),lookfor(1))
        if strcmp(lookin(i:i+length(lookfor)-1),lookfor)
            location = i;
            break
        end
    end
end

end