% compare_CA1_anovan.m
% Author: Cara Ravasio
% Date: 04/18/23
% Purpose: Just cleans up the waveform characterization script.

function pvals_struct = compare_CA1_anovan(pos_40_hip,pos_140_hip,pos_1000_hip,...
                                            neg_40_hip, neg_140_hip, neg_1000_hip,...
                                            reb_40_hip, reb_140_hip,reb_1000_hip,...
                                            pvals_struct,bcolor)
%% ============================== Increasing Slope =========================%
%Positive
inc_slope_struct.CA1_40Hz = pos_40_hip.inc_slope;
inc_slope_struct.CA1_140Hz = pos_140_hip.inc_slope;
inc_slope_struct.CA1_1000Hz = pos_1000_hip.inc_slope;

[pos_inc_slope_pvals_CA1] = anova_ttest_bonferroni_box(inc_slope_struct,bcolor([1,3,5],:));
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod Increasing Slope (CA1)'));
saveas(gcf,['box_CA1_PosMod_Increasing_Slope.fig']);
saveas(gcf,['box_CA1_PosMod_Increasing_Slope.jpg']);

%Negative
inc_slope_struct.CA1_40Hz = neg_40_hip.inc_slope;
inc_slope_struct.CA1_140Hz = neg_140_hip.inc_slope;
inc_slope_struct.CA1_1000Hz = neg_1000_hip.inc_slope;

[neg_inc_slope_pvals_CA1] = anova_ttest_bonferroni_box(inc_slope_struct,bcolor([1,3,5],:));
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod Increasing Slope (CA1)'));
saveas(gcf,['box_CA1_NegMod_Increasing_Slope.fig']);
saveas(gcf,['box_CA1_NegMod_Increasing_Slope.jpg']);

%Rebound
inc_slope_struct.CA1_40Hz = reb_40_hip.inc_slope;
inc_slope_struct.CA1_140Hz = reb_140_hip.inc_slope;
inc_slope_struct.CA1_1000Hz = reb_1000_hip.inc_slope;

[reb_inc_slope_pvals_CA1] = anova_ttest_bonferroni_box(inc_slope_struct,bcolor([1,3,5],:));
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound Increasing Slope (CA1)'));
saveas(gcf,['box_CA1_Reb_Increasing_Slope.fig']);
saveas(gcf,['box_CA1_Reb_Increasing_Slope.jpg']);
%% ============================== Decreasing Slope =========================%
%Positive
dec_slope_struct.CA1_40Hz = pos_40_hip.dec_slope;
dec_slope_struct.CA1_140Hz = pos_140_hip.dec_slope;
dec_slope_struct.CA1_1000Hz = pos_1000_hip.dec_slope;

