% DBS_modulation_check.m
% Author: Cara
% Date: 04/13/22
% Purpose: Identify which traces indicate neurons being positively-,
% negatively-, or not-modulated during stimulation, post-stimulation, and
% the first second of stimulation
%
% EDITED 08/09/22 modulation during stimulation is from 5-10s, rebound is
% from 10-15s.

function mod_info = DBS_modulation_check(z_data,freq,mod_flag,save_flag,Fs)
%inputs: data,freq, mod_flag, save_flag, sampling_freq
% mod_flag = 2 ---> rebound modulation
% mod_flag = 1 ---> positive mod
% mod_flag = 0 ---> non mod
% mod_flag = -1 --> negative mod
%
% save_flag = 1 --> Save generated figures
% save_flag = 0 --> Do not save generated figures
try
    num_frames = size(z_data{1,1}.trace,2);
catch
    num_frames = size(z_data.trace,2);
end

%===== Stimulation (5-10s)/Rebound (10-15s) period used for significance ======%
count=0;
avg_trace = zeros(1,20*Fs);
traces = [];
neurons=[];

f1 = figure;
hold on

if mod_flag == 1 || mod_flag ==-1
    f2=figure;
    hold on
    count2=0;
    avg_trace2 = zeros(1,20*Fs);
    traces2 = [];
    neurons2=[];
end

