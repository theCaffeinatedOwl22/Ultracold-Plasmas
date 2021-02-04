%% Script Notes

%% Initiate Program
clc, clearvars -except inp, close all, f = filesep;
set(0,'defaultfigurecolor',[1 1 1])

addpath('/home/grant/git-hub/plasma-lif-analysis/')
[gitdir] = getmainpath();

folders = {'sub-programs','DIH','spectrum-model','422-profile','quadrupole-field-model','export-fig','andor-camera-baseline'};
for i = 1:length(folders)
    addpath(genpath([gitdir f folders{i}]))
end

c = defineConstants();

ind = 1;
if ind ~= 1
    %% CLEAR DIRECTORIES
    inp = {};
    openvar('inp')
end
fields = {'date','phase','pol','n','sigx','sigy','Te','mag','t','tau','xc','yc','xL','xR','yL','yR','tE','pwrToInt','spinpolL','spinpolR','gamL','comment','dir'};
s = cell2struct(inp,fields,2);

andir = '';
maindir = '';
figdir = '';
mkdir([maindir f figdir])

for i = 1:length(s)
    s(i).andir = [s(i).dir f andir];
end

%% Read in data
for i = 1:length(s)
    s(i).andir = [s(i).dir f andir];
    load([s(i).andir f 'os.mat'])

    x = [os.local.x];
    for j = 1:length(x)
        if x(j) ~= 0
            ind = j;
            break
        end
    end

    for j = 1:length(x)
        if j < ind
            os.local(j).tr = 1;
        else
            os.local(j).tr = 2;
        end
    end

    s(i).os = os;

end

% sort data points by exposure time
for i = 1:length(s)
    tE(i) = str2double(extractBefore(extractAfter(s(i).andir,'expose'),'n'));
end
[~,sortind] = sort(tE);
s = s(sortind);

%% Plot Density Transects

t = unique([s.t]);

for i = 1:length(t)
    fig = figure;
    fig.Position = [498   281   867   420];

    ax = subplot(1,2,1);
    hold on
    s2 = s([s.t] == t(i));
    [~,sortind] = sort([s2.tE]);
    s2 = s2(sortind);
    for j = 1:length(s2)
        ind = [s2(j).os.local.tr] == 2;
        s3 = s2(j).os.local(ind);
        xdata = [s3.x];
        ydata = [s3.nFit];
        plot(xdata,ydata,'LineWidth',1.5)
    end
    xlabel('x (mm)')
    ylabel('n_f_i_t (10^1^4 m^-^3)')
    title(['x-transect - expand ' num2str(s2(j).t) ' us'])
    ax.PlotBoxAspectRatio = [1 1 1];
    ax.Position(2) = ax.Position(2) - .05;
     ax.YLim(1) = 0;

    ax = subplot(1,2,2);
    hold on
    s2 = s([s.t] == t(i));
    [~,sortind] = sort([s2.tE]);
    s2 = s2(sortind);
    lgdstr = {};
    for j = 1:length(s2)
        ind = [s2(j).os.local.tr] == 1;
        s3 = s2(j).os.local(ind);
        xdata = [s3.y];
        ydata = [s3.nFit];
        plot(xdata,ydata,'LineWidth',1.5)
        str1 = extractBefore(extractAfter(s2(j).andir,'expose'),'n');
        lgdstr{end+1} = [str1 'ns'];
    end
    xlabel('y (mm)')
    ylabel('n_f_i_t (10^1^4 m^-^3)')
    title(['y-transect - expand ' num2str(s2(j).t) ' us'])
    ax.PlotBoxAspectRatio = [1 1 1];
    lgd = legend(lgdstr);
    ax.Position(2) = ax.Position(2) - .05;
    ax.YLim(1) = 0;

    an = annotation('textbox');
    an.Position = [0.0058    0.8762    0.9919    0.1143];
    an.HorizontalAlignment = 'center';
    an.VerticalAlignment = 'middle';
    an.LineStyle = 'none';
    an.FontSize = 12;

    if i == 1
        str1 = 'Initial Density Control Measurements - all taken with 500 ns exposure, legend indicates exposure of corresponding pumping test';
    else
        str1 = 'Optical Pumping Test Measurements';
    end
    str2 = ' - n_f_i_t from FGR fit to local spectra';

    an.String = [str1 str2];

    txt = text(0,0,'test');
    txt.Units = 'normalized';
    txt.Position = [-1.6633   -0.1020         0];
    txt.String = 'Phase6.1-Te40';

    export_fig(['Phase6.1-Te40-Pumping-Density-t' num2str(t(i)) 'us.png'],'-png',fig)
end

%% Plot Density Transects