[pos_dec_slope_pvals_CA1] = anova_ttest_bonferroni_box(dec_slope_struct,bcolor([1,3,5],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod decreasing Slope (CA1)'));
saveas(gcf,['box_CA1_PosMod_decreasing_Slope.fig']);
saveas(gcf,['box_CA1_PosMod_decreasing_Slope.jpg']);

%Negative
dec_slope_struct.CA1_40Hz = neg_40_hip.dec_slope;
dec_slope_struct.CA1_140Hz = neg_140_hip.dec_slope;
dec_slope_struct.CA1_1000Hz = neg_1000_hip.dec_slope;

[neg_dec_slope_pvals_CA1] = anova_ttest_bonferroni_box(dec_slope_struct,bcolor([1,3,5],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod decreasing Slope (CA1)'));
saveas(gcf,['box_CA1_NegMod_decreasing_Slope.fig']);
saveas(gcf,['box_CA1_NegMod_decreasing_Slope.jpg']);

%Rebound
dec_slope_struct.CA1_40Hz = reb_40_hip.dec_slope;
dec_slope_struct.CA1_140Hz = reb_140_hip.dec_slope;
dec_slope_struct.CA1_1000Hz = reb_1000_hip.dec_slope;

[reb_dec_slope_pvals_CA1] = anova_ttest_bonferroni_box(dec_slope_struct,bcolor([1,3,5],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound decreasing Slope (CA1)'));
saveas(gcf,['box_CA1_Reb_decreasing_Slope.fig']);
saveas(gcf,['box_CA1_Reb_decreasing_Slope.jpg']);
%% ==================================== AUC ================================%
%Positive
auc_struct.CA1_40Hz = pos_40_hip.auc;
auc_struct.CA1_140Hz = pos_140_hip.auc;
auc_struct.CA1_1000Hz = pos_1000_hip.auc;

[pos_auc_pvals_CA1] = anova_ttest_bonferroni_box(auc_struct,bcolor([1,3,5],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod AUC (CA1)'));
saveas(gcf,['box_CA1_PosMod_AUC.fig']);
saveas(gcf,['box_CA1_PosMod_AUC.jpg']);

%Negative
auc_struct.CA1_40Hz = neg_40_hip.auc;
auc_struct.CA1_140Hz = neg_140_hip.auc;
auc_struct.CA1_1000Hz = neg_1000_hip.auc;

[neg_auc_pvals_CA1] = anova_ttest_bonferroni_box(auc_struct,bcolor([1,3,5],:));
ylabel('AUC (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod AUC (CA1)'));
saveas(gcf,['box_CA1_NegMod_AUC.fig']);
saveas(gcf,['box_CA1_NegMod_AUC.jpg']);

%Rebound
auc_struct.CA1_40Hz = reb_40_hip.auc;
auc_struct.CA1_140Hz = reb_140_hip.auc;
auc_struct.CA1_1000Hz = reb_1000_hip.auc;

[reb_auc_pvals_CA1] = anova_ttest_bonferroni_box(auc_struct,bcolor([1,3,5],:));
ylabel('AUC (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound AUC (CA1)'));
saveas(gcf,['box_CA1_Reb_AUC.fig']);
saveas(gcf,['box_CA1_Reb_AUC.jpg']);
%% ================================ Time-To_Peak ===========================%
%Positive
ttp_struct.CA1_40Hz = pos_40_hip.locs;
ttp_struct.CA1_140Hz = pos_140_hip.locs;
ttp_struct.CA1_1000Hz = pos_1000_hip.locs;

[pos_ttp_pvals_CA1] = anova_ttest_bonferroni_box(ttp_struct,bcolor([1,3,5],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod ttp (CA1)'));
saveas(gcf,['box_CA1_PosMod_ttp.fig']);
saveas(gcf,['box_CA1_PosMod_ttp.jpg']);

%Negative
ttp_struct.CA1_40Hz = neg_40_hip.locs;
ttp_struct.CA1_140Hz = neg_140_hip.locs;
ttp_struct.CA1_1000Hz = neg_1000_hip.locs;

[neg_ttp_pvals_CA1] = anova_ttest_bonferroni_box(ttp_struct,bcolor([1,3,5],:));
ylabel('ttp (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod ttp (CA1)'));
saveas(gcf,['box_CA1_NegMod_ttp.fig']);
saveas(gcf,['box_CA1_NegMod_ttp.jpg']);

%Rebound
ttp_struct.CA1_40Hz = reb_40_hip.locs;
ttp_struct.CA1_140Hz = reb_140_hip.locs;
ttp_struct.CA1_1000Hz = reb_1000_hip.locs;

[reb_ttp_pvals_CA1] = anova_ttest_bonferroni_box(ttp_struct,bcolor([1,3,5],:));
ylabel('ttp (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound ttp (CA1)'));
saveas(gcf,['box_CA1_Reb_ttp.fig']);
saveas(gcf,['box_CA1_Reb_ttp.jpg']);
%% =================================== FWHM ================================%
%Positive
fwhm_struct.CA1_40Hz = pos_40_hip.fwhm;
fwhm_struct.CA1_140Hz = pos_140_hip.fwhm;
fwhm_struct.CA1_1000Hz = pos_1000_hip.fwhm;

[pos_fwhm_pvals_CA1] = anova_ttest_bonferroni_box(fwhm_struct,bcolor([1,3,5],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod fwhm (CA1)'));
saveas(gcf,['box_CA1_PosMod_fwhm.fig']);
saveas(gcf,['box_CA1_PosMod_fwhm.jpg']);

%Negative
fwhm_struct.CA1_40Hz = neg_40_hip.fwhm;
fwhm_struct.CA1_140Hz = neg_140_hip.fwhm;
fwhm_struct.CA1_1000Hz = neg_1000_hip.fwhm;

[neg_fwhm_pvals_CA1] = anova_ttest_bonferroni_box(fwhm_struct,bcolor([1,3,5],:));
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod fwhm (CA1)'));
saveas(gcf,['box_CA1_NegMod_fwhm.fig']);
saveas(gcf,['box_CA1_NegMod_fwhm.jpg']);

%Rebound
fwhm_struct.CA1_40Hz = reb_40_hip.fwhm;
fwhm_struct.CA1_140Hz = reb_140_hip.fwhm;
fwhm_struct.CA1_1000Hz = reb_1000_hip.fwhm;

[reb_fwhm_pvals_CA1] = anova_ttest_bonferroni_box(fwhm_struct,bcolor([1,3,5],:));
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound fwhm (CA1)'));
saveas(gcf,['box_CA1_Reb_fwhm.fig']);
saveas(gcf,['box_CA1_Reb_fwhm.jpg']);
%% ================================ Peak Height ============================%
%Positive
pkht_struct.CA1_40Hz = pos_40_hip.pks;
pkht_struct.CA1_140Hz = pos_140_hip.pks;
pkht_struct.CA1_1000Hz = pos_1000_hip.pks;

[pos_pkht_pvals_CA1] = anova_ttest_bonferroni_box(pkht_struct,bcolor([1,3,5],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod pkht (CA1)'));
saveas(gcf,['box_CA1_PosMod_pkht.fig']);
saveas(gcf,['box_CA1_PosMod_pkht.jpg']);

%Negative
pkht_struct.CA1_40Hz = neg_40_hip.pks;
pkht_struct.CA1_140Hz = neg_140_hip.pks;
pkht_struct.CA1_1000Hz = neg_1000_hip.pks;

[neg_pkht_pvals_CA1] = anova_ttest_bonferroni_box(pkht_struct,bcolor([1,3,5],:));
ylabel('pkht (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod pkht (CA1)'));
saveas(gcf,['box_CA1_NegMod_pkht.fig']);
saveas(gcf,['box_CA1_NegMod_pkht.jpg']);

%Rebound
pkht_struct.CA1_40Hz = reb_40_hip.pks;
pkht_struct.CA1_140Hz = reb_140_hip.pks;
pkht_struct.CA1_1000Hz = reb_1000_hip.pks;

[reb_pkht_pvals_CA1] = anova_ttest_bonferroni_box(pkht_struct,bcolor([1,3,5],:));
ylabel('pkht (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound pkht (CA1)'));
saveas(gcf,['box_CA1_Reb_pkht.fig']);
saveas(gcf,['box_CA1_Reb_pkht.jpg']);
%% =================================== LHS =================================%
%Positive
lhs_struct.CA1_40Hz = pos_40_hip.lhs;
lhs_struct.CA1_140Hz = pos_140_hip.lhs;
lhs_struct.CA1_1000Hz = pos_1000_hip.lhs;

[pos_lhs_pvals_CA1] = anova_ttest_bonferroni_box(lhs_struct,bcolor([1,3,5],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod lhs (CA1)'));
saveas(gcf,['box_CA1_PosMod_lhs.fig']);
saveas(gcf,['box_CA1_PosMod_lhs.jpg']);

%Negative
lhs_struct.CA1_40Hz = neg_40_hip.lhs;
lhs_struct.CA1_140Hz = neg_140_hip.lhs;
lhs_struct.CA1_1000Hz = neg_1000_hip.lhs;

[neg_lhs_pvals_CA1] = anova_ttest_bonferroni_box(lhs_struct,bcolor([1,3,5],:));
ylabel('lhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod lhs (CA1)'));
saveas(gcf,['box_CA1_NegMod_lhs.fig']);
saveas(gcf,['box_CA1_NegMod_lhs.jpg']);

%Rebound
lhs_struct.CA1_40Hz = reb_40_hip.lhs;
lhs_struct.CA1_140Hz = reb_140_hip.lhs;
lhs_struct.CA1_1000Hz = reb_1000_hip.lhs;

[reb_lhs_pvals_CA1] = anova_ttest_bonferroni_box(lhs_struct,bcolor([1,3,5],:));
ylabel('lhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound lhs (CA1)'));
saveas(gcf,['box_CA1_Reb_lhs.fig']);
saveas(gcf,['box_CA1_Reb_lhs.jpg']);
%% =================================== RHS =================================%
%Positive
rhs_struct.CA1_40Hz = pos_40_hip.rhs;
rhs_struct.CA1_140Hz = pos_140_hip.rhs;
rhs_struct.CA1_1000Hz = pos_1000_hip.rhs;

[pos_rhs_pvals_CA1] = anova_ttest_bonferroni_box(rhs_struct,bcolor([1,3,5],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod rhs (CA1)'));
saveas(gcf,['box_CA1_PosMod_rhs.fig']);
saveas(gcf,['box_CA1_PosMod_rhs.jpg']);

%Negative
rhs_struct.CA1_40Hz = neg_40_hip.rhs;
rhs_struct.CA1_140Hz = neg_140_hip.rhs;
rhs_struct.CA1_1000Hz = neg_1000_hip.rhs;

[neg_rhs_pvals_CA1] = anova_ttest_bonferroni_box(rhs_struct,bcolor([1,3,5],:));
ylabel('rhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod rhs (CA1)'));
saveas(gcf,['box_CA1_NegMod_rhs.fig']);
saveas(gcf,['box_CA1_NegMod_rhs.jpg']);

%Rebound
rhs_struct.CA1_40Hz = reb_40_hip.rhs;
rhs_struct.CA1_140Hz = reb_140_hip.rhs;
rhs_struct.CA1_1000Hz = reb_1000_hip.rhs;

[reb_rhs_pvals_CA1] = anova_ttest_bonferroni_box(rhs_struct,bcolor([1,3,5],:));
ylabel('rhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Rebound rhs (CA1)'));
saveas(gcf,['box_CA1_Reb_rhs.fig']);
saveas(gcf,['box_CA1_Reb_rhs.jpg']);

%% Save Pvals struct
pvals_struct.inc_slope.pos.CA1 = pos_inc_slope_pvals_CA1;
pvals_struct.inc_slope.neg.CA1 = neg_inc_slope_pvals_CA1;
pvals_struct.inc_slope.reb.CA1 = reb_inc_slope_pvals_CA1;

pvals_struct.dec_slope.pos.CA1 = pos_dec_slope_pvals_CA1;
pvals_struct.dec_slope.neg.CA1 = neg_dec_slope_pvals_CA1;
pvals_struct.dec_slope.reb.CA1 = reb_dec_slope_pvals_CA1;

pvals_struct.auc.pos.CA1 = pos_auc_pvals_CA1;
pvals_struct.auc.neg.CA1 = neg_auc_pvals_CA1;
pvals_struct.auc.reb.CA1 = reb_auc_pvals_CA1;

pvals_struct.fwhm.pos.CA1 = pos_fwhm_pvals_CA1;
pvals_struct.fwhm.neg.CA1 = neg_fwhm_pvals_CA1;
pvals_struct.fwhm.reb.CA1 = reb_fwhm_pvals_CA1;

pvals_struct.ttp.pos.CA1 = pos_ttp_pvals_CA1;
pvals_struct.ttp.neg.CA1 = neg_ttp_pvals_CA1;
pvals_struct.ttp.reb.CA1 = reb_ttp_pvals_CA1;

pvals_struct.pkht.pos.CA1 = pos_pkht_pvals_CA1;
pvals_struct.pkht.neg.CA1 = neg_pkht_pvals_CA1;
pvals_struct.pkht.reb.CA1 = reb_pkht_pvals_CA1;

pvals_struct.lhs.pos.CA1 = pos_lhs_pvals_CA1;
pvals_struct.lhs.neg.CA1 = neg_lhs_pvals_CA1;
pvals_struct.lhs.reb.CA1 = reb_lhs_pvals_CA1;

pvals_struct.rhs.pos.CA1 = pos_rhs_pvals_CA1;
pvals_struct.rhs.neg.CA1 = neg_rhs_pvals_CA1;
pvals_struct.rhs.reb.CA1 = reb_rhs_pvals_CA1;
end