% total_avg_trace_dbs_auc_comp.m
% Date: 11/14/23
% Author: Cara
% Purpose: Test the area under the curve during dbs across frequencies
% but within brain region. or within brain region but across frequencies

function p = total_avg_trace_dbs_auc_comp(data40_CA1,data140_CA1,data1000_CA1,...
                                      data40_M1, data140_M1, data1000_M1,Fs,colors)
% colors = 6x3 matrix where top three rows are CA1 and bottom three rows 
% are M1 in ascending frequency order top to bottom.


%% Setup neuron matrices
all_neuron40_CA1 = [];
for i=1:numel(data40_CA1)
    all_neuron40_CA1 = vertcat(all_neuron40_CA1,data40_CA1(i).roi_data.avg_trace_minusBG_new_scaled); 
end

all_neuron140_CA1 = [];
for i=1:numel(data140_CA1)
    all_neuron140_CA1 = vertcat(all_neuron140_CA1,data140_CA1(i).roi_data.avg_trace_minusBG_new_scaled); 
end

all_neuron1000_CA1 = [];
for i=1:numel(data1000_CA1)
    all_neuron1000_CA1 = vertcat(all_neuron1000_CA1,data1000_CA1(i).roi_data.avg_trace_minusBG_new_scaled); 
end

all_neuron40_M1 = [];
for i=1:numel(data40_M1)
    all_neuron40_M1 = vertcat(all_neuron40_M1,data40_M1(i).roi_data.avg_trace_minusBG_new_scaled); 
end

all_neuron140_M1 = [];
for i=1:numel(data140_M1)
    all_neuron140_M1 = vertcat(all_neuron140_M1,data140_M1(i).roi_data.avg_trace_minusBG_new_scaled); 
end

all_neuron1000_M1 = [];
for i=1:numel(data1000_M1)
    all_neuron1000_M1 = vertcat(all_neuron1000_M1,data1000_M1(i).roi_data.avg_trace_minusBG_new_scaled); 
end

%% Calculate AUC during DBS and baseline
    base_auc40_CA1 = trapz(all_neuron40_CA1(:,1:5*Fs-1),2);
    dbs_auc40_CA1 = trapz(all_neuron40_CA1(:,5*Fs:10*Fs-1),2);
    
    base_auc140_CA1 = trapz(all_neuron140_CA1(:,1:5*Fs-1),2);
    dbs_auc140_CA1 = trapz(all_neuron140_CA1(:,5*Fs:10*Fs-1),2);
    
    base_auc1000_CA1 = trapz(all_neuron1000_CA1(:,1:5*Fs-1),2);
    dbs_auc1000_CA1 = trapz(all_neuron1000_CA1(:,5*Fs:10*Fs-1),2);

    base_auc40_M1 = trapz(all_neuron40_M1(:,1:5*Fs-1),2);
    dbs_auc40_M1 = trapz(all_neuron40_M1(:,5*Fs:10*Fs-1),2);
    
    base_auc140_M1 = trapz(all_neuron140_M1(:,1:5*Fs-1),2);
    dbs_auc140_M1 = trapz(all_neuron140_M1(:,5*Fs:10*Fs-1),2);
    
    base_auc1000_M1 = trapz(all_neuron1000_M1(:,1:5*Fs-1),2);
    dbs_auc1000_M1 = trapz(all_neuron1000_M1(:,5*Fs:10*Fs-1),2);
    
%% Perform signrank within each test condition against baseline
    [p.CA1.hz40,~,~] = signrank(dbs_auc40_CA1,base_auc40_CA1);
    [p.CA1.hz140,~,~] = signrank(dbs_auc140_CA1,base_auc140_CA1); 
    [p.CA1.hz1000,~,~] = signrank(dbs_auc1000_CA1,base_auc1000_CA1); 
    
    [p.M1.hz40,~,~] = signrank(dbs_auc40_M1,base_auc40_M1);
    [p.M1.hz140,~,~] = signrank(dbs_auc140_M1,base_auc140_M1); 
    [p.M1.hz1000,~,~] = signrank(dbs_auc1000_M1,base_auc1000_M1); 
    
%% Perform ranksum within each test frequency
    [p.hz40,~,~] = ranksum(dbs_auc40_CA1,dbs_auc40_M1);
    [p.hz140,~,~] = ranksum(dbs_auc140_CA1,dbs_auc140_M1);
    [p.hz1000,~,~] = ranksum(dbs_auc1000_CA1,dbs_auc1000_M1);
    
