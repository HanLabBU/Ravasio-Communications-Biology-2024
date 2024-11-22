% sess_compare_all_anovan.m
% Author: Cara Ravasio
% Date: 04/18/23
% Purpose: Just cleans up the waveform characterization script.
function pvals_struct = sess_compare_all_anovan(pos_40_hip,pos_140_hip,pos_1000_hip,...
                                    neg_40_hip, neg_140_hip, neg_1000_hip,...
                                    reb_40_hip, reb_140_hip,reb_1000_hip,...
                                    pos_40_cort,pos_140_cort,pos_1000_cort,...
                                    neg_40_cort, neg_140_cort, neg_1000_cort,...
                                    reb_40_cort, reb_140_cort,reb_1000_cort,...
                                    pvals_struct,bcolor,Fs)
                                
%% ============================ Inc Slope ==================================%
%Positive
temp_struct.CA1_40Hz = pos_40_hip.sess_inc_slope;
temp_struct.CA1_140Hz = pos_140_hip.sess_inc_slope;
temp_struct.CA1_1000Hz = pos_1000_hip.sess_inc_slope;
temp_struct.M1_40Hz = pos_40_cort.sess_inc_slope;
temp_struct.M1_140Hz = pos_140_cort.sess_inc_slope;
temp_struct.M1_1000Hz = pos_1000_cort.sess_inc_slope;
pos_sess_inc_slope_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Pos Mod Inc Slope of Sess-Avg Traces')
saveas(gcf,'Sess_Pos_IncSlope.fig');

%Negative
temp_struct.CA1_40Hz = neg_40_hip.sess_inc_slope;
temp_struct.CA1_140Hz = neg_140_hip.sess_inc_slope;
temp_struct.CA1_1000Hz = neg_1000_hip.sess_inc_slope;
temp_struct.M1_40Hz = neg_40_cort.sess_inc_slope;
temp_struct.M1_140Hz = neg_140_cort.sess_inc_slope;
temp_struct.M1_1000Hz = neg_1000_cort.sess_inc_slope;
neg_sess_inc_slope_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Neg Mod Inc Slope of Sess-Avg Traces')
saveas(gcf,'Sess_Neg_IncSlope.fig');

%Rebound
temp_struct.CA1_40Hz = reb_40_hip.sess_inc_slope;
temp_struct.CA1_140Hz = reb_140_hip.sess_inc_slope;
temp_struct.CA1_1000Hz = reb_1000_hip.sess_inc_slope;
temp_struct.M1_40Hz = reb_40_cort.sess_inc_slope;
temp_struct.M1_140Hz = reb_140_cort.sess_inc_slope;
temp_struct.M1_1000Hz = reb_1000_cort.sess_inc_slope;
reb_sess_inc_slope_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Reb Mod Inc Slope of Sess-Avg Traces')
saveas(gcf,'Sess_Reb_IncSlope.fig');

%% ============================ Dec Slope ==================================%
%Positive
temp_struct.CA1_40Hz = pos_40_hip.sess_dec_slope;
temp_struct.CA1_140Hz = pos_140_hip.sess_dec_slope;
temp_struct.CA1_1000Hz = pos_1000_hip.sess_dec_slope;
temp_struct.M1_40Hz = pos_40_cort.sess_dec_slope;
temp_struct.M1_140Hz = pos_140_cort.sess_dec_slope;
temp_struct.M1_1000Hz = pos_1000_cort.sess_dec_slope;
pos_sess_dec_slope_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Pos Mod Dec Slope of Sess-Avg Traces')
saveas(gcf,'Sess_Pos_DecSlope.fig');

%Negative
temp_struct.CA1_40Hz = neg_40_hip.sess_dec_slope;
temp_struct.CA1_140Hz = neg_140_hip.sess_dec_slope;
temp_struct.CA1_1000Hz = neg_1000_hip.sess_dec_slope;
temp_struct.M1_40Hz = neg_40_cort.sess_dec_slope;
temp_struct.M1_140Hz = neg_140_cort.sess_dec_slope;
temp_struct.M1_1000Hz = neg_1000_cort.sess_dec_slope;
neg_sess_dec_slope_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Neg Mod Dec Slope of Sess-Avg Traces')
saveas(gcf,'Sess_Neg_DecSlope.fig');

%Rebound
temp_struct.CA1_40Hz = reb_40_hip.sess_dec_slope;
temp_struct.CA1_140Hz = reb_140_hip.sess_dec_slope;
temp_struct.CA1_1000Hz = reb_1000_hip.sess_dec_slope;
temp_struct.M1_40Hz = reb_40_cort.sess_dec_slope;
temp_struct.M1_140Hz = reb_140_cort.sess_dec_slope;
temp_struct.M1_1000Hz = reb_1000_cort.sess_dec_slope;
reb_sess_dec_slope_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Reb Mod Dec Slope of Sess-Avg Traces')
saveas(gcf,'Sess_Reb_DecSlope.fig');

