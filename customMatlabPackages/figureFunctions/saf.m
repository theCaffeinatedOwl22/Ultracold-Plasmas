function [] = saf(figName)
% This function saves the figure with figure handle 'fig' to the current folder with name 'figName' both 
% as a PNG and as a FIG file. 'figName' should be a string.

% saveas(gcf,[figName '.fig']);
saveas(gcf,[figName '.png']);


end