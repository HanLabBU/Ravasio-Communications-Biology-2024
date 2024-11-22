% mouse_by_mouse_analysis
% Author: Cara R
% Date: 08/03/22
% Purpose: To analyze the mean +/- SEM traces for every mouse. Uses the
% data from DBS_modulation_check.m script. Basically just
% avg_trace_plusMinus_SEM.m with a ton of 'try' statements

Fs = 10;
rec_start = 0; %CHANGE THIS
rec_end = 0; %CHANGE THIS
mouse = 'C00047125';%CHANGE THIS
region = 'Hippocampus';%CHANGE THIS
mod = 'Pos';%CHANGE THIS
data = pos_mod_40;%CHANGE THIS
for i = rec_start:rec_end
    data_rec_40.trans.neurons = []; data_rec_40.trans.traces = [];
    data_rec_40.sust.neurons = []; data_rec_40.sust.traces = [];
    for j=1:size(data.trans.neurons,1)
        if data.trans.neurons(j,1) == i
            data_rec_40.trans.neurons = [data_rec_40.trans.neurons ; data.trans.neurons(j,:)];
            data_rec_40.trans.traces = [data_rec_40.trans.traces ; data.trans.traces(j,:)];
        end
    end
    for j=1:size(data.sust.neurons,1)
        if data.sust.neurons(j,1) == i
            data_rec_40.sust.neurons = [data_rec_40.sust.neurons ; data.sust.neurons(j,:)];
            data_rec_40.sust.traces = [data_rec_40.sust.traces ; data.sust.traces(j,:)];
        end
    end
    
end
data_rec_40.trans.avg_trace = mean(data_rec_40.trans.traces,1);
data_rec_40.sust.avg_trace = mean(data_rec_40.sust.traces,1);

data = pos_mod_140;%CHANGE THIS
rec_start = 0;%CHANGE THIS
rec_end = 0;%CHANGE THIS
for i = rec_start:rec_end
    data_rec_140.trans.neurons = []; data_rec_140.trans.traces = [];
    data_rec_140.sust.neurons = []; data_rec_140.sust.traces = [];
    for j=1:size(data.trans.neurons,1)
        if data.trans.neurons(j,1) == i
            data_rec_140.trans.neurons = [data_rec_140.trans.neurons ; data.trans.neurons(j,:)];
            data_rec_140.trans.traces = [data_rec_140.trans.traces ; data.trans.traces(j,:)];
        end
    end
    for j=1:size(data.sust.neurons,1)
        if data.sust.neurons(j,1) == i
            data_rec_140.sust.neurons = [data_rec_140.sust.neurons ; data.sust.neurons(j,:)];
            data_rec_140.sust.traces = [data_rec_140.sust.traces ; data.sust.traces(j,:)];
        end
    end
    
end
data_rec_140.trans.avg_trace = mean(data_rec_140.trans.traces,1);
data_rec_140.sust.avg_trace = mean(data_rec_140.sust.traces,1);

data = pos_mod_1000;   %CHANGE THIS
rec_start = 21;   %CHANGE THIS
rec_end = 23;   %CHANGE THIS
for i = rec_start:rec_end
    data_rec_1000.trans.neurons = []; data_rec_1000.trans.traces = [];
    data_rec_1000.sust.neurons = []; data_rec_1000.sust.traces = [];
    for j=1:size(data.trans.neurons,1)
        if data.trans.neurons(j,1) == i
            data_rec_1000.trans.neurons = [data_rec_1000.trans.neurons ; data.trans.neurons(j,:)];
            data_rec_1000.trans.traces = [data_rec_1000.trans.traces ; data.trans.traces(j,:)];
        end
    end
    for j=1:size(data.sust.neurons,1)
        if data.sust.neurons(j,1) == i
            data_rec_1000.sust.neurons = [data_rec_1000.sust.neurons ; data.sust.neurons(j,:)];
            data_rec_1000.sust.traces = [data_rec_1000.sust.traces ; data.sust.traces(j,:)];
        end
    end

end
data_rec_1000.trans.avg_trace = mean(data_rec_1000.trans.traces,1);
data_rec_1000.sust.avg_trace = mean(data_rec_1000.sust.traces,1);

