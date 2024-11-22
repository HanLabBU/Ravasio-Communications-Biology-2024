% avg_trace_plusMinus_std.m
% Author: Cara
% Date: 05/16/23
% Purpose: same as avg_trace_plusMinus_SEM but uses std dev instead.

function avg_trace_plusMinus_std(data40,data140,data1000, mod, region, rebound_flag, Fs, colors)
    % data40, data140, and data1000 are output structs from DBS_Modulation_Check
    % 40Hz is in BLUE, 140Hz is in RED, 1000Hz is in GREEN throughout.
    % mod is a str "Pos","Non", or "Neg"
    % region is a str and should be either "Hippocampus" or "Motor Cortex"
    % rebound_flag is 0 for Acute response and 1 for Rebound response
    % Fs = 20; %Hz
    % colors = [40Hz_rgb', 140Hz_rgb', 100Hz_rgb']; Each column is the RGB
    % matrix for that frequency.
    
    %Ex: avg_trace_plusMinus_std(pos_mod_40, pos_mod_140, pos_mod_1000,'Pos', 'Hippocampus', 0, 20, colors);
    
color_40 = colors(1,:);
color_140 = colors(2,:);
color_1000 = colors(3,:);

if ~rebound_flag
    %% Acute Response Classification
    %========= 40Hz ======================================================%
    num_40_neurons = size(data40.neurons,1);
    data40_temp = data40.avg_trace;
    signif40 = std(data40.avg_trace(2:5*Fs));
    baselineAvg40 = mean(data40.avg_trace(2:5*Fs-1));
    std40 = std(data40.traces,1);
    curve1_40 = data40_temp + std40;
    curve2_40 = data40_temp - std40;
    x = [2:20*Fs];
    x2_40 = [x, fliplr(x)];
    y2_40 = [curve1_40(2:end), fliplr(curve2_40(2:end))];
    
    %========= 140Hz =====================================================%
    num_140_neurons = size(data140.neurons,1);
    data140_temp = data140.avg_trace;
    signif140 = std(data140.avg_trace(2:5*Fs));
    baselineAvg140 = mean(data140.avg_trace(2:5*Fs-1));
    std140 = std(data140.traces,1);
    curve1_140 = data140_temp + std140;
    curve2_140 = data140_temp - std140;
    x = [2:20*Fs];
    x2_140 = [x, fliplr(x)];
    y2_140 = [curve1_140(2:end), fliplr(curve2_140(2:end))];
    
    %========= 1000Hz ====================================================%
    num_1000_neurons = size(data1000.neurons,1);
    data1000_temp = data1000.avg_trace;
    signif1000 = std(data1000.avg_trace(2:5*Fs));
    baselineAvg1000 = mean(data1000.avg_trace(2:5*Fs-1));
    std1000 = std(data1000.traces,1);
    curve1_1000 = data1000_temp + std1000;
    curve2_1000 = data1000_temp - std1000;
    x = [2:20*Fs];
    x2_1000 = [x, fliplr(x)];
    y2_1000 = [curve1_1000(2:end), fliplr(curve2_1000(2:end))];
    
    % Plot Figure     
    figure; 
    plot(x,data40.avg_trace(2:end), '-','Color',color_40, 'LineWidth', 1.5); 
    hold on;
    plot(x,data140.avg_trace(2:end), '-','Color',color_140, 'LineWidth', 1.5);
    plot(x,data1000.avg_trace(2:end), '-','Color',color_1000, 'LineWidth', 1.5);
    
    yline(baselineAvg40+2*signif40,'Color',color_40,'LineStyle','-'); %40Hz significance max
    yline(baselineAvg40-2*signif40,'Color',color_40,'LineStyle','-'); %40Hz significance max

    yline(baselineAvg140+2*signif140,'Color',color_140,'LineStyle','-'); %140Hz significance max
    yline(baselineAvg140-2*signif140,'Color',color_140,'LineStyle','-'); %140Hz significance max

    yline(baselineAvg1000+2*signif1000,'Color',color_1000,'LineStyle','-'); %1000Hz significance max
    yline(baselineAvg1000-2*signif1000,'Color',color_1000,'LineStyle','-'); %1000Hz significance max
    
    h = fill(x2_40,y2_40, color_40,'LineStyle','none'); %shade in 40Hz std area
    h.FaceAlpha = 0.25; %make 40Hz std area transparent
    
    h = fill(x2_140,y2_140, color_140,'LineStyle','none'); %shade in 140Hz std area
    h.FaceAlpha = 0.25; %make 140Hz std area transparent
    
    h = fill(x2_1000,y2_1000, color_1000,'LineStyle','none'); %shade in 140Hz std area
    h.FaceAlpha = 0.25; %make 140Hz std area transparent
    
    xline(5*Fs,'Color','black','LineStyle','-');
    xline(10*Fs,'Color','black','LineStyle','-');
    if strcmp(mod,'Scaled Pos')
        yl(1) = -0.02; yl(2) = 0.14;
    elseif strcmp(mod,'Scaled Neg')
        yl(1) = -0.12; yl(2) = 0.04;
    else %non-mod case
        yl=ylim;
    end
    h=fill([5*Fs,5*Fs,10*Fs,10*Fs], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
    h.FaceAlpha = 0.25;
    h.EdgeColor = 'none';
    
    title(['Stimulation ' mod '-Mod ' region]);
    set(gca,'XTick',[0:Fs:20*Fs],'XTickLabel',[0:20]);
    xlabel('Time (s)'); ylabel('\DeltaF/F');
    ylim([yl(1) yl(2)]);
    legend({['40Hz (', num2str(num_40_neurons),' neurons)'],...
            ['140Hz (', num2str(num_140_neurons),' neurons)'],...
            ['1000Hz (', num2str(num_1000_neurons),' neurons)']});
    saveas(gcf,['stim_' mod 'mod_' region 'std.fig']);
    saveas(gcf,['stim_' mod 'mod_' region 'std.jpg']);

    
elseif rebound_flag
    %% Rebound Response Classification Mean +/- std
    %========= 40Hz ======================================================%
    num_40_neurons = size(data40.neurons,1);
    data40_temp = data40.avg_trace;
    signif40 = std(data40.avg_trace(2:5*Fs));
    baselineAvg40 = mean(data40.avg_trace(2:5*Fs-1));
    std40 = std(data40.traces,1);
    curve1_40 = data40_temp + std40;
    curve2_40 = data40_temp - std40;
    x = [2:20*Fs];
    x2_40 = [x, fliplr(x)];
    y2_40 = [curve1_40(2:end), fliplr(curve2_40(2:end))];
    
    %========= 140Hz =====================================================%
    num_140_neurons = size(data140.neurons,1);
    data140_temp = data140.avg_trace;
    signif140 = std(data140.avg_trace(2:5*Fs));
    baselineAvg140 = mean(data140.avg_trace(2:5*Fs-1));
    std140 = std(data140.traces,1);
    curve1_140 = data140_temp + std140;
    curve2_140 = data140_temp - std140;
    x = [2:20*Fs];
    x2_140 = [x, fliplr(x)];
    y2_140 = [curve1_140(2:end), fliplr(curve2_140(2:end))];
    
    %========= 1000Hz ====================================================%
    num_1000_neurons = size(data1000.neurons,1);
    data1000_temp = data1000.avg_trace;
    signif1000 = std(data1000.avg_trace(2:5*Fs));
    baselineAvg1000 = mean(data1000.avg_trace(2:5*Fs-1));
    std1000 = std(data1000.traces,1);
    curve1_1000 = data1000_temp + std1000;
    curve2_1000 = data1000_temp - std1000;
    x = [2:20*Fs];
    x2_1000 = [x, fliplr(x)];
    y2_1000 = [curve1_1000(2:end), fliplr(curve2_1000(2:end))];
    
    % Plot Figure   
    figure; 
    plot(x,data40.avg_trace(2:end), '-','Color',color_40, 'LineWidth', 1.5); 
    hold on;
    plot(x,data140.avg_trace(2:end), '-','Color',color_140, 'LineWidth', 1.5);
    plot(x,data1000.avg_trace(2:end), '-','Color',color_1000, 'LineWidth', 1.5);
    
    yline(baselineAvg40+2*signif40,'Color',color_40,'LineStyle','-'); %40Hz significance max
    yline(baselineAvg40-2*signif40,'Color',color_40,'LineStyle','-'); %40Hz significance max

    yline(baselineAvg140+2*signif140,'Color',color_140,'LineStyle','-'); %140Hz significance max
    yline(baselineAvg140-2*signif140,'Color',color_140,'LineStyle','-'); %140Hz significance max

    yline(baselineAvg1000+2*signif1000,'Color',color_1000,'LineStyle','-'); %1000Hz significance max
    yline(baselineAvg1000-2*signif1000,'Color',color_1000,'LineStyle','-'); %1000Hz significance max
    
    h = fill(x2_40,y2_40, color_40,'LineStyle','none'); %shade in 40Hz std area
    h.FaceAlpha = 0.25; %make 40Hz std area transparent
    
    h = fill(x2_140,y2_140, color_140,'LineStyle','none'); %shade in 140Hz std area
    h.FaceAlpha = 0.25; %make 140Hz std area transparent
    
    h = fill(x2_1000,y2_1000, color_1000,'LineStyle','none'); %shade in 140Hz std area
    h.FaceAlpha = 0.25; %make 140Hz std area transparent
    
        
    xline(5*Fs,'Color','black','LineStyle','-');
    xline(10*Fs,'Color','black','LineStyle','-');
    yl(1) = -0.04; yl(2) = 0.12; %Observed limits needed for rebound graphs
    h=fill([10*Fs,10*Fs,15*Fs,15*Fs], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
    h.FaceAlpha = 0.25;
    h.EdgeColor = 'none';
    
    title([mod region]);
    set(gca,'XTick',[0:Fs:20*Fs],'XTickLabel',[0:20]);
    xlabel('Time (s)'); ylabel('\DeltaF/F');
    ylim([yl(1) yl(2)]);
    legend({['40Hz (', num2str(num_40_neurons),' neurons)'],...
            ['140Hz (', num2str(num_140_neurons),' neurons)'],...
            ['1000Hz (', num2str(num_1000_neurons),' neurons)']},'Location','NorthWest');
    saveas(gcf,[ mod '_' region 'std.fig']);
    saveas(gcf,[mod '_' region 'std.jpg']);
end
end