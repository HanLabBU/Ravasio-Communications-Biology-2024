% event_analysis.m
% Author: Cara
% Date: 05/25/23
% Purpose: To perform analysis on the average event shape, and rate for the
% 5s of baseline, 5s stimulation and 5s bins (x2) of post stimulation.

function [event_traces,event_counts, p, fwhm] = event_analysis(roi_list_final,pos_mod,neg_mod,non_mod,freq,region,color)
%% Setup
win = 100; Fs = 20;
base_event_trace = [];
DBS_event_trace = [];
post_1_event_trace = [];
post_2_event_trace = [];
num_sess = numel(roi_list_final);

%% Bin the identified events
% Keep track of the bin counts per session
running_neuron_count = 0;
mod_ID = []; %pos=1; neg=-1; non=0;
for i=1:numel(roi_list_final) % #sess
    last_base_count = 0; last_DBS_count = 0; last_post_count_1 = 0; last_post_count_2 = 0;
    base_count = 0; DBS_count = 0; post_count_1 = 0; post_count_2 = 0;
    for j=1:numel(roi_list_final(i).roi_list) % #neurons
        
        if ismember([i,j],pos_mod.neurons,'rows')
            mod_ID = [mod_ID, 1];
        elseif ismember([i,j],neg_mod.neurons,'rows')
            mod_ID = [mod_ID, -1];
        elseif ismember([i,j],non_mod.neurons,'rows')
            mod_ID = [mod_ID, 0];
        end
        
        neuron_base_count = 0;
        neuron_DBS_count = 0;
        neuron_post_count_1 = 0;
        neuron_post_count_2 = 0;
        for k=1:numel(roi_list_final(i).roi_list{1,j}) % #trials
            for n=1:numel(roi_list_final(i).roi_list{1,j}(k).event_amp) % #events
                event_time = roi_list_final(i).roi_list{1,j}(k).event_time(n,:);
                if mean(event_time) < 5
                    if mean(event_time)> 2
                        base_count = base_count +1;
                        neuron_base_count = neuron_base_count +1;
                        try
                            base_event_trace = vertcat(base_event_trace, roi_list_final(i).roi_list{1,j}(k).trace(event_time(2)*Fs-win:event_time(2)*Fs+win));
                        catch
                            temp = NaN*ones(1,201);
                            trace_end = numel(roi_list_final(i).roi_list{1,j}(k).trace(1:(event_time(2)*Fs+win)));
                            temp(end-trace_end+1:end) = roi_list_final(i).roi_list{1,j}(k).trace(1:(event_time(2)*Fs+win)); % pad with NaNs
                            base_event_trace = vertcat(base_event_trace, temp);
                        end
                    end
                elseif mean(event_time) < 10
                    DBS_count = DBS_count +1;
                    neuron_DBS_count = neuron_DBS_count +1;
                    DBS_event_trace = vertcat(DBS_event_trace, roi_list_final(i).roi_list{1,j}(k).trace(event_time(2)*Fs-win:event_time(2)*Fs+win));
                else
                    if mean(event_time) < 15
                        post_count_1 = post_count_1 + 1;
                        neuron_post_count_1 = neuron_post_count_1 +1;
                        try
                            post_1_event_trace = vertcat(post_1_event_trace, roi_list_final(i).roi_list{1,j}(k).trace(event_time(2)*Fs-win:event_time(2)*Fs+win));
                        catch
                            temp = NaN*ones(1,201);
                            trace_end = numel(roi_list_final(i).roi_list{1,j}(k).trace((event_time(2)*Fs-win):end));
                            temp(1:trace_end) = roi_list_final(i).roi_list{1,j}(k).trace((event_time(2)*Fs-win):end); % pad with NaNs
                            post_1_event_trace = vertcat(post_1_event_trace, temp);
                        end
                    else
                        post_count_2 = post_count_2 +1;
                        neuron_post_count_2 = neuron_post_count_2 +1;
                        try
                            post_2_event_trace = vertcat(post_2_event_trace, roi_list_final(i).roi_list{1,j}(k).trace(event_time(2)*Fs-win:event_time(2)*Fs+win));
                        catch
                            temp = NaN*ones(1,201);
                            trace_end = numel(roi_list_final(i).roi_list{1,j}(k).trace((event_time(2)*Fs-win):end));
                            temp(1:trace_end) = roi_list_final(i).roi_list{1,j}(k).trace((event_time(2)*Fs-win):end); % pad with NaNs
                            post_2_event_trace = vertcat(post_2_event_trace, temp);
                        end
                    end

                end
            end
        end
        num_trials = numel(roi_list_final(i).roi_list{1,j});
        idx = running_neuron_count+j;
        
        if neuron_base_count < 2 %~neuron_base_count
            neuron_avg_base_trace(idx,:) = NaN*ones(1,201);
        else
            neuron_avg_base_trace(idx,:) = mean(base_event_trace(last_base_count+1:end,:),1,'omitnan'); %average across all events from this neuron
        end
        neuron_avg_base_count(idx) = neuron_base_count/num_trials;
        
        if neuron_DBS_count < 2 %~neuron_base_count
            neuron_avg_DBS_trace(idx,:) = NaN*ones(1,201);
        else
            neuron_avg_DBS_trace(idx,:) = mean(DBS_event_trace(last_DBS_count+1:end,:),1,'omitnan'); %average across all events fro this neuron
        end
        neuron_avg_DBS_count(idx) = neuron_DBS_count/num_trials;
        
        if ~neuron_post_count_1
            neuron_avg_post_1_trace(idx,:) = NaN*ones(1,201);
        else
            neuron_avg_post_1_trace(idx,:) = mean(post_1_event_trace(last_post_count_1+1:end,:),1,'omitnan'); %average across all events fro this neuron
        end
        neuron_avg_post_1_count(idx) = neuron_post_count_1/num_trials;
        
        if ~neuron_post_count_2
            neuron_avg_post_2_trace(idx,:) = NaN*ones(1,201);
        else
            neuron_avg_post_2_trace(idx,:) = mean(post_2_event_trace(last_post_count_2+1:end,:),1,'omitnan'); %average across all events fro this neuron
        end
        neuron_avg_post_2_count(idx) = neuron_post_count_2/num_trials;
        
        last_base_count = last_base_count + neuron_base_count;
        last_DBS_count = last_DBS_count + neuron_DBS_count;
        last_post_count_1 = last_post_count_1 + neuron_post_count_1;
        last_post_count_2 = last_post_count_2 + neuron_post_count_2;
    end
    running_neuron_count = running_neuron_count + numel(roi_list_final(i).roi_list);
    num_neurons(i) = numel(roi_list_final(i).roi_list);
    sess_base_cnts(i) = base_count;
    sess_DBS_cnts(i) = DBS_count;
    sess_post_1_cnts(i) = post_count_1;
    sess_post_2_cnts(i) = post_count_2;
