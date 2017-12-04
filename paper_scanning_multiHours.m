clear;close all;

token = 1;
n = 10;
channel = [11];
dataTemp = [];
for m = token : token+n-1
    [date, h] = colLocation(m,'2012-01-01')
    % date = '2012-07-04';
    % h = 6;
    % fileName = ['/Volumes/ssd/sutong-2012-tidy/' date '/' date ' ' num2str(h,'%02d') '-VIB.mat'];
    fileName = ['C:/dataArchiveTemp/Sutong/' date '/' date ' ' num2str(h,'%02d') '-VIB.mat'];
    load(fileName);
    dataTemp = [dataTemp;data];
    clear data

end

data = dataTemp;
t = 0.05:0.05:3600*n;
data = data - repmat(nanmean(data),[72000*n,1]);

figure
plot(t, data(:,channel), 'k');
% plot(t,data(:,1),t,data(:,2),t,data(:,3));
xlabel('Time (s)');
ylabel('Accel. (m/s^2)');
set(gca,'fontname', 'Times New Roman','fontweight','bold');
xlim([0 3600*n]);
% ylim([-0.8 0.7]);
% set(gca,'ytick', [-0.8:0.2:0.6]);

% set(gca, 'fontsize', 20);
% set(gca,'Units','normalized', 'Position',[0.06 0.14 0.93 0.83]);  % control axis's position in figure
% % set(gca,'Units','normalized', 'OuterPosition',[0 0 1 1]);  % control axis's position in figure
% set(gcf,'Units','pixels','Position',[100, 100, 1900, 600]);

box off
set(gca, 'visible', 'off');
set(gcf,'color','white');
set(gca, 'fontsize', 14);
set(gca,'Units','normalized', 'Position',[0 0 1 1]);
% set(gca,'Units','normalized', 'OuterPosition',[0 0 1 1]);  % control axis's position in figure
set(gcf,'Units','pixels','Position',[100, 100, 1500, 300]);

%%
folderName = 'plotForPaper';
if ~exist(folderName, 'dir'), mkdir(folderName); end
saveName = ['accel_' date '-' num2str(h,'%02d') '_ch' tidyName(abbr(channel)) '_scanning.png'];
% saveName = ['accel_' date '-' num2str(h,'%02d') '_ch' tidyName(abbr(channel)) '.emf'];
saveas(gcf, [folderName '/' saveName]);