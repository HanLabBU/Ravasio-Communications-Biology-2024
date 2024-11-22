% movstd_DBS_mod_check.m
% Author: Cara R
% Date: 08/24/22
% Purpose: Using a moving window of standard deviation to identify when
% significant changes in occur in a neuron trace in order to classify a
% neuron's modulatory behavior.

%% Setup
addpath(genpath('~/handata_server/Cara_Ravasio/Code/GCaMP_Data_Extraction'));
base_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/Good_Recordings_Data_Files'; %/media/hanlabadmins/Elements/DBS/Hippocampus/GCaMP';
region = 'CA1';
cd(base_path);

load(['./data40_' region '.mat'])
load(['./data140_' region '.mat'])
load(['./data1000_' region '.mat'])
load([

traces = example_traces.CA1_40.neg.stim.traces; 
%trace 5 shows post rebound at 10s
%trace 8 shows a deactivation at 5s with recovery at 10s
%trace 17 shows a silence during stimulation cmpared to pre and post stim
%trace 4 shows a neuron recovering from just having fired before baseline
%% Smooth original traces then find cells' std dev traces
num_neurons = size(traces,1);
std_win = 5; %number of points used for moving std dev window

smooth_traces = [];
std_dev_traces=[];
for i=1:num_neurons
    smooth_traces(i,:) = smooth(traces(i,:)); %5-point moving average by default (equivalently 0.5 second window)
    std_dev_traces(i,:) = smooth(movstd(smooth_traces(i,:),std_win));
end

%% Z-test the std dev trace to determine significance
for i=1:num_neurons 
    baseline_5s = std_dev_traces(i,2:5*Fs-1); %All baseline excluding first frame
    baseline_3s = std_dev_traces(i,2*Fs-1:5*Fs-1); %3 seconds preceding stimulation
    
    baseline_avg_5s = mean(baseline_5s)*ones(size(traces(i,:)));
    baseline_avg_3s = mean(baseline_3s)*ones(size(traces(i,:)));
    
    fluor_trace(i,:) = smooth_traces(i,:);
    std_dev_trace(i,:) = std_dev_traces(i,:);
    first_deriv_trace(i,:) = gradient(smooth_traces(i,:),Fs);
    signif_stdev_5s(i) = 2*std(baseline_5s);
    signif_stdev_3s(i) = 2*std(baseline_3s);
    z_trace_5s(i,:) = (std_dev_traces(i,:)-baseline_avg_5s)/std(baseline_5s);
    z_trace_3s(i,:) = (std_dev_traces(i,:)-baseline_avg_3s)/std(baseline_3s);
end


%% T-test on the std-dev trace to determine significance
% onset significance (expect trace1 = no, trace2 = yes, and trace3 = yes)
[h5_on, p5_on] = ttest2(std_dev_trace(:,5*Fs:5.5*Fs)',std_dev_trace(:,2:5*Fs-1)');
[h3_on, p3_on] = ttest2(std_dev_trace(:,5*Fs:5.5*Fs)',std_dev_trace(:,3*Fs:5*Fs-1)');

%offset significance (expect trace1 = yes, trace2 = yes, and trace3 = yes)
[h5_off, p5_off] = ttest2(std_dev_trace(:,10*Fs:10.5*Fs)',std_dev_trace(:,2:5*Fs-1)');
[h3_off, p3_off] = ttest2(std_dev_trace(:,10*Fs:10.5*Fs)',std_dev_trace(:,3*Fs:5*Fs-1)');

%Entire stimulation period compared to baseline
[h5_base_stim, p5_base_stim] = ttest2(std_dev_trace(:,5*Fs:10*Fs)',std_dev_trace(:,1:5*Fs-1)');

%Entire stim period compared to post
[h5_post_stim, p5_post_stim] = ttest2(std_dev_trace(:,5*Fs:10*Fs)',std_dev_trace(:,10*Fs+1:end)');

%entire stim period compared to base + post
[h5_base_post_stim, p5_base_post_stim] = ttest2(std_dev_trace(:,5*Fs:10*Fs)',std_dev_trace(:,[1:5*Fs-1,10*Fs+1:end])');
%% Plot the traces with color and style coded identification to determine best approach
figure;
% green if both onset agree
% red if onset disagree 
% solid line if offset agree
% dashed line if offset disagree
for i=1:num_neurons
%     if h3_on(i) == h5_on(i)
%         color = 'g';
%     else
%         color = 'r';
%     end
%     
%     if h3_off(i) == h5_off(i)
%         style = '-';
%     else
%         style = '--';
%     end
    if h5_post_stim(i) 
        color = 'g';
    else
        color = 'r';
    end
    style = '-';
 
    plot([1:num_frames],smooth_traces(i,:),[color, style]);
    set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:20]);
    yline(5); yline(10);
    title(['h5 on ' num2str(h5_on(i)) ', h3 on ' num2str(h3_on(i)) ', h5 off ' num2str(h5_off(i)) ', h3 off ' num2str(h3_off(i))]); 
    
    wait_input = input('Can we move on?: ','s');
    wait_input = str2double(num2cell(wait_input));
    wait_input(isnan(wait_input)) = [];
    if ~wait_input(wait_input<1)
        wait_input(wait_input<1) = [];
        close all
        break
    end
end

%% Try kmeans-clustering on good traces, check some random ones.
data=[];
for i=1:numel(z_140_s)
    data = [data; z_140_s{1,i}.trace];
end

k = 3; %We want positive, non, and negative modulation
% ========================= kmeans clustering ============================%
[IDX,C]=kmeans(data,k,'Replicates',100);

figure;
hold on;
plot([1:200],C(1,:));
plot([1:200],C(2,:));
plot([1:200],C(3,:));
plot([1:200],C(4,:));
plot([1:200],C(5,:));
plot([1:200],C(6,:));
title('Scaled 140Hz Neuron cluster avg trace');

figure;
% 
% figure;
% plot(C(:,1),C(:,2),'k.','MarkerSize',16);
% title(strcat('(k=',num2str(k),'), best of 100 replicates'));
% xlabel('Recording');
% ylabel('Cell Number');
% legend(legend_labels,'Location','northoutside');
% subplot(2,6,k+5);
% silhouette(data,IDX,'Euclidean');
% s=silhouette(data,IDX,'Euclidean');
% hold on;
% l=xline(mean(s,'omitnan'));
% set(l,'LineStyle','--','Color','r');
% title(strcat('Silhouette mean=',num2str(mean(s,'omitnan'))));

 