end
event_traces.base = base_event_trace;
event_traces.DBS = DBS_event_trace;
event_traces.post_1 = post_1_event_trace;
event_traces.post_2 = post_2_event_trace;
event_traces.neuron_avg.base = neuron_avg_base_trace;
event_traces.neuron_avg.DBS = neuron_avg_DBS_trace;
event_traces.neuron_avg.post_1 = neuron_avg_post_1_trace;
event_traces.neuron_avg.post_2 = neuron_avg_post_2_trace;
event_counts.base = base_count./num_neurons;
event_counts.DBS = DBS_count./num_neurons;
event_counts.post_1 = post_count_1./num_neurons;
event_counts.post_2 = post_count_2./num_neurons;
event_counts.neuron_avg.base = neuron_avg_base_count;
event_counts.neuron_avg.DBS = neuron_avg_DBS_count;
event_counts.neuron_avg.post_1 = neuron_avg_post_1_count;
event_counts.neuron_avg.post_2 = neuron_avg_post_2_count;
event_counts.sess.base = sess_base_cnts./num_neurons;
event_counts.sess.DBS = sess_DBS_cnts./num_neurons;
event_counts.sess.post_1 = sess_post_1_cnts./num_neurons;
event_counts.sess.post_2 = sess_post_2_cnts./num_neurons;
event_counts.sess.all_events = (sess_base_cnts + sess_DBS_cnts + sess_post_1_cnts + sess_post_2_cnts)./num_neurons;

%% Signrank on event rates for each bin comparison
p.count =signrank(sess_base_cnts./num_neurons, sess_DBS_cnts./num_neurons);

