% effect_size_check.m
% Date: 09/12/23
% Author: Cara
% Purpose: See if we can do Neuron-wise comparison but using the effect 
% size to emphasize small vs medium vs large difference

function cohen_d = effect_size_check(save_path)
%% Setup
% addpath(genpath('/home/hanlabadmins/handata_server/Cara_Ravasio/Code/GCaMP_Data_Extraction'));
% save_path = '/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Paper_Figures_Clean_Data';
% 
% cd(save_path);
Fs = 20; % Hz

%% Load in Data
% - CA1 - %
load([save_path,'/pos_40_CA1.mat']);
load([save_path,'/pos_140_CA1.mat']);
load([save_path,'/pos_1000_CA1.mat']);

load([save_path,'/neg_40_CA1.mat']);
load([save_path,'/neg_140_CA1.mat']);
load([save_path,'/neg_1000_CA1.mat']);

load([save_path, '/non_mod_40_CA1.mat']);
load([save_path, '/non_mod_140_CA1.mat']);
load([save_path, '/non_mod_1000_CA1.mat']);

% - M1 - %
load([save_path,'/pos_40_M1.mat']);
load([save_path,'/pos_140_M1.mat']);
load([save_path,'/pos_1000_M1.mat']);

load([save_path,'/neg_40_M1.mat']);
load([save_path,'/neg_140_M1.mat']);
load([save_path,'/neg_1000_M1.mat']);

load([save_path, '/non_mod_40_M1.mat']);
load([save_path, '/non_mod_140_M1.mat']);
load([save_path, '/non_mod_1000_M1.mat']);

%- p-values -%
load([save_path,'/pvals_struct.mat']);
%% Cohen's d - Effect size (Neuron-wise analysis)
% Cohen's d = (Mean1 - Mean2)/(pooled std)

% - 40Hz - %
cohen_d.hz40.pos.auc = (mean(pos_40_CA1.auc) - mean(pos_40_M1.auc))/pooledstd(pos_40_CA1.auc,pos_40_M1.auc);
cohen_d.hz40.neg.auc = (mean(neg_40_CA1.auc) - mean(neg_40_M1.auc))/pooledstd(neg_40_CA1.auc,neg_40_M1.auc);
cohen_d.hz40.pos.ttp = (mean(pos_40_CA1.locs) - mean(pos_40_M1.locs))/pooledstd(pos_40_CA1.locs,pos_40_M1.locs);
cohen_d.hz40.neg.ttp = (mean(neg_40_CA1.locs) - mean(neg_40_M1.locs))/pooledstd(neg_40_CA1.locs,neg_40_M1.locs);
cohen_d.hz40.pos.fwhm = (mean(pos_40_CA1.fwhm,'omitnan') - mean(pos_40_M1.fwhm,'omitnan'))/pooledstd(pos_40_CA1.fwhm,pos_40_M1.fwhm);
cohen_d.hz40.neg.fwhm = (mean(neg_40_CA1.fwhm,'omitnan') - mean(neg_40_M1.fwhm,'omitnan'))/pooledstd(neg_40_CA1.fwhm,neg_40_M1.fwhm);
cohen_d.hz40.pos.pkht = (mean(pos_40_CA1.pks,'omitnan') - mean(pos_40_M1.pks,'omitnan'))/pooledstd(pos_40_CA1.pks,pos_40_M1.pks);
cohen_d.hz40.neg.pkht = (mean(neg_40_CA1.pks,'omitnan') - mean(neg_40_M1.pks,'omitnan'))/pooledstd(neg_40_CA1.pks,neg_40_M1.pks);