%% ================================ AUC ====================================%
%Positive
temp_struct.CA1_40Hz = pos_40_hip.sess_auc;
temp_struct.CA1_140Hz = pos_140_hip.sess_auc;
temp_struct.CA1_1000Hz = pos_1000_hip.sess_auc;
temp_struct.M1_40Hz = pos_40_cort.sess_auc;
temp_struct.M1_140Hz = pos_140_cort.sess_auc;
temp_struct.M1_1000Hz = pos_1000_cort.sess_auc;
pos_sess_auc_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Pos Mod AUC of Sess-Avg Traces')
saveas(gcf,'Sess_Pos_AUC.fig');

%Negative
temp_struct.CA1_40Hz = neg_40_hip.sess_auc;
temp_struct.CA1_140Hz = neg_140_hip.sess_auc;
temp_struct.CA1_1000Hz = neg_1000_hip.sess_auc;
temp_struct.M1_40Hz = neg_40_cort.sess_auc;
temp_struct.M1_140Hz = neg_140_cort.sess_auc;
temp_struct.M1_1000Hz = neg_1000_cort.sess_auc;
neg_sess_auc_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Neg Mod AUC of Sess-Avg Traces')
saveas(gcf,'Sess_Neg_AUC.fig');

%Rebound
temp_struct.CA1_40Hz = reb_40_hip.sess_only_reb_auc;
temp_struct.CA1_140Hz = reb_140_hip.sess_only_reb_auc;
temp_struct.CA1_1000Hz = reb_1000_hip.sess_only_reb_auc;
temp_struct.M1_40Hz = reb_40_cort.sess_only_reb_auc;
temp_struct.M1_140Hz = reb_140_cort.sess_only_reb_auc;
temp_struct.M1_1000Hz = reb_1000_cort.sess_only_reb_auc;
reb_sess_auc_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('only-Reb Mod AUC of Sess-Avg Traces')
saveas(gcf,'Sess_only_Reb_AUC.fig');

%% ================================ TTP ====================================%
%Positive
temp_struct.CA1_40Hz = pos_40_hip.sess_loc/Fs;
temp_struct.CA1_140Hz = pos_140_hip.sess_loc/Fs;
temp_struct.CA1_1000Hz = pos_1000_hip.sess_loc/Fs;
temp_struct.M1_40Hz = pos_40_cort.sess_loc/Fs;
temp_struct.M1_140Hz = pos_140_cort.sess_loc/Fs;
temp_struct.M1_1000Hz = pos_1000_cort.sess_loc/Fs;
pos_sess_ttp_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Pos Mod TTP of Sess-Avg Traces')
saveas(gcf,'Sess_Pos_TTP.fig');


%Negative
temp_struct.CA1_40Hz = neg_40_hip.sess_loc/Fs;
temp_struct.CA1_140Hz = neg_140_hip.sess_loc/Fs;
temp_struct.CA1_1000Hz = neg_1000_hip.sess_loc/Fs;
temp_struct.M1_40Hz = neg_40_cort.sess_loc/Fs;
temp_struct.M1_140Hz = neg_140_cort.sess_loc/Fs;
temp_struct.M1_1000Hz = neg_1000_cort.sess_loc/Fs;
neg_sess_ttp_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Neg Mod TTP of Sess-Avg Traces')
saveas(gcf,'Sess_Neg_TTP.fig');


%Rebound
temp_struct.CA1_40Hz = reb_40_hip.sess_loc/Fs;
temp_struct.CA1_140Hz = reb_140_hip.sess_loc/Fs;
temp_struct.CA1_1000Hz = reb_1000_hip.sess_loc/Fs;
temp_struct.M1_40Hz = reb_40_cort.sess_loc/Fs;
temp_struct.M1_140Hz = reb_140_cort.sess_loc/Fs;
temp_struct.M1_1000Hz = reb_1000_cort.sess_loc/Fs;
reb_sess_ttp_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Reb Mod TTP of Sess-Avg Traces')
saveas(gcf,'Sess_Reb_TTP.fig');

%% =============================== FWHM ====================================%
%Positive
temp_struct.CA1_40Hz = pos_40_hip.sess_fwhm;
temp_struct.CA1_140Hz = pos_140_hip.sess_fwhm;
temp_struct.CA1_1000Hz = pos_1000_hip.sess_fwhm;
temp_struct.M1_40Hz = pos_40_cort.sess_fwhm;
temp_struct.M1_140Hz = pos_140_cort.sess_fwhm;
temp_struct.M1_1000Hz = pos_1000_cort.sess_fwhm;
pos_sess_fwhm_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Pos Mod FWHM of Sess-Avg Traces')
saveas(gcf,'Sess_Pos_FWHM.fig');

