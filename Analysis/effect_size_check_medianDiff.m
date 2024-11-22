function median_diff = effect_size_check_medianDiff()
%% Load in data
% - CA1 - %
load([save_path,'/pos_40_CA1.mat']);
load([save_path,'/pos_140_CA1.mat']);
load([save_path,'/pos_1000_CA1.mat']);

load([save_path,'/neg_40_CA1.mat']);
load([save_path,'/neg_140_CA1.mat']);
load([save_path,'/neg_1000_CA1.mat']);

% - M1 - %
load([save_path,'/pos_40_M1.mat']);
load([save_path,'/pos_140_M1.mat']);
load([save_path,'/pos_1000_M1.mat']);

load([save_path,'/neg_40_M1.mat']);
load([save_path,'/neg_140_M1.mat']);
load([save_path,'/neg_1000_M1.mat']);

%% - 40Hz -%
% AUC
median_diff.Hz40.pos.auc = table2array(meanEffectSize(pos_40_CA1.auc, pos_40_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.Hz40.neg.auc = table2array(meanEffectSize(neg_40_CA1.auc, neg_40_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
%TTP
median_diff.Hz40.pos.ttp = table2array(meanEffectSize(pos_40_CA1.locs, pos_40_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.Hz40.neg.ttp = table2array(meanEffectSize(neg_40_CA1.locs, neg_40_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));

%% - 140Hz -%
% AUC
median_diff.Hz140.pos.auc = table2array(meanEffectSize(pos_140_CA1.auc, pos_140_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.Hz140.neg.auc = table2array(meanEffectSize(neg_140_CA1.auc, neg_140_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
%TTP
median_diff.Hz140.pos.ttp = table2array(meanEffectSize(pos_140_CA1.locs, pos_140_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.Hz140.neg.ttp = table2array(meanEffectSize(neg_140_CA1.locs, neg_140_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));

%% - 1000Hz -%
% AUC
median_diff.Hz1000.pos.auc = table2array(meanEffectSize(pos_1000_CA1.auc, pos_1000_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.Hz1000.neg.auc = table2array(meanEffectSize(neg_1000_CA1.auc, neg_1000_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
%TTP
median_diff.Hz1000.pos.ttp = table2array(meanEffectSize(pos_1000_CA1.locs, pos_1000_M1.locs, ...
                            Effect="mediandiff", VarianceType = "unequal"));
median_diff.Hz1000.neg.ttp = table2array(meanEffectSize(neg_1000_CA1.locs, neg_1000_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));

%% CA1
%Hz40v140
% AUC
median_diff.CA1.Hz40v140.pos.auc = table2array(meanEffectSize(pos_40_CA1.auc, pos_140_CA1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.CA1.Hz40v140.neg.auc = table2array(meanEffectSize(neg_40_CA1.auc, neg_140_CA1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
%TTP
median_diff.CA1.Hz40v140.pos.ttp = table2array(meanEffectSize(pos_40_CA1.locs, pos_140_CA1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.CA1.Hz40v140.neg.ttp = table2array(meanEffectSize(neg_40_CA1.locs, neg_140_CA1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));

%Hz40v1000
% AUC
median_diff.CA1.Hz40v1000.pos.auc = table2array(meanEffectSize(pos_40_CA1.auc, pos_1000_CA1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.CA1.Hz40v1000.neg.auc = table2array(meanEffectSize(neg_40_CA1.auc, neg_1000_CA1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
%TTP
median_diff.CA1.Hz40v1000.pos.ttp = table2array(meanEffectSize(pos_40_CA1.locs, pos_1000_CA1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.CA1.Hz40v1000.neg.ttp = table2array(meanEffectSize(neg_40_CA1.locs, neg_1000_CA1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));

%Hz140v1000
% AUC
median_diff.CA1.Hz140v1000.pos.auc = table2array(meanEffectSize(pos_140_CA1.auc, pos_1000_CA1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.CA1.Hz140v1000.neg.auc = table2array(meanEffectSize(neg_140_CA1.auc, neg_1000_CA1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
%TTP
median_diff.CA1.Hz140v1000.pos.ttp = table2array(meanEffectSize(pos_140_CA1.locs, pos_1000_CA1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.CA1.Hz140v1000.neg.ttp = table2array(meanEffectSize(neg_140_CA1.locs, neg_1000_CA1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));

%% M1
%Hz40v140
% AUC
median_diff.M1.Hz40v140.pos.auc = table2array(meanEffectSize(pos_40_M1.auc, pos_140_M1.auc, ...
                            Effect="mediandiff", VarianceType = "unequal"));
median_diff.M1.Hz40v140.neg.auc = table2array(meanEffectSize(neg_40_M1.auc, neg_140_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
%TTP
median_diff.M1.Hz40v140.pos.ttp = table2array(meanEffectSize(pos_40_M1.locs, pos_140_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.M1.Hz40v140.neg.ttp = table2array(meanEffectSize(neg_40_M1.locs, neg_140_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));

%Hz40v1000
% AUC
median_diff.M1.Hz40v1000.pos.auc = table2array(meanEffectSize(pos_40_M1.auc, pos_1000_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.M1.Hz40v1000.neg.auc = table2array(meanEffectSize(neg_40_M1.auc, neg_1000_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
%TTP
median_diff.M1.Hz40v1000.pos.ttp = table2array(meanEffectSize(pos_40_M1.locs, pos_1000_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.M1.Hz40v1000.neg.ttp = table2array(meanEffectSize(neg_40_M1.locs, neg_1000_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));

%Hz140v1000
% AUC
median_diff.M1.Hz140v1000.pos.auc = table2array(meanEffectSize(pos_140_M1.auc, pos_1000_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.M1.Hz140v1000.neg.auc = table2array(meanEffectSize(neg_140_M1.auc, neg_1000_M1.auc, ...
                            Effect="mediandiff",VarianceType = "unequal"));
%TTP
median_diff.M1.Hz140v1000.pos.ttp = table2array(meanEffectSize(pos_140_M1.locs, pos_1000_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));
median_diff.M1.Hz140v1000.neg.ttp = table2array(meanEffectSize(neg_140_M1.locs, neg_1000_M1.locs, ...
                            Effect="mediandiff",VarianceType = "unequal"));
end