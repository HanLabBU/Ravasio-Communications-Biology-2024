% compare_M1_KW.m
% Author: Cara Ravasio
% Date: 05/01/23
% Purpose: Just cleans up the waveform characterization script. Use
% Kurskal-Wallis for non-normal distribution

function pvals_struct = compare_M1_KW(pos_40_cort,pos_140_cort,pos_1000_cort,...
                                            neg_40_cort, neg_140_cort, neg_1000_cort,...
                                            pvals_struct,bcolor)
% %% ============================== Increasing Slope =========================%
% %Positive
% inc_slope_struct.M1_40Hz = pos_40_cort.inc_slope;
% inc_slope_struct.M1_140Hz = pos_140_cort.inc_slope;
% inc_slope_struct.M1_1000Hz = pos_1000_cort.inc_slope;
% 
% [pos_inc_slope_pvals_M1] = KW_ranksum_dunnsidak_box(inc_slope_struct,bcolor([2,4,6],:));
% ylabel('Increasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Pos Mod Increasing Slope (M1)'));
% saveas(gcf,['box_M1_PosMod_Increasing_Slope.fig']);
% saveas(gcf,['box_M1_PosMod_Increasing_Slope.jpg']);
% 
% %Negative
% inc_slope_struct.M1_40Hz = neg_40_cort.inc_slope;
% inc_slope_struct.M1_140Hz = neg_140_cort.inc_slope;
% inc_slope_struct.M1_1000Hz = neg_1000_cort.inc_slope;
% 
% [neg_inc_slope_pvals_M1] = KW_ranksum_dunnsidak_box(inc_slope_struct,bcolor([2,4,6],:));
% ylabel('Increasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Neg Mod Increasing Slope (M1)'));
% saveas(gcf,['box_M1_NegMod_Increasing_Slope.fig']);
% saveas(gcf,['box_M1_NegMod_Increasing_Slope.jpg']);
% 
% % %Rebound
% % inc_slope_struct.M1_40Hz = reb_40_cort.inc_slope;
% % inc_slope_struct.M1_140Hz = reb_140_cort.inc_slope;
% % inc_slope_struct.M1_1000Hz = reb_1000_cort.inc_slope;
% % 
% % [reb_inc_slope_pvals_M1] = KW_ranksum_dunnsidak_box(inc_slope_struct,bcolor([2,4,6],:));
% % ylabel('Increasing Slope (df/f/Frames)');
% % xlabel('Stimulation Frequency');
% % title(sprintf('Rebound Increasing Slope (M1)'));
% % saveas(gcf,['box_M1_Reb_Increasing_Slope.fig']);
% % saveas(gcf,['box_M1_Reb_Increasing_Slope.jpg']);
% %% ============================== Decreasing Slope =========================%
% %Positive
% dec_slope_struct.M1_40Hz = pos_40_cort.dec_slope;
% dec_slope_struct.M1_140Hz = pos_140_cort.dec_slope;
% dec_slope_struct.M1_1000Hz = pos_1000_cort.dec_slope;
% 
% [pos_dec_slope_pvals_M1] = KW_ranksum_dunnsidak_box(dec_slope_struct,bcolor([2,4,6],:));
% ylabel('decreasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Pos Mod decreasing Slope (M1)'));
% saveas(gcf,['box_M1_PosMod_decreasing_Slope.fig']);
% saveas(gcf,['box_M1_PosMod_decreasing_Slope.jpg']);
% 
% %Negative
% dec_slope_struct.M1_40Hz = neg_40_cort.dec_slope;
% dec_slope_struct.M1_140Hz = neg_140_cort.dec_slope;
% dec_slope_struct.M1_1000Hz = neg_1000_cort.dec_slope;
% 
% [neg_dec_slope_pvals_M1] = KW_ranksum_dunnsidak_box(dec_slope_struct,bcolor([2,4,6],:));
% ylabel('decreasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Neg Mod decreasing Slope (M1)'));
% saveas(gcf,['box_M1_NegMod_decreasing_Slope.fig']);
% saveas(gcf,['box_M1_NegMod_decreasing_Slope.jpg']);
% 
% % %Rebound
% % dec_slope_struct.M1_40Hz = reb_40_cort.dec_slope;
% % dec_slope_struct.M1_140Hz = reb_140_cort.dec_slope;
% % dec_slope_struct.M1_1000Hz = reb_1000_cort.dec_slope;
% % 
% % [reb_dec_slope_pvals_M1] = KW_ranksum_dunnsidak_box(dec_slope_struct,bcolor([2,4,6],:));
% % ylabel('decreasing Slope (df/f/Frames)');
% % xlabel('Stimulation Frequency');
% % title(sprintf('Rebound decreasing Slope (M1)'));
% % saveas(gcf,['box_M1_Reb_decreasing_Slope.fig']);
% % saveas(gcf,['box_M1_Reb_decreasing_Slope.jpg']);
%% ==================================== AUC ================================%
%Positive
auc_struct.M1_40Hz = pos_40_cort.auc;
auc_struct.M1_140Hz = pos_140_cort.auc;
auc_struct.M1_1000Hz = pos_1000_cort.auc;

