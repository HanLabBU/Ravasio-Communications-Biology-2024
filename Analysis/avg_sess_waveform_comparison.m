% avg_sess_waveform comparison
% Date: 04/19/23
% Author: Cara
% Purpose: To compare the neocortical and hippocampal 40Hz 140Hz and 1000Hz avg 
% modulated waveforms.

function avg_sess_waveform_comparison(pos_40_CA1,neg_40_CA1,reb_40_CA1,...
                                    pos_140_CA1,neg_140_CA1,reb_140_CA1,...
                                    pos_1000_CA1,neg_1000_CA1,reb_1000_CA1,...
                                    pos_40_M1,neg_40_M1,reb_40_M1,...
                                    pos_140_M1,neg_140_M1,reb_140_M1,...
                                    pos_1000_M1,neg_1000_M1,reb_1000_M1)
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
%% get info from waveforms

%Hippocampal

avg_pos_40_CA1 = mean(pos_40_CA1.session_avg_traces,1); 
avg_reb_40_CA1 = mean(reb_40_CA1.session_avg_traces,1);
avg_neg_40_CA1 = mean(neg_40_CA1.session_avg_traces,1);
% sem_pos_40_CA1 = std(pos_40_s.traces,1)./sqrt(size(pos_40_s.neurons,1));
% sem_reb_40_CA1 = std(reb_40_s.traces,1)./sqrt(size(reb_40_s.neurons,1));
% sem_neg_40_CA1 = std(neg_40_s.traces,1)./sqrt(size(neg_40_s.neurons,1));
std_pos_40_CA1 = std(pos_40_CA1.session_avg_traces,1);
std_reb_40_CA1 = std(reb_40_CA1.session_avg_traces,1);
std_neg_40_CA1 = std(neg_40_CA1.session_avg_traces,1);


avg_pos_140_CA1 = mean(pos_140_CA1.session_avg_traces,1); 
avg_reb_140_CA1 = mean(reb_140_CA1.session_avg_traces,1);
avg_neg_140_CA1 = mean(neg_140_CA1.session_avg_traces,1);
% sem_pos_140_CA1 = std(pos_140_s.traces,1)./sqrt(size(pos_140_s.neurons,1));
% sem_reb_140_CA1 = std(reb_140_s.traces,1)./sqrt(size(reb_140_s.neurons,1));
% sem_neg_140_CA1 = std(neg_140_s.traces,1)./sqrt(size(neg_140_s.neurons,1));
std_pos_140_CA1 = std(pos_140_CA1.session_avg_traces,1);
std_reb_140_CA1 = std(reb_140_CA1.session_avg_traces,1);
std_neg_140_CA1 = std(neg_140_CA1.session_avg_traces,1);


avg_pos_1000_CA1 = mean(pos_1000_CA1.session_avg_traces,1); 
avg_reb_1000_CA1 = mean(reb_1000_CA1.session_avg_traces,1);
avg_neg_1000_CA1 = mean(neg_1000_CA1.session_avg_traces,1);
% sem_pos_1000_CA1 = std(pos_1000_s.traces,1)./sqrt(size(pos_1000_s.neurons,1));
% sem_reb_1000_CA1 = std(reb_1000_s.traces,1)./sqrt(size(reb_1000_s.neurons,1));
% sem_neg_1000_CA1 = std(neg_1000_s.traces,1)./sqrt(size(neg_1000_s.neurons,1));
std_pos_1000_CA1 = std(pos_1000_CA1.session_avg_traces,1);
std_reb_1000_CA1 = std(reb_1000_CA1.session_avg_traces,1);
std_neg_1000_CA1 = std(neg_1000_CA1.session_avg_traces,1);


%Neocortex
base_M1_path = ['/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Paper_Figures_Clean_Data/'];

avg_pos_40_M1 = mean(pos_40_M1.session_avg_traces,1); 
avg_reb_40_M1 = mean(reb_40_M1.session_avg_traces,1);
avg_neg_40_M1 = mean(neg_40_M1.session_avg_traces,1);
% sem_pos_40_M1 = std(pos_40_s.traces,1)./sqrt(size(pos_40_s.neurons,1));
% sem_reb_40_M1 = std(reb_40_s.traces,1)./sqrt(size(reb_40_s.neurons,1));
% sem_neg_40_M1 = std(neg_40_s.traces,1)./sqrt(size(neg_40_s.neurons,1));
std_pos_40_M1 = std(pos_40_M1.session_avg_traces,1);
std_reb_40_M1 = std(reb_40_M1.session_avg_traces,1);
std_neg_40_M1 = std(neg_40_M1.session_avg_traces,1);


