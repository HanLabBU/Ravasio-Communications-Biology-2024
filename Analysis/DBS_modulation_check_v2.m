% DBS_modulation_check_v2.m
% Author: Cara
% Date: 04/13/22
% Purpose: Identify which traces indicate neurons being positively-,
% negatively-, or not-modulated during stimulation, post-stimulation, and
% the first second of stimulation using the signrank output stats over all
% trials


function [pos_mod,neg_mod,non_mod,rebound] = DBS_modulation_check_v2(stats,z_data,freq,region,save_flag, Fs)
%inputs: stats, data, freq, save_flag, sampling_freq

% save_flag = 1 --> Save generated figures
% save_flag = 0 --> Do not save generated figures
try
    num_frames = size(z_data{1,1}.fluor_trace,2);
    num_sess = numel(z_data);
catch
    num_frames = size(z_data.fluor_trace,2);
    num_sess = 1;
end

%===== Stimulation (5-10s)/Rebound (10-15s) period used for significance ======%
pos_count = 0;
neg_count = 0;
non_count = 0;
reb_count = 0;

pos_mod.neurons = [];
pos_mod.traces = [];
pos_mod.trial_traces = {};

neg_mod.neurons = [];
neg_mod.traces = [];
neg_mod.trial_traces = {};

non_mod.neurons = [];
non_mod.traces = [];
non_mod.trial_traces = {};

rebound.neurons = [];
rebound.traces = [];
rebound.trial_traces = {};

if save_flag
    f1 = figure; hold on;
    f2 = figure; hold on;
    f3 = figure; hold on;
    f4 = figure; hold on;
end

 for i =1:num_sess
    try
    num_neurons = size(z_data{1,i}.fluor_trial_traces,1);
    for j = 1:num_neurons
        pos_flag = 0;
        
        % Is there a consistent modulation effect? Classify.
        pos_mean_check = (mean(z_data{1,i}.fluor_trace(j,5*Fs:10*Fs)) > mean(z_data{1,i}.fluor_trace(j,1:5*Fs-1)));
        pos_var_check = (var(z_data{1,i}.fluor_trace(j,5*Fs:7*Fs)) > var(z_data{1,i}.fluor_trace(j,3*Fs:5*Fs-1)));
        neg_mean_check = (mean(z_data{1,i}.fluor_trace(j,5*Fs:10*Fs)) < mean(z_data{1,i}.fluor_trace(j,1:5*Fs-1)));
        %neg_var_check = (var(z_data{1,i}.fluor_trace(j,5*Fs:10*Fs)) > var(z_data{1,i}.fluor_trace(j,1:5*Fs-1))); %removed because of evidence from example traces- 05/22/23 CRR
        
        if stats{1,i}.signrank_h(j,1) && pos_mean_check  %There is a significant increase starting at DBS onset
            pos_flag = 1;
            if save_flag
             figure(f1);plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]); 
            end
            pos_count = pos_count + 1;
            pos_mod.neurons = [pos_mod.neurons; i,j];
            pos_mod.traces = [pos_mod.traces; z_data{1,i}.fluor_trace(j,:)];
            pos_mod.trial_traces{1,pos_count} =  z_data{1,i}.fluor_trial_traces(j,:,:);
