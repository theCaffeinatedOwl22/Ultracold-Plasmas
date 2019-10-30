%% Initiate Program
clc
clear
close all

%% Load directories for data set folder names, remove initial and final two time points for each set

T = readtable('E:\Research\Magnetic Trapping Data\Magnetic Bottling Data Summary.xlsx');    % load spreadsheet

T = T(logical(T.Phase == 3),:); % keep only rows with Phase = 3

T = sortrows(T,{'Phase','Te_0__K_','n0_1e14M_3_','Fields','t_us_'});    % sort table by data set

% Each 'With Fields' data set should be accompanied by a 'No Fields' data set. Based on how the table is sorted, separating
% which rows belong to which set is as simple as moving row-by-row and looking for changes in the 'Fields' variable.

ind = zeros(size(T.Phase)); % for each row, indicates which data set the 'With Fields' case corresponds to
ind2 = 0;   % counts the current data set
for ii = 1:length(T.Phase)-1
    if ~strcmp(T.Fields{ii},T.Fields{ii+1}) && strcmp(T.Fields{ii},'No')    % check for change in 'Fields' row-by-row
        ind2 = ind2+1;
    end
    
    if strcmp(T.Fields{ii+1},'Yes') % indicate which data set each row corresponds to 
        ind(ii+1) = ind2;
    end
end

folders = cell(1,max(ind));
for ii = 1:max(ind) % iterate over each detected data set
    folders{ii} = T.DataLocation(logical(ind == ii));   % pull out the ii'th data set
    folders{ii} = folders{ii}(2:end-2); % remove the first and last two points because not reliable Voigt fits
end

% Note that 'folders{ii}{jj}' is organized such that 'ii' index data set and 'jj' indexes time points within each datea set

%% Load magnetic field map for each data point

% Note that the LIF analysis code converts the Zeeman shifts to a magnetic field that is consistent with the derivation on
% 06/05/19. Please see that entry or the 'temperatureAndVexpAnalysis.m' function for more details. All we need to do now is
% load the magnetic field map for each data point, filter out the unphysical measurements (the 'bad' fits), and then obtain
% statistics on the remaining trustworthy measurements.

numFolders = 0; % determine the total number of data folders that will be analyzed
for ii = 1:length(folders)
    numFolders = numFolders+length(folders{ii});
end

xData = cell(1,numFolders); % pre-allocate space to matrices
yData = cell(1,numFolders);
bData = cell(1,numFolders);

ind = 0;    % counts how many folders have been analyzed
for ii = 1:length(folders)  % iterate over each data set
    for jj = 1:length(folders{ii})  % iterate over time points within each data set
        ind = ind+1;
        load([folders{ii}{jj} '\analysis_250um_constrainedVoigtModelWithPiAndSigmaPeaksNewSaveModel\outputStructure.mat'])   % load magnetic field data as function of x and y
        xData{ind} = outputStructure.voigtAnalysis.locX;
        yData{ind} = outputStructure.voigtAnalysis.locY;
        bData{ind} = outputStructure.voigtAnalysis.B;
    end
end

% The bMap data is loaded in vector form, but I would like it in matrix form. The next step is to convert that. However,
% first it's important to check that all the region locations are the same.

for ii = 1:length(xData)-1  % check that all x-locations are the same
    if min(xData{ii} == xData{ii+1})~=1
        error('Data sets are incompatible')
    end
end

for ii = 1:length(yData)-1  % check that all y-locations are the same
    if min(yData{ii} == yData{ii+1})~=1
        error('Data sets are incompatible')
    end
end

% I happen to know that this data set is symmetric in the x- and y-locations analyzed, so I exploit that here. The
% reformatting of the data into matrix form is case-specific, but the end goal is to have xData, yData, and bData in matrix
% form such that the elements of each matrix correspond to each other.

[xMesh,yMesh] = meshgrid(unique(xData{11}),unique(yData{11}));