%% Perform Kruskal-Wallis with Dunn-Sidak correction withint each region
    [p_kw,~,stats_kw] = kruskalwallis([dbs_auc40_CA1',dbs_auc140_CA1',dbs_auc1000_CA1'],...
                   [40*ones(size(dbs_auc40_CA1')),140*ones(size(dbs_auc140_CA1')),1000*ones(size(dbs_auc1000_CA1'))],'off');
    if p_kw<0.05
        c = multcompare(stats_kw, 'ctype', 'dunn-sidak','display','off');
        p.CA1.all = c(:,end);
    else
        p.CA1.all = p_kw; %[1;1;1];
    end  
    
    [p_kw,~,stats_kw] = kruskalwallis([dbs_auc40_M1',dbs_auc140_M1',dbs_auc1000_M1'],...
                   [40*ones(size(dbs_auc40_M1')),140*ones(size(dbs_auc140_M1')),1000*ones(size(dbs_auc1000_M1'))],'off');
    if p_kw<0.05
        c = multcompare(stats_kw, 'ctype', 'dunn-sidak','display','off');
        p.M1.all = c(:,end);
    else
        p.M1.all = p_kw; %[1;1;1];
    end 
    
%% Violin Plots
% 40Hz
    f = figure;
    ax = axes(f);
    hz40_auc.CA1 = dbs_auc40_CA1;
    hz40_auc.M1 = dbs_auc40_M1;
    violinplot(hz40_auc,{'CA1','M1'},'ShowData',false,'ViolinColor',[colors(1,:);colors(4,:)]);
    hold on;
    yline(0);
    title(ax,'Total Avg 40Hz DBS AUC');
    saveas(gcf,['total_avg_dbs_auc_violin_40Hz.fig']);
    
% 140Hz
    f = figure;
    ax = axes(f);
    hz140_auc.CA1 = dbs_auc140_CA1;
    hz140_auc.M1 = dbs_auc140_M1;
    violinplot(hz140_auc,{'CA1','M1'},'ShowData',false,'ViolinColor',[colors(2,:);colors(5,:)]);
    hold on;
    yline(0);
    title(ax,'Total Avg 140Hz DBS AUC');
    saveas(gcf,['total_avg_dbs_auc_violin_140Hz.fig']);
    
% 1000Hz
    f = figure;
    ax = axes(f);
    hz1000_auc.CA1 = dbs_auc1000_CA1;
    hz1000_auc.M1 = dbs_auc1000_M1;
    violinplot(hz1000_auc,{'CA1','M1'},'ShowData',false,'ViolinColor',[colors(3,:);colors(6,:)]);
    hold on;
    yline(0);
    title(ax,'Total Avg 1000Hz DBS AUC');
    saveas(gcf,['total_avg_dbs_auc_violin_1000Hz.fig']);
    
% CA1
    f = figure;
    ax = axes(f);
    CA1_auc.hz40 = dbs_auc40_CA1;
    CA1_auc.hz140 = dbs_auc140_CA1;
    CA1_auc.hz1000 = dbs_auc1000_CA1;
    violinplot(CA1_auc,{'hz40','hz140','hz1000'},'GroupOrder',{'hz40','hz140','hz1000'},'ShowData',false,'ViolinColor',[colors(1,:);colors(2,:);colors(3,:)]);
    hold on;
    yline(0);
    title(ax,'Total Avg CA1 DBS AUC');
    saveas(gcf,['total_avg_dbs_auc_violin_CA1.fig']);
    
% M1
    f = figure;
    ax = axes(f);
    M1_auc.hz40 = dbs_auc40_M1;
    M1_auc.hz140 = dbs_auc140_M1;
    M1_auc.hz1000 = dbs_auc1000_M1;
    violinplot(M1_auc,{'hz40','hz140','hz1000'},'GroupOrder',{'hz40','hz140','hz1000'},'ShowData',false,'ViolinColor',[colors(4,:);colors(5,:);colors(6,:)]);
    hold on;
    yline(0);
    title(ax,'Total Avg M1 DBS AUC');
    saveas(gcf,['total_avg_dbs_auc_violin_M1.fig']);
    
end
