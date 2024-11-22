%compare_1000Hz_ttest.m
% Author: Cara Ravasio
% Date: 04/18/23
% Purpose: Just cleans up the waveform characterization script.

function pvals_struct = compare_1000Hz_ttest(pos_1000_hip,pos_1000_cort, ...
                                             neg_1000_hip,neg_1000_cort,...
                                             reb_1000_hip,reb_1000_cort,...
                                             pvals_struct,bcolor)
%% ============================== Increasing Slope =========================%
%Positive
inc_slope_struct.CA1_1000Hz = pos_1000_hip.inc_slope;
inc_slope_struct.M1_1000Hz = pos_1000_cort.inc_slope;

[pos_inc_slope_pvals_1000] = anova_ttest_bonferroni_box(inc_slope_struct,bcolor([5,6],:));
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod Increasing Slope (1000Hz)'));
saveas(gcf,['box_1000Hz_PosMod_Increasing_Slope.fig']);
saveas(gcf,['box_1000Hz_PosMod_Increasing_Slope.jpg']);

%Negative
inc_slope_struct.CA1_1000Hz = neg_1000_hip.inc_slope;
inc_slope_struct.M1_1000Hz = neg_1000_cort.inc_slope;

[neg_inc_slope_pvals_1000] = anova_ttest_bonferroni_box(inc_slope_struct,bcolor([5,6],:));
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod Increasing Slope (1000Hz)'));
saveas(gcf,['box_1000Hz_NegMod_Increasing_Slope.fig']);
saveas(gcf,['box_1000Hz_NegMod_Increasing_Slope.jpg']);

%Rebound
inc_slope_struct.CA1_1000Hz = reb_1000_hip.inc_slope;
inc_slope_struct.M1_1000Hz = reb_1000_cort.inc_slope;

[reb_inc_slope_pvals_1000] = anova_ttest_bonferroni_box(inc_slope_struct,bcolor([5,6],:));
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Reb Increasing Slope (1000Hz)'));
saveas(gcf,['box_1000Hz_RebMod_Increasing_Slope.fig']);
saveas(gcf,['box_1000Hz_RebMod_Increasing_Slope.jpg']);
%% ============================== Decreasing Slope =========================%
%Positive
dec_slope_struct.CA1_1000Hz = pos_1000_hip.dec_slope;
dec_slope_struct.M1_1000Hz = pos_1000_cort.dec_slope;