% - 140Hz - %
cohen_d.hz140.pos.auc = (mean(pos_140_CA1.auc) - mean(pos_140_M1.auc))/pooledstd(pos_140_CA1.auc,pos_140_M1.auc);
cohen_d.hz140.neg.auc = (mean(neg_140_CA1.auc) - mean(neg_140_M1.auc))/pooledstd(neg_140_CA1.auc,neg_140_M1.auc);
cohen_d.hz140.pos.ttp = (mean(pos_140_CA1.locs) - mean(pos_140_M1.locs))/pooledstd(pos_140_CA1.locs,pos_140_M1.locs);
cohen_d.hz140.neg.ttp = (mean(neg_140_CA1.locs) - mean(neg_140_M1.locs))/pooledstd(neg_140_CA1.locs,neg_140_M1.locs);
cohen_d.hz140.pos.fwhm = (mean(pos_140_CA1.fwhm,'omitnan') - mean(pos_140_M1.fwhm,'omitnan'))/pooledstd(pos_140_CA1.fwhm,pos_140_M1.fwhm);
cohen_d.hz140.neg.fwhm = (mean(neg_140_CA1.fwhm,'omitnan') - mean(neg_140_M1.fwhm,'omitnan'))/pooledstd(neg_140_CA1.fwhm,neg_140_M1.fwhm);
cohen_d.hz140.pos.pkht = (mean(pos_140_CA1.pks,'omitnan') - mean(pos_140_M1.pks,'omitnan'))/pooledstd(pos_140_CA1.pks,pos_140_M1.pks);
cohen_d.hz140.neg.pkht = (mean(neg_140_CA1.pks,'omitnan') - mean(neg_140_M1.pks,'omitnan'))/pooledstd(neg_140_CA1.pks,neg_140_M1.pks);

% - 1000Hz - %
cohen_d.hz1000.pos.auc = (mean(pos_1000_CA1.auc) - mean(pos_1000_M1.auc))/pooledstd(pos_1000_CA1.auc,pos_1000_M1.auc);
cohen_d.hz1000.neg.auc = (mean(neg_1000_CA1.auc) - mean(neg_1000_M1.auc))/pooledstd(neg_1000_CA1.auc,neg_1000_M1.auc);
cohen_d.hz1000.pos.ttp = (mean(pos_1000_CA1.locs) - mean(pos_1000_M1.locs))/pooledstd(pos_1000_CA1.locs,pos_1000_M1.locs);
cohen_d.hz1000.neg.ttp = (mean(neg_1000_CA1.locs) - mean(neg_1000_M1.locs))/pooledstd(neg_1000_CA1.locs,neg_1000_M1.locs);
cohen_d.hz1000.pos.fwhm = (mean(pos_1000_CA1.fwhm,'omitnan') - mean(pos_1000_M1.fwhm,'omitnan'))/pooledstd(pos_1000_CA1.fwhm,pos_1000_M1.fwhm);
cohen_d.hz1000.neg.fwhm = (mean(neg_1000_CA1.fwhm,'omitnan') - mean(neg_1000_M1.fwhm,'omitnan'))/pooledstd(neg_1000_CA1.fwhm,neg_1000_M1.fwhm);
cohen_d.hz1000.pos.pkht = (mean(pos_1000_CA1.pks,'omitnan') - mean(pos_1000_M1.pks,'omitnan'))/pooledstd(pos_1000_CA1.pks,pos_1000_M1.pks);
cohen_d.hz1000.neg.pkht = (mean(neg_1000_CA1.pks,'omitnan') - mean(neg_1000_M1.pks,'omitnan'))/pooledstd(neg_1000_CA1.pks,neg_1000_M1.pks);

% - CA1 -%
cohen_d.CA1.hz40_140.pos.auc = (mean(pos_40_CA1.auc) - mean(pos_140_CA1.auc))/pooledstd(pos_40_CA1.auc,pos_140_CA1.auc);
cohen_d.CA1.hz40_140.neg.auc = (mean(neg_40_CA1.auc) - mean(neg_140_CA1.auc))/pooledstd(neg_40_CA1.auc,neg_140_CA1.auc);
cohen_d.CA1.hz40_140.pos.ttp = (mean(pos_40_CA1.locs) - mean(pos_140_CA1.locs))/pooledstd(pos_40_CA1.locs,pos_140_CA1.locs);
cohen_d.CA1.hz40_140.neg.ttp = (mean(neg_40_CA1.locs) - mean(neg_140_CA1.locs))/pooledstd(neg_40_CA1.locs,neg_140_CA1.locs);
cohen_d.CA1.hz40_140.pos.fwhm = (mean(pos_40_CA1.fwhm,'omitnan') - mean(pos_140_CA1.fwhm,'omitnan'))/pooledstd(pos_40_CA1.fwhm,pos_140_CA1.fwhm);
cohen_d.CA1.hz40_140.neg.fwhm = (mean(neg_40_CA1.fwhm,'omitnan') - mean(neg_140_CA1.fwhm,'omitnan'))/pooledstd(neg_40_CA1.fwhm,neg_140_CA1.fwhm);
cohen_d.CA1.hz40_140.pos.pkht = (mean(pos_40_CA1.pks,'omitnan') - mean(pos_140_CA1.pks,'omitnan'))/pooledstd(pos_40_CA1.pks,pos_140_CA1.pks);
cohen_d.CA1.hz40_140.neg.pkht = (mean(neg_40_CA1.pks,'omitnan') - mean(neg_140_CA1.pks,'omitnan'))/pooledstd(neg_40_CA1.pks,neg_140_CA1.pks);

