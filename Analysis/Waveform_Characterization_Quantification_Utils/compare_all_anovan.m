% compare_all_anovan.m
% Author: Cara Ravasio
% Date: 04/18/23
% Purpose: Just cleans up the waveform characterization script.
function pvals_struct = compare_all_anovan(pos_40_hip,pos_140_hip,pos_1000_hip,...
                                    neg_40_hip, neg_140_hip, neg_1000_hip,...
                                    reb_40_hip, reb_140_hip,reb_1000_hip,...
                                    pos_40_cort,pos_140_cort,pos_1000_cort,...
                                    neg_40_cort, neg_140_cort, neg_1000_cort,...
                                    reb_40_cort, reb_140_cort,reb_1000_cort,...
                                    pvals_struct,bcolor,Fs)
%% ============================== Increasing Slope =========================%
%Positive
inc_slope_struct.CA1_40Hz = pos_40_hip.inc_slope;
inc_slope_struct.CA1_140Hz = pos_140_hip.inc_slope;
inc_slope_struct.CA1_1000Hz = pos_1000_hip.inc_slope;
inc_slope_struct.M1_40Hz = pos_40_cort.inc_slope;
inc_slope_struct.M1_140Hz = pos_140_cort.inc_slope;
inc_slope_struct.M1_1000Hz = pos_1000_cort.inc_slope;

pos_inc_slope_pvals = anova_bonferroni_box(inc_slope_struct,bcolor);
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod Increasing Slope'));
saveas(gcf,'box_PosMod_Increasing_Slope.fig');
saveas(gcf,'box_PosMod_Increasing_Slope.jpg');

%Negative
inc_slope_struct.CA1_40Hz = neg_40_hip.inc_slope;
inc_slope_struct.CA1_140Hz = neg_140_hip.inc_slope;
inc_slope_struct.CA1_1000Hz = neg_1000_hip.inc_slope;
inc_slope_struct.M1_40Hz = neg_40_cort.inc_slope;
inc_slope_struct.M1_140Hz = neg_140_cort.inc_slope;
inc_slope_struct.M1_1000Hz = neg_1000_cort.inc_slope;

neg_inc_slope_pvals = anova_bonferroni_box(inc_slope_struct,bcolor);
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod Increasing Slope'));
saveas(gcf,'box_NegMod_Increasing_Slope.fig');
saveas(gcf,'box_NegMod_Increasing_Slope.jpg');

%Rebound
inc_slope_struct.CA1_40Hz = reb_40_hip.inc_slope;
inc_slope_struct.CA1_140Hz = reb_140_hip.inc_slope;
inc_slope_struct.CA1_1000Hz = reb_1000_hip.inc_slope;
inc_slope_struct.M1_40Hz = reb_40_cort.inc_slope;
inc_slope_struct.M1_140Hz = reb_140_cort.inc_slope;
inc_slope_struct.M1_1000Hz = reb_1000_cort.inc_slope;

reb_inc_slope_pvals = anova_bonferroni_box(inc_slope_struct,bcolor);
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound Increasing Slope'));
saveas(gcf,'box_Reb_Increasing_Slope.fig');
saveas(gcf,'box_Reb_Increasing_Slope.jpg');

%% ============================== Decreasing Slope =========================%
%Positive
dec_slope_struct.CA1_40Hz = pos_40_hip.dec_slope;
dec_slope_struct.CA1_140Hz = pos_140_hip.dec_slope;
dec_slope_struct.CA1_1000Hz = pos_1000_hip.dec_slope;
dec_slope_struct.M1_40Hz = pos_40_cort.dec_slope;
dec_slope_struct.M1_140Hz = pos_140_cort.dec_slope;
dec_slope_struct.M1_1000Hz = pos_1000_cort.dec_slope;

pos_dec_slope_pvals = anova_bonferroni_box(dec_slope_struct,bcolor);
ylabel('Decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod Decreasing Slope'));
saveas(gcf,'box_PosMod_Decreasing_Slope.fig');
saveas(gcf,'box_PosMod_Decreasing_Slope.jpg');