[pos_dec_slope_pvals_1000] = anova_ttest_bonferroni_box(dec_slope_struct,bcolor([5,6],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod decreasing Slope (1000Hz)'));
saveas(gcf,['box_1000Hz_PosMod_decreasing_Slope.fig']);
saveas(gcf,['box_1000Hz_PosMod_decreasing_Slope.jpg']);

%Negative
dec_slope_struct.CA1_1000Hz = neg_1000_hip.dec_slope;
dec_slope_struct.M1_1000Hz = neg_1000_cort.dec_slope;

[neg_dec_slope_pvals_1000] = anova_ttest_bonferroni_box(dec_slope_struct,bcolor([5,6],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod decreasing Slope (1000Hz)'));
saveas(gcf,['box_1000Hz_NegMod_decreasing_Slope.fig']);
saveas(gcf,['box_1000Hz_NegMod_decreasing_Slope.jpg']);

%Rebound
dec_slope_struct.CA1_1000Hz = reb_1000_hip.dec_slope;
dec_slope_struct.M1_1000Hz = reb_1000_cort.dec_slope;

[reb_dec_slope_pvals_1000] = anova_ttest_bonferroni_box(dec_slope_struct,bcolor([5,6],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Reb decreasing Slope (1000Hz)'));
saveas(gcf,['box_1000Hz_RebMod_decreasing_Slope.fig']);
saveas(gcf,['box_1000Hz_RebMod_decreasing_Slope.jpg']);
%% ==================================== AUC ================================%
%Positive
auc_struct.CA1_1000Hz = pos_1000_hip.auc;
auc_struct.M1_1000Hz = pos_1000_cort.auc;

[pos_auc_pvals_1000] = anova_ttest_bonferroni_box(auc_struct,bcolor([5,6],:));
ylabel('AUC (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod AUC (1000Hz)'));
saveas(gcf,['box_1000Hz_PosMod_AUC.fig']);
saveas(gcf,['box_1000Hz_PosMod_AUC.jpg']);

%Negative
auc_struct.CA1_1000Hz = neg_1000_hip.auc;
auc_struct.M1_1000Hz = neg_1000_cort.auc;

[neg_auc_pvals_1000] = anova_ttest_bonferroni_box(auc_struct,bcolor([5,6],:));
ylabel('AUC (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod AUC (1000Hz)'));
saveas(gcf,['box_1000Hz_NegMod_AUC.fig']);
saveas(gcf,['box_1000Hz_NegMod_AUC.jpg']);

%Rebound
auc_struct.CA1_1000Hz = reb_1000_hip.auc;
auc_struct.M1_1000Hz = reb_1000_cort.auc;

[reb_auc_pvals_1000] = anova_ttest_bonferroni_box(auc_struct,bcolor([5,6],:));
ylabel('AUC (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Reb AUC (1000Hz)'));
saveas(gcf,['box_1000Hz_RebMod_AUC.fig']);
saveas(gcf,['box_1000Hz_RebMod_AUC.jpg']);
%% ================================ Time-To_Peak ===========================%
%Positive
ttp_struct.CA1_1000Hz = pos_1000_hip.locs;
ttp_struct.M1_1000Hz = pos_1000_cort.locs;

[pos_ttp_pvals_1000] = anova_ttest_bonferroni_box(ttp_struct,bcolor([5,6],:));
ylabel('ttp (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod ttp (1000Hz)'));
saveas(gcf,['box_1000Hz_PosMod_ttp.fig']);
saveas(gcf,['box_1000Hz_PosMod_ttp.jpg']);

%Negative
ttp_struct.CA1_1000Hz = neg_1000_hip.locs;
ttp_struct.M1_1000Hz = neg_1000_cort.locs;

[neg_ttp_pvals_1000] = anova_ttest_bonferroni_box(ttp_struct,bcolor([5,6],:));
ylabel('ttp (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod ttp (1000Hz)'));
saveas(gcf,['box_1000Hz_NegMod_ttp.fig']);
saveas(gcf,['box_1000Hz_NegMod_ttp.jpg']);

%Rebound
ttp_struct.CA1_1000Hz = reb_1000_hip.locs;
ttp_struct.M1_1000Hz = reb_1000_cort.locs;

[reb_ttp_pvals_1000] = anova_ttest_bonferroni_box(ttp_struct,bcolor([5,6],:));
ylabel('ttp (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Reb ttp (1000Hz)'));
saveas(gcf,['box_1000Hz_RebMod_ttp.fig']);
saveas(gcf,['box_1000Hz_RebMod_ttp.jpg']);
%% =================================== FWHM ================================%
%Positive
fwhm_struct.CA1_1000Hz = pos_1000_hip.fwhm;
fwhm_struct.M1_1000Hz = pos_1000_cort.fwhm;

[pos_fwhm_pvals_1000] = anova_ttest_bonferroni_box(fwhm_struct,bcolor([5,6],:));
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod fwhm (1000Hz)'));
saveas(gcf,['box_1000Hz_PosMod_fwhm.fig']);
saveas(gcf,['box_1000Hz_PosMod_fwhm.jpg']);

%Negative
fwhm_struct.CA1_1000Hz = neg_1000_hip.fwhm;
fwhm_struct.M1_1000Hz = neg_1000_cort.fwhm;

