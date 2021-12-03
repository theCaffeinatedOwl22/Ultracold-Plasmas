function [s] = getlinespecs(m)
%%
% m is the number of lines to be plotted on the same graph

s.col = plasmaModified(m); % each row of s.col contains RGB triplet
s.style = cell(m,1);        % line style for each line color (row of s.col)

ind = 0;
for ii = 1:m
    ind = ind+1;
    styleInd = {'-'};

    if (m == 4 || m == 5)
        styleInd = {'-','--'};
        s.style{ii} = styleInd{ind};
    elseif (m >= 6)
        styleInd = {'-','--','-.'};
        s.style{ii} = styleInd{ind};
    else
        s.style{ii} = styleInd{ind};
    end

    if ind >= length(styleInd)
        ind = 0;
    end
end

end