%Negative
dec_slope_struct.CA1_40Hz = neg_40_hip.dec_slope;
dec_slope_struct.CA1_140Hz = neg_140_hip.dec_slope;
dec_slope_struct.CA1_1000Hz = neg_1000_hip.dec_slope;
dec_slope_struct.M1_40Hz = neg_40_cort.dec_slope;
dec_slope_struct.M1_140Hz = neg_140_cort.dec_slope;
dec_slope_struct.M1_1000Hz = neg_1000_cort.dec_slope;

neg_dec_slope_pvals = anova_bonferroni_box(dec_slope_struct,bcolor);
ylabel('Decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod Decreasing Slope'));
saveas(gcf,'box_NegMod_Decreasing_Slope.fig');
saveas(gcf,'box_NegMod_Decreasing_Slope.jpg');

%Rebound
dec_slope_struct.CA1_40Hz = reb_40_hip.dec_slope;
dec_slope_struct.CA1_140Hz = reb_140_hip.dec_slope;
dec_slope_struct.CA1_1000Hz = reb_1000_hip.dec_slope;
dec_slope_struct.M1_40Hz = reb_40_cort.dec_slope;
dec_slope_struct.M1_140Hz = reb_140_cort.dec_slope;
dec_slope_struct.M1_1000Hz = reb_1000_cort.dec_slope;

reb_dec_slope_pvals = anova_bonferroni_box(dec_slope_struct,bcolor);
ylabel('Decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound Decreasing Slope'));
saveas(gcf,'box_Reb_Decreasing_Slope.fig');
saveas(gcf,'box_Reb_Decreasing_Slope.jpg');
%% ============================== AUC ======================================%
%Positive
auc_struct.CA1_40Hz = pos_40_hip.auc;
auc_struct.CA1_140Hz = pos_140_hip.auc;
auc_struct.CA1_1000Hz = pos_1000_hip.auc;
auc_struct.M1_40Hz = pos_40_cort.auc;
auc_struct.M1_140Hz = pos_140_cort.auc;
auc_struct.M1_1000Hz = pos_1000_cort.auc;

pos_auc_pvals = anova_bonferroni_box(auc_struct,bcolor);
ylabel('AUC');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod AUC'));
saveas(gcf,'box_PosMod_AUC.fig');
saveas(gcf,'box_PosMod_AUC.jpg');

%Negative
auc_struct.CA1_40Hz = neg_40_hip.auc;
auc_struct.CA1_140Hz = neg_140_hip.auc;
auc_struct.CA1_1000Hz = neg_1000_hip.auc;
auc_struct.M1_40Hz = neg_40_cort.auc;
auc_struct.M1_140Hz = neg_140_cort.auc;
auc_struct.M1_1000Hz = neg_1000_cort.auc;

neg_auc_pvals = anova_bonferroni_box(auc_struct,bcolor);
ylabel('AUC');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod AUC'));
saveas(gcf,'box_NegMod_AUC.fig');
saveas(gcf,'box_NegMod_AUC.jpg');

%Rebound
auc_struct.CA1_40Hz = reb_40_hip.only_reb_auc;
auc_struct.CA1_140Hz = reb_140_hip.only_reb_auc;
auc_struct.CA1_1000Hz = reb_1000_hip.only_reb_auc;
auc_struct.M1_40Hz = reb_40_cort.only_reb_auc;
auc_struct.M1_140Hz = reb_140_cort.only_reb_auc;
auc_struct.M1_1000Hz = reb_1000_cort.only_reb_auc;

reb_auc_pvals = anova_bonferroni_box(auc_struct,bcolor);
ylabel('AUC');
xlabel('Stimulation Frequency');
title(sprintf('Only Rebound AUC'));
saveas(gcf,'box_only_Reb_AUC.fig');
saveas(gcf,'box_only_Reb_AUC.jpg');

%% ========================= Time-to-Peak ==================================%
%Positive
ttp_struct.CA1_40Hz = pos_40_hip.locs/Fs;
ttp_struct.CA1_140Hz = pos_140_hip.locs/Fs;
ttp_struct.CA1_1000Hz = pos_1000_hip.locs/Fs;
ttp_struct.M1_40Hz = pos_40_cort.locs/Fs;
ttp_struct.M1_140Hz = pos_140_cort.locs/Fs;
ttp_struct.M1_1000Hz = pos_1000_cort.locs/Fs;

