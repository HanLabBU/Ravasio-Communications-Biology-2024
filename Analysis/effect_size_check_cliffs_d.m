function cliffs_d = effect_size_check_cliffs_d()
%% Load in data
save_path = 'Z:\Cara_Ravasio\Data\GCaMP_Data_Extraction\Paper_Figures_Clean_Data';
Fs = 20;

% - CA1 - %
load([save_path,'/pos_40_CA1.mat']);
load([save_path,'/pos_140_CA1.mat']);
load([save_path,'/pos_1000_CA1.mat']);

load([save_path,'/neg_40_CA1.mat']);
load([save_path,'/neg_140_CA1.mat']);
load([save_path,'/neg_1000_CA1.mat']);

load([save_path,'/non_mod_40_CA1.mat']);
load([save_path,'/non_mod_140_CA1.mat']);
load([save_path,'/non_mod_1000_CA1.mat']);

% - M1 - %
load([save_path,'/pos_40_M1.mat']);
load([save_path,'/pos_140_M1.mat']);
load([save_path,'/pos_1000_M1.mat']);

load([save_path,'/neg_40_M1.mat']);
load([save_path,'/neg_140_M1.mat']);
load([save_path,'/neg_1000_M1.mat']);

load([save_path,'/non_mod_40_M1.mat']);
load([save_path,'/non_mod_140_M1.mat']);
load([save_path,'/non_mod_1000_M1.mat']);