[pos_auc_pvals_M1] = KW_ranksum_dunnsidak_box(auc_struct,bcolor([2,4,6],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod AUC (M1)'));
saveas(gcf,['box_M1_PosMod_AUC.fig']);
saveas(gcf,['box_M1_PosMod_AUC.jpg']);

%Negative
auc_struct.M1_40Hz = neg_40_cort.auc;
auc_struct.M1_140Hz = neg_140_cort.auc;
auc_struct.M1_1000Hz = neg_1000_cort.auc;

[neg_auc_pvals_M1] = KW_ranksum_dunnsidak_box(auc_struct,bcolor([2,4,6],:));
ylabel('AUC (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod AUC (M1)'));
saveas(gcf,['box_M1_NegMod_AUC.fig']);
saveas(gcf,['box_M1_NegMod_AUC.jpg']);

% %Rebound
% auc_struct.M1_40Hz = reb_40_cort.auc;
% auc_struct.M1_140Hz = reb_140_cort.auc;
% auc_struct.M1_1000Hz = reb_1000_cort.auc;
% 
% [reb_auc_pvals_M1] = KW_ranksum_dunnsidak_box(auc_struct,bcolor([2,4,6],:));
% ylabel('AUC (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Rebound AUC (M1)'));
% saveas(gcf,['box_M1_Reb_AUC.fig']);
% saveas(gcf,['box_M1_Reb_AUC.jpg']);
%% ================================ Time-To_Peak ===========================%
%Positive
ttp_struct.M1_40Hz = pos_40_cort.locs;
ttp_struct.M1_140Hz = pos_140_cort.locs;
ttp_struct.M1_1000Hz = pos_1000_cort.locs;

[pos_ttp_pvals_M1] = KW_ranksum_dunnsidak_box(ttp_struct,bcolor([2,4,6],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod ttp (M1)'));
saveas(gcf,['box_M1_PosMod_ttp.fig']);
saveas(gcf,['box_M1_PosMod_ttp.jpg']);

%Negative
ttp_struct.M1_40Hz = neg_40_cort.locs;
ttp_struct.M1_140Hz = neg_140_cort.locs;
ttp_struct.M1_1000Hz = neg_1000_cort.locs;

[neg_ttp_pvals_M1] = KW_ranksum_dunnsidak_box(ttp_struct,bcolor([2,4,6],:));
ylabel('ttp (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod ttp (M1)'));
saveas(gcf,['box_M1_NegMod_ttp.fig']);
saveas(gcf,['box_M1_NegMod_ttp.jpg']);
% 
% %Rebound
% ttp_struct.M1_40Hz = reb_40_cort.locs;
% ttp_struct.M1_140Hz = reb_140_cort.locs;
% ttp_struct.M1_1000Hz = reb_1000_cort.locs;
% 
% [reb_ttp_pvals_M1] = KW_ranksum_dunnsidak_box(ttp_struct,bcolor([2,4,6],:));
% ylabel('ttp (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Rebound ttp (M1)'));
% saveas(gcf,['box_M1_Reb_ttp.fig']);
% saveas(gcf,['box_M1_Reb_ttp.jpg']);
%% =================================== FWHM ================================%
%Positive
fwhm_struct.M1_40Hz = pos_40_cort.fwhm;
fwhm_struct.M1_140Hz = pos_140_cort.fwhm;
fwhm_struct.M1_1000Hz = pos_1000_cort.fwhm;

[pos_fwhm_pvals_M1] = KW_ranksum_dunnsidak_box(fwhm_struct,bcolor([2,4,6],:));
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod fwhm (M1)'));
saveas(gcf,['box_M1_PosMod_fwhm.fig']);
saveas(gcf,['box_M1_PosMod_fwhm.jpg']);