cohen_d.CA1.hz1000_140.pos.auc = (mean(pos_1000_CA1.auc) - mean(pos_140_CA1.auc))/pooledstd(pos_1000_CA1.auc,pos_140_CA1.auc);
cohen_d.CA1.hz1000_140.neg.auc = (mean(neg_1000_CA1.auc) - mean(neg_140_CA1.auc))/pooledstd(neg_1000_CA1.auc,neg_140_CA1.auc);
cohen_d.CA1.hz1000_140.pos.ttp = (mean(pos_1000_CA1.locs) - mean(pos_140_CA1.locs))/pooledstd(pos_1000_CA1.locs,pos_140_CA1.locs);
cohen_d.CA1.hz1000_140.neg.ttp = (mean(neg_1000_CA1.locs) - mean(neg_140_CA1.locs))/pooledstd(neg_1000_CA1.locs,neg_140_CA1.locs);
cohen_d.CA1.hz1000_140.pos.fwhm = (mean(pos_1000_CA1.fwhm,'omitnan') - mean(pos_140_CA1.fwhm,'omitnan'))/pooledstd(pos_1000_CA1.fwhm,pos_140_CA1.fwhm);
cohen_d.CA1.hz1000_140.neg.fwhm = (mean(neg_1000_CA1.fwhm,'omitnan') - mean(neg_140_CA1.fwhm,'omitnan'))/pooledstd(neg_1000_CA1.fwhm,neg_140_CA1.fwhm);
cohen_d.CA1.hz1000_140.pos.pkht = (mean(pos_1000_CA1.pks,'omitnan') - mean(pos_140_CA1.pks,'omitnan'))/pooledstd(pos_1000_CA1.pks,pos_140_CA1.pks);
cohen_d.CA1.hz1000_140.neg.pkht = (mean(neg_1000_CA1.pks,'omitnan') - mean(neg_140_CA1.pks,'omitnan'))/pooledstd(neg_1000_CA1.pks,neg_140_CA1.pks);

cohen_d.CA1.hz40_1000.pos.auc = (mean(pos_40_CA1.auc) - mean(pos_1000_CA1.auc))/pooledstd(pos_40_CA1.auc,pos_1000_CA1.auc);
cohen_d.CA1.hz40_1000.neg.auc = (mean(neg_40_CA1.auc) - mean(neg_1000_CA1.auc))/pooledstd(neg_40_CA1.auc,neg_1000_CA1.auc);
cohen_d.CA1.hz40_1000.pos.ttp = (mean(pos_40_CA1.locs) - mean(pos_1000_CA1.locs))/pooledstd(pos_40_CA1.locs,pos_1000_CA1.locs);
cohen_d.CA1.hz40_1000.neg.ttp = (mean(neg_40_CA1.locs) - mean(neg_1000_CA1.locs))/pooledstd(neg_40_CA1.locs,neg_1000_CA1.locs);
cohen_d.CA1.hz40_1000.pos.fwhm = (mean(pos_40_CA1.fwhm,'omitnan') - mean(pos_1000_CA1.fwhm,'omitnan'))/pooledstd(pos_40_CA1.fwhm,pos_1000_CA1.fwhm);
cohen_d.CA1.hz40_1000.neg.fwhm = (mean(neg_40_CA1.fwhm,'omitnan') - mean(neg_1000_CA1.fwhm,'omitnan'))/pooledstd(neg_40_CA1.fwhm,neg_1000_CA1.fwhm);
cohen_d.CA1.hz40_1000.pos.pkht = (mean(pos_40_CA1.pks,'omitnan') - mean(pos_1000_CA1.pks,'omitnan'))/pooledstd(pos_40_CA1.pks,pos_1000_CA1.pks);
cohen_d.CA1.hz40_1000.neg.pkht = (mean(neg_40_CA1.pks,'omitnan') - mean(neg_1000_CA1.pks,'omitnan'))/pooledstd(neg_40_CA1.pks,neg_1000_CA1.pks);