%% Transient Figures
%========= 40Hz ======================================================%
try
    data_rec_40_temp = mean(data_rec_40.trans.traces(:,:),1);
    signif40 = std(data_rec_40.trans.avg_trace(2:5*Fs));
    baselineAvg40 = mean(data_rec_40.trans.avg_trace(2:5*Fs-1));
    sem40 = std(data_rec_40.trans.traces,1)./sqrt(size(data_rec_40.trans.neurons,1));
    curve1_40 = data_rec_40_temp + sem40;
    curve2_40 = data_rec_40_temp - sem40;
    %How to get the shaded region to work
    x = [2:20*Fs]; %remove first frame because of artifact
    x2_40 = [x, fliplr(x)];
    y2_40 = [curve1_40(2:end), fliplr(curve2_40(2:end))];
    num_40_neurons = size(data_rec_40.trans.traces,1);
catch
    signif40 = [];
    baselineAvg40 = [];
    sem40 = [];
    curve1_40 = [];
    curve2_40 = [];
    %How to get the shaded region to work
    x = [2:20*Fs]; %remove first frame because of artifact
    x2_40 = [x, fliplr(x)];
    y2_40 = [];
    num_40_neurons = 0;
end
%========= 140Hz =====================================================%
try
    data_rec_140_temp = data_rec_140.trans.avg_trace;
    signif140 = std(data_rec_140.trans.avg_trace(2:5*Fs));
    baselineAvg140 = mean(data_rec_140.trans.avg_trace(2:5*Fs-1));
    sem140 = std(data_rec_140.trans.traces,1)./sqrt(size(data_rec_140.trans.neurons,1));
    curve1_140 = data_rec_140_temp + sem140;
    curve2_140 = data_rec_140_temp - sem140;
    %How to get the shaded region to work
    x = [2:20*Fs]; %remove first frame because of artifact
    x2_140 = [x, fliplr(x)];
    y2_140 = [curve1_140(2:end), fliplr(curve2_140(2:end))];
    num_140_neurons = size(data_rec_140.trans.traces,1);
catch
    signif140 = [];
    baselineAvg140 = [];
    sem140 = [];
    curve1_140 = [];
    curve2_140 = [];
    %How to get the shaded region to work
    x = [2:20*Fs]; %remove first frame because of artifact
    x2_140 = [x, fliplr(x)];
    y2_140 = [];
    num_140_neurons = 0;
end

%========= 1000Hz ====================================================%
try
    data_rec_1000_temp = data_rec_1000.trans.avg_trace;
    signif1000 = std(data_rec_1000.trans.avg_trace(2:5*Fs));
    baselineAvg1000 = mean(data_rec_1000.trans.avg_trace(2:5*Fs-1));
    sem1000 = std(data_rec_1000.trans.traces,1)./sqrt(size(data_rec_1000.trans.neurons,1));
    curve1_1000 = data_rec_1000_temp + sem1000;
    curve2_1000 = data_rec_1000_temp - sem1000;
    %How to get the shaded region to work
    x = [2:20*Fs]; %remove first frame because of artifact
    x2_1000 = [x, fliplr(x)];
    y2_1000 = [curve1_1000(2:end), fliplr(curve2_1000(2:end))];
    num_1000_neurons = size(data_rec_1000.trans.traces,1);
catch
    signif1000 = [];
    baselineAvg1000 = [];
    sem1000 = [];
    curve1_1000 = [];
    curve2_1000 = [];
    %How to get the shaded region to work
    x = [2:20*Fs]; %remove first frame because of artifact
    x2_1000 = [x, fliplr(x)];
    y2_1000 = [];
    num_1000_neurons = 0;
end

min_y = min([curve2_40,curve2_140, curve2_1000])-1; %concatenate the min sem curves and find the overall min
max_y = max([curve1_40,curve1_140,curve1_1000])+1; %concatenate the max sem curves and find the overall max
if isempty(min_y)
    min_y = 0;
    max_y = 1;
end

figure;
try
    plot(x,data_rec_40.trans.avg_trace(2:end), 'b-', 'LineWidth', 1.5);
end
hold on;
try
    plot(x,data_rec_140.trans.avg_trace(2:end), 'r-', 'LineWidth', 1.5);
end
try
    plot(x,data_rec_1000.trans.avg_trace(2:end), 'g-', 'LineWidth', 1.5);
end

line([50 50],[min_y max_y],'Color','black','LineStyle','-'); %stim onset
line([100 100], [min_y max_y],'Color','black','LineStyle','-');%stim offset