%             if pos_var_check
%                 if save_flag
%                  figure(f1);plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]); 
%                 end
%                 pos_count = pos_count + 1;
%                 pos_mod.neurons = [pos_mod.neurons; i,j];
%                 pos_mod.traces = [pos_mod.traces; z_data{1,i}.fluor_trace(j,:)];
%                 pos_mod.trial_traces{1,pos_count} =  z_data{1,i}.fluor_trial_traces(j,:,:);
%             else
%                 if save_flag
%                     figure(f3);plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
%                 end
%                 non_count = non_count + 1;
%                 non_mod.neurons = [non_mod.neurons; i,j];
%                 non_mod.traces = [non_mod.traces; z_data{1,i}.fluor_trace(j,:)];
%                 non_mod.trial_traces{1,non_count} =  z_data{1,i}.fluor_trial_traces(j,:,:);
%             end
        elseif stats{1,i}.signrank_h(j,1) && neg_mean_check %&& neg_var_check %There is a significatn decrease %removed variance check step becuase of evidence from example traces -05/22/23 CRR
            if save_flag
                figure(f2);plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
            end
            neg_count = neg_count + 1;
            neg_mod.neurons = [neg_mod.neurons; i,j];
            neg_mod.traces = [neg_mod.traces; z_data{1,i}.fluor_trace(j,:)];
            neg_mod.trial_traces{1,neg_count} =  z_data{1,i}.fluor_trial_traces(j,:,:);
            
        else
            if save_flag
                figure(f3);plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
            end
            non_count = non_count + 1;
            non_mod.neurons = [non_mod.neurons; i,j];
            non_mod.traces = [non_mod.traces; z_data{1,i}.fluor_trace(j,:)];
            non_mod.trial_traces{1,non_count} =  z_data{1,i}.fluor_trial_traces(j,:,:);
        end

        % - Rebound - %
        % classify each trial
        reb_mean_check = mean(z_data{1,i}.fluor_trace(j,10*Fs+1:15*Fs)) > mean(z_data{1,i}.fluor_trace(j,1:5*Fs-1));
        reb_var_check = var(z_data{1,i}.fluor_trace(j,10*Fs+1:12*Fs)) > var(z_data{1,i}.fluor_trace(j,8*Fs:10*Fs));
        if ~pos_flag && stats{1,i}.signrank_h(j,2) && reb_mean_check && reb_var_check
            if save_flag
                figure(f4);plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
            end
            reb_count = reb_count + 1;
            rebound.neurons = [rebound.neurons; i,j];
            rebound.traces = [rebound.traces; z_data{1,i}.fluor_trace(j,:)];
            rebound.trial_traces{1,reb_count} =  z_data{1,i}.fluor_trial_traces(j,:,:);
        end
    end
    catch
        num_neurons = size(z_data.fluor_trial_traces,1);
        for j = 1:num_neurons
            pos_flag = 0;

            % Is there a consistent modulation effect? Classify
            pos_mean_check = (mean(z_data.fluor_trace(j,5*Fs:10*Fs)) > mean(z_data.fluor_trace(j,1:5*Fs-1)));
            pos_var_check = (var(z_data.fluor_trace(j,5*Fs:7*Fs)) > var(z_data.fluor_trace(j,3*Fs:5*Fs-1)));
            neg_mean_check = (mean(z_data.fluor_trace(j,5*Fs:10*Fs)) < mean(z_data.fluor_trace(j,1:5*Fs-1)));
            neg_var_check = (var(z_data.fluor_trace(j,5*Fs:7*Fs)) > var(z_data.fluor_trace(j,3*Fs:5*Fs-1)));
            
            if stats.signrank_h(j,1) && pos_mean_check
                pos_flag = 1;
                if pos_var_check
                    if save_flag
                        figure(f1);plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                    end
                    pos_count = pos_count + 1;
                    pos_mod.neurons = [pos_mod.neurons; i,j];
                    pos_mod.traces = [pos_mod.traces; z_data.fluor_trace(j,:)];
                    pos_mod.trial_traces{1,pos_count} =  z_data.fluor_trial_traces(j,:,:);
                else
                    if save_flag
                        figure(f3);plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                    end
                    non_count = non_count + 1;
                    non_mod.neurons = [non_mod.neurons; i,j];
                    non_mod.traces = [non_mod.traces; z_data.fluor_trace(j,:)];
                    non_mod.trial_traces{1,pos_count} =  z_data.fluor_trial_traces(j,:,:);
                end
            elseif stats.signrank_h(j,1) && neg_mean_check && neg_var_check
                if save_flag
                    figure(f2);plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                end
                neg_count = neg_count + 1;
                neg_mod.neurons = [neg_mod.neurons; i,j];
                neg_mod.traces = [neg_mod.traces; z_data.fluor_trace(j,:)];
                neg_mod.trial_traces{1,neg_count} =  z_data.fluor_trial_traces(j,:,:);
                
            else
                if save_flag
                    figure(f3);plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                end
                non_count = non_count + 1;
                non_mod.neurons = [non_mod.neurons; i,j];
                non_mod.traces = [non_mod.traces; z_data.fluor_trace(j,:)];
                non_mod.trial_traces{1,non_count} =  z_data.fluor_trial_traces(j,:,:);
            end

            % - Rebound - %
            reb_mean_check = mean(z_data.fluor_trace(j,10*Fs+1:15*Fs)) > mean(z_data.fluor_trace(j,1:5*Fs-1));
            reb_var_check = var(z_data.fluor_trace(j,10*Fs+1:12*Fs)) > var(z_data.fluor_trace(j,8*Fs:10*Fs));
            if ~pos_flag && stats.signrank_h(j,2) && reb_mean_check && reb_var_check
                if save_flag
                    figure(f4);plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                end
                reb_count = reb_count + 1;
                rebound.neurons = [rebound.neurons; i,j];
                rebound.traces = [rebound.traces; z_data.fluor_trace(j,:)];
                rebound.trial_traces{1,reb_count} =  z_data.fluor_trial_traces(j,:,:);
            end
        end
    end
 end