% - M1 -%
cohen_d.M1.hz40_140.pos.auc = (mean(pos_40_M1.auc) - mean(pos_140_M1.auc))/pooledstd(pos_40_M1.auc,pos_140_M1.auc);
cohen_d.M1.hz40_140.neg.auc = (mean(neg_40_M1.auc) - mean(neg_140_M1.auc))/pooledstd(neg_40_M1.auc,neg_140_M1.auc);
cohen_d.M1.hz40_140.pos.ttp = (mean(pos_40_M1.locs) - mean(pos_140_M1.locs))/pooledstd(pos_40_M1.locs,pos_140_M1.locs);
cohen_d.M1.hz40_140.neg.ttp = (mean(neg_40_M1.locs) - mean(neg_140_M1.locs))/pooledstd(neg_40_M1.locs,neg_140_M1.locs);
cohen_d.M1.hz40_140.pos.fwhm = (mean(pos_40_M1.fwhm,'omitnan') - mean(pos_140_M1.fwhm,'omitnan'))/pooledstd(pos_40_M1.fwhm,pos_140_M1.fwhm);
cohen_d.M1.hz40_140.neg.fwhm = (mean(neg_40_M1.fwhm,'omitnan') - mean(neg_140_M1.fwhm,'omitnan'))/pooledstd(neg_40_M1.fwhm,neg_140_M1.fwhm);
cohen_d.M1.hz40_140.pos.pkht = (mean(pos_40_M1.pks,'omitnan') - mean(pos_140_M1.pks,'omitnan'))/pooledstd(pos_40_M1.pks,pos_140_M1.pks);
cohen_d.M1.hz40_140.neg.pkht = (mean(neg_40_M1.pks,'omitnan') - mean(neg_140_M1.pks,'omitnan'))/pooledstd(neg_40_M1.pks,neg_140_M1.pks);

cohen_d.M1.hz1000_140.pos.auc = (mean(pos_1000_M1.auc) - mean(pos_140_M1.auc))/pooledstd(pos_1000_M1.auc,pos_140_M1.auc);
cohen_d.M1.hz1000_140.neg.auc = (mean(neg_1000_M1.auc) - mean(neg_140_M1.auc))/pooledstd(neg_1000_M1.auc,neg_140_M1.auc);
cohen_d.M1.hz1000_140.pos.ttp = (mean(pos_1000_M1.locs) - mean(pos_140_M1.locs))/pooledstd(pos_1000_M1.locs,pos_140_M1.locs);
cohen_d.M1.hz1000_140.neg.ttp = (mean(neg_1000_M1.locs) - mean(neg_140_M1.locs))/pooledstd(neg_1000_M1.locs,neg_140_M1.locs);
cohen_d.M1.hz1000_140.pos.fwhm = (mean(pos_1000_M1.fwhm,'omitnan') - mean(pos_140_M1.fwhm,'omitnan'))/pooledstd(pos_1000_M1.fwhm,pos_140_M1.fwhm);
cohen_d.M1.hz1000_140.neg.fwhm = (mean(neg_1000_M1.fwhm,'omitnan') - mean(neg_140_M1.fwhm,'omitnan'))/pooledstd(neg_1000_M1.fwhm,neg_140_M1.fwhm);
cohen_d.M1.hz1000_140.pos.pkht = (mean(pos_1000_M1.pks,'omitnan') - mean(pos_140_M1.pks,'omitnan'))/pooledstd(pos_1000_M1.pks,pos_140_M1.pks);
cohen_d.M1.hz1000_140.neg.pkht = (mean(neg_1000_M1.pks,'omitnan') - mean(neg_140_M1.pks,'omitnan'))/pooledstd(neg_1000_M1.pks,neg_140_M1.pks);

