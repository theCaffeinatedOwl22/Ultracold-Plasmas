function [out] = readtext(directory,opt,dlm,com)
% directory (string): full path to text file
% opt (string): 'double' or 'string'
% dlm (cell): dlm{i} is a string with the delimiter that values within a row are separated by
% com (string): comment delimiter, after which all text is ignored
% contents (column vector cell): contents{i} contains a row vector cell with the parsed values for each line

% Note: more than one value delimiter may be provided, but only one comment delimiter is allowed.

% default values
if nargin < 2, opt = 'string'; end
if nargin < 3, dlm = {','}; end
if nargin < 4, com = '%'; end

% preallocate space for file contents
rowiter = 1; % iter counts the number of lines that have been recorded in contents
largest_row = 1; % keeps track of how many columns we care about
numalloc = 1000; % number of lines to preallocate to cell array at a time
contents{numalloc,numalloc} = []; % prellocate space to cell array

% read in values from file line-by-line
fid = fopen(directory,'r'); % open stream to file
while ~feof(fid) % while end of file not yet reached
    % read in line from file
    line = fgetl(fid); 
    
    % only keep contents before comment delimiter if it is found within line
    k = strfind(line,com);
    if ~isempty(k)
        if k(1) == 1
            line = '';
        else
            line = line(1:k(1)-1);
        end
    end
    
    % record contents within line
    if ~isempty(line)
        vals = strsplit(line,dlm); % parse contents within line using given delimiters
        if length(vals) > largest_row, largest_row = length(vals); end
        
        % preallocate extra columns to contents as necessary to use contiguous blocks of memory
        numcols = size(contents,2);
        if length(vals) > numcols
            largest_row = length(vals);
            contents{1,numcols+numalloc} = [];
        end
        
        % put values within contents
        for i = 1:length(vals)
            contents{rowiter,i} = vals{i};
        end
        
        % increase line count
        rowiter = rowiter + 1;
    end
    
    % preallocate extra rows to contents as necessary to use contiguous blocks of memory
    if rowiter == length(contents), contents{rowiter+numalloc} = []; end 
end

% remove excess space preallocated to contents
contents = contents(1:rowiter-1,1:largest_row);
if strcmp(opt,'double')
    contents_mat = zeros(size(contents));
    for i = 1:size(contents,1)
        for j = 1:size(contents,2)
            contents_mat(i,j) = str2double(contents{i,j});
        end
    end
    out = contents_mat;
else
    out = contents;
end

end