[neg_fwhm_pvals_1000] = anova_ttest_bonferroni_box(fwhm_struct,bcolor([5,6],:));
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod fwhm (1000Hz)'));
saveas(gcf,['box_1000Hz_NegMod_fwhm.fig']);
saveas(gcf,['box_1000Hz_NegMod_fwhm.jpg']);

%Rebound
fwhm_struct.CA1_1000Hz = reb_1000_hip.fwhm;
fwhm_struct.M1_1000Hz = reb_1000_cort.fwhm;

[reb_fwhm_pvals_1000] = anova_ttest_bonferroni_box(fwhm_struct,bcolor([5,6],:));
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Reb fwhm (1000Hz)'));
saveas(gcf,['box_1000Hz_RebMod_fwhm.fig']);
saveas(gcf,['box_1000Hz_RebMod_fwhm.jpg']);
%% ================================ Peak Height ============================%
%Positive
pkht_struct.CA1_1000Hz = pos_1000_hip.pks;
pkht_struct.M1_1000Hz = pos_1000_cort.pks;

[pos_pkht_pvals_1000] = anova_ttest_bonferroni_box(pkht_struct,bcolor([5,6],:));
ylabel('pkht (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod pkht (1000Hz)'));
saveas(gcf,['box_1000Hz_PosMod_pkht.fig']);
saveas(gcf,['box_1000Hz_PosMod_pkht.jpg']);

%Negative
pkht_struct.CA1_1000Hz = neg_1000_hip.pks;
pkht_struct.M1_1000Hz = neg_1000_cort.pks;

[neg_pkht_pvals_1000] = anova_ttest_bonferroni_box(pkht_struct,bcolor([5,6],:));
ylabel('pkht (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod pkht (1000Hz)'));
saveas(gcf,['box_1000Hz_NegMod_pkht.fig']);
saveas(gcf,['box_1000Hz_NegMod_pkht.jpg']);

%Rebound
pkht_struct.CA1_1000Hz = reb_1000_hip.pks;
pkht_struct.M1_1000Hz = reb_1000_cort.pks;

[reb_pkht_pvals_1000] = anova_ttest_bonferroni_box(pkht_struct,bcolor([5,6],:));
ylabel('pkht (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Reb pkht (1000Hz)'));
saveas(gcf,['box_1000Hz_RebMod_pkht.fig']);
saveas(gcf,['box_1000Hz_RebMod_pkht.jpg']);
%% =================================== LHS =================================%
%Positive
lhs_struct.CA1_1000Hz = pos_1000_hip.lhs;
lhs_struct.M1_1000Hz = pos_1000_cort.lhs;

[pos_lhs_pvals_1000] = anova_ttest_bonferroni_box(lhs_struct,bcolor([5,6],:));
ylabel('lhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod lhs (1000Hz)'));
saveas(gcf,['box_1000Hz_PosMod_lhs.fig']);
saveas(gcf,['box_1000Hz_PosMod_lhs.jpg']);

%Negative
lhs_struct.CA1_1000Hz = neg_1000_hip.lhs;
lhs_struct.M1_1000Hz = neg_1000_cort.lhs;

[neg_lhs_pvals_1000] = anova_ttest_bonferroni_box(lhs_struct,bcolor([5,6],:));
ylabel('lhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod lhs (1000Hz)'));
saveas(gcf,['box_1000Hz_NegMod_lhs.fig']);
saveas(gcf,['box_1000Hz_NegMod_lhs.jpg']);

%Rebound
lhs_struct.CA1_1000Hz = reb_1000_hip.lhs;
lhs_struct.M1_1000Hz = reb_1000_cort.lhs;

[reb_lhs_pvals_1000] = anova_ttest_bonferroni_box(lhs_struct,bcolor([5,6],:));
ylabel('lhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Reb lhs (1000Hz)'));
saveas(gcf,['box_1000Hz_RebMod_lhs.fig']);
saveas(gcf,['box_1000Hz_RebMod_lhs.jpg']);
%% =================================== RHS =================================%
%Positive
rhs_struct.CA1_1000Hz = pos_1000_hip.rhs;
rhs_struct.M1_1000Hz = pos_1000_cort.rhs;