cohen_d.M1.hz40_1000.pos.auc = (mean(pos_40_M1.auc) - mean(pos_1000_M1.auc))/pooledstd(pos_40_M1.auc,pos_1000_M1.auc);
cohen_d.M1.hz40_1000.neg.auc = (mean(neg_40_M1.auc) - mean(neg_1000_M1.auc))/pooledstd(neg_40_M1.auc,neg_1000_M1.auc);
cohen_d.M1.hz40_1000.pos.ttp = (mean(pos_40_M1.locs) - mean(pos_1000_M1.locs))/pooledstd(pos_40_M1.locs,pos_1000_M1.locs);
cohen_d.M1.hz40_1000.neg.ttp = (mean(neg_40_M1.locs) - mean(neg_1000_M1.locs))/pooledstd(neg_40_M1.locs,neg_1000_M1.locs);
cohen_d.M1.hz40_1000.pos.fwhm = (mean(pos_40_M1.fwhm,'omitnan') - mean(pos_1000_M1.fwhm,'omitnan'))/pooledstd(pos_40_M1.fwhm,pos_1000_M1.fwhm);
cohen_d.M1.hz40_1000.neg.fwhm = (mean(neg_40_M1.fwhm,'omitnan') - mean(neg_1000_M1.fwhm,'omitnan'))/pooledstd(neg_40_M1.fwhm,neg_1000_M1.fwhm);
cohen_d.M1.hz40_1000.pos.pkht = (mean(pos_40_M1.pks,'omitnan') - mean(pos_1000_M1.pks,'omitnan'))/pooledstd(pos_40_M1.pks,pos_1000_M1.pks);
cohen_d.M1.hz40_1000.neg.pkht = (mean(neg_40_M1.pks,'omitnan') - mean(neg_1000_M1.pks,'omitnan'))/pooledstd(neg_40_M1.pks,neg_1000_M1.pks);

%% One-sample test compared to 0 effect size

all_neurons = vertcat(pos_40_CA1.traces,neg_40_CA1.traces,non_mod_40_CA1.traces);
cohen_d.CA1.hz40.onetail = (mean(mean(all_neurons(:,5*Fs:10*Fs-1),2))-0)/std(mean(all_neurons(:,5*Fs:10*Fs-1),2));

all_neurons = vertcat(pos_140_CA1.traces,neg_140_CA1.traces,non_mod_140_CA1.traces);
cohen_d.CA1.hz140.onetail = (mean(mean(all_neurons(:,5*Fs:10*Fs-1),2))-0)/std(mean(all_neurons(:,5*Fs:10*Fs-1),2));

all_neurons = vertcat(pos_1000_CA1.traces,neg_1000_CA1.traces,non_mod_1000_CA1.traces);
cohen_d.CA1.hz1000.onetail = (mean(mean(all_neurons(:,5*Fs:10*Fs-1),2))-0)/std(mean(all_neurons(:,5*Fs:10*Fs-1),2));

all_neurons = vertcat(pos_40_M1.traces,neg_40_M1.traces,non_mod_40_M1.traces);
cohen_d.M1.hz40.onetail = (mean(mean(all_neurons(:,5*Fs:10*Fs-1),2))-0)/std(mean(all_neurons(:,5*Fs:10*Fs-1),2));

all_neurons = vertcat(pos_140_M1.traces,neg_140_M1.traces,non_mod_140_M1.traces);
cohen_d.M1.hz140.onetail = (mean(mean(all_neurons(:,5*Fs:10*Fs-1),2))-0)/std(mean(all_neurons(:,5*Fs:10*Fs-1),2));

all_neurons = vertcat(pos_1000_M1.traces,neg_1000_M1.traces,non_mod_1000_M1.traces);
cohen_d.M1.hz1000.onetail = (mean(mean(all_neurons(:,5*Fs:10*Fs-1),2))-0)/std(mean(all_neurons(:,5*Fs:10*Fs-1),2));
%% Save cohen's d variable for all of the effect sizes
save('effect_size.mat','cohen_d');
end





