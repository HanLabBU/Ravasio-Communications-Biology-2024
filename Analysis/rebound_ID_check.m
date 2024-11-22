%quick rebound identity check
%% Setup
save_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/Good_Recordings_Data_Files';
Fs = 20; %Hz
region = 'CA1';

%% 40Hz
negID = 1;
nonID = 1;
for j=1:size(rebound_40_s.neurons,1)
    [Row1,Val1]=find(neg_mod_40_s.neurons(:,1)==rebound_40_s.neurons(j,1));
    [Row2,Val2]=find(neg_mod_40_s.neurons(:,2)==rebound_40_s.neurons(j,2));
    if sum(ismember(Row1,Row2))
        neg_reb_40_s.traces(negID,:) = rebound_40_s.traces(j,:);
        neg_reb_40_s.neurons(negID,:) = rebound_40_s.neurons(j,:);
        negID = negID + 1;
    else
        non_reb_40_s.traces(nonID,:) = rebound_40_s.traces(j,:); 
        non_reb_40_s.neurons(nonID,:) = rebound_40_s.neurons(j,:);
        nonID = nonID + 1;
    end
end
neg_reb_40_s.avg_trace = mean(neg_reb_40_s.traces,1);
non_reb_40_s.avg_trace = mean(non_reb_40_s.traces,1);
save(sprintf([save_path '/neg_reb_40_s.mat']),'neg_reb_40_s');
save(sprintf([save_path '/non_reb_40_s.mat']),'non_reb_40_s');

figure;
hold on
plot([1/Fs:1/Fs:20],neg_reb_40_s.traces, 'Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],neg_reb_40_s.avg_trace,'r-');
xline(5);
xline(10);
title(['Neg-Mod + Rebound 40Hz ' region]);
xlabel('Time (s)');
ylabel('F/F');
saveas(gcf,[save_path '/40_neg_reb_traces.fig'])

figure;
hold on
plot([1/Fs:1/Fs:20],non_reb_40_s.traces, 'Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],non_reb_40_s.avg_trace,'r-');
xline(5);
xline(10);
title(['Non-Mod + Rebound 40Hz ' region]);
xlabel('Time (s)');
ylabel('F/F');
saveas(gcf,[save_path '/40_non_reb_traces.fig'])

%% 140Hz
negID = 1;
nonID = 1;
for j=1:size(rebound_140_s.neurons,1)
    [Row1,Val1]=find(neg_mod_140_s.neurons(:,1)==rebound_140_s.neurons(j,1));
    [Row2,Val2]=find(neg_mod_140_s.neurons(:,2)==rebound_140_s.neurons(j,2));
    if sum(ismember(Row1,Row2))
        neg_reb_140_s.traces(negID,:) = rebound_140_s.traces(j,:);
        neg_reb_140_s.neurons(negID,:) = rebound_140_s.neurons(j,:);
        negID = negID + 1;
    else
        non_reb_140_s.traces(nonID,:) = rebound_140_s.traces(j,:); 
        non_reb_140_s.neurons(nonID,:) = rebound_140_s.neurons(j,:);
        nonID = nonID + 1;
    end
end
neg_reb_140_s.avg_trace = mean(neg_reb_140_s.traces,1);
non_reb_140_s.avg_trace = mean(non_reb_140_s.traces,1);
save(sprintf([save_path '/neg_reb_140_s.mat']),'neg_reb_140_s');
save(sprintf([save_path '/non_reb_140_s.mat']),'non_reb_140_s');

figure;
hold on
plot([1/Fs:1/Fs:20],neg_reb_140_s.traces, 'Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],neg_reb_140_s.avg_trace,'r-');
xline(5);
xline(10);
title(['Neg-Mod + Rebound 140Hz ' region]);
xlabel('Time (s)');
ylabel('F/F');
saveas(gcf,[save_path '/140_neg_reb_traces.fig'])

figure;
hold on
plot([1/Fs:1/Fs:20],non_reb_140_s.traces, 'Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],non_reb_140_s.avg_trace,'r-');
xline(5);
xline(10);
title(['Non-Mod + Rebound 140Hz ' region]);
xlabel('Time (s)');
ylabel('F/F');
saveas(gcf,[save_path '/140_non_reb_traces.fig'])

%% 100Hz
negID = 1;
nonID = 1;
for j=1:size(rebound_1000_s.neurons,1)
    [Row1,Val1]=find(neg_mod_1000_s.neurons(:,1)==rebound_1000_s.neurons(j,1));
    [Row2,Val2]=find(neg_mod_1000_s.neurons(:,2)==rebound_1000_s.neurons(j,2));
    if sum(ismember(Row1,Row2))
        neg_reb_1000_s.traces(negID,:) = rebound_1000_s.traces(j,:);
        neg_reb_1000_s.neurons(negID,:) = rebound_1000_s.neurons(j,:);
        negID = negID + 1;
    else
        non_reb_1000_s.traces(nonID,:) = rebound_1000_s.traces(j,:); 
        non_reb_1000_s.neurons(nonID,:) = rebound_1000_s.neurons(j,:);
        nonID = nonID + 1;
    end
end
neg_reb_1000_s.avg_trace = mean(neg_reb_1000_s.traces,1);
non_reb_1000_s.avg_trace = mean(non_reb_1000_s.traces,1);
save(sprintf([save_path '/neg_reb_1000_s.mat']),'neg_reb_1000_s');
save(sprintf([save_path '/non_reb_1000_s.mat']),'non_reb_1000_s');

figure;
hold on
plot([1/Fs:1/Fs:20],neg_reb_1000_s.traces, 'Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],neg_reb_1000_s.avg_trace,'r-');
xline(5);
xline(10);
title(['Neg-Mod + Rebound 1000Hz ' region]);
xlabel('Time (s)');
ylabel('F/F');
saveas(gcf,[save_path '/1000_neg_reb_traces.fig'])

figure;
hold on
plot([1/Fs:1/Fs:20],non_reb_1000_s.traces, 'Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],non_reb_1000_s.avg_trace,'r-');
xline(5);
xline(10);
title(['Non-Mod + Rebound 1000Hz ' region]);
xlabel('Time (s)');
ylabel('F/F');
saveas(gcf,[save_path '/1000_non_reb_traces.fig'])