%Visualize event count changes
% box_data = [sess_base_cnts./num_neurons; sess_DBS_cnts./num_neurons];
% f = figure;
% ax = axes(f);
% hold on
% line(repmat([1:2],num_sess,1)',box_data,'Color',[0.8 0.8 0.8]);
% boxplot(box_data','Colors',color,'Symbol','k.','OutlierSize',10);
% plot(ax,repmat([1:2],num_sess,1),box_data','.','MarkerSize',18,'Color',color);
% ylabel('Binned Event Counts/neuron'); xlabel('Baseline  |  DBS');
% lims_x = xlim; lims_y = ylim;
% text(lims_x(2)-2,lims_y(2),['Significance: ' num2str(p.count)],'FontSize',12);
% title([num2str(freq) 'Hz ' region ' Event count changes (Session Wise n = ' num2str(num_sess) ')']);
% saveas(gcf,[num2str(freq) 'Hz_' region '_eventRatePlot.fig']);

%% Analyze Full-Width at Half-Maximum for events
% Find FWHM
fwhm = run_find_fwhm_transient_Ca_events(event_traces.neuron_avg);

% Determine significance using sign rank
p.fwhm = signrank(fwhm.base,fwhm.DBS);

% Display FWHM in violin plots
%Violin Plot of all neurons
vcolor = [0.8,0.8,0.8; color]; %baseline is gray, DBS is color (determined by stim freq and region)
% figure
% v = violinplot([fwhm.base',fwhm.DBS'],{'Baseline','DBS'},'ViolinColor',vcolor);
% title([num2str(freq) 'Hz ' region ' Calcium Event FWHM Violin (all events)']);

%violin plot that only shows neurons that were used for signrank
mask = ~(isnan(fwhm.base) | isnan(fwhm.DBS)); %create a binary mask where NaN entries cause a neuron to be excluded (0), else ignore (1)
violin_mat = mask'.*[fwhm.base',fwhm.DBS']; %convert all 0s to NaN so they won't be used in the violin
violin_mat(violin_mat == 0) = NaN;
figure;
v_ex = violinplot(violin_mat,{'Baseline','DBS'},'ViolinColor',vcolor,'ShowData',false,'ViolinAlpha',1);
title([num2str(freq) 'Hz ' region ' Calcium Event FWHM Violin (only events used in signrank, n = ' num2str(sum(mask)) ')']);
saveas(gcf,['event_FWHM_violin_' num2str(freq) 'Hz_' region '.fig']);

% Violin plot with only neurons used in signrank but showing the difference
% between fwhm instead of two distrbutions
figure;
diff_mat = minus(violin_mat(:,2),violin_mat(:,1));
p.fwhm_diff = signrank(diff_mat);
vd = violinplot(diff_mat,{'DBS-Baseline'},'ViolinColor',vcolor(2,:),'ShowData',false,'ViolinAlpha',1);
yline(0,'Color','k')
title([num2str(freq) 'Hz ' region ' Calcium Event Difference in FWHM Violin (only events used in signrank, n = ' num2str(sum(mask)) ')']);
saveas(gcf,['event_FWHM_diff_violin_' num2str(freq) 'Hz_' region '.fig']);

% %box plot version
% f=figure;
% ax = axes(f);
% b_ex = boxplot(violin_mat,[1 2],'Labels',{'Baseline','DBS'},'colors',vcolor, 'OutlierSize', 6,'Symbol', '.k');
% title(ax,[num2str(freq) 'Hz ' region ' Calcium Event FWHM Box (only events used in signrank, n = ' num2str(sum(mask)) ')']);
% saveas(gcf,['event_FWHM_box_' num2str(freq) 'Hz_' region '.fig']);

%scatter plot (broken down by mod_ID)
f = figure;
ax = axes(f);
plot(fwhm.base(mod_ID == 0),fwhm.DBS(mod_ID == 0),'k.','MarkerSize',14);
hold on
plot(fwhm.base(mod_ID == -1),fwhm.DBS(mod_ID == -1),'b.','MarkerSize',14);
plot(fwhm.base(mod_ID == 1),fwhm.DBS(mod_ID == 1),'r.','MarkerSize',14);
xl = xlim;
yl = ylim;
maxim = max(horzcat(xl,yl));
xlim([0,maxim]); ylim([0,maxim]);
line([0 maxim],[0 maxim],'Color','b');
xlabel('base FWHM'); ylabel('DBS FWHM');
legend({'not modulated','inhibited','activated','1:1 line'});
title(ax,[num2str(freq) 'Hz ' region ' Calcium Event FWHM Scatter (only events used in signrank, n = ' num2str(sum(mask)) ')']);
saveas(gcf,['event_FWHM_scatter_' num2str(freq) 'Hz_' region '.fig']);

%% Avg event shape +/- STD
 
if strcmp(region, 'CA1')
    line_style = '-';
else
    line_style = '-'; %'--'; %editing in illustrator is easier with solid lines
end
neuron_avg_base_trace = mask'.*neuron_avg_base_trace; %08/02/23 Added this line to exclude neurons not used in signrank
neuron_avg_base_trace(neuron_avg_base_trace == 0) = NaN; %08/02/23 
std_base = std(neuron_avg_base_trace,0,1,'omitnan');
curve1_base = mean(neuron_avg_base_trace,1,'omitnan') + std_base;
curve2_base = mean(neuron_avg_base_trace,1,'omitnan') - std_base;
x = [1:201];
x2_base = [x, fliplr(x)];
y2_base = [curve1_base(1:end), fliplr(curve2_base(1:end))];

neuron_avg_DBS_trace = mask'.*neuron_avg_DBS_trace; %08/02/23 Added this line to exclude neurons not used in signrank
neuron_avg_DBS_trace(neuron_avg_DBS_trace == 0) = NaN; %08/02/23 
std_DBS = std(neuron_avg_DBS_trace,0,1,'omitnan');
curve1_DBS = mean(neuron_avg_DBS_trace,1,'omitnan') + std_DBS;
curve2_DBS = mean(neuron_avg_DBS_trace,1,'omitnan') - std_DBS;
x = [1:201];
x2_DBS = [x, fliplr(x)];
y2_DBS = [curve1_DBS(1:end), fliplr(curve2_DBS(1:end))];

figure;
hold on
plot(x,mean(neuron_avg_base_trace,1,'omitnan'),'Color',[0.7 0.7 0.7],'LineStyle',line_style);
plot(x,mean(neuron_avg_DBS_trace,1,'omitnan'),'Color', color,'LineStyle',line_style);
h = fill(x2_base,y2_base, [0.7 0.7 0.7],'LineStyle','none'); %fill in area
h.FaceAlpha = 0.25; %make area transparent
h = fill(x2_DBS,y2_DBS, color,'LineStyle','none'); %fill in area
h.FaceAlpha = 0.25; %make area transparent
ylim([0.25 0.8]);
lims_x = xlim; lims_y = ylim;
text(lims_x(2)-200,lims_y(2),['Significance: ' num2str(p.fwhm)],'FontSize',12);
title(['Avg Event Shape +/- std (' num2str(freq) 'Hz ' region ')']);
legend({'Baseline', 'DBS'})
xlabel('frames'); ylabel('df/f');
saveas(gcf,['event_shape_' num2str(freq),'_' region '.fig']);

%% Analyze Peak height for events
% Find pkht
pkht = run_find_pkht_transient_Ca_events(event_traces.neuron_avg);

% Determine significance using sign rank
%p.pkht = signrank(pkht.base,pkht.DBS);
p.pkht = signrank(pkht.post_2,pkht.DBS);

% Display pkht in violin plots
%Violin Plot of all neurons
vcolor = [0.8,0.8,0.8; color]; %baseline is gray, DBS is color (determined by stim freq and region)
% figure
% v = violinplot([pkht.base',pkht.DBS'],{'Baseline','DBS'},'ViolinColor',vcolor);
% title([num2str(freq) 'Hz ' region ' Calcium Event FWHM Violin (all events)']);

%violin plot that only shows neurons that were used for signrank
% mask = ~(isnan(pkht.base) | isnan(pkht.DBS)); %create a binary mask where NaN entries cause a neuron to be excluded (0), else ignore (1)
% violin_mat = mask'.*[pkht.base',pkht.DBS']; %convert all 0s to NaN so they won't be used in the violin
% mask = ~(isnan(pkht.post_2) | isnan(pkht.DBS)); %create a binary mask where NaN entries cause a neuron to be excluded (0), else ignore (1)
% violin_mat = mask'.*[pkht.post_2',pkht.DBS']; %convert all 0s to NaN so they won't be used in the violin
% violin_mat(violin_mat == 0) = NaN;
% figure;
% % v_pk = violinplot(violin_mat,{'Baseline','DBS'},'ViolinColor',vcolor,'ShowData',false,'ViolinAlpha',1);
% v_pk = violinplot(violin_mat,{'Post','DBS'},'ViolinColor',vcolor,'ShowData',false,'ViolinAlpha',1);
% title([num2str(freq) 'Hz ' region ' Calcium Event Peak Height Violin (only events used in signrank, n = ' num2str(sum(mask)) ')']);
% saveas(gcf,['event_pkht_violin_' num2str(freq) 'Hz_' region '.fig']);

end