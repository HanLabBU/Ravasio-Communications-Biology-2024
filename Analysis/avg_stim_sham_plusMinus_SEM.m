% avg_stim_sham_plusMinus_SEM.m
% Author: Cara
% Date: 05/11/23
% Purpose: To make figures which show the average trace, its SEM shaded
% above and below it, and the onset and offset of sham stimulation.

function avg_stim_sham_plusMinus_SEM(data40,data140,data1000, data_ctrl, mod, region, rebound_flag, Fs, colors)
    % data_ctrl output structs from DBS_Modulation_Check
    % mod is a str "Pos","Non", or "Neg"
    % rebound_flag is 0 for Acute response and 1 for Rebound response
    % Fs = 20; %Hz
    
    %Ex: avg_trace_plusMinus_SEM(pos_mod_ctrl,'Pos', 0, 10);
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
    sem40 = std(data40.traces,1)%./sqrt(size(data40.neurons,1));
    curve1_40 = data40_temp + sem40;
    curve2_40 = data40_temp - sem40;
    x = [2:20*Fs];
    x2_40 = [x, fliplr(x)];
    y2_40 = [curve1_40(2:end), fliplr(curve2_40(2:end))];
    
    %========= 140Hz =====================================================%
    num_140_neurons = size(data140.neurons,1);
    data140_temp = data140.avg_trace;
    signif140 = std(data140.avg_trace(2:5*Fs));
    baselineAvg140 = mean(data140.avg_trace(2:5*Fs-1));
    sem140 = std(data140.traces,1)%./sqrt(size(data140.neurons,1));
    curve1_140 = data140_temp + sem140;
    curve2_140 = data140_temp - sem140;
    x = [2:20*Fs];
    x2_140 = [x, fliplr(x)];
    y2_140 = [curve1_140(2:end), fliplr(curve2_140(2:end))];
    
    %========= 1000Hz ====================================================%
    num_1000_neurons = size(data1000.neurons,1);
    data1000_temp = data1000.avg_trace;
    signif1000 = std(data1000.avg_trace(2:5*Fs));
    baselineAvg1000 = mean(data1000.avg_trace(2:5*Fs-1));
    sem1000 = std(data1000.traces,1)%./sqrt(size(data1000.neurons,1));
    curve1_1000 = data1000_temp + sem1000;
    curve2_1000 = data1000_temp - sem1000;
    x = [2:20*Fs];
    x2_1000 = [x, fliplr(x)];
    y2_1000 = [curve1_1000(2:end), fliplr(curve2_1000(2:end))];
    
    %========================== Sham =====================================%
    num_neurons = size(data_ctrl.traces,1);
    data_ctrl_temp = mean(data_ctrl.traces,1); %avg along neurons
    signif_ctrl = std(data_ctrl_temp(2:5*Fs));
    baselineAvg_ctrl = mean(data_ctrl_temp(2:5*Fs-1));
    sem_ctrl = std(data_ctrl.traces,1)%./sqrt(num_neurons);
    curve1_ctrl = data_ctrl_temp + sem_ctrl;
    curve2_ctrl = data_ctrl_temp - sem_ctrl;
    x = [2:20*Fs];
    x2_ctrl = [x, fliplr(x)];
    y2_ctrl = [curve1_ctrl(2:end), fliplr(curve2_ctrl(2:end))];
    %=====================================================================%
    