pos_ttp_pvals = anova_bonferroni_box(ttp_struct,bcolor);
ylabel('Time-to-Peak (seconds)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod Time-to-Peak'));
saveas(gcf,'box_PosMod_TTP.fig');
saveas(gcf,'box_PosMod_TTP.jpg');

%Negative
ttp_struct.CA1_40Hz = neg_40_hip.locs/Fs;
ttp_struct.CA1_140Hz = neg_140_hip.locs/Fs;
ttp_struct.CA1_1000Hz = neg_1000_hip.locs/Fs;
ttp_struct.M1_40Hz = neg_40_cort.locs/Fs;
ttp_struct.M1_140Hz = neg_140_cort.locs/Fs;
ttp_struct.M1_1000Hz = neg_1000_cort.locs/Fs;

neg_ttp_pvals = anova_bonferroni_box(ttp_struct,bcolor);
ylabel('Time-to-Peak (seconds)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod Time-to-Peak'));
saveas(gcf,'box_NegMod_TTP.fig');
saveas(gcf,'box_NegMod_TTP.jpg');

%Rebound
ttp_struct.CA1_40Hz = reb_40_hip.locs/Fs;
ttp_struct.CA1_140Hz = reb_140_hip.locs/Fs;
ttp_struct.CA1_1000Hz = reb_1000_hip.locs/Fs;
ttp_struct.M1_40Hz = reb_40_cort.locs/Fs;
ttp_struct.M1_140Hz = reb_140_cort.locs/Fs;
ttp_struct.M1_1000Hz = reb_1000_cort.locs/Fs;

reb_ttp_pvals = anova_bonferroni_box(ttp_struct,bcolor);
ylabel('Time-to-Peak (seconds)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound Time-to-Peak'));
saveas(gcf,'box_Reb_TTP.fig');
saveas(gcf,'box_Reb_TTP.jpg');

%% ============================= FWHM ======================================%
%Positive
fwhm_struct.CA1_40Hz = pos_40_hip.fwhm/Fs;
fwhm_struct.CA1_140Hz = pos_140_hip.fwhm/Fs;
fwhm_struct.CA1_1000Hz = pos_1000_hip.fwhm/Fs;
fwhm_struct.M1_40Hz = pos_40_cort.fwhm/Fs;
fwhm_struct.M1_140Hz = pos_140_cort.fwhm/Fs;
fwhm_struct.M1_1000Hz = pos_1000_cort.fwhm/Fs;

pos_fwhm_pvals = anova_bonferroni_box(fwhm_struct,bcolor);
ylabel('FWHM (seconds)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod FWHM'));
saveas(gcf,'box_PosMod_FWHM.fig');
saveas(gcf,'box_PosMod_FWHM.jpg');

%Negative
fwhm_struct.CA1_40Hz = neg_40_hip.fwhm/Fs;
fwhm_struct.CA1_140Hz = neg_140_hip.fwhm/Fs;
fwhm_struct.CA1_1000Hz = neg_1000_hip.fwhm/Fs;
fwhm_struct.M1_40Hz = neg_40_cort.fwhm/Fs;
fwhm_struct.M1_140Hz = neg_140_cort.fwhm/Fs;
fwhm_struct.M1_1000Hz = neg_1000_cort.fwhm/Fs;

neg_fwhm_pvals = anova_bonferroni_box(fwhm_struct,bcolor);
ylabel('FWHM (seconds)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod FWHM'));
saveas(gcf,'box_NegMod_FWHM.fig');
saveas(gcf,'box_NegMod_FWHM.jpg');

%Rebound
fwhm_struct.CA1_40Hz = reb_40_hip.fwhm/Fs;
fwhm_struct.CA1_140Hz = reb_140_hip.fwhm/Fs;
fwhm_struct.CA1_1000Hz = reb_1000_hip.fwhm/Fs;
fwhm_struct.M1_40Hz = reb_40_cort.fwhm/Fs;
fwhm_struct.M1_140Hz = reb_140_cort.fwhm/Fs;
fwhm_struct.M1_1000Hz = reb_1000_cort.fwhm/Fs;

reb_fwhm_pvals = anova_bonferroni_box(fwhm_struct,bcolor);
ylabel('FWHM (seconds)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound FWHM'));
saveas(gcf,'box_Reb_FWHM.fig');
saveas(gcf,'box_Reb_FWHM.jpg');