[pos_rhs_pvals_1000] = anova_ttest_bonferroni_box(rhs_struct,bcolor([5,6],:));
ylabel('rhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod rhs (1000Hz)'));
saveas(gcf,['box_1000Hz_PosMod_rhs.fig']);
saveas(gcf,['box_1000Hz_PosMod_rhs.jpg']);

%Negative
rhs_struct.CA1_1000Hz = neg_1000_hip.rhs;
rhs_struct.M1_1000Hz = neg_1000_cort.rhs;

[neg_rhs_pvals_1000] = anova_ttest_bonferroni_box(rhs_struct,bcolor([5,6],:));
ylabel('rhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod rhs (1000Hz)'));
saveas(gcf,['box_1000Hz_NegMod_rhs.fig']);
saveas(gcf,['box_1000Hz_NegMod_rhs.jpg']);

%Rebound
rhs_struct.CA1_1000Hz = reb_1000_hip.rhs;
rhs_struct.M1_1000Hz = reb_1000_cort.rhs;

[reb_rhs_pvals_1000] = anova_ttest_bonferroni_box(rhs_struct,bcolor([5,6],:));
ylabel('rhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Reb rhs (1000Hz)'));
saveas(gcf,['box_1000Hz_RebMod_rhs.fig']);
saveas(gcf,['box_1000Hz_RebMod_rhs.jpg']);


%% Save Pvals struct
pvals_struct.inc_slope.pos.Hz1000 = pos_inc_slope_pvals_1000;
pvals_struct.inc_slope.neg.Hz1000 = neg_inc_slope_pvals_1000;
pvals_struct.inc_slope.reb.Hz1000 = reb_inc_slope_pvals_1000;

pvals_struct.dec_slope.pos.Hz1000 = pos_dec_slope_pvals_1000;
pvals_struct.dec_slope.neg.Hz1000 = neg_dec_slope_pvals_1000;
pvals_struct.dec_slope.reb.Hz1000 = reb_dec_slope_pvals_1000;

pvals_struct.auc.pos.Hz1000 = pos_auc_pvals_1000;
pvals_struct.auc.neg.Hz1000 = neg_auc_pvals_1000;
pvals_struct.auc.reb.Hz1000 = reb_auc_pvals_1000;

pvals_struct.fwhm.pos.Hz1000 = pos_fwhm_pvals_1000;
pvals_struct.fwhm.neg.Hz1000 = neg_fwhm_pvals_1000;
pvals_struct.fwhm.reb.Hz1000 = reb_fwhm_pvals_1000;

pvals_struct.ttp.pos.Hz1000 = pos_ttp_pvals_1000;
pvals_struct.ttp.neg.Hz1000 = neg_ttp_pvals_1000;
pvals_struct.ttp.reb.Hz1000 = reb_ttp_pvals_1000;

pvals_struct.pkht.pos.Hz1000 = pos_pkht_pvals_1000;
pvals_struct.pkht.neg.Hz1000 = neg_pkht_pvals_1000;
pvals_struct.pkht.reb.Hz1000 = reb_pkht_pvals_1000;

pvals_struct.lhs.pos.Hz1000 = pos_lhs_pvals_1000;
pvals_struct.lhs.neg.Hz1000 = neg_lhs_pvals_1000;
pvals_struct.lhs.reb.Hz1000 = reb_lhs_pvals_1000;

pvals_struct.rhs.pos.Hz1000 = pos_rhs_pvals_1000;
pvals_struct.rhs.neg.Hz1000 = neg_rhs_pvals_1000;
pvals_struct.rhs.reb.Hz1000 = reb_rhs_pvals_1000;
end