pos_mod.avg_trace = mean(pos_mod.traces,1);
non_mod.avg_trace = mean(non_mod.traces,1);
neg_mod.avg_trace = mean(neg_mod.traces,1);
rebound.avg_trace = mean(rebound.traces,1);

 %overlay the average trace for each condidtion; add title, labels, etc.
 if save_flag
     figure(f1);plot([1:num_frames],mean(pos_mod.traces,1), 'r');
     xline(5*Fs,'Color','black','LineStyle','-');
     xline(10*Fs,'Color','black','LineStyle','-');
     title([num2str(freq) 'Hz ' region ' Pos-Mod Traces (n= ' num2str(pos_count) ')']);
     set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:20]);
     xlabel('df/f'); ylabel('Time (sec)');

     figure(f2);plot([1:num_frames],mean(neg_mod.traces,1), 'r');
     xline(5*Fs,'Color','black','LineStyle','-');
     xline(10*Fs,'Color','black','LineStyle','-');
     title([num2str(freq) 'Hz ' region ' Neg-Mod Traces (n= ' num2str(neg_count) ')']);
     set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:20]);
     xlabel('df/f'); ylabel('Time (sec)');

     figure(f3);plot([1:num_frames],mean(non_mod.traces,1), 'r');
     xline(5*Fs,'Color','black','LineStyle','-');
     xline(10*Fs,'Color','black','LineStyle','-');
     title([num2str(freq) 'Hz ' region ' Non-Mod Traces (n= ' num2str(non_count) ')']);
     set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:20]);
     xlabel('df/f'); ylabel('Time (sec)');

     figure(f4);plot([1:num_frames],mean(rebound.traces,1), 'r');
     xline(5*Fs,'Color','black','LineStyle','-');
     xline(10*Fs,'Color','black','LineStyle','-');
     title([num2str(freq) 'Hz ' region ' Rebound Traces (n= ' num2str(reb_count) ')']);
     set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:20]);
     xlabel('df/f'); ylabel('Time (sec)');

     saveas(f1,[sprintf('%d_%s_pos_mod_trace.fig',freq,region)]);
     saveas(f2,[sprintf('%d_%s_neg_mod_trace.fig',freq,region)]);
     saveas(f3,[sprintf('%d_%s_non_mod_trace.fig',freq,region)]);
     saveas(f4,[sprintf('%d_%s_reb_mod_trace.fig',freq,region)]);
 end
 
end