t = unique([s.t]);

for i = 1:length(t)
    fig = figure;
    fig.Position = [498   281   867   420];

    ax = subplot(1,2,1);
    hold on
    s2 = s([s.t] == t(i));
    [~,sortind] = sort([s2.tE]);
    s2 = s2(sortind);
    for j = 1:length(s2)
        ind = [s2(j).os.local.tr] == 2;
        s3 = s2(j).os.local(ind);
        xdata = [s3.x];
        ydata = [s3.Ti];
        plot(xdata,ydata,'LineWidth',1.5)
    end
    xlabel('x (mm)')
    ylabel('T_i (K)')
    title(['x-transect - expand ' num2str(s2(j).t) ' us'])
    ax.PlotBoxAspectRatio = [1 1 1];
    ax.Position(2) = ax.Position(2) - .05;
     ax.YLim(1) = 0;

    ax = subplot(1,2,2);
    hold on
    s2 = s([s.t] == t(i));
    [~,sortind] = sort([s2.tE]);
    s2 = s2(sortind);
    lgdstr = {};
    for j = 1:length(s2)
        ind = [s2(j).os.local.tr] == 1;
        s3 = s2(j).os.local(ind);
        xdata = [s3.y];
        ydata = [s3.Ti];
        plot(xdata,ydata,'LineWidth',1.5)
        str1 = extractBefore(extractAfter(s2(j).andir,'expose'),'n');
        lgdstr{end+1} = [str1 'ns'];
    end
    xlabel('y (mm)')
    ylabel('T_i (K)')
    title(['y-transect - expand ' num2str(s2(j).t) ' us'])
    ax.PlotBoxAspectRatio = [1 1 1];
    lgd = legend(lgdstr);
    ax.Position(2) = ax.Position(2) - .05;
    ax.YLim(1) = 0;

    an = annotation('textbox');
    an.Position = [0.0058    0.8762    0.9919    0.1143];
    an.HorizontalAlignment = 'center';
    an.VerticalAlignment = 'middle';
    an.LineStyle = 'none';
    an.FontSize = 12;

    if i == 1
        str1 = 'Initial Density Control Measurements - all taken with 500 ns exposure, legend indicates exposure of corresponding pumping test';
    else
        str1 = 'Optical Pumping Test Measurements';
    end
    str2 = ' - n_f_i_t from FGR fit to local spectra';
<<<<<<< HEAD

    an.String = [str1 str2];

=======

    an.String = [str1 str2];

>>>>>>> 0948276be486cde9a0903c33535949f7bf71ea49
    txt = text(0,0,'test');
    txt.Units = 'normalized';
    txt.Position = [-1.6633   -0.1020         0];
    txt.String = 'Phase6.1-Te40';

    export_fig(['Phase6.1-Te40-Pumping-Ti-t' num2str(t(i)) 'us.png'],'-png',fig)
end

%% Plot Spectra for Local Region vs Exposure
t =75;
x0 = -4;
y0 = 0;

fig = figure;
fig.Position = [496   281   869   420];

ind = t == [s.t];
s2 = s(ind);

ax1 = subplot(1,2,1);
ax1.PlotBoxAspectRatio = [1 1 1];
hold on
ax2 = subplot(1,2,2);
ax2.PlotBoxAspectRatio = [1 1 1];

hold on

lgdstr = {};
n = zeros(size(s2));
for i = 1:length(s2)
    indx = abs([s2(i).os.local.x] - x0);
    indy = abs([s2(i).os.local.y] - y0);
    [~,ind] = min(indx+indy);

    xstr = num2str(round(s2(i).os.local(ind).x,2,'significant'));
    ystr = num2str(round(s2(i).os.local(ind).y,2,'significant'));
    tEstr = num2str(s2(i).tE);

    xdata = s2(i).os.local(ind).dets;
    ydata = s2(i).os.local(ind).spec;
    ydata2 = s2(i).os.local(ind).fit.spec;

    axes(ax1)
    plot(xdata,ydata,'LineWidth',1.5)
    axes(ax2)
    plot(xdata,ydata2,'LineWidth',1.5)

    lgdstr{end+1} = ['tE = ' tEstr ' us'];
    test(i).tE = s2(i).tE;
    test(i).nFit = s2(i).os.local(ind).nFit;
    test(i).nLIF = s2(i).os.local(ind).nLIF2;
    test(i).Ti = s2(i).os.local(ind).Ti;
    test(i).p = s2(i).os.local(ind).p;
    test(i).I = s2(i).os.batch.I(0,0);
end


lgd = legend(lgdstr);
lgd.Position = [0.7920    0.6032    0.1513    0.2298];