avg_pos_140_M1 = mean(pos_140_M1.session_avg_traces,1); 
avg_reb_140_M1 = mean(reb_140_M1.session_avg_traces,1);
avg_neg_140_M1 = mean(neg_140_M1.session_avg_traces,1);
% sem_pos_140_M1 = std(pos_140_s.traces,1)./sqrt(size(pos_140_s.neurons,1));
% sem_reb_140_M1 = std(reb_140_s.traces,1)./sqrt(size(reb_140_s.neurons,1));
% sem_neg_140_M1 = std(neg_140_s.traces,1)./sqrt(size(neg_140_s.neurons,1));
std_pos_140_M1 = std(pos_140_M1.session_avg_traces,1);
std_reb_140_M1 = std(reb_140_M1.session_avg_traces,1);
std_neg_140_M1 = std(neg_140_M1.session_avg_traces,1);


avg_pos_1000_M1 = mean(pos_1000_M1.session_avg_traces,1); 
avg_reb_1000_M1 = mean(reb_1000_M1.session_avg_traces,1);
avg_neg_1000_M1 = mean(neg_1000_M1.session_avg_traces,1);
% sem_pos_1000_M1 = std(pos_1000_s.traces,1)./sqrt(size(pos_1000_s.neurons,1));
% sem_reb_1000_M1 = std(reb_1000_s.traces,1)./sqrt(size(reb_1000_s.neurons,1));
% sem_neg_1000_M1 = std(neg_1000_s.traces,1)./sqrt(size(neg_1000_s.neurons,1));
std_pos_1000_M1 = std(pos_1000_M1.session_avg_traces,1);
std_reb_1000_M1 = std(reb_1000_M1.session_avg_traces,1);
std_neg_1000_M1 = std(neg_1000_M1.session_avg_traces,1);

%% std stuff
avg_traces = [avg_pos_40_CA1; avg_reb_40_CA1; avg_neg_40_CA1;...
              avg_pos_140_CA1; avg_reb_140_CA1; avg_neg_140_CA1;...
              avg_pos_1000_CA1; avg_reb_1000_CA1; avg_neg_1000_CA1;...
              avg_pos_40_M1; avg_reb_40_M1; avg_neg_40_M1;...
              avg_pos_140_M1; avg_reb_140_M1; avg_neg_140_M1;...
              avg_pos_1000_M1; avg_reb_1000_M1; avg_neg_1000_M1];
          
trace_std = [std_pos_40_CA1; std_reb_40_CA1; std_neg_40_CA1;...
             std_pos_140_CA1; std_reb_140_CA1; std_neg_140_CA1;...
             std_pos_1000_CA1; std_reb_1000_CA1; std_neg_1000_CA1;...
             std_pos_40_M1; std_reb_40_M1; std_neg_40_M1;...
             std_pos_140_M1; std_reb_140_M1; std_neg_140_M1;...
             std_pos_1000_M1; std_reb_1000_M1; std_neg_1000_M1];
        
for i=1:size(avg_traces,1)
    data_temp = avg_traces(i,:);
    std_temp = trace_std(i,:);
    curve1(i,:) = data_temp + std_temp;
    curve2(i,:) = data_temp - std_temp;
    x = [2/Fs:1/Fs:20];
    x2 = [x, fliplr(x)];
    y2(i,:) = [curve1(i,2:end), fliplr(curve2(i,2:end))];
end

%% Change directory to the save path
cd(save_path);
%% Plot traces side by side
figure;