try
    for i =1:length(z_data)
        for j = 1:size(z_data{1,i}.fluor_trace,1)
            thresh = z_data{1,i}.signif_dF(j);
            temp_mean = mean(z_data{1,i}.fluor_trace(j,5*Fs:10*Fs));
            temp_var_pre = abs(var(z_data{1,i}.fluor_trace(j,2:5*Fs-1))); %Pre stimulation variance 5s (0,5s; ignore first frame artifact)
            temp_var_stim = abs(var(z_data{1,i}.fluor_trace(j,5*Fs:10*Fs))); % Stimulation variance 5s (5-10s)
            temp_var_post = abs(var(z_data{1,i}.fluor_trace(j,10*Fs+1:15*Fs)));%Post Stimulation rebound variance 5s (10-15s)
            
            % if the stimulation trace is generally significantly higher
            % or lower than baseline, plot the trace.
            %Negative Modulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if (mod_flag == -1)
                if (temp_mean <= -1*thresh) % If the calcium is negatively modulated, and the neuron is not recovering from an event before
                    if temp_var_pre<temp_var_stim %if variance of last 3sec of baseline is less than variance of the first 3sec of post-stim
                        %plots all trial-averaged neurons from all recordings in light grey
                        figure(f1);plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                        count = count+1;
                        neurons = [neurons; i,j];
                        traces = [traces; z_data{1,i}.fluor_trace(j,:)];
                        avg_trace = avg_trace + z_data{1,i}.fluor_trace(j,:);
                    elseif ~(temp_var_pre<temp_var_stim)
                        %plots all trial-averaged neurons from all recordings in light grey
                        figure(f2);plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                        count2 = count2+1;
                        neurons2 = [neurons2; i,j];
                        traces2 = [traces2; z_data{1,i}.fluor_trace(j,:)];
                        avg_trace2 = avg_trace2 + z_data{1,i}.fluor_trace(j,:);
                        
                    end
                end
            %Non Modulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            elseif (mod_flag == 0)
                if ~((temp_mean >= thresh && temp_var_pre<temp_var_stim) || (temp_mean <= -1*thresh && temp_var_pre<temp_var_stim))
                    %plots all trial-averaged neurons from all recordings in light grey
                    plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                    count = count+1;
                    neurons = [neurons; i,j];
                    traces = [traces; z_data{1,i}.fluor_trace(j,:)];
                    avg_trace = avg_trace + z_data{1,i}.fluor_trace(j,:);
                end
            %Positive Modulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            elseif (mod_flag == 1)
                if (temp_mean >= thresh)
                    if(temp_var_pre<temp_var_stim) %if variance of last 3sec of baseline is less than variance of the first 3sec of post-stim
                        %plots all trial-averaged neurons from all recordings in light grey
                        figure(f1);plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                        count = count+1;
                        neurons = [neurons; i,j];
                        traces = [traces; z_data{1,i}.fluor_trace(j,:)];
                        avg_trace = avg_trace + z_data{1,i}.fluor_trace(j,:);
                    elseif~(temp_var_pre<temp_var_stim)
                        %plots all trial-averaged neurons from all recordings in light grey
                        figure(f2);plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                        count2 = count2+1;
                        neurons2 = [neurons2; i,j];
                        traces2 = [traces2; z_data{1,i}.fluor_trace(j,:)];
                        avg_trace2 = avg_trace2 + z_data{1,i}.fluor_trace(j,:);
                        
                    end
                end
            %Rebound Modulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            elseif (mod_flag == 2)
                temp_mean_reb = mean(z_data{1,i}.fluor_trace(j,10*Fs+1:15*Fs));
                if (temp_mean_reb >= thresh && ~(temp_mean>=thresh) && temp_var_stim<temp_var_post) %If the rebound is above threshold and not a recovery from posmod (exclude any pos_mod neurons), and not starting to fire before post-stim
                    %plots all trial-averaged neurons from all recordings in light grey
                    plot([1:num_frames],z_data{1,i}.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                    count = count+1;
                    neurons = [neurons; i,j];
                    traces = [traces; z_data{1,i}.fluor_trace(j,:)];
                    avg_trace = avg_trace + z_data{1,i}.fluor_trace(j,:);
                end
            end
        end
    end
catch
    for j = 1:size(z_data.fluor_trace,1)
        thresh = z_data.signif_dF(j);
        temp_mean = mean(z_data.fluor_trace(j,5*Fs:10*Fs-1));
        temp_var_pre = abs(var(z_data.fluor_trace(j,2:5*Fs-1))); %5s prestim
        temp_var_stim = abs(var(z_data.fluor_trace(j,5*Fs:10*Fs))); %5sec stim
        temp_var_post = abs(var(z_data.fluor_trace(j,10*Fs+1:15*Fs)));%5sec post-stim

        % if the stimulation trace is generally significantly higher
        % or lower than baseline, plot the trace.
        %Negative Modulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (mod_flag == -1)
            if (temp_mean <= -1*thresh) % If the calcium is negatively modulated, and the neuron is not recovering from an event before
                if temp_var_pre<temp_var_stim %if variance of last 3sec of baseline is less than variance of the first 3sec of post-stim
                    %plots all trial-averaged neurons from all recordings in light grey
                    figure(f1);plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                    count = count+1;
                    neurons = [neurons; i,j];
                    traces = [traces; z_data.fluor_trace(j,:)];
                    avg_trace = avg_trace + z_data.fluor_trace(j,:);
                elseif ~(temp_var_pre<temp_var_stim)
                    %plots all trial-averaged neurons from all recordings in light grey
                    figure(f2);plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                    count2 = count2+1;
                    neurons2 = [neurons2; i,j];
                    traces2 = [traces2; z_data.fluor_trace(j,:)];
                    avg_trace2 = avg_trace2 + z_data.fluor_trace(j,:);
                end
            end
        %Non Modulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif (mod_flag == 0)
            if ~((temp_mean >= thresh && temp_var_pre) || (temp_mean <= -1*thresh && temp_var_pre))
                %plots all trial-averaged neurons from all recordings in light grey
                plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                count = count+1;
                neurons = [neurons; i,j];
                traces = [traces; z_data.fluor_trace(j,:)];
                avg_trace = avg_trace + z_data.fluor_trace(j,:);
            end
        %Positive Modulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif (mod_flag == 1)
            if (temp_mean >= thresh)
                if(temp_var_pre<temp_var_stim) %if variance of last 3sec of baseline is less than variance of the first 3sec of post-stim
                    %plots all trial-averaged neurons from all recordings in light grey
                    figure(f1);plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                    count = count+1;
                    neurons = [neurons; i,j];
                    traces = [traces; z_data.fluor_trace(j,:)];
                    avg_trace = avg_trace + z_data.fluor_trace(j,:);
                elseif~(temp_var_pre<temp_var_stim)
                    %plots all trial-averaged neurons from all recordings in light grey
                    figure(f2);plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                    count2 = count2+1;
                    neurons2 = [neurons2; i,j];
                    traces2 = [traces2; z_data.fluor_trace(j,:)];
                    avg_trace2 = avg_trace2 + z_data.fluor_trace(j,:);
                end
            end
        %Rebound Modulation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif (mod_flag == 2)
            temp_mean_reb = mean(z_data.fluor_trace(j,10*Fs+1:15*Fs));
            if (temp_mean_reb >= thresh && ~(temp_mean>=thresh) && temp_var_stim<temp_var_post) %If the rebound is above threshold and not a recovery from posmod (exclude any pos_mod neurons), and not starting to fire before post-stim
                %plots all trial-averaged neurons from all recordings in light grey
                plot([1:num_frames],z_data.fluor_trace(j,:), 'Color',[0.8 0.8 0.8]);
                count = count+1;
                neurons = [neurons; i,j];
                traces = [traces; z_data.fluor_trace(j,:)];
                avg_trace = avg_trace + z_data.fluor_trace(j,:);
            end
        end
    end
end

avg_trace = avg_trace/count;
thresh = 2*std(avg_trace(2:5*Fs-1));
figure(f1);plot([1:num_frames], avg_trace, 'r'); %Plot total avg tace in red
if ~isnan(thresh)
yline(thresh,'Color','red','LineStyle','--');
xline(5*Fs,'Color','black','LineStyle','-');
yline(-1*thresh,'Color','red','LineStyle','--');
xline(10*Fs,'Color','black','LineStyle','-');
end
set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:20]);
if (mod_flag == -1)
    title([sprintf('Sig neg mod %d Hz (%d cells) ',freq, count)]);
    if (save_flag == 1)
        saveas(gcf,[sprintf('%d_neg_mod_trace.fig',freq)]);
    end
    if count2
        avg_trace2 = avg_trace2/count2;
        thresh2 = 2*std(avg_trace2(2:5*Fs-1),'omitnan');
        figure(f2);plot([1:num_frames], avg_trace2, 'r'); %Plot total avg tace in red
        yline(thresh2,'Color','red','LineStyle','--');
        xline(5*Fs,'Color','black','LineStyle','-');
        yline(-1*thresh2,'Color','red','LineStyle','--');
        xline(10*Fs,'Color','black','LineStyle','-');
        set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:20]);
        title([sprintf('Rejected neg mod %d Hz (%d cells) ',freq, count2)]);
        if (save_flag == 1)
            saveas(gcf,[sprintf('%d_rejected_neg_mod_trace.fig',freq)]);
        end
    end
