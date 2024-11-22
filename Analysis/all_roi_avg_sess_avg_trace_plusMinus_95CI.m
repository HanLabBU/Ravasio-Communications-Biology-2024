% all_roi_avg_sess_avg_trace_plusMinus_95CI.m
% Author: Cara
% Date: 09/19/23
% Purpose: To find the overall average session avg trace for a given stimulation
% condition and see whether the overall effect is inhibitory. This takes
% the data structs which contain every good roi_data struct concatenates
% every neuron's average trace and then averages across all neurons. +/-
% 95% confidence interval (95% t-score * SEM).
% Standard error of the mean used to be included to show confidence of average
% trace but was essentially meaningless, and std does not tell the story of
% overall inhibition as well because of positively modulated outliers. I 
% also tried averaging all session average traces, but this did not seem 
% as accurate to me when interested in overall effect.
%
% ex: all_roi_avg_sess_avg_trace_plusMinus_95CI(data_40_CA1, 40, 'CA1', CA1_colors);

function all_roi_avg_sess_avg_trace_plusMinus_95CI(data, freq, region, colors)
%% Setup
Fs = 20; %Hz

if freq == 40
    color = colors(1,:);
elseif freq == 140
    color = colors(2,:);
elseif freq == 1000
    color = colors(3,:);
else
    color = [1 0 0]; %red for ctrl if passed through
end

%% Calculate Avg sess avg trace and SEM
sess = [];
for i=1:numel(data)
    sess = vertcat(sess,data(i).roi_data.total_avg_trace_minusBG_new_scaled); 
end
ts = tinv([0.025  0.975],size(sess,1)-1);      % T-Score
sem_avg = std(sess,1)./sqrt(size(sess,1))*ts(2);
avg_trace = mean(sess,1);
curve1 = avg_trace + sem_avg;
curve2 = avg_trace - sem_avg;
x = [1:20*Fs];
x2 = [x, fliplr(x)];
y2 = [curve1(1:end), fliplr(curve2(1:end))];

%% Plot and save figure
figure;
plot([1:20*Fs],avg_trace,'-','Color',color);
hold on
h = fill(x2,y2, color,'LineStyle','none'); %shade in sem area
h.FaceAlpha = 0.25; %make sem area transparent
xline(5*Fs,'Color','black','LineStyle','-');
xline(10*Fs,'Color','black','LineStyle','-');
ylim([-0.025, 0.02]); %found empirically after plotting all traces
title(['Total Avg Trace ' num2str(freq) 'Hz ' region]);
set(gca,'XTick',[0:Fs:20*Fs],'XTickLabel',[0:20]);
xlabel('Time (s)'); ylabel('\DeltaF/F');

saveas(gcf,['total_avg_sess_avg_trace_plusMinus_95CI_' num2str(freq), '_',region],'fig');