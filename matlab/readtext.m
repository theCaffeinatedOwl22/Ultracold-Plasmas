function [contents] = readtext(directory,dlm,com)
% directory (string): full path to text file
% dlm (cell): dlm{i} is a string with the delimiter that values within a row are separated by
% com (string): comment delimiter, after which all text is ignored
% contents (column vector cell): contents{i} contains a row vector cell with the parsed values for each line

% Note: more than one value delimiter may be provided, but only one comment delimiter is allowed.

% default delimiters
if nargin < 2, dlm = {','}; end
if nargin < 3, com = '%'; end

% preallocate space for file contents
iter = 1; % iter counts the number of lines that have been recorded in contents
numlines = 1000; % number of lines to preallocate to cell array at a time
contents{numlines,1} = []; % prellocate space to cell array

% read in values from file line-by-line
fid = fopen(directory,'r'); % open stream to file
while ~feof(fid) % while end of file not yet reached
    line = fgetl(fid); % read in line from file
    
    line = extractBefore(line,com); % only keep text before comment delimiters
    if ~isempty(line) % only record if line is not empty after considering comment delimiter
        contents{iter} = strsplit(line,dlm); % parse contents within line using given delimiters
        iter = iter + 1; % increase line count
    end
    
    % preallocate extra space to contents as necessary to use contiguous blocks of memory
    if iter == length(contents), contents{iter+numlines} = []; end 
end

% remove excess space preallocated to contents
contents = contents(1:iter-1,1);

end