elseif (mod_flag == 0)
    title([sprintf('Sig non mod %d Hz (%d cells) ',freq, count)]);
    if (save_flag == 1)
        saveas(gcf,[sprintf('%d_non_mod_trace.fig',freq)]);
    end
elseif(mod_flag == 1)
    title([sprintf('Sig pos mod %d Hz (%d cells) ',freq, count)]);
    if (save_flag == 1)
        saveas(gcf,[sprintf('%d_pos_mod_trace.fig',freq)]);
    end
    if count2
        avg_trace2 = avg_trace2/count2;
        thresh2 = 2*std(avg_trace2(2:5*Fs-1),'omitnan');
        figure(f2);plot([1:num_frames], avg_trace2, 'r'); %Plot total avg tace in red
        yline(thresh2,'Color','red','LineStyle','--');
        xline(5*Fs,'Color','black','LineStyle','-');
        yline(-1*thresh2,'Color','red','LineStyle','--');
        xline(10*Fs,'Color','black','LineStyle','-');
        set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:20]);
        title([sprintf('Rejected pos mod %d Hz (%d cells) ',freq, count2)]);
        if (save_flag == 1)
            saveas(gcf,[sprintf('%d_rejected_pos_mod_trace.fig',freq)]);
        end
    end
elseif(mod_flag == 2)
    title([sprintf('Sig rebound %d Hz (%d cells) ',freq, count)]);
    if (save_flag == 1)
        saveas(gcf,[sprintf('%d_rebound_trace.fig',freq)]);
    end
end
mod_info.avg_trace = avg_trace;
mod_info.neurons = neurons;
mod_info.traces = traces;

end