%Negative
temp_struct.CA1_40Hz = neg_40_hip.sess_fwhm;
temp_struct.CA1_140Hz = neg_140_hip.sess_fwhm;
temp_struct.CA1_1000Hz = neg_1000_hip.sess_fwhm;
temp_struct.M1_40Hz = neg_40_cort.sess_fwhm;
temp_struct.M1_140Hz = neg_140_cort.sess_fwhm;
temp_struct.M1_1000Hz = neg_1000_cort.sess_fwhm;
neg_sess_fwhm_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Neg Mod FWHM of Sess-Avg Traces')
saveas(gcf,'Sess_Neg_FWHM.fig');


%Rebound
temp_struct.CA1_40Hz = reb_40_hip.sess_fwhm;
temp_struct.CA1_140Hz = reb_140_hip.sess_fwhm;
temp_struct.CA1_1000Hz = reb_1000_hip.sess_fwhm;
temp_struct.M1_40Hz = reb_40_cort.sess_fwhm;
temp_struct.M1_140Hz = reb_140_cort.sess_fwhm;
temp_struct.M1_1000Hz = reb_1000_cort.sess_fwhm;
reb_sess_fwhm_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Reb Mod FWHM of Sess-Avg Traces')
saveas(gcf,'Sess_Reb_FWHM.fig');

%% =============================== PkHt ====================================%
%Positive
temp_struct.CA1_40Hz = pos_40_hip.sess_pk;
temp_struct.CA1_140Hz = pos_140_hip.sess_pk;
temp_struct.CA1_1000Hz = pos_1000_hip.sess_pk;
temp_struct.M1_40Hz = pos_40_cort.sess_pk;
temp_struct.M1_140Hz = pos_140_cort.sess_pk;
temp_struct.M1_1000Hz = pos_1000_cort.sess_pk;
pos_sess_pkht_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Pos Mod Pk Ht of Sess-Avg Traces')
saveas(gcf, 'Sess_Pos_PkHt.fig');

%Negative
temp_struct.CA1_40Hz = neg_40_hip.sess_pk;
temp_struct.CA1_140Hz = neg_140_hip.sess_pk;
temp_struct.CA1_1000Hz = neg_1000_hip.sess_pk;
temp_struct.M1_40Hz = neg_40_cort.sess_pk;
temp_struct.M1_140Hz = neg_140_cort.sess_pk;
temp_struct.M1_1000Hz = neg_1000_cort.sess_pk;
neg_sess_pkht_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Neg Mod Pk Ht of Sess-Avg Traces')
saveas(gcf,'Sess_Neg_PkHt.fig');

%Rebound
temp_struct.CA1_40Hz = reb_40_hip.sess_pk;
temp_struct.CA1_140Hz = reb_140_hip.sess_pk;
temp_struct.CA1_1000Hz = reb_1000_hip.sess_pk;
temp_struct.M1_40Hz = reb_40_cort.sess_pk;
temp_struct.M1_140Hz = reb_140_cort.sess_pk;
temp_struct.M1_1000Hz = reb_1000_cort.sess_pk;
reb_sess_pkht_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Reb Pk Ht of Sess-Avg Traces')
saveas(gcf,'Sess_Reb_PkHt.fig');

%% ================================ LHS ====================================%
%Positive
temp_struct.CA1_40Hz = pos_40_hip.sess_lhs;
temp_struct.CA1_140Hz = pos_140_hip.sess_lhs;
temp_struct.CA1_1000Hz = pos_1000_hip.sess_lhs;
temp_struct.M1_40Hz = pos_40_cort.sess_lhs;
temp_struct.M1_140Hz = pos_140_cort.sess_lhs;
temp_struct.M1_1000Hz = pos_1000_cort.sess_lhs;
pos_sess_lhs_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Pos Mod LHS of Sess-Avg Traces')
saveas(gcf,'Sess_Pos_LHS.fig');

%Negative
temp_struct.CA1_40Hz = neg_40_hip.sess_lhs;
temp_struct.CA1_140Hz = neg_140_hip.sess_lhs;
temp_struct.CA1_1000Hz = neg_1000_hip.sess_lhs;
temp_struct.M1_40Hz = neg_40_cort.sess_lhs;
temp_struct.M1_140Hz = neg_140_cort.sess_lhs;
temp_struct.M1_1000Hz = neg_1000_cort.sess_lhs;
neg_sess_lhs_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Neg Mod LHS of Sess-Avg Traces')
saveas(gcf,'Sess_Neg_LHS.fig');

