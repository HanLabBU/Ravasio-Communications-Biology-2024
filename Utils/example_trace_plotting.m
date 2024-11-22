%% plot example traces individually (keep track of favorites)
Fs = 20;

trial_traces = squeeze(example_traces.hz40.non.M1.trial_traces{n,1});
offset = mean(trial_traces(1:5*Fs,:),1);
trial_traces = trial_traces-offset;

figure;
hold on
plot([1/Fs:1/Fs:20],trial_traces,'-','Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],mean(trial_traces,2),'r-');
xline(5);
xline(10);
title(['Neuron ' num2str(n)]);

n=n+1

%% Plot best 4 traces
figure;
subplot(2,2,1)
trial_traces = squeeze(example_traces.hz1000.non.M1.trial_traces{14,1});
offset = mean(trial_traces(1:5*Fs,:),1);
trial_traces = trial_traces-offset;
hold on
plot([1/Fs:1/Fs:20],trial_traces,'-','Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],mean(trial_traces,2),'r-');
xline(5);
xline(10);

subplot(2,2,2)
trial_traces = squeeze(example_traces.hz1000.non.M1.trial_traces{16,1});
offset = mean(trial_traces(1:5*Fs,:),1);
trial_traces = trial_traces-offset;
hold on
plot([1/Fs:1/Fs:20],trial_traces,'-','Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],mean(trial_traces,2),'r-');
xline(5);
xline(10);

subplot(2,2,3)
trial_traces = squeeze(example_traces.hz1000.non.M1.trial_traces{17,1});
offset = mean(trial_traces(1:5*Fs,:),1);
trial_traces = trial_traces-offset;
hold on
plot([1/Fs:1/Fs:20],trial_traces,'-','Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],mean(trial_traces,2),'r-');
xline(5);
xline(10);

subplot(2,2,4)
trial_traces = squeeze(example_traces.hz1000.non.M1.trial_traces{27,1});
offset = mean(trial_traces(1:5*Fs,:),1);
trial_traces = trial_traces-offset;
hold on
plot([1/Fs:1/Fs:20],trial_traces,'-','Color',[0.8 0.8 0.8]);
plot([1/Fs:1/Fs:20],mean(trial_traces,2),'r-');
xline(5);
xline(10);