%% ============================= Peak Height ===============================%
%Positive
pkht_struct.CA1_40Hz = pos_40_hip.pks;
pkht_struct.CA1_140Hz = pos_140_hip.pks;
pkht_struct.CA1_1000Hz = pos_1000_hip.pks;
pkht_struct.M1_40Hz = pos_40_cort.pks;
pkht_struct.M1_140Hz = pos_140_cort.pks;
pkht_struct.M1_1000Hz = pos_1000_cort.pks;

pos_pkht_pvals = anova_bonferroni_box(pkht_struct,bcolor);
ylabel('Peak Height (df/f)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod Peak Height'));
saveas(gcf,'box_PosMod_PkHt.fig');
saveas(gcf,'box_PosMod_PkHt.jpg');

%Negative
pkht_struct.CA1_40Hz = neg_40_hip.pks;
pkht_struct.CA1_140Hz = neg_140_hip.pks;
pkht_struct.CA1_1000Hz = neg_1000_hip.pks;
pkht_struct.M1_40Hz = neg_40_cort.pks;
pkht_struct.M1_140Hz = neg_140_cort.pks;
pkht_struct.M1_1000Hz = neg_1000_cort.pks;

neg_pkht_pvals = anova_bonferroni_box(pkht_struct,bcolor);
ylabel('Peak Height (df/f)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod Peak Height'));
saveas(gcf,'box_NegMod_PkHt.fig');
saveas(gcf,'box_NegMod_PkHt.jpg');

%Rebound
pkht_struct.CA1_40Hz = reb_40_hip.pks;
pkht_struct.CA1_140Hz = reb_140_hip.pks;
pkht_struct.CA1_1000Hz = reb_1000_hip.pks;
pkht_struct.M1_40Hz = reb_40_cort.pks;
pkht_struct.M1_140Hz = reb_140_cort.pks;
pkht_struct.M1_1000Hz = reb_1000_cort.pks;

reb_pkht_pvals = anova_bonferroni_box(pkht_struct,bcolor);
ylabel('Peak Height (df/f)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound Peak Height'));
saveas(gcf,'box_Reb_PkHt.fig');
saveas(gcf,'box_Reb_PkHt.jpg');

%% =============================== LHS =====================================%
%Positive
lhs_struct.CA1_40Hz = pos_40_hip.lhs;
lhs_struct.CA1_140Hz = pos_140_hip.lhs;
lhs_struct.CA1_1000Hz = pos_1000_hip.lhs;
lhs_struct.M1_40Hz = pos_40_cort.lhs;
lhs_struct.M1_140Hz = pos_140_cort.lhs;
lhs_struct.M1_1000Hz = pos_1000_cort.lhs;

pos_lhs_pvals = anova_bonferroni_box(lhs_struct,bcolor);
ylabel('Asymmetry LHS (frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod Asymmetry (LHS)'));
saveas(gcf,'box_PosMod_LHS.fig');
saveas(gcf,'box_PosMod_LHS.jpg');

%Negative
lhs_struct.CA1_40Hz = neg_40_hip.lhs;
lhs_struct.CA1_140Hz = neg_140_hip.lhs;
lhs_struct.CA1_1000Hz = neg_1000_hip.lhs;
lhs_struct.M1_40Hz = neg_40_cort.lhs;
lhs_struct.M1_140Hz = neg_140_cort.lhs;
lhs_struct.M1_1000Hz = neg_1000_cort.lhs;

neg_lhs_pvals = anova_bonferroni_box(lhs_struct,bcolor);
ylabel('Asymmetry LHS (frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod Asymmetry (LHS)'));
saveas(gcf,'box_NegMod_LHS.fig');
saveas(gcf,'box_NegMod_LHS.jpg');

%Rebound
lhs_struct.CA1_40Hz = reb_40_hip.lhs;
lhs_struct.CA1_140Hz = reb_140_hip.lhs;
lhs_struct.CA1_1000Hz = reb_1000_hip.lhs;
lhs_struct.M1_40Hz = reb_40_cort.lhs;
lhs_struct.M1_140Hz = reb_140_cort.lhs;
lhs_struct.M1_1000Hz = reb_1000_cort.lhs;

