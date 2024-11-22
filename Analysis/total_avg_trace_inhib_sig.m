% total_avg_trace_inhib_sig.m
% Date: 07/28/23
% Author: Cara
% Purpose: Clean up transient figure generation script. Check if there is a
% significant decrease in fluorescence across all neurons avg traces
% compared to baseline

%function [p,h,d,stats] = total_avg_trace_inhib_sig(data, Fs, freq, region, color)
function [p,h,stats] = total_avg_trace_inhib_sig(data, Fs, freq, region, color)
    vcolor = [0.8,0.8,0.8; color];
    all_neuron = [];
    for i=1:numel(data)
        all_neuron = vertcat(all_neuron,data(i).roi_data.avg_trace_minusBG_new_scaled); 
    end
    
    avg_base_f = mean(all_neuron(:,1:5*Fs-1),2);
    avg_dbs_f = mean(all_neuron(:,5*Fs:10*Fs-1),2);
    base_auc = trapz(all_neuron(:,1:5*Fs-1),2);
    dbs_auc = trapz(all_neuron(:,5*Fs:10*Fs-1),2);
    
    %[p,h,stats] = signrank(avg_dbs_f,0,'tail','left','alpha',0.01);
    [p.f,h.f,stats.f] = signrank(avg_dbs_f,0); %Added 10/12/23 to be two tailed 
    [p.auc,h.auc,stats.auc] = signrank(dbs_auc,base_auc); %Added 10/12/23 to be two tailed 

    f = figure;
    ax = axes(f);
    violinplot([avg_base_f,avg_dbs_f],{'Baseline','DBS'},'ShowData',false,'ViolinColor',vcolor);
    hold on;
    yline(0);
    title(ax,[num2str(freq) 'Hz ' region ' avg fluorescence n = ' num2str(numel(avg_base_f))]);
    saveas(gcf,['total_avg_fluor_violin_' num2str(freq) '_' region '.fig']);
    
    f = figure;
    ax = axes(f);
    violinplot([base_auc,dbs_auc],{'Baseline','DBS'},'ShowData',false,'ViolinColor',vcolor);
    hold on;
    yline(0);
    title(ax,[num2str(freq) 'Hz ' region ' DBS AUC n = ' num2str(numel(dbs_auc))]);
    saveas(gcf,['total_avg_dbs_auc_violin_' num2str(freq) '_' region '.fig']);
    
%     f = figure;
%     ax = axes(f);
%     boxplot([avg_base_f, avg_dbs_f],[1 2],'Labels',{'Baseline','DBS'});
%     hold on;
%     yline(0);
%     title(ax,[num2str(freq) 'Hz ' region ' avg fluorescence']);
    
    f = figure;
    ax = axes(f);
    [f,x_values] = ecdf(avg_dbs_f);
    J = plot(x_values,f);
    hold on;
    [f2,x_values2] = ecdf(avg_base_f);
    H = plot(x_values2,f2,'k:');
    K = plot(x_values,normcdf(x_values),'r--');
    set(J,'LineWidth',2);
    set(H,'LineWidth',2);
    set(K,'LineWidth',2);
    legend([J H K],'Empirical CDF','baseline cdf','Standard Normal CDF','Location','SE');
    title(ax,[num2str(freq) 'Hz ' region ' avg fluorescence cdf']);
    
end