h=fill([50,50,60,60], [min_y max_y max_y min_y],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

try
    line([1 20*Fs],[baselineAvg40+2*signif40 baselineAvg40+2*signif40],'Color','blue','LineStyle','-'); %40Hz significance max
    line([1 20*Fs], [baselineAvg40-2*signif40 baselineAvg40-2*signif40],'Color','blue','LineStyle','-');%40Hz significance min
end

try
    line([1 20*Fs],[baselineAvg140+2*signif140 baselineAvg140+2*signif140],'Color','red','LineStyle','-'); %140Hz significance max
    line([1 20*Fs], [baselineAvg140-2*signif140 baselineAvg140-2*signif140],'Color','red','LineStyle','-');%140Hz significance min
end

try
    line([1 20*Fs],[baselineAvg1000+2*signif1000 baselineAvg1000+2*signif1000],'Color','green','LineStyle','-'); %1000Hz significance max
    line([1 20*Fs], [baselineAvg1000-2*signif1000 baselineAvg1000-2*signif1000],'Color','green','LineStyle','-');%1000Hz significance min
end

try
    h = fill(x2_40,y2_40, 'b'); %shade in 40Hz sem area
    h.FaceAlpha = 0.25; %make 40Hz sem area transparent
end

try
    h = fill(x2_140,y2_140, 'r'); %shade in 140Hz sem area
    h.FaceAlpha = 0.25; %make 140Hz sem area transparent
end

try
    h = fill(x2_1000,y2_1000, 'g'); %shade in 1000Hz sem area
    h.FaceAlpha = 0.25; %make 1000Hz sem area transparent
end

%Define color array
colors = {'b','r','g'};
freq_ID = {'40Hz','140Hz','1000Hz'};
%Create legend labels
legend_labels = [];
for i = 1:length(freq_ID)
    legend_labels = [legend_labels, plot(nan,nan,colors{i},'DisplayName',freq_ID{i})];
end

title([mouse ' Transient ' mod '-Mod ' region ' (' num2str(num_40_neurons) ...
    '|' num2str(num_140_neurons) '|' num2str(num_1000_neurons) ' neurons)']);
set(gca,'XTick',[0:Fs:20*Fs],'XTickLabel',[0:20]); %relabel ticks for sec not frames
xlabel('Time (s)'); ylabel('\DeltaF/F');
ylim([min_y max_y]);
legend(legend_labels);
saveas(gcf,[mouse '_trans_' mod 'mod_' region '.fig']);
saveas(gcf,[mouse '_trans_' mod 'mod_'  region '.jpg']);

%% Sustained Figures
%========= 40Hz ======================================================%
try
    data_rec_40_temp = data_rec_40.sust.avg_trace;
    signif40 = std(data_rec_40.sust.avg_trace(2:5*Fs));
    baselineAvg40 = mean(data_rec_40.sust.avg_trace(2:5*Fs-1));
    sem40 = std(data_rec_40.sust.traces,1)./sqrt(size(data_rec_40.sust.neurons,1));
    curve1_40 = data_rec_40_temp + sem40;
    curve2_40 = data_rec_40_temp - sem40;
    x = [2:20*Fs];
    x2_40 = [x, fliplr(x)];
    y2_40 = [curve1_40(2:end), fliplr(curve2_40(2:end))];
    num_40_neurons = size(data_rec_40.sust.traces,1);
catch
    signif40 = [];
    baselineAvg40 = [];
    sem40 = [];
    curve1_40 = [];
    curve2_40 = [];
    %How to get the shaded region to work
    x = [2:20*Fs]; %remove first frame because of artifact
    x2_40 = [x, fliplr(x)];
    y2_40 = [];
    num_40_neurons = 0;
end
%========= 140Hz =====================================================%
try
    data_rec_140_temp = data_rec_140.sust.avg_trace;
    signif140 = std(data_rec_140.sust.avg_trace(2:5*Fs));
    baselineAvg140 = mean(data_rec_140.sust.avg_trace(2:5*Fs-1));
    sem140 = std(data_rec_140.sust.traces,1)./sqrt(size(data_rec_140.sust.neurons,1));
    curve1_140 = data_rec_140_temp + sem140;
    curve2_140 = data_rec_140_temp - sem140;
    x = [2:20*Fs];
    x2_140 = [x, fliplr(x)];
    y2_140 = [curve1_140(2:end), fliplr(curve2_140(2:end))];
    num_140_neurons = size(data_rec_140.sust.traces,1);
catch
    signif140 = [];
    baselineAvg140 = [];
    sem140 = [];
    curve1_140 = [];
    curve2_140 = [];
    %How to get the shaded region to work
    x = [2:20*Fs]; %remove first frame because of artifact
    x2_140 = [x, fliplr(x)];
    y2_140 = [];
    num_140_neurons = 0;
end

%========= 1000Hz ====================================================%
try
    data_rec_1000_temp = data_rec_1000.sust.avg_trace;
    signif1000 = std(data_rec_1000.sust.avg_trace(2:5*Fs));
    baselineAvg1000 = mean(data_rec_1000.sust.avg_trace(2:5*Fs-1));
    sem1000 = std(data_rec_1000.sust.traces,1)./sqrt(size(data_rec_1000.sust.neurons,1));
    curve1_1000 = data_rec_1000_temp + sem1000;
    curve2_1000 = data_rec_1000_temp - sem1000;
    x = [2:20*Fs];
    x2_1000 = [x, fliplr(x)];
    y2_1000 = [curve1_1000(2:end), fliplr(curve2_1000(2:end))];
    num_1000_neurons = size(data_rec_1000.sust.traces,1);
catch
    signif1000 = [];
    baselineAvg1000 = [];
    sem1000 = [];
    curve1_1000 = [];
    curve2_1000 = [];
    %How to get the shaded region to work
    x = [2:20*Fs]; %remove first frame because of artifact
    x2_1000 = [x, fliplr(x)];
    y2_1000 = [];
    num_1000_neurons = 0;
end

min_y = min([curve2_40,curve2_140,curve2_1000])-1; %concatenate the min sem curves and find the overall min
max_y = max([curve1_40,curve1_140,curve1_1000])+1; %concatenate the max sem curves and find the overall max
if isempty(min_y)
    min_y = 0;
    max_y = 1;
end

figure;
try
    plot(x,data_rec_40.sust.avg_trace(2:end), 'b-', 'LineWidth', 1.5);
end
hold on;
try
    plot(x,data_rec_140.sust.avg_trace(2:end), 'r-', 'LineWidth', 1.5);
end
try
    plot(x,data_rec_1000.sust.avg_trace(2:end), 'g-', 'LineWidth', 1.5);
end

line([50 50],[min_y max_y],'Color','black','LineStyle','-');
line([100 100], [min_y max_y],'Color','black','LineStyle','-');

h=fill([60,60,100,100], [min_y max_y max_y min_y],[0.5 0.5 0.5]);
h.FaceAlpha = 0.25;
h.EdgeColor = 'none';

try
    line([1 20*Fs],[baselineAvg40+2*signif40 baselineAvg40+2*signif40],'Color','blue','LineStyle','-'); %40Hz significance max
    line([1 20*Fs], [baselineAvg40-2*signif40 baselineAvg40-2*signif40],'Color','blue','LineStyle','-');%40Hz significance min
end

try
    line([1 20*Fs],[baselineAvg140+2*signif140 baselineAvg140+2*signif140],'Color','red','LineStyle','-'); %140Hz significance max
    line([1 20*Fs], [baselineAvg140-2*signif140 baselineAvg140-2*signif140],'Color','red','LineStyle','-');%140Hz significance min
end

try
    line([1 20*Fs],[baselineAvg1000+2*signif1000 baselineAvg1000+2*signif1000],'Color','green','LineStyle','-'); %1000Hz significance max
    line([1 20*Fs], [baselineAvg1000-2*signif1000 baselineAvg1000-2*signif1000],'Color','green','LineStyle','-');%1000Hz significance min
end

try
    h = fill(x2_40,y2_40, 'b'); %shade in 40Hz sem area
    h.FaceAlpha = 0.25; %make 40Hz sem area transparent
end

try
    h = fill(x2_140,y2_140, 'r'); %shade in 140Hz sem area
    h.FaceAlpha = 0.25; %make 140Hz sem area transparent
end

try
    h = fill(x2_1000,y2_1000, 'g'); %shade in 140Hz sem area
    h.FaceAlpha = 0.25; %make 140Hz sem area transparent
end

%Define color array
colors = {'b','r','g'};
freq_ID = {'40Hz','140Hz','1000Hz'};
%Create legend labels
legend_labels = [];
for i = 1:length(freq_ID)
    legend_labels = [legend_labels, plot(nan,nan,colors{i},'DisplayName',freq_ID{i})];
end


title([mouse ' Sustained ' mod '-Mod ' region ' (' num2str(num_40_neurons) ...
    '|' num2str(num_140_neurons) '|' num2str(num_1000_neurons) ' neurons)']);
set(gca,'XTick',[0:Fs:20*Fs],'XTickLabel',[0:20]);
xlabel('Time (s)'); ylabel('\DeltaF/F');
ylim([min_y max_y]);
legend(legend_labels);
saveas(gcf,[mouse '_sust_' mod 'mod_' region '.fig']);
saveas(gcf,[mouse '_sust_' mod 'mod_' region '.jpg']);