reb_lhs_pvals = anova_bonferroni_box(lhs_struct,bcolor);
ylabel('Asymmetry LHS (frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound Asymmetry (LHS)'));
saveas(gcf,'box_Reb_LHS.fig');
saveas(gcf,'box_Reb_LHS.jpg');

%% ============================== RHS ====================================%
%Positive
rhs_struct.CA1_40Hz = pos_40_hip.rhs;
rhs_struct.CA1_140Hz = pos_140_hip.rhs;
rhs_struct.CA1_1000Hz = pos_1000_hip.rhs;
rhs_struct.M1_40Hz = pos_40_cort.rhs;
rhs_struct.M1_140Hz = pos_140_cort.rhs;
rhs_struct.M1_1000Hz = pos_1000_cort.rhs;

pos_rhs_pvals = anova_bonferroni_box(rhs_struct,bcolor);
ylabel('Asymmetry RHS (frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod Asymmetry (RHS)'));
saveas(gcf,'box_PosMod_RHS.fig');
saveas(gcf,'box_PosMod_RHS.jpg');

%Negative
rhs_struct.CA1_40Hz = neg_40_hip.rhs;
rhs_struct.CA1_140Hz = neg_140_hip.rhs;
rhs_struct.CA1_1000Hz = neg_1000_hip.rhs;
rhs_struct.M1_40Hz = neg_40_cort.rhs;
rhs_struct.M1_140Hz = neg_140_cort.rhs;
rhs_struct.M1_1000Hz = neg_1000_cort.rhs;

neg_rhs_pvals = anova_bonferroni_box(rhs_struct,bcolor);
ylabel('Asymmetry RHS (frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod Asymmetry (RHS)'));
saveas(gcf,'box_NegMod_RHS.fig');
saveas(gcf,'box_NegMod_RHS.jpg');

%Rebound
rhs_struct.CA1_40Hz = reb_40_hip.rhs;
rhs_struct.CA1_140Hz = reb_140_hip.rhs;
rhs_struct.CA1_1000Hz = reb_1000_hip.rhs;
rhs_struct.M1_40Hz = reb_40_cort.rhs;
rhs_struct.M1_140Hz = reb_140_cort.rhs;
rhs_struct.M1_1000Hz = reb_1000_cort.rhs;

reb_rhs_pvals = anova_bonferroni_box(rhs_struct,bcolor);
ylabel('Asymmetry RHS (frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound Asymmetry (RHS)'));
saveas(gcf,'box_Reb_RHS.fig');
saveas(gcf,'box_Reb_RHS.jpg');

%% Compile Pvals struct
pvals_struct.inc_slope.pos.all = pos_inc_slope_pvals;
pvals_struct.inc_slope.neg.all = neg_inc_slope_pvals;
pvals_struct.inc_slope.reb.all = reb_inc_slope_pvals;

pvals_struct.dec_slope.pos.all = pos_dec_slope_pvals;
pvals_struct.dec_slope.neg.all = neg_dec_slope_pvals;
pvals_struct.dec_slope.reb.all = reb_dec_slope_pvals;

pvals_struct.auc.pos.all = pos_auc_pvals;
pvals_struct.auc.neg.all = neg_auc_pvals;
pvals_struct.auc.reb.all = reb_auc_pvals;

pvals_struct.fwhm.pos.all = pos_fwhm_pvals;
pvals_struct.fwhm.neg.all = neg_fwhm_pvals;
pvals_struct.fwhm.reb.all = reb_fwhm_pvals;

pvals_struct.ttp.pos.all = pos_ttp_pvals;
pvals_struct.ttp.neg.all = neg_ttp_pvals;
pvals_struct.ttp.reb.all = reb_ttp_pvals;

pvals_struct.pkht.pos.all = pos_pkht_pvals;
pvals_struct.pkht.neg.all = neg_pkht_pvals;
pvals_struct.pkht.reb.all = reb_pkht_pvals;

pvals_struct.lhs.pos.all = pos_lhs_pvals;
pvals_struct.lhs.neg.all = neg_lhs_pvals;
pvals_struct.lhs.reb.all = reb_lhs_pvals;

pvals_struct.rhs.pos.all = pos_rhs_pvals;
pvals_struct.rhs.neg.all = neg_rhs_pvals;
pvals_struct.rhs.reb.all = reb_rhs_pvals;
end
