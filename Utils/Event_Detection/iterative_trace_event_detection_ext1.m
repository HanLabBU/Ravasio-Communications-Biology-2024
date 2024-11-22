function roi_list = iterative_trace_event_detection_ext1(roi_list, save_keyword, sample_freq)
% Hua-an Tseng, huaantseng at gmail
% To detect the event, run:
% 1. trace_event_detection
% 2. trace_event_remove_overlap
% 3. trace_waveform
% 4. trace_waveform_remove_empty
% Then you can use trace_event_plot to check the trace and the detected events.

% ext 1 - fixed std threshold during all iterations. Stop after 2
% iterations. Discard events with rise time >= 6 samples. Smooth trace
% prior to event detection


% sample_freq = 20;
% save_keyword = datestr(now,'yyyymmdd');
whole_tic = tic;

if nargin<3 || isempty(sample_freq)
    sample_freq = 20;
end

if nargin<2 || isempty(save_keyword)
    save_keyword = datestr(now,'yyyymmdd');
end

params.Fs = sample_freq;
params.tapers = [2 3];
std_threshold = 7;              % change this
window_size = 1;
pre_window = 2;
% [b,a] = butter(3,2*[0.02 9.9]/sample_freq,'bandpass');
% freqz(b,a)
for roi_idx= 1:numel(roi_list)
    fprintf(['ROI ',num2str(roi_idx),'/',num2str(numel(roi_list)),'\n']);
    whole_trace = roi_list(roi_idx).trace;
%   whole_trace = filter(b,a,whole_trace);
%   whole_trace = butter_bandpass_filter(whole_trace,0.02,9.9,20);
    x_axis = [1:numel(whole_trace)]/20;
    
    % smooth by a second
    whole_trace = movmean(whole_trace,20);
    
    [S,t,f]=mtspecgramc(whole_trace,[window_size 0.05],params);
    normalized_S = bsxfun(@minus, S, mean(S,1));
    normalized_S  = bsxfun(@rdivide, normalized_S , std(S,[],1));
    f_idx = find(f>=0 & f<=2);
    power=mean(normalized_S(:,f_idx),2);
    d_power=diff(power);
    
    
    up_power_idx_list = find(isoutlier(d_power,'median')); % All points igher than the median
    if ~isempty(up_power_idx_list)
        up_power_idx_list = [up_power_idx_list(1);up_power_idx_list(find(diff(up_power_idx_list)>1)+1)]; % segement disconnected lengths higher than median and get starting indices
        up_power_idx_list = up_power_idx_list(d_power(up_power_idx_list)>mean(d_power)); % Remove peaks that start below the mean
        
        %         up_threshold = mean(d_power)+std_threshold(1)*std(d_power);
        %
        %         up_power_idx_list = diff(sign(d_power-up_threshold));
        %         up_power_idx_list = find(up_power_idx_list>0);
        
        down_power_idx_list = ones(size(up_power_idx_list))*length(d_power);
        
        for up_power_idx=1:numel(up_power_idx_list)
            
            current_d_power = d_power(up_power_idx_list(up_power_idx):end);
            try
                down_power_idx_list(up_power_idx) = up_power_idx_list(up_power_idx)+find(current_d_power<=0,1,'first');
            catch
                down_power_idx_list(up_power_idx) = up_power_idx_list(up_power_idx);
            end
            
        end
        
        
        keepLooking = 1;
        passNum = 1;
        results = struct();
        std_threshold2 = std_threshold;
        pre_window2 = pre_window;
        max_fall = 4;
        
        event_time = [t(up_power_idx_list)' t(down_power_idx_list)'];
    %% loop 
        while keepLooking
            [event_amp, event_time ,event_idx,pre_event_threshold] = iterative_get_spikes(event_time,whole_trace,std_threshold2,pre_window2,sample_freq);

            % delete nan amplitude values
            pre_event_threshold(isnan(event_amp),:) = [];
            event_time(isnan(event_amp),:) = [];
            event_idx(isnan(event_amp),:) = [];
            event_amp(isnan(event_amp),:) = [];
            
            % delete events of rise time less than 3 samples
            pre_event_threshold(event_idx(:,2)-event_idx(:,1)<7,:) = [];
            event_time(event_idx(:,2)-event_idx(:,1)<7,:) = [];
            event_amp(event_idx(:,2)-event_idx(:,1)<7,:) = [];
            event_idx(event_idx(:,2)-event_idx(:,1)<7,:) = [];
            
            % save nextpass for event time
            event_time_next_pass = event_time(event_amp<pre_event_threshold,:);
            
            % delete events with amp less than pre event threshold
            event_time(event_amp<pre_event_threshold,:) = [];
            event_idx(event_amp<pre_event_threshold,:) = [];
            event_amp(event_amp<pre_event_threshold,:) = [];
            
            
            % event falls
            whole_trace2 = roi_list(roi_idx).trace;
            event_fall =  iterative_get_event_fall(event_idx,whole_trace2,max_fall);
            
            % for iteration
            if numel(event_amp) >0
                results(passNum).event_time = event_time;
                results(passNum).event_idx = event_idx;
                results(passNum).event_amp = event_amp;
                results(passNum).pre_event_threshold = pre_event_threshold;
                results(passNum).event_fall = event_fall;
                
                if passNum < 3
%                     std_threshold2 = std_threshold2*0.9;
                    pre_window2 = pre_window2*1.75;
                end
                
                passNum = passNum+1;
                event_time = event_time_next_pass;
                
                for Sidx = 1:size(event_idx,1)
%                 whole_trace(event_idx(Sidx,1):event_fall(Sidx,2)) = nan;
                  whole_trace(event_idx(Sidx,1):event_fall(Sidx,1)) = nan;
                end
                if passNum == 3
                    keepLooking = 0;
                end 
            else
                keepLooking = 0;
            end
            
        end
        
        event_time = [];
        event_idx = [];
        event_amp = [];
        event_fall = [];
        if ~isempty(fieldnames(results))
            for rr = 1:size(results,2)
                event_time = [event_time ; results(rr).event_time];
                event_idx = [event_idx ; results(rr).event_idx];
                event_amp = [event_amp ; results(rr).event_amp];
                event_fall = [event_fall ; results(rr).event_fall];
                [~,sort_idx] = sort(event_time(:,1));
            end
        else
            sort_idx = [];
        end

       
        % assign
        roi_list(roi_idx).event_time = event_time(sort_idx,:);
        roi_list(roi_idx).event_idx = event_idx(sort_idx,:);
        roi_list(roi_idx).event_amp = event_amp(sort_idx);
%         roi_list(roi_idx).event_fall = event_fall(sort_idx,:);
        
%         % plot
%         figure
%         plot(whole_trace)
%         vline(event_idx(:,1)','r')
%         hold on
%         vline(event_idx(:,2)','g')
% %         hold on
% %         vline(event_fall(:,1)','m')
% %         hold on
% %         vline(event_fall(:,2)','y')
    end
end

%     save(['trace_event_',save_keyword],'roi_list');
fprintf(['Total loading time: ',num2str(round(toc(whole_tic),2)),' seconds.\n']);

end