%Negative
fwhm_struct.M1_40Hz = neg_40_cort.fwhm;
fwhm_struct.M1_140Hz = neg_140_cort.fwhm;
fwhm_struct.M1_1000Hz = neg_1000_cort.fwhm;

[neg_fwhm_pvals_M1] = KW_ranksum_dunnsidak_box(fwhm_struct,bcolor([2,4,6],:));
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod fwhm (M1)'));
saveas(gcf,['box_M1_NegMod_fwhm.fig']);
saveas(gcf,['box_M1_NegMod_fwhm.jpg']);

% %Rebound
% fwhm_struct.M1_40Hz = reb_40_cort.fwhm;
% fwhm_struct.M1_140Hz = reb_140_cort.fwhm;
% fwhm_struct.M1_1000Hz = reb_1000_cort.fwhm;
% 
% [reb_fwhm_pvals_M1] = KW_ranksum_dunnsidak_box(fwhm_struct,bcolor([2,4,6],:));
% ylabel('fwhm (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Rebound fwhm (M1)'));
% saveas(gcf,['box_M1_Reb_fwhm.fig']);
% saveas(gcf,['box_M1_Reb_fwhm.jpg']);
%% ================================ Peak Height ============================%
%Positive
pkht_struct.M1_40Hz = pos_40_cort.pks;
pkht_struct.M1_140Hz = pos_140_cort.pks;
pkht_struct.M1_1000Hz = pos_1000_cort.pks;

[pos_pkht_pvals_M1] = KW_ranksum_dunnsidak_box(pkht_struct,bcolor([2,4,6],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod pkht (M1)'));
saveas(gcf,['box_M1_PosMod_pkht.fig']);
saveas(gcf,['box_M1_PosMod_pkht.jpg']);

%Negative
pkht_struct.M1_40Hz = neg_40_cort.pks;
pkht_struct.M1_140Hz = neg_140_cort.pks;
pkht_struct.M1_1000Hz = neg_1000_cort.pks;

[neg_pkht_pvals_M1] = KW_ranksum_dunnsidak_box(pkht_struct,bcolor([2,4,6],:));
ylabel('pkht (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod pkht (M1)'));
saveas(gcf,['box_M1_NegMod_pkht.fig']);
saveas(gcf,['box_M1_NegMod_pkht.jpg']);

% %Rebound
% pkht_struct.M1_40Hz = reb_40_cort.pks;
% pkht_struct.M1_140Hz = reb_140_cort.pks;
% pkht_struct.M1_1000Hz = reb_1000_cort.pks;
% 
% [reb_pkht_pvals_M1] = KW_ranksum_dunnsidak_box(pkht_struct,bcolor([2,4,6],:));
% ylabel('pkht (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Rebound pkht (M1)'));
% saveas(gcf,['box_M1_Reb_pkht.fig']);
% saveas(gcf,['box_M1_Reb_pkht.jpg']);
% %% =================================== LHS =================================%
% %Positive
% lhs_struct.M1_40Hz = pos_40_cort.lhs;
% lhs_struct.M1_140Hz = pos_140_cort.lhs;
% lhs_struct.M1_1000Hz = pos_1000_cort.lhs;
% 
% [pos_lhs_pvals_M1] = KW_ranksum_dunnsidak_box(lhs_struct,bcolor([2,4,6],:));
% ylabel('decreasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Pos Mod lhs (M1)'));
% saveas(gcf,['box_M1_PosMod_lhs.fig']);
% saveas(gcf,['box_M1_PosMod_lhs.jpg']);
% 
% %Negative
% lhs_struct.M1_40Hz = neg_40_cort.lhs;
% lhs_struct.M1_140Hz = neg_140_cort.lhs;
% lhs_struct.M1_1000Hz = neg_1000_cort.lhs;
% 
% [neg_lhs_pvals_M1] = KW_ranksum_dunnsidak_box(lhs_struct,bcolor([2,4,6],:));
% ylabel('lhs (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Neg Mod lhs (M1)'));
% saveas(gcf,['box_M1_NegMod_lhs.fig']);
% saveas(gcf,['box_M1_NegMod_lhs.jpg']);
% 
% % %Rebound
% % lhs_struct.M1_40Hz = reb_40_cort.lhs;
% % lhs_struct.M1_140Hz = reb_140_cort.lhs;
% % lhs_struct.M1_1000Hz = reb_1000_cort.lhs;
% % 
% % [reb_lhs_pvals_M1] = KW_ranksum_dunnsidak_box(lhs_struct,bcolor([2,4,6],:));
% % ylabel('lhs (df/f/Frames)');
% % xlabel('Stimulation Frequency');
% % title(sprintf('Rebound lhs (M1)'));
% % saveas(gcf,['box_M1_Reb_lhs.fig']);
% % saveas(gcf,['box_M1_Reb_lhs.jpg']);
% %% =================================== RHS =================================%
% %Positive
% rhs_struct.M1_40Hz = pos_40_cort.rhs;
% rhs_struct.M1_140Hz = pos_140_cort.rhs;
% rhs_struct.M1_1000Hz = pos_1000_cort.rhs;
% 
% [pos_rhs_pvals_M1] = KW_ranksum_dunnsidak_box(rhs_struct,bcolor([2,4,6],:));
% ylabel('decreasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Pos Mod rhs (M1)'));
% saveas(gcf,['box_M1_PosMod_rhs.fig']);
% saveas(gcf,['box_M1_PosMod_rhs.jpg']);
% 
% %Negative
% rhs_struct.M1_40Hz = neg_40_cort.rhs;
% rhs_struct.M1_140Hz = neg_140_cort.rhs;
% rhs_struct.M1_1000Hz = neg_1000_cort.rhs;
% 
% [neg_rhs_pvals_M1] = KW_ranksum_dunnsidak_box(rhs_struct,bcolor([2,4,6],:));
% ylabel('rhs (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Neg Mod rhs (M1)'));
% saveas(gcf,['box_M1_NegMod_rhs.fig']);
% saveas(gcf,['box_M1_NegMod_rhs.jpg']);
% % 
% % %Rebound
% % rhs_struct.M1_40Hz = reb_40_cort.rhs;
% % rhs_struct.M1_140Hz = reb_140_cort.rhs;
% % rhs_struct.M1_1000Hz = reb_1000_cort.rhs;
% % 
% % [reb_rhs_pvals_M1] = KW_ranksum_dunnsidak_box(rhs_struct,bcolor([2,4,6],:));
% % ylabel('rhs (df/f/Frames)');
% % xlabel('Stimulation Frequency');
% % title(sprintf('Rebound rhs (M1)'));
% % saveas(gcf,['box_M1_Reb_rhs.fig']);
% % saveas(gcf,['box_M1_Reb_rhs.jpg']);