subplot(1,3,1)
plot([2/Fs:1/Fs:20],avg_neg_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_neg_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Negative Mod std
h = fill(x2,y2(3,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(6,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(9,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(12,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(15,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(18,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
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
plot([2/Fs:1/Fs:20],avg_pos_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_pos_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Positive Mod std
h = fill(x2,y2(1,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(4,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(7,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(10,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(13,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(16,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.14;
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
plot([2/Fs:1/Fs:20],avg_reb_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_reb_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Rebound std
h = fill(x2,y2(2,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(5,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(8,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(11,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(14,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(17,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
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

saveas(gcf, 'all_sess_avg_traces_all_conditions.fig')
%% Just Negative Modulation Plot (All four traces)
figure;
plot([2/Fs:1/Fs:20],avg_neg_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_neg_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Negative Mod std
h = fill(x2,y2(3,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(6,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(9,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(12,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(15,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(18,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
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
legend({'40Hz hippocampus', '40Hz neocortex','140Hz hippocampus', ...
        '140Hz neocortex','1000Hz hippocampus','1000Hz neocortex'});
saveas(gcf, 'all_sess_neg_avg_traces.fig')

%% Just positive modulation plot (All four traces)
figure;
plot([2/Fs:1/Fs:20],avg_pos_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_pos_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Positive Mod std
h = fill(x2,y2(1,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(4,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(7,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(10,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(13,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(16,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.14;
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
saveas(gcf, 'all_sess_pos_avg_traces.fig')   

%% All Rebound Modulation
figure;
plot([2/Fs:1/Fs:20],avg_reb_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_reb_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Rebound std
h = fill(x2,y2(2,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(5,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(8,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(11,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(14,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(17,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
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
saveas(gcf, 'all_sess_reb_mod_avg_traces.fig')   

%% Negative Modulation (40Hz traces)
figure;
plot([2/Fs:1/Fs:20],avg_neg_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_neg_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);

%Negative Mod std
h = fill(x2,y2(3,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(12,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.12; yl(2)=0.04;
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
saveas(gcf, 'sess_neg_40Hz_avg_traces.fig')

%% Positive Modulation (40Hz traces)
figure;
plot([2/Fs:1/Fs:20],avg_pos_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_pos_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);

%Positive Mod std
h = fill(x2,y2(1,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(10,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.14;
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
saveas(gcf, 'sess_pos_40Hz_avg_traces.fig')

%% Rebound (40Hz)
figure;
plot([2/Fs:1/Fs:20],avg_reb_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_reb_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);

%Rebound std
h = fill(x2,y2(2,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(11,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
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
saveas(gcf, 'sess_reb_40Hz_avg_traces.fig')   

%% Negative Modulation (140Hz traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_neg_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);

%Negative Mod std
h = fill(x2,y2(6,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(15,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.12; yl(2)=0.04;
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
saveas(gcf, 'sess_neg_140Hz_avg_traces.fig')

%% Positive Modulation (140Hz traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_pos_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);

%Positive Mod std
h = fill(x2,y2(4,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(13,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.14;
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
saveas(gcf, 'sess_pos_140Hz_avg_traces.fig')


%% Rebound (140Hz)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_reb_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);

%Rebound std
h = fill(x2,y2(5,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(14,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
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
saveas(gcf, 'sess_reb_140Hz_avg_traces.fig')   

%% Negative Modulation (1000Hz traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_neg_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Negative Mod std
h = fill(x2,y2(9,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(18,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.12; yl(2)=0.04;
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
saveas(gcf, 'sess_neg_1000Hz_avg_traces.fig')

%% Positive Modulation (1000Hz traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_pos_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Positive Mod std
h = fill(x2,y2(7,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(16,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.14;
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
saveas(gcf, 'sess_pos_1000Hz_avg_traces.fig')


%% Rebound (1000Hz traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_reb_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Rebound std
h = fill(x2,y2(8,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(17,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
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
saveas(gcf, 'sess_reb_1000Hz_avg_traces.fig')   

%% Negative Modulation (Hip traces)
figure;
plot([2/Fs:1/Fs:20],avg_neg_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_neg_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);

%Negative Mod std
h = fill(x2,y2(3,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(6,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(9,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.12; yl(2)=0.04;
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
saveas(gcf, 'sess_CA1_neg_avg_traces.fig')

%% Positive Modulation (Hip traces)
figure;
plot([2/Fs:1/Fs:20],avg_pos_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_pos_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);

%Positive Mod std
h = fill(x2,y2(1,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(4,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(7,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.14;
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
saveas(gcf, 'sess_CA1_pos_avg_traces.fig')


%% Rebound (Hip traces)
figure;
plot([2/Fs:1/Fs:20],avg_reb_40_CA1(2:end),'-','Color',color_40_CA1,'Linewidth', 2);
hold on;
plot([2/Fs:1/Fs:20],avg_reb_140_CA1(2:end),'-','Color',color_140_CA1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_CA1(2:end),'-','Color',color_1000_CA1,'Linewidth', 2);

%Rebound std
h = fill(x2,y2(2,:), color_40_CA1,'LineStyle','none'); %shade in 40Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(5,:), color_140_CA1,'LineStyle','none'); %shade in 140Hz CA1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(8,:), color_1000_CA1,'LineStyle','none'); %shade in 1000Hz CA1 std area 
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
saveas(gcf, 'sess_CA1_reb_avg_traces.fig')   

%% Negative Modulation (Cort traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_neg_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_neg_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Negative Mod std
h = fill(x2,y2(12,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(15,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(18,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.12; yl(2)=0.04;
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
saveas(gcf, 'sess_M1_neg_avg_traces.fig')

%% Positive Modulation (Cort traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_pos_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_pos_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Positive Mod std
h = fill(x2,y2(10,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(13,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(16,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent

%Stimulation fill
yl(1)=-0.02; yl(2)=0.14;
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
saveas(gcf, 'sess_M1_pos_avg_traces.fig')

%% Rebound (Cort traces)
figure;
hold on;
plot([2/Fs:1/Fs:20],avg_reb_40_M1(2:end),'--','Color',color_40_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_140_M1(2:end),'--','Color',color_140_M1,'Linewidth', 2);
plot([2/Fs:1/Fs:20],avg_reb_1000_M1(2:end),'--','Color',color_1000_M1,'Linewidth', 2);

%Rebound std
h = fill(x2,y2(11,:), color_40_M1,'LineStyle','none'); %shade in 40Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(14,:), color_140_M1,'LineStyle','none'); %shade in 140Hz M1 std area 
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2,y2(17,:), color_1000_M1,'LineStyle','none'); %shade in 1000Hz M1 std area 
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
saveas(gcf, 'sess_M1_reb_avg_traces.fig')   
end