% Plot Figure     
    figure; 
    plot(x,data40.avg_trace(2:end), '-','Color',color_40, 'LineWidth', 1.5); 
    hold on;
    plot(x,data140.avg_trace(2:end), '-','Color',color_140, 'LineWidth', 1.5);
    plot(x,data1000.avg_trace(2:end), '-','Color',color_1000, 'LineWidth', 1.5);
    plot(x,data_ctrl_temp(2:end), '-r', 'LineWidth', 1.5); 
    
    yline(baselineAvg40+2*signif40,'Color',color_40,'LineStyle','-'); %40Hz significance max
    yline(baselineAvg40-2*signif40,'Color',color_40,'LineStyle','-'); %40Hz significance max

    yline(baselineAvg140+2*signif140,'Color',color_140,'LineStyle','-'); %140Hz significance max
    yline(baselineAvg140-2*signif140,'Color',color_140,'LineStyle','-'); %140Hz significance max

    yline(baselineAvg1000+2*signif1000,'Color',color_1000,'LineStyle','-'); %1000Hz significance max
    yline(baselineAvg1000-2*signif1000,'Color',color_1000,'LineStyle','-'); %1000Hz significance max
    
    yline(baselineAvg_ctrl+2*signif_ctrl,'Color',[1 0 0],'LineStyle','-');
    yline(baselineAvg_ctrl-2*signif_ctrl,'Color',[1 0 0],'LineStyle','-'); 
    
    h = fill(x2_40,y2_40, color_40,'LineStyle','none'); %shade in 40Hz sem area
    h.FaceAlpha = 0.25; %make 40Hz sem area transparent
    
    h = fill(x2_140,y2_140, color_140,'LineStyle','none'); %shade in 140Hz sem area
    h.FaceAlpha = 0.25; %make 140Hz sem area transparent
    
    h = fill(x2_1000,y2_1000, color_1000,'LineStyle','none'); %shade in 140Hz sem area
    h.FaceAlpha = 0.25; %make 140Hz sem area transparent

    h = fill(x2_ctrl,y2_ctrl, [1 0 0],'LineStyle','none'); %shade in sem area
    h.FaceAlpha = 0.25; %make sem area transparent

    
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
    
    title(['Stim + Sham ' mod '-Mod']);
    set(gca,'XTick',[0:Fs:20*Fs],'XTickLabel',[0:20]);
    xlabel('Time (s)'); ylabel('\DeltaF/F');
    ylim([yl(1) yl(2)]);
    legend({['40Hz (', num2str(num_40_neurons),' neurons)'],...
            ['140Hz (', num2str(num_140_neurons),' neurons)'],...
            ['1000Hz (', num2str(num_1000_neurons),' neurons)'],...
            ['Control (', num2str(num_neurons),' neurons)']});
    saveas(gcf,['stim_sham_' mod 'mod_' region '.fig']);
    saveas(gcf,['stim_sham_' mod 'mod_' region '.jpg']);
    