%% Save Pvals struct
% pvals_struct.inc_slope.pos.M1 = pos_inc_slope_pvals_M1;
% pvals_struct.inc_slope.neg.M1 = neg_inc_slope_pvals_M1;
% %pvals_struct.inc_slope.reb.M1 = reb_inc_slope_pvals_M1;
% 
% pvals_struct.dec_slope.pos.M1 = pos_dec_slope_pvals_M1;
% pvals_struct.dec_slope.neg.M1 = neg_dec_slope_pvals_M1;
% %pvals_struct.dec_slope.reb.M1 = reb_dec_slope_pvals_M1;

pvals_struct.auc.pos.M1 = pos_auc_pvals_M1;
pvals_struct.auc.neg.M1 = neg_auc_pvals_M1;
%pvals_struct.auc.reb.M1 = reb_auc_pvals_M1;

pvals_struct.fwhm.pos.M1 = pos_fwhm_pvals_M1;
pvals_struct.fwhm.neg.M1 = neg_fwhm_pvals_M1;
%pvals_struct.fwhm.reb.M1 = reb_fwhm_pvals_M1;

pvals_struct.ttp.pos.M1 = pos_ttp_pvals_M1;
pvals_struct.ttp.neg.M1 = neg_ttp_pvals_M1;
%pvals_struct.ttp.reb.M1 = reb_ttp_pvals_M1;

pvals_struct.pkht.pos.M1 = pos_pkht_pvals_M1;
pvals_struct.pkht.neg.M1 = neg_pkht_pvals_M1;
%pvals_struct.pkht.reb.M1 = reb_pkht_pvals_M1;
 
% pvals_struct.lhs.pos.M1 = pos_lhs_pvals_M1;
% pvals_struct.lhs.neg.M1 = neg_lhs_pvals_M1;
% %pvals_struct.lhs.reb.M1 = reb_lhs_pvals_M1;
% 
% pvals_struct.rhs.pos.M1 = pos_rhs_pvals_M1;
% pvals_struct.rhs.neg.M1 = neg_rhs_pvals_M1;
% %pvals_struct.rhs.reb.M1 = reb_rhs_pvals_M1;
end