%Rebound
temp_struct.CA1_40Hz = reb_40_hip.sess_lhs;
temp_struct.CA1_140Hz = reb_140_hip.sess_lhs;
temp_struct.CA1_1000Hz = reb_1000_hip.sess_lhs;
temp_struct.M1_40Hz = reb_40_cort.sess_lhs;
temp_struct.M1_140Hz = reb_140_cort.sess_lhs;
temp_struct.M1_1000Hz = reb_1000_cort.sess_lhs;
reb_sess_lhs_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Reb Mod LHS of Sess-Avg Traces')
saveas(gcf,'Sess_Reb_LHS.fig');

%% ================================ RHS ====================================%
%Positive
temp_struct.CA1_40Hz = pos_40_hip.sess_rhs;
temp_struct.CA1_140Hz = pos_140_hip.sess_rhs;
temp_struct.CA1_1000Hz = pos_1000_hip.sess_rhs;
temp_struct.M1_40Hz = pos_40_cort.sess_rhs;
temp_struct.M1_140Hz = pos_140_cort.sess_rhs;
temp_struct.M1_1000Hz = pos_1000_cort.sess_rhs;
pos_sess_rhs_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Pos Mod RHS of Sess-Avg Traces')
saveas(gcf,'Sess_Pos_RHS.fig');

%Negative
temp_struct.CA1_40Hz = neg_40_hip.sess_rhs;
temp_struct.CA1_140Hz = neg_140_hip.sess_rhs;
temp_struct.CA1_1000Hz = neg_1000_hip.sess_rhs;
temp_struct.M1_40Hz = neg_40_cort.sess_rhs;
temp_struct.M1_140Hz = neg_140_cort.sess_rhs;
temp_struct.M1_1000Hz = neg_1000_cort.sess_rhs;
neg_sess_rhs_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Neg Mod RHS of Sess-Avg Traces')
saveas(gcf,'Sess_Neg_RHS.fig');


%Rebound
temp_struct.CA1_40Hz = reb_40_hip.sess_rhs;
temp_struct.CA1_140Hz = reb_140_hip.sess_rhs;
temp_struct.CA1_1000Hz = reb_1000_hip.sess_rhs;
temp_struct.M1_40Hz = reb_40_cort.sess_rhs;
temp_struct.M1_140Hz = reb_140_cort.sess_rhs;
temp_struct.M1_1000Hz = reb_1000_cort.sess_rhs;
reb_sess_rhs_pvals = anova_bonferroni_box(temp_struct,bcolor);
title('Reb Mod RHS of Sess-Avg Traces')
saveas(gcf,'Sess_Reb_RHS.fig');

%% Save pvals struct
pvals_struct.sess.inc_slope.pos.all = pos_sess_inc_slope_pvals;
pvals_struct.sess.inc_slope.neg.all = neg_sess_inc_slope_pvals;
pvals_struct.sess.inc_slope.reb.all = reb_sess_inc_slope_pvals;

pvals_struct.sess.dec_slope.pos.all = pos_sess_dec_slope_pvals;
pvals_struct.sess.dec_slope.neg.all = neg_sess_dec_slope_pvals;
pvals_struct.sess.dec_slope.reb.all = reb_sess_dec_slope_pvals;

pvals_struct.sess.auc.pos.all = pos_sess_auc_pvals;
pvals_struct.sess.auc.neg.all = neg_sess_auc_pvals;
pvals_struct.sess.auc.reb.all = reb_sess_auc_pvals;

pvals_struct.sess.fwhm.pos.all = pos_sess_fwhm_pvals;
pvals_struct.sess.fwhm.neg.all = neg_sess_fwhm_pvals;
pvals_struct.sess.fwhm.reb.all = reb_sess_fwhm_pvals;

pvals_struct.sess.ttp.pos.all = pos_sess_ttp_pvals;
pvals_struct.sess.ttp.neg.all = neg_sess_ttp_pvals;
pvals_struct.sess.ttp.reb.all = reb_sess_ttp_pvals;

pvals_struct.sess.pkht.pos.all = pos_sess_pkht_pvals;
pvals_struct.sess.pkht.neg.all = neg_sess_pkht_pvals;
pvals_struct.sess.pkht.reb.all = reb_sess_pkht_pvals;

pvals_struct.sess.lhs.pos.all = pos_sess_lhs_pvals;
pvals_struct.sess.lhs.neg.all = neg_sess_lhs_pvals;
pvals_struct.sess.lhs.reb.all = reb_sess_lhs_pvals;

pvals_struct.sess.rhs.pos.all = pos_sess_rhs_pvals;
pvals_struct.sess.rhs.neg.all = neg_sess_rhs_pvals;
pvals_struct.sess.rhs.reb.all = reb_sess_rhs_pvals;
end