bMesh = zeros(size(xMesh,1),size(xMesh,2),numFolders);
for ii = 1:length(bData)    % iterates over folders
    for jj = 1:length(bData{ii})    % iterates over positions within each folders data
        xPos = xData{ii}(jj);
        yPos = yData{ii}(jj);
        xDiff = abs(xMesh - xPos);
        yDiff = abs(yMesh - yPos);
        [~,xInd] = min(xDiff+yDiff,[],2);
        [~,yInd] = min(xDiff+yDiff,[],1);
        bMesh(yInd,xInd,ii) = bData{ii}(jj);
    end
end

%% Filter data for magnetic field data and obtain statistics

% Now I would like to omit extreme outliers in the data, specifically magnetic field measurements that are greater than 200 G
% because those measurements are completely unphysical.

for ii = 1:length(bMesh)    % iterate over each data point
    ind = logical(bMesh(:,:,ii) > 100); % find outlying values
    [row,col] = find(ind == 1);
    
    for jj = 1:length(row)  % iterate over outlying values for this data point
        bMesh(row(jj),col(jj),ii) = nan;
    end
end

% Now I'm going to obtain the statistics by averaging over the loaded data sets
bMeshAvg = mean(bMesh,3,'omitnan');
bMeshStd = std(bMesh,0,3,'omitnan');
bMeshSte = bMeshStd./sqrt(size(bMesh,3));

%% Plot results of magnetic field calculation
fig = figure;
fig.Position = [272   258   844   631];
subplot(2,2,1)
imagesc(xMesh(1,:),yMesh(:,1),bMeshAvg)
xlabel('X Position (mm)')
ylabel('Y Position (mm)')
title('Mean Magnetic Field')
ax = gca;
c = colorbar;
c.Label.String = 'B (G)';
ax.YDir = 'normal';
ax.CLim = [0 65];
subplot(2,2,2)
imagesc(xMesh(1,:),yMesh(:,1),bMeshSte)
xlabel('X Position (mm)')
ylabel('Y Position (mm)')
title('Standard Error of Magnetic Field')
ax = gca;
c = colorbar;
c.Label.String = 'B (G)';
ax.YDir = 'normal';
ax.CLim = [0 2];
subplot(2,2,3)
errorbar(xMesh(1,:),bMeshAvg(1,:),bMeshSte(1,:))
hold on
errorbar(xMesh(9,:),bMeshAvg(9,:),bMeshSte(9,:))
hold on
errorbar(xMesh(17,:),bMeshAvg(17,:),bMeshSte(17,:))
legend({['Y = ' num2str(round(yMesh(1,1),2)) ' mm'],['Y = ' num2str(round(yMesh(9,1),2)) ' mm'],['Y = ' num2str(round(yMesh(17,1),2)) ' mm']})
xlabel('X Position (mm)')
ylabel('B (G)')
title('Field along x-axis')
subplot(2,2,4)
errorbar(yMesh(:,1),bMeshAvg(:,1),bMeshSte(:,1))
hold on
errorbar(yMesh(:,5),bMeshAvg(:,5),bMeshSte(:,5))
errorbar(yMesh(:,9),bMeshAvg(:,9),bMeshSte(:,9))
errorbar(yMesh(:,13),bMeshAvg(:,13),bMeshSte(:,13))
errorbar(yMesh(:,17),bMeshAvg(:,17),bMeshSte(:,17))
legend({['X = ' num2str(round(xMesh(1,1),2)) ' mm'],['X = ' num2str(round(xMesh(1,5),2)) ' mm'],['X = ' num2str(round(xMesh(1,9),2)) ' mm'],['X = ' num2str(round(xMesh(1,13),2)) ' mm'],['X = ' num2str(round(xMesh(1,17),2)) ' mm']})
xlabel('Y Position (mm)')
ylabel('B (G)')
title('Field along y-axis')
