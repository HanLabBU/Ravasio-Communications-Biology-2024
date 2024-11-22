% avg_mod_waveform_comparison
% Date: 06/06/22
% Author: Cara
% Purpose: To compare the neocortical and hippocampal 40Hz 140Hz and 1000Hz avg 
% modulated waveforms.
%
% Edited 05/16/23: Turned into a function, no output, all mod structs as
% inputs, removed the loading sections 
%
%Edited 09/15/23: Turned SEM into 95% confidence interval.

function avg_mod_waveform_comparison(pos_mod_40_CA1,neg_mod_40_CA1,rebound_40_CA1,...
                                    pos_mod_140_CA1,neg_mod_140_CA1,rebound_140_CA1,...
                                    pos_mod_1000_CA1,neg_mod_1000_CA1,rebound_1000_CA1,...
                                    pos_mod_40_M1,neg_mod_40_M1,rebound_40_M1,...
                                    pos_mod_140_M1,neg_mod_140_M1,rebound_140_M1,...
                                    pos_mod_1000_M1,neg_mod_1000_M1,rebound_1000_M1)
%% Setup
save_path = ['/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Paper_Figures_Clean_Data'];
Fs = 20; % Hz

%Setting up color scheme for figures (Colorblind friendly)
white = [255 255 255]/255;
purple = [0.494,0.184,0.556];%[197 28 124]/255;%[136 26 88]/255; %40Hz
orange = [0.85,0.325,0.098];%[249 81 8]/255;%[165 54 6]/255; %140Hz
blue = [0, 0.447,0.741];%[57 150 191]/255;%[22 76 100]/255; %100Hz
length = 200; % the number of color steps included in the colormap

color_40_CA1 = purple;
color_140_CA1 = orange;
color_1000_CA1 = blue;

