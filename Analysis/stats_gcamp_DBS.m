% stats_gcamp_DBS.m
% Date: 03/10/22
% Author: Cara Ravasio
%Purpose, to perform a two-tailed z-test (alpha<0.05, i.e. Z<>=+/-1.96).
% Inputs: 
%    trace = roi_data.avg_trace_minusBG_new;
%    trial_traces = roi_data.trace_minusBG_new_DN_reshaped;
%    Fs = 20; %Hz

function [stats,z] = stats_gcamp_DBS(trace,trial_traces,Fs)
    for i=1:size(trace,1) %number of neurons for the trace struct provided
        baseline = trace(i,2:5*Fs-1); %First 5 seconds of rec (exclude first frame)

       % Wilcoxon Signed-rank test =======================================%
           trial_baseline = trial_traces(i,1:5*Fs,:);
           [p(i,1),h(i,1)] = signrank(squeeze(mean(trial_baseline,2)),squeeze(mean(trial_traces(i,5*Fs+1:10*Fs,:),2))); %compare distribution of means
           [p(i,2),h(i,2)] = signrank(squeeze(mean(trial_baseline,2)),squeeze(mean(trial_traces(i,10*Fs+1:15*Fs,:),2)));
       
        % Z-Test =========================================================%
        % For comparing individual fluorescence values to the baseline
        % distribution in the average trace for a neuron. 
        % (Baseline dstribution is >30fr, so this is fine).
        baseline_avg = mean(baseline)*ones(size(trace(i,:)));
        z.fluor_trace(i,:) = trace(i,:);
        z.fluor_trial_traces(i,:,:) = trial_traces(i,:,:);
        z.signif_dF(i) = 2*std(baseline);
        z.trace(i,:) = (trace(i,:)-baseline_avg)/std(baseline);
        
%         % Characterizing the bump, silences, and rebounds ================%
%         signif=[]; activ_fr=[]; deact_fr=[]; num_frames =size(trace,2);
%         for frame = 2:num_frames %skip the first frame because of artifacts
%             if z.fluor_trace(i,frame) >= signif_dF(i)
%                 signif=[signif,1]; %concatenate a 1 for +significance
%                 if frame > 5*Fs 
%                     activ_fr = [activ_fr,frame];
%                 end
%             elseif z.fluor_trace(i,frame)<= -signif_dF(i)  
%                 signif=[signif,-1]; %concatenate a -1 for -significance
%                 if frame > 5*Fs
%                      deact_fr = [deact_fr,frame];
%                 end
%             else
%                 signif=[signif,0]; %concatenate a 0 for no significance
%             end
%         end
%         z.act_width(i) = numel(activ_fr); %activation width (s); convert from frames to seconds
%         z.deact_width(i) = numel(deact_fr); %deactivation width (s); convert from frames to second
%         if ~numel(activ_fr) %if there is no bump
%             z.lat(i) = nan; %latency (s); The 50th frame is stimulation onset; convert to seconds
%             max_activ = nan;
%             max_fr = nan;
%         else
%              z.lat(i) = (bump_fr(1)-5*Fs)/Fs; %latency (s); The 50th frame is stimulation onset; convert to seconds
%             [max_activ, max_fr] = max(z.trace(i,5*Fs:end)); %max of bump should be located between the 5th and 7th second
%             max_fr = 49 + max_fr; % shift by 49 frames because the 50th frame would be the first
%         end
%         [min_sil,min_fr] = min(z.trace(i,:));
%         z.max(i,:) = [max_activ, max_fr]; %maximum value, maximum frame
%         z.min(i,:) = [min_sil, min_fr]; %minimum value, minimum frame
% 
%         %Derivatives
%         stats.first_deriv(i,:) = gradient(trace(i,:),Fs);
%         stats.second_deriv(i,:) = gradient(stats.first_deriv(i,:),Fs);
        
    end
    
    % Wilcoxon Signed-Rank assignment ====================================%
    stats.signrank_p = p;
    stats.signrank_h = h;
    
    % T-Test =============================================================%
    % For comparing mean values of baseline, stimulation and
    % post-stmulation to each other. This is performed over all trials
    % to get a distribution of mean values. The trial sample sizes are
    % small so we must use a T-Test (paired/dependent T-test)
    
    %Setup the period means for each trial
    trial_baseline_avgs = mean(trial_traces(:,2:5*Fs-1,:),2);
    trial_stim_avgs = mean(trial_traces(:,5*Fs:10*Fs,:),2);
    trial_poststim_avgs = mean(trial_traces(:,10*Fs+1:end,:),2);
    
    [H_stim_tr, P_stim_tr, CI_stim_tr, STATS_stim_tr] = ttest2(trial_baseline_avgs, trial_stim_avgs);
    stats.h_stim_tr = H_stim_tr; stats.p_stim_tr = P_stim_tr; 
    stats.ci_stim_tr = CI_stim_tr; stats.stats_stim_tr = STATS_stim_tr;
    
    [H_poststim_tr, P_poststim_tr, CI_poststim_tr, STATS_poststim_tr] = ttest2(trial_baseline_avgs, trial_poststim_avgs);
    stats.h_poststim_tr = H_poststim_tr; stats.p_poststim_tr = P_poststim_tr;
    stats.ci_poststim_tr = CI_poststim_tr; stats.stats_poststim_tr = STATS_poststim_tr;
    
end