%% - 40Hz -%
% AUC
cliffs_d.Hz40.pos.auc = table2array(meanEffectSize(pos_40_CA1.auc, pos_40_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.Hz40.neg.auc = table2array(meanEffectSize(neg_40_CA1.auc, neg_40_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%TTP
cliffs_d.Hz40.pos.ttp = table2array(meanEffectSize(pos_40_CA1.locs, pos_40_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.Hz40.neg.ttp = table2array(meanEffectSize(neg_40_CA1.locs, neg_40_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%% - 140Hz -%
% AUC
cliffs_d.Hz140.pos.auc = table2array(meanEffectSize(pos_140_CA1.auc, pos_140_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.Hz140.neg.auc = table2array(meanEffectSize(neg_140_CA1.auc, neg_140_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%TTP
cliffs_d.Hz140.pos.ttp = table2array(meanEffectSize(pos_140_CA1.locs, pos_140_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.Hz140.neg.ttp = table2array(meanEffectSize(neg_140_CA1.locs, neg_140_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%% - 1000Hz -%
% AUC
cliffs_d.Hz1000.pos.auc = table2array(meanEffectSize(pos_1000_CA1.auc, pos_1000_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.Hz1000.neg.auc = table2array(meanEffectSize(neg_1000_CA1.auc, neg_1000_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%TTP
cliffs_d.Hz1000.pos.ttp = table2array(meanEffectSize(pos_1000_CA1.locs, pos_1000_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.Hz1000.neg.ttp = table2array(meanEffectSize(neg_1000_CA1.locs, neg_1000_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%% CA1
%Hz40v140
% AUC
cliffs_d.CA1.Hz40v140.pos.auc = table2array(meanEffectSize(pos_40_CA1.auc, pos_140_CA1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.CA1.Hz40v140.neg.auc = table2array(meanEffectSize(neg_40_CA1.auc, neg_140_CA1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%TTP
cliffs_d.CA1.Hz40v140.pos.ttp = table2array(meanEffectSize(pos_40_CA1.locs, pos_140_CA1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.CA1.Hz40v140.neg.ttp = table2array(meanEffectSize(neg_40_CA1.locs, neg_140_CA1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%Hz40v1000
% AUC
cliffs_d.CA1.Hz40v1000.pos.auc = table2array(meanEffectSize(pos_40_CA1.auc, pos_1000_CA1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.CA1.Hz40v1000.neg.auc = table2array(meanEffectSize(neg_40_CA1.auc, neg_1000_CA1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%TTP
cliffs_d.CA1.Hz40v1000.pos.ttp = table2array(meanEffectSize(pos_40_CA1.locs, pos_1000_CA1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.CA1.Hz40v1000.neg.ttp = table2array(meanEffectSize(neg_40_CA1.locs, neg_1000_CA1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%Hz140v1000
% AUC
cliffs_d.CA1.Hz140v1000.pos.auc = table2array(meanEffectSize(pos_140_CA1.auc, pos_1000_CA1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.CA1.Hz140v1000.neg.auc = table2array(meanEffectSize(neg_140_CA1.auc, neg_1000_CA1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%TTP
cliffs_d.CA1.Hz140v1000.pos.ttp = table2array(meanEffectSize(pos_140_CA1.locs, pos_1000_CA1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.CA1.Hz140v1000.neg.ttp = table2array(meanEffectSize(neg_140_CA1.locs, neg_1000_CA1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%% M1
%Hz40v140
% AUC
cliffs_d.M1.Hz40v140.pos.auc = table2array(meanEffectSize(pos_40_M1.auc, pos_140_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.M1.Hz40v140.neg.auc = table2array(meanEffectSize(neg_40_M1.auc, neg_140_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%TTP
cliffs_d.M1.Hz40v140.pos.ttp = table2array(meanEffectSize(pos_40_M1.locs, pos_140_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.M1.Hz40v140.neg.ttp = table2array(meanEffectSize(neg_40_M1.locs, neg_140_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%Hz40v1000
% AUC
cliffs_d.M1.Hz40v1000.pos.auc = table2array(meanEffectSize(pos_40_M1.auc, pos_1000_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.M1.Hz40v1000.neg.auc = table2array(meanEffectSize(neg_40_M1.auc, neg_1000_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%TTP
cliffs_d.M1.Hz40v1000.pos.ttp = table2array(meanEffectSize(pos_40_M1.locs, pos_1000_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.M1.Hz40v1000.neg.ttp = table2array(meanEffectSize(neg_40_M1.locs, neg_1000_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%Hz140v1000
% AUC
cliffs_d.M1.Hz140v1000.pos.auc = table2array(meanEffectSize(pos_140_M1.auc, pos_1000_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.M1.Hz140v1000.neg.auc = table2array(meanEffectSize(neg_140_M1.auc, neg_1000_M1.auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%TTP
cliffs_d.M1.Hz140v1000.pos.ttp = table2array(meanEffectSize(pos_140_M1.locs, pos_1000_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.M1.Hz140v1000.neg.ttp = table2array(meanEffectSize(neg_140_M1.locs, neg_1000_M1.locs, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%% Population level DBS effect size check - Avg dF

%- CA1 -%
avg_df = [mean(neg_40_CA1.traces(:,5*Fs:10*Fs),2); ...
          mean(non_mod_40_CA1.traces(:,5*Fs:10*Fs),2);...
          mean(pos_40_CA1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.CA1.Hz40.total.df = table2array(meanEffectSize(avg_df, 0, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

avg_df = [mean(neg_140_CA1.traces(:,5*Fs:10*Fs),2); ...
          mean(non_mod_140_CA1.traces(:,5*Fs:10*Fs),2);...
          mean(pos_140_CA1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.CA1.Hz140.total.df = table2array(meanEffectSize(avg_df, 0, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

avg_df = [mean(neg_1000_CA1.traces(:,5*Fs:10*Fs),2); ...
          mean(non_mod_1000_CA1.traces(:,5*Fs:10*Fs),2);...
          mean(pos_1000_CA1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.CA1.Hz1000.total.df = table2array(meanEffectSize(avg_df, 0, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%- M1 -%
avg_df = [mean(neg_40_M1.traces(:,5*Fs:10*Fs),2); ...
          mean(non_mod_40_M1.traces(:,5*Fs:10*Fs),2);...
          mean(pos_40_M1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.M1.Hz40.total.df = table2array(meanEffectSize(avg_df, 0, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

avg_df = [mean(neg_140_M1.traces(:,5*Fs:10*Fs),2); ...
          mean(non_mod_140_M1.traces(:,5*Fs:10*Fs),2);...
          mean(pos_140_M1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.M1.Hz140.total.df = table2array(meanEffectSize(avg_df, 0, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

avg_df = [mean(neg_1000_M1.traces(:,5*Fs:10*Fs),2); ...
          mean(non_mod_1000_M1.traces(:,5*Fs:10*Fs),2);...
          mean(pos_1000_M1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.M1.Hz1000.total.df = table2array(meanEffectSize(avg_df, 0, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%% Population level DBS effect size check - AUC within each condition

%- CA1 -%
avg_auc = [trapz(neg_40_CA1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_40_CA1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_40_CA1.traces(:,5*Fs:10*Fs),2)];
base_auc = [trapz(neg_40_CA1.traces(:,1:5*Fs),2); ...
          trapz(non_mod_40_CA1.traces(:,1:5*Fs),2);...
          trapz(pos_40_CA1.traces(:,1:5*Fs),2)];
cliffs_d.CA1.Hz40.total.auc = table2array(meanEffectSize(avg_auc, base_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

avg_auc = [trapz(neg_140_CA1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_140_CA1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_140_CA1.traces(:,5*Fs:10*Fs),2)];
base_auc = [trapz(neg_140_CA1.traces(:,1:5*Fs),2); ...
          trapz(non_mod_140_CA1.traces(:,1:5*Fs),2);...
          trapz(pos_140_CA1.traces(:,1:5*Fs),2)];
cliffs_d.CA1.Hz140.total.auc = table2array(meanEffectSize(avg_auc, base_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

avg_auc = [trapz(neg_1000_CA1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_1000_CA1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_1000_CA1.traces(:,5*Fs:10*Fs),2)];
base_auc = [trapz(neg_1000_CA1.traces(:,1:5*Fs),2); ...
          trapz(non_mod_1000_CA1.traces(:,1:5*Fs),2);...
          trapz(pos_1000_CA1.traces(:,1:5*Fs),2)];
cliffs_d.CA1.Hz1000.total.auc = table2array(meanEffectSize(avg_auc, base_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%- M1 -%
avg_auc = [trapz(neg_40_M1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_40_M1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_40_M1.traces(:,5*Fs:10*Fs),2)];
base_auc = [trapz(neg_40_M1.traces(:,1:5*Fs),2); ...
          trapz(non_mod_40_M1.traces(:,1:5*Fs),2);...
          trapz(pos_40_M1.traces(:,1:5*Fs),2)];
cliffs_d.M1.Hz40.total.auc = table2array(meanEffectSize(avg_auc, base_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

avg_auc = [trapz(neg_140_M1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_140_M1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_140_M1.traces(:,5*Fs:10*Fs),2)];
base_auc = [trapz(neg_140_M1.traces(:,1:5*Fs),2); ...
          trapz(non_mod_140_M1.traces(:,1:5*Fs),2);...
          trapz(pos_140_M1.traces(:,1:5*Fs),2)];
cliffs_d.M1.Hz140.total.auc = table2array(meanEffectSize(avg_auc, base_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

avg_auc = [trapz(neg_1000_M1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_1000_M1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_1000_M1.traces(:,5*Fs:10*Fs),2)];
base_auc = [trapz(neg_1000_M1.traces(:,1:5*Fs),2); ...
          trapz(non_mod_1000_M1.traces(:,1:5*Fs),2);...
          trapz(pos_1000_M1.traces(:,1:5*Fs),2)];
cliffs_d.M1.Hz1000.total.auc = table2array(meanEffectSize(avg_auc, base_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%% Population level DBS effect size check - AUC within each condition
%- 40Hz -%
CA1_auc = [trapz(neg_40_CA1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_40_CA1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_40_CA1.traces(:,5*Fs:10*Fs),2)];
M1_auc = [trapz(neg_40_M1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_40_M1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_40_M1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.Hz40.total.auc = table2array(meanEffectSize(CA1_auc, M1_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
                        
%- 140Hz -%
CA1_auc = [trapz(neg_140_CA1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_140_CA1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_140_CA1.traces(:,5*Fs:10*Fs),2)];
M1_auc = [trapz(neg_140_M1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_140_M1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_140_M1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.Hz140.total.auc = table2array(meanEffectSize(CA1_auc, M1_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
                        
%- 1000Hz -%
CA1_auc = [trapz(neg_1000_CA1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_1000_CA1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_1000_CA1.traces(:,5*Fs:10*Fs),2)];
M1_auc = [trapz(neg_1000_M1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_1000_M1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_1000_M1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.Hz1000.total.auc = table2array(meanEffectSize(CA1_auc, M1_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));

%- CA1 -%
hz40_auc = [trapz(neg_40_CA1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_40_CA1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_40_CA1.traces(:,5*Fs:10*Fs),2)];
hz140_auc = [trapz(neg_140_CA1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_140_CA1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_140_CA1.traces(:,5*Fs:10*Fs),2)];
hz1000_auc = [trapz(neg_1000_CA1.traces(:,5*Fs:10*Fs),2); ...
              trapz(non_mod_1000_CA1.traces(:,5*Fs:10*Fs),2);...
              trapz(pos_1000_CA1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.CA1.Hz40v140.total.auc = table2array(meanEffectSize(hz40_auc, hz140_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.CA1.Hz40v1000.total.auc = table2array(meanEffectSize(hz40_auc, hz1000_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.CA1.Hz140v1000.total.auc = table2array(meanEffectSize(hz140_auc, hz1000_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
                        
%- M1 -%
hz40_auc = [trapz(neg_40_M1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_40_M1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_40_M1.traces(:,5*Fs:10*Fs),2)];
hz140_auc = [trapz(neg_140_M1.traces(:,5*Fs:10*Fs),2); ...
          trapz(non_mod_140_M1.traces(:,5*Fs:10*Fs),2);...
          trapz(pos_140_M1.traces(:,5*Fs:10*Fs),2)];
hz1000_auc = [trapz(neg_1000_M1.traces(:,5*Fs:10*Fs),2); ...
              trapz(non_mod_1000_M1.traces(:,5*Fs:10*Fs),2);...
              trapz(pos_1000_M1.traces(:,5*Fs:10*Fs),2)];
cliffs_d.M1.Hz40v140.total.auc = table2array(meanEffectSize(hz40_auc, hz140_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.M1.Hz40v1000.total.auc = table2array(meanEffectSize(hz40_auc, hz1000_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
cliffs_d.M1.Hz140v1000.total.auc = table2array(meanEffectSize(hz140_auc, hz1000_auc, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
%% Save Cliff's delta struct

save([save_path, '/cliffs_d'],'cliffs_d')

end