elseif rebound_flag
    %% Rebound Response Classification Mean +/- SEM
    %========= 40Hz ======================================================%
    num_40_neurons = size(data40.neurons,1);
    data40_temp = data40.avg_trace;
    signif40 = std(data40.avg_trace(2:5*Fs));
    baselineAvg40 = mean(data40.avg_trace(2:5*Fs-1));
    sem40 = std(data40.traces,1)./sqrt(size(data40.neurons,1));
    curve1_40 = data40_temp + sem40;
    curve2_40 = data40_temp - sem40;
    x = [2:20*Fs];
    x2_40 = [x, fliplr(x)];
    y2_40 = [curve1_40(2:end), fliplr(curve2_40(2:end))];
    
    %========= 140Hz =====================================================%
    num_140_neurons = size(data140.neurons,1);
    data140_temp = data140.avg_trace;
    signif140 = std(data140.avg_trace(2:5*Fs));
    baselineAvg140 = mean(data140.avg_trace(2:5*Fs-1));
    sem140 = std(data140.traces,1)./sqrt(size(data140.neurons,1));
    curve1_140 = data140_temp + sem140;
    curve2_140 = data140_temp - sem140;
    x = [2:20*Fs];
    x2_140 = [x, fliplr(x)];
    y2_140 = [curve1_140(2:end), fliplr(curve2_140(2:end))];
    
    %========= 1000Hz ====================================================%
    num_1000_neurons = size(data1000.neurons,1);
    data1000_temp = data1000.avg_trace;
    signif1000 = std(data1000.avg_trace(2:5*Fs));
    baselineAvg1000 = mean(data1000.avg_trace(2:5*Fs-1));
    sem1000 = std(data1000.traces,1)./sqrt(size(data1000.neurons,1));
    curve1_1000 = data1000_temp + sem1000;
    curve2_1000 = data1000_temp - sem1000;
    x = [2:20*Fs];
    x2_1000 = [x, fliplr(x)];
    y2_1000 = [curve1_1000(2:end), fliplr(curve2_1000(2:end))];
    
    %============ Sham ===================================================%
    num_neurons = size(data_ctrl.traces,1);
    data_ctrl_temp = mean(data_ctrl.traces,1); %avg along neurons
    signif_ctrl = std(data_ctrl_temp(2:5*Fs));
    baselineAvg_ctrl = mean(data_ctrl_temp(2:5*Fs-1));
    sem_ctrl = std(data_ctrl.traces,1)./sqrt(num_neurons);
    curve1_ctrl = data_ctrl_temp + sem_ctrl;
    curve2_ctrl = data_ctrl_temp - sem_ctrl;
    x = [2:20*Fs];
    x2_ctrl = [x, fliplr(x)];
    y2_ctrl = [curve1_ctrl(2:end), fliplr(curve2_ctrl(2:end))];

    
    % Plot Figure   
    figure; 
    plot(x,data40.avg_trace(2:end), '-','Color',color_40, 'LineWidth', 1.5); 
    hold on;
    plot(x,data140.avg_trace(2:end), '-','Color',color_140, 'LineWidth', 1.5);
    plot(x,data1000.avg_trace(2:end), '-','Color',color_1000, 'LineWidth', 1.5);
    plot(x,data_ctrl_temp(2:end), '-r', 'LineWidth', 1.5); 
    
    yline(baselineAvg40+2*signif40,'Color',color_40,'LineStyle','-'); %40Hz significance max
    yline(baselineAvg40-2*signif40,'Color',color_40,'LineStyle','-'); %40Hz significance max

    yline(baselineAvg140+2*signif140,'Color',color_140,'LineStyle','-'); %140Hz significance max
    yline(baselineAvg140-2*signif140,'Color',color_140,'LineStyle','-'); %140Hz significance max

    yline(baselineAvg1000+2*signif1000,'Color',color_1000,'LineStyle','-'); %1000Hz significance max
    yline(baselineAvg1000-2*signif1000,'Color',color_1000,'LineStyle','-'); %1000Hz significance max
    
    yline(baselineAvg_ctrl+2*signif_ctrl,'Color',[1 0 0],'LineStyle','-');
    yline(baselineAvg_ctrl-2*signif_ctrl,'Color',[1 0 0],'LineStyle','-'); 
    
    h = fill(x2_40,y2_40, color_40,'LineStyle','none'); %shade in 40Hz sem area
    h.FaceAlpha = 0.25; %make 40Hz sem area transparent
    
    h = fill(x2_140,y2_140, color_140,'LineStyle','none'); %shade in 140Hz sem area
    h.FaceAlpha = 0.25; %make 140Hz sem area transparent
    
    h = fill(x2_1000,y2_1000, color_1000,'LineStyle','none'); %shade in 140Hz sem area
    h.FaceAlpha = 0.25; %make 140Hz sem area transparent
    
    h = fill(x2_ctrl,y2_ctrl, [1 0 0],'LineStyle','none'); %shade in sem area
    h.FaceAlpha = 0.25; %make sem area transparent
    
    xline(5*Fs,'Color','black','LineStyle','-');
    xline(10*Fs,'Color','black','LineStyle','-');
    yl(1) = -0.04; yl(2) = 0.12; %Observed limits needed for rebound graphs
    h=fill([10*Fs,10*Fs,15*Fs,15*Fs], [yl(1) yl(2) yl(2) yl(1)],[0.5 0.5 0.5]);
    h.FaceAlpha = 0.25;
    h.EdgeColor = 'none';
    
    title(['Stim + Sham ' mod]);
    set(gca,'XTick',[0:Fs:20*Fs],'XTickLabel',[0:20]);
    xlabel('Time (s)'); ylabel('\DeltaF/F');
    ylim([yl(1) yl(2)]);
    legend({['40Hz (', num2str(num_40_neurons),' neurons)'],...
            ['140Hz (', num2str(num_140_neurons),' neurons)'],...
            ['1000Hz (', num2str(num_1000_neurons),' neurons)'],...
            ['Sham (', num2str(num_neurons),' neurons)']},'Location','NorthWest');
    saveas(gcf,[ mod '_stim_sham_' region '.fig']);
    saveas(gcf,[mod '_stim_sham_' region '.jpg']);
end
end