colormap_40 = [linspace(white(1),purple(1), length)',linspace(white(2),purple(2), length)',linspace(white(3),purple(3), length)'];
colormap_140 = [linspace(white(1),orange(1), length)',linspace(white(2),orange(2), length)',linspace(white(3),orange(3), length)'];
colormap_1000 = [linspace(white(1),blue(1), length)',linspace(white(2),blue(2), length)',linspace(white(3),blue(3), length)'];

color_40_M1 = colormap_40(length/2,:);
color_140_M1 = colormap_140(length/2,:);
color_1000_M1 = colormap_1000(length/2,:);
%% Load in waveforms

ts = tinv([0.025  0.975],size(pos_mod_40_CA1.neurons,1)-1);      % T-Score
avg_pos_40_hip = pos_mod_40_CA1.avg_trace; 
avg_reb_40_hip = rebound_40_CA1.avg_trace;
avg_neg_40_hip = neg_mod_40_CA1.avg_trace;
sem_pos_40_hip = std(pos_mod_40_CA1.traces,1)./sqrt(size(pos_mod_40_CA1.neurons,1))*ts(2);
sem_reb_40_hip = std(rebound_40_CA1.traces,1)./sqrt(size(rebound_40_CA1.neurons,1))*ts(2);
sem_neg_40_hip = std(neg_mod_40_CA1.traces,1)./sqrt(size(neg_mod_40_CA1.neurons,1))*ts(2);
% sem_pos_40_hip = std(pos_mod_40_CA1.traces);
% sem_reb_40_hip = std(rebound_40_CA1.traces);
% sem_neg_40_hip = std(neg_mod_40_CA1.traces);

ts = tinv([0.025  0.975],size(pos_mod_140_CA1.neurons,1)-1);      % T-Score
avg_pos_140_hip = pos_mod_140_CA1.avg_trace; 
avg_reb_140_hip = rebound_140_CA1.avg_trace;
avg_neg_140_hip = neg_mod_140_CA1.avg_trace;
sem_pos_140_hip = std(pos_mod_140_CA1.traces,1)./sqrt(size(pos_mod_140_CA1.neurons,1))*ts(2);
sem_reb_140_hip = std(rebound_140_CA1.traces,1)./sqrt(size(rebound_140_CA1.neurons,1))*ts(2);
sem_neg_140_hip = std(neg_mod_140_CA1.traces,1)./sqrt(size(neg_mod_140_CA1.neurons,1))*ts(2);
% sem_pos_140_hip = std(pos_mod_140_CA1.traces);
% sem_reb_140_hip = std(rebound_140_CA1.traces);
% sem_neg_140_hip = std(neg_mod_140_CA1.traces);

ts = tinv([0.025  0.975],size(pos_mod_1000_CA1.neurons,1)-1);      % T-Score
avg_pos_1000_hip = pos_mod_1000_CA1.avg_trace; 
avg_reb_1000_hip = rebound_1000_CA1.avg_trace;
avg_neg_1000_hip = neg_mod_1000_CA1.avg_trace;
sem_pos_1000_hip = std(pos_mod_1000_CA1.traces,1)./sqrt(size(pos_mod_1000_CA1.neurons,1))*ts(2);
sem_reb_1000_hip = std(rebound_1000_CA1.traces,1)./sqrt(size(rebound_1000_CA1.neurons,1))*ts(2);
sem_neg_1000_hip = std(neg_mod_1000_CA1.traces,1)./sqrt(size(neg_mod_1000_CA1.neurons,1))*ts(2);
% sem_pos_1000_hip = std(pos_mod_1000_CA1.traces);
% sem_reb_1000_hip = std(rebound_1000_CA1.traces);
% sem_neg_1000_hip = std(neg_mod_1000_CA1.traces);


%Neocortex
ts = tinv([0.025  0.975],size(pos_mod_40_M1.neurons,1)-1);      % T-Score
avg_pos_40_cort = pos_mod_40_M1.avg_trace; 
avg_reb_40_cort = rebound_40_M1.avg_trace;
avg_neg_40_cort = neg_mod_40_M1.avg_trace;
sem_pos_40_cort = std(pos_mod_40_M1.traces,1)./sqrt(size(pos_mod_40_M1.neurons,1))*ts(2);
sem_reb_40_cort = std(rebound_40_M1.traces,1)./sqrt(size(rebound_40_M1.neurons,1))*ts(2);
sem_neg_40_cort = std(neg_mod_40_M1.traces,1)./sqrt(size(neg_mod_40_M1.neurons,1))*ts(2);
% sem_pos_40_cort = std(pos_mod_40_M1.traces);
% sem_reb_40_cort = std(rebound_40_M1.traces);
% sem_neg_40_cort = std(neg_mod_40_M1.traces);


ts = tinv([0.025  0.975],size(pos_mod_140_M1.neurons,1)-1);      % T-Score
avg_pos_140_cort = pos_mod_140_M1.avg_trace; 
avg_reb_140_cort = rebound_140_M1.avg_trace;
avg_neg_140_cort = neg_mod_140_M1.avg_trace;
sem_pos_140_cort = std(pos_mod_140_M1.traces,1)./sqrt(size(pos_mod_140_M1.neurons,1))*ts(2);
sem_reb_140_cort = std(rebound_140_M1.traces,1)./sqrt(size(rebound_140_M1.neurons,1))*ts(2);
sem_neg_140_cort = std(neg_mod_140_M1.traces,1)./sqrt(size(neg_mod_140_M1.neurons,1))*ts(2);
% sem_pos_140_cort = std(pos_mod_140_M1.traces);
% sem_reb_140_cort = std(rebound_140_M1.traces);
% sem_neg_140_cort = std(neg_mod_140_M1.traces);

ts = tinv([0.025  0.975],size(pos_mod_1000_M1.neurons,1)-1);      % T-Score
avg_pos_1000_cort = pos_mod_1000_M1.avg_trace; 
avg_reb_1000_cort = rebound_1000_M1.avg_trace;
avg_neg_1000_cort = neg_mod_1000_M1.avg_trace;
sem_pos_1000_cort = std(pos_mod_1000_M1.traces,1)./sqrt(size(pos_mod_1000_M1.neurons,1))*ts(2);
sem_reb_1000_cort = std(rebound_1000_M1.traces,1)./sqrt(size(rebound_1000_M1.neurons,1))*ts(2);
sem_neg_1000_cort = std(neg_mod_1000_M1.traces,1)./sqrt(size(neg_mod_1000_M1.neurons,1))*ts(2);
% sem_pos_1000_cort = std(pos_mod_1000_M1.traces);
% sem_reb_1000_cort = std(rebound_1000_M1.traces);
% sem_neg_1000_cort = std(neg_mod_1000_M1.traces);

%% SEM stuff
avg_traces = [avg_pos_40_hip; avg_reb_40_hip; avg_neg_40_hip;...
              avg_pos_140_hip; avg_reb_140_hip; avg_neg_140_hip;...
              avg_pos_1000_hip; avg_reb_1000_hip; avg_neg_1000_hip;...
              avg_pos_40_cort; avg_reb_40_cort; avg_neg_40_cort;...
              avg_pos_140_cort; avg_reb_140_cort; avg_neg_140_cort;...
              avg_pos_1000_cort; avg_reb_1000_cort; avg_neg_1000_cort];
          
trace_sem = [sem_pos_40_hip; sem_reb_40_hip; sem_neg_40_hip;...
             sem_pos_140_hip; sem_reb_140_hip; sem_neg_140_hip;...
             sem_pos_1000_hip; sem_reb_1000_hip; sem_neg_1000_hip;...
             sem_pos_40_cort; sem_reb_40_cort; sem_neg_40_cort;...
             sem_pos_140_cort; sem_reb_140_cort; sem_neg_140_cort;...
             sem_pos_1000_cort; sem_reb_1000_cort; sem_neg_1000_cort];
        
for i=1:size(avg_traces,1)
    data_temp = avg_traces(i,:);
    sem_temp = trace_sem(i,:);
    curve1(i,:) = data_temp + sem_temp;
    curve2(i,:) = data_temp - sem_temp;
    x = [2/Fs:1/Fs:20];
    x2 = [x, fliplr(x)];
    y2(i,:) = [curve1(i,2:end), fliplr(curve2(i,2:end))];
end

%% Change directory to the save path
cd(save_path);
%% Plot traces side by side
figure;

subplot(1,3,1)
plot([2/Fs:1/Fs:20],avg_neg_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_neg_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Negative Mod SEM
h = fill(x2,y2(3,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(6,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(9,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(12,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(15,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(18,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.12; yl(2)=0.04;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Negatively Modulated');
xlabel('Time (s)');
ylabel('Fluorescence (au)');

subplot(1,3,2)
plot([2/Fs:1/Fs:20],avg_pos_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_pos_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Positive Mod SEM
h = fill(x2,y2(1,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(4,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(7,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(10,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(13,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(16,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.18;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Positively Modulated');
xlabel('Time (s)');
ylabel('Fluorescence (au)');

subplot(1,3,3)
plot([2/Fs:1/Fs:20],avg_reb_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_reb_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Rebound SEM
h = fill(x2,y2(2,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(5,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(8,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(11,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(14,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(17,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.04; yl(2)=0.12;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Rebound');
xlabel('Time (s)');
ylabel('Fluorescence (au)');

legend({'40Hz hippocampus', '40Hz neocortex','140Hz hippocampus', ...
        '140Hz neocortex','1000Hz hippocampus','1000Hz neocortex'},'Location', 'northwest');
suptitle('Average calcium modulation waveforms in hippocampus and neocortex');

saveas(gcf, 'all_avg_traces_all_conditions.fig')
%% Just Negative Modulation Plot (All four traces)
figure;
plot([2/Fs:1/Fs:20],avg_neg_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_neg_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Negative Mod SEM
h = fill(x2,y2(3,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(6,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(9,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(12,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(15,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(18,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.14; yl(2)=0.06;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Negatively Modulated');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz hippocampus', '40Hz neocortex','140Hz hippocampus', ...
        '140Hz neocortex','1000Hz hippocampus','1000Hz neocortex'});
saveas(gcf, 'all_neg_mod_avg_traces.fig')

%% Just positive modulation plot (All four traces)
figure;
plot([2/Fs:1/Fs:20],avg_pos_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_pos_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Positive Mod SEM
h = fill(x2,y2(1,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(4,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(7,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(10,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(13,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(16,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.18;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Positively Modulated');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz hippocampus', '40Hz neocortex','140Hz hippocampus', ...
        '140Hz neocortex','1000Hz hippocampus','1000Hz neocortex'});
saveas(gcf, 'all_pos_mod_avg_traces.fig')   

%% All Rebound Modulation
figure;
plot([2/Fs:1/Fs:20],avg_reb_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_reb_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Rebound SEM
h = fill(x2,y2(2,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(5,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(8,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(11,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(14,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(17,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.04; yl(2)=0.12;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Rebound');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz hippocampus', '40Hz neocortex','140Hz hippocampus', ...
        '140Hz neocortex','1000Hz hippocampus','1000Hz neocortex'});
saveas(gcf, 'all_reb_mod_avg_traces.fig')   

%% Negative Modulation (40Hz traces)
figure;
plot([2/Fs:1/Fs:20],avg_neg_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_neg_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);

%Negative Mod SEM
h = fill(x2,y2(3,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(12,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.14; yl(2)=0.06;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Negatively Modulated 40Hz traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz hippocampus', '40Hz neocortex'});
saveas(gcf, 'neg_mod_40Hz_avg_traces.fig')

%% Positive Modulation (40Hz traces)
figure;
plot([2/Fs:1/Fs:20],avg_pos_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_pos_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);

%Positive Mod SEM
h = fill(x2,y2(1,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(10,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.18;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Positively Modulated 40Hz traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz hippocampus', '40Hz neocortex'});
saveas(gcf, 'pos_mod_40Hz_avg_traces.fig')

%% Rebound (40Hz)
figure;
plot([2/Fs:1/Fs:20],avg_reb_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_reb_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);

%Rebound SEM
h = fill(x2,y2(2,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(11,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.04; yl(2)=0.12;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Rebound 40Hz traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz hippocampus', '40Hz neocortex'});
saveas(gcf, 'reb_40Hz_avg_traces.fig')   

%% Negative Modulation (140Hz traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_neg_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);

%Negative Mod SEM
h = fill(x2,y2(6,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(15,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.14; yl(2)=0.06;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Negatively Modulated 140Hz traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'140Hz hippocampus', '140Hz neocortex'});
saveas(gcf, 'neg_mod_140Hz_avg_traces.fig')

%% Positive Modulation (140Hz traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_pos_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);

%Positive Mod SEM
h = fill(x2,y2(4,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(13,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.18;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Positively Modulated 140Hz traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'140Hz hippocampus', '140Hz neocortex'});
saveas(gcf, 'pos_mod_140Hz_avg_traces.fig')


%% Rebound (140Hz)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_reb_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);

%Rebound SEM
h = fill(x2,y2(5,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(14,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.04; yl(2)=0.12;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Rebound 140Hz traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'140Hz hippocampus', '140Hz neocortex'});
saveas(gcf, 'reb_140Hz_avg_traces.fig')   

%% Negative Modulation (1000Hz traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_neg_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Negative Mod SEM
h = fill(x2,y2(9,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(18,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.14; yl(2)=0.06;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Negatively Modulated 1000Hz traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'1000Hz hippocampus', '1000Hz neocortex'});
saveas(gcf, 'neg_mod_1000Hz_avg_traces.fig')

%% Positive Modulation (1000Hz traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_pos_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Positive Mod SEM
h = fill(x2,y2(7,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(16,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.18;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Positively Modulated 1000Hz traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'1000Hz hippocampus', '1000Hz neocortex'});
saveas(gcf, 'pos_mod_1000Hz_avg_traces.fig')


%% Rebound (1000Hz traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_reb_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Rebound SEM
h = fill(x2,y2(8,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(17,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.04; yl(2)=0.12;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Rebound 1000Hz traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'1000Hz hippocampus','1000Hz neocortex'});
saveas(gcf, 'reb_1000Hz_avg_traces.fig')   

%% Negative Modulation (Hip traces)
figure;
plot([2/Fs:1/Fs:20],avg_neg_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_neg_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);

%Negative Mod SEM
h = fill(x2,y2(3,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(6,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(9,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.14; yl(2)=0.06;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Negatively Modulated hippocampal traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz hippocampus', '140Hz hippocampus','1000Hz hippocampus'});
saveas(gcf, 'CA1_neg_mod_avg_traces.fig')

%% Positive Modulation (Hip traces)
figure;
plot([2/Fs:1/Fs:20],avg_pos_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_pos_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);

%Positive Mod SEM
h = fill(x2,y2(1,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(4,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(7,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.18;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Positively Modulated hippocmapal traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz hippocampus','140Hz hippocampus', '1000Hz hippocampus'});
saveas(gcf, 'CA1_pos_mod_avg_traces.fig')


%% Rebound (Hip traces)
figure;
plot([2/Fs:1/Fs:20],avg_reb_40_hip(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_reb_140_hip(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_hip(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);

%Rebound SEM
h = fill(x2,y2(2,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(5,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(8,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.04; yl(2)=0.12;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Rebound hippocampal traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz hippocampus', '140Hz hippocampus','1000Hz hippocampus'});
saveas(gcf, 'CA1_reb_avg_traces.fig')   

%% Negative Modulation (Cort traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_neg_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Negative Mod SEM
h = fill(x2,y2(12,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(15,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(18,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.14; yl(2)=0.06;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Negatively Modulated neocortical traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz neocortex', '140Hz neocortex','1000Hz neocortex'});
saveas(gcf, 'M1_neg_mod_avg_traces.fig')

%% Positive Modulation (Cort traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_pos_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Positive Mod SEM
h = fill(x2,y2(10,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(13,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(16,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.18;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Positively Modulated Neocortical traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz neocortex', '140Hz neocortex','1000Hz neocortex'});
saveas(gcf, 'M1_pos_mod_avg_traces.fig')

%% Rebound (Cort traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_reb_40_cort(2:end),'-','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_cort(2:end),'-','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_cort(2:end),'-','Color',color_1000_M1,'Linewidth', 2);

%Rebound SEM
h = fill(x2,y2(11,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(14,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(17,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 sem area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.04; yl(2)=0.12;
ylim([yl(1) yl(2)]);
h=fill([5,5,10,10], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

xline(5,'Color','k','LineStyle','-');
xline(10,'Color','k','LineStyle','-');
title('Rebound Neocortical traces');
xlabel('Time (s)');
ylabel('Fluorescence (au)');
legend({'40Hz neocortex','140Hz neocortex','1000Hz neocortex'});
saveas(gcf, 'M1_reb_avg_traces.fig')   
end