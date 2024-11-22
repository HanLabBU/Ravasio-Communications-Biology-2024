% DBS_GCaMP_reliability.m
% Author: Cara Ravasio
% Date: 06/21/22
% Purpose: Assess how often a given neuron is
% positively/negatively/non-modulated during a trial. 
% Over time, do the neurons become more/less reliable or do they stay the same?
%% Load roi_data
% uiopen('roi_data*');
% stim_freq = input("What is the stimulation frequency?");
function DBS_GCaMP_reliability(roi_data,stim_freq)
%% Classify neuron traces identities
%Find dimensions of interest
[num_neurons,num_frames, num_trials]=size(roi_data.trace_DN_reshaped(roi_data.goodIdx,:,:));
Fs = num_frames/20; %number of frames gathered in 20sec trial

%Classify neurons
traces = roi_data.trace_minusBG_new_DN_reshaped_scaled(roi_data.goodIdx,:,:);
baselines = traces(:,2:5*Fs-1,:);
baseline_avgs = mean(baselines,2);
baseline_stds = std(baselines,0,2);
z_traces = (traces-baseline_avgs)./(baseline_stds);

reliability_stim_mat = zeros(num_neurons,num_trials);
reliability_reb_mat = zeros(num_neurons,num_trials);
for i=1:num_neurons
    for j=1:num_trials
        if sum(z_traces(i,5*Fs:10*Fs,j)) >= 2*(10*Fs-5*Fs) %pos mod
            reliability_stim_mat(i,j) = 1;
        elseif sum(z_traces(i,5*Fs:10*Fs,j)) <= -2*(10*Fs-5*Fs) %neg mod
            reliability_stim_mat(i,j) = -1;
            if sum(z_traces(i,10*Fs:15*Fs,j)) >= 2*(15*Fs-10*Fs) % Rebound, exclude any pos_mod neurons
                reliability_reb_mat(i,j) = 1;
            else
                reliability_reb_mat(i,j) = 0;
            end
        else
            reliability_stim_mat(i,j) = 0; %nonmod
            if sum(z_traces(i,10*Fs:15*Fs,j)) >= 2*(15*Fs-10*Fs) % Rebound, exclude any pos_mod neurons
                reliability_reb_mat(i,j) = 1;
            else
                reliability_reb_mat(i,j) = 0;
            end
        end
        
    end
end

% [~,z_test_s] = stats_gcamp_DBS(reshape(permute(roi_data.trace_minusBG_new_DN_reshaped_scaled(roi_data.goodIdx,:,:),[3,1,2]),[num_neurons*num_trials,num_frames]),...
%                                roi_data.trace_minusBG_new_DN_reshaped_scaled(roi_data.goodIdx,:,:),Fs);

% pos_mod = DBS_modulation_check(z_test_s,stim_freq,1,0,Fs);
% non_mod = DBS_modulation_check(z_test_s,stim_freq,0,0,Fs);
% neg_mod = DBS_modulation_check(z_test_s,stim_freq,-1,0,Fs);
% rebound = DBS_modulation_check(z_test_s,stim_freq,2,0,Fs);
% 
% % Neuron classification for average traces
% [~, z_avg_s] = stats_gcamp_DBS(roi_data.avg_trace_minusBG_new_scaled(roi_data.goodIdx,:),roi_data.trace_minusBG_new_DN_reshaped_scaled(roi_data.goodIdx,:,:),Fs);
% pos_mod_avg = DBS_modulation_check(z_avg_s,stim_freq,1,0,Fs);
% non_mod_avg = DBS_modulation_check(z_avg_s,stim_freq,0,0,Fs);
% neg_mod_avg = DBS_modulation_check(z_avg_s,stim_freq,-1,0,Fs);
% rebound_avg = DBS_modulation_check(z_avg_s,stim_freq,2,0,Fs);


close all
%% Quantify reliability Matrices
% Reliability is how often a neurons was positively/negatively/non
% modulated over the course of all of the trials in a recording
% 
% reliability_stim_mat = zeros(num_neurons,num_trials);
% reliability_rebound_mat = zeros(num_neurons,num_trials);
% 
% %Stimulation reliability matrix
% temp = pos_mod.neurons;
% for i=1:size(temp,1)
%     reliability_stim_mat(temp(i,2),temp(i,1)) = 1;
% end
% temp = neg_mod.neurons;
% for i=1:size(temp,1)
%     reliability_stim_mat(temp(i,2),temp(i,1)) = -1;
% end
% 
% %Rebound reliability matrix
% temp = rebound.neurons;
% for i=1:size(temp,1)
%     reliability_rebound_mat(temp(i,2),temp(i,1)) = 1;
% end


%% Evaluate Reliability Scores

reliability_stim.pos = sum((reliability_stim_mat == 1),2)./num_trials; %sum along the second dimension and divide by the number of trials to identify reliability
reliability_stim.non = sum((reliability_stim_mat == 0),2)./num_trials;
reliability_stim.neg = sum((reliability_stim_mat == -1),2)./num_trials;

reliability_rebound.pos = sum((reliability_reb_mat == 1),2)./num_trials; %sum along the second dimension and divide by the number of trials to identify reliability
reliability_rebound.non = sum((reliability_reb_mat == 0),2)./num_trials;
reliability_rebound.neg = sum((reliability_reb_mat == -1),2)./num_trials;

%% Visualize Reliability

%Matrices
figure;
heatmap(reliability_stim_mat);
colormap(multigradient('preset', 'div.km.BuRd'));
caxis([-1 1]);
grid off
title('Stimulation Modulation')
xlabel('Trial');
ylabel('Neuron');

figure;
heatmap(reliability_reb_mat);
colormap(multigradient('preset', 'div.km.BuRd'));
caxis([-1 1]);
grid off
title('Rebound')
xlabel('Trial');
ylabel('Neuron');

%Reliability scores
figure;
heatmap(horzcat(reliability_stim.pos, reliability_stim.neg));
%heatmap(horzcat(reliability_sust.pos, reliability_sust.non, reliability_sust.neg))
%caxis([0,1]);
grid off
title('Stim Reliability');
ylabel('Neuron');
%xlabel('Reliability Positive | Non | Negative');
xlabel('Reliability Positive | Negative');

figure;
heatmap(horzcat(reliability_rebound.pos,reliability_rebound.neg))
%(horzcat(reliability_post.pos, reliability_post.non,reliability_post.neg))
%caxis([0,1]);
grid off
title('Rebound Reliability');
ylabel('Neuron');
%xlabel('Reliability Positive | Non | Negative');
xlabel('Reliability Positive | Negative');
end

