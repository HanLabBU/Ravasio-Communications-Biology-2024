% compare_40Hz_ranksum.m
% Author: Cara Ravasio
% Date: 05/01/23
% Purpose: Just cleans up the waveform characterization script. Use ranksum
% for non-normal distribution

function pvals_struct = compare_40Hz_ranksum(pos_40_hip,pos_40_cort,...
                                            neg_40_hip, neg_40_cort,...
                                            pvals_struct,bcolor)
% %% ============================== Increasing Slope =========================%
% %Positive
% inc_slope_struct.CA1_40Hz = pos_40_hip.inc_slope;
% inc_slope_struct.M1_40Hz = pos_40_cort.inc_slope;
% 
% [pos_inc_slope_pvals_40] = KW_ranksum_dunnsidak_box(inc_slope_struct,bcolor([1,2],:));
% ylabel('Increasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Pos Mod Increasing Slope (40Hz)'));
% saveas(gcf,['box_40Hz_PosMod_Increasing_Slope.fig']);
% saveas(gcf,['box_40Hz_PosMod_Increasing_Slope.jpg']);
% 
% %Negative
% inc_slope_struct.CA1_40Hz = neg_40_hip.inc_slope;
% inc_slope_struct.M1_40Hz = neg_40_cort.inc_slope;
% 
% [neg_inc_slope_pvals_40] = KW_ranksum_dunnsidak_box(inc_slope_struct,bcolor([1,2],:));
% ylabel('Increasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Neg Mod Increasing Slope (40Hz)'));
% saveas(gcf,['box_40Hz_NegMod_Increasing_Slope.fig']);
% saveas(gcf,['box_40Hz_NegMod_Increasing_Slope.jpg']);
% 
% % %Rebound
% % inc_slope_struct.CA1_40Hz = reb_40_hip.inc_slope;
% % inc_slope_struct.M1_40Hz = reb_40_cort.inc_slope;
% % 
% % [reb_inc_slope_pvals_40] = KW_ranksum_dunnsidak_box(inc_slope_struct,bcolor([1,2],:));
% % ylabel('Increasing Slope (df/f/Frames)');
% % xlabel('Stimulation Frequency');
% % title(sprintf('Reb Increasing Slope (40Hz)'));
% % saveas(gcf,['box_40Hz_RebMod_Increasing_Slope.fig']);
% % saveas(gcf,['box_40Hz_RebMod_Increasing_Slope.jpg']);
% %% ============================== Decreasing Slope =========================%
% %Positive
% dec_slope_struct.CA1_40Hz = pos_40_hip.dec_slope;
% dec_slope_struct.M1_40Hz = pos_40_cort.dec_slope;
% 
% [pos_dec_slope_pvals_40] = KW_ranksum_dunnsidak_box(dec_slope_struct,bcolor([1,2],:));
% ylabel('decreasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Pos Mod decreasing Slope (40Hz)'));
% saveas(gcf,['box_40Hz_PosMod_decreasing_Slope.fig']);
% saveas(gcf,['box_40Hz_PosMod_decreasing_Slope.jpg']);
% 
% %Negative
% dec_slope_struct.CA1_40Hz = neg_40_hip.dec_slope;
% dec_slope_struct.M1_40Hz = neg_40_cort.dec_slope;
% 
% [neg_dec_slope_pvals_40] = KW_ranksum_dunnsidak_box(dec_slope_struct,bcolor([1,2],:));
% ylabel('decreasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Neg Mod decreasing Slope (40Hz)'));
% saveas(gcf,['box_40Hz_NegMod_decreasing_Slope.fig']);
% saveas(gcf,['box_40Hz_NegMod_decreasing_Slope.jpg']);
% 
% % %Rebound
% % dec_slope_struct.CA1_40Hz = reb_40_hip.dec_slope;
% % dec_slope_struct.M1_40Hz = reb_40_cort.dec_slope;
% % 
% % [reb_dec_slope_pvals_40] = KW_ranksum_dunnsidak_box(dec_slope_struct,bcolor([1,2],:));
% % ylabel('decreasing Slope (df/f/Frames)');
% % xlabel('Stimulation Frequency');
% % title(sprintf('Reb decreasing Slope (40Hz)'));
% % saveas(gcf,['box_40Hz_RebMod_decreasing_Slope.fig']);
% % saveas(gcf,['box_40Hz_RebMod_decreasing_Slope.jpg']);
%% ==================================== AUC ================================%
%Positive
auc_struct.CA1_40Hz = pos_40_hip.auc;
auc_struct.M1_40Hz = pos_40_cort.auc;

[pos_auc_pvals_40] = KW_ranksum_dunnsidak_box(auc_struct,bcolor([1,2],:));
ylabel('AUC (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod AUC (40Hz)'));
saveas(gcf,['box_40Hz_PosMod_AUC.fig']);
saveas(gcf,['box_40Hz_PosMod_AUC.jpg']);

%Negative
auc_struct.CA1_40Hz = neg_40_hip.auc;
auc_struct.M1_40Hz = neg_40_cort.auc;

[neg_auc_pvals_40] = KW_ranksum_dunnsidak_box(auc_struct,bcolor([1,2],:));
ylabel('AUC (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod AUC (40Hz)'));
saveas(gcf,['box_40Hz_NegMod_AUC.fig']);
saveas(gcf,['box_40Hz_NegMod_AUC.jpg']);

% %Rebound
% auc_struct.CA1_40Hz = reb_40_hip.auc;
% auc_struct.M1_40Hz = reb_40_cort.auc;
% 
% [reb_auc_pvals_40] = KW_ranksum_dunnsidak_box(auc_struct,bcolor([1,2],:));
% ylabel('AUC (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb AUC (40Hz)'));
% saveas(gcf,['box_40Hz_RebMod_AUC.fig']);
% saveas(gcf,['box_40Hz_RebMod_AUC.jpg']);
%% ================================ Time-To_Peak ===========================%
%Positive
ttp_struct.CA1_40Hz = pos_40_hip.locs;
ttp_struct.M1_40Hz = pos_40_cort.locs;

[pos_ttp_pvals_40] = KW_ranksum_dunnsidak_box(ttp_struct,bcolor([1,2],:));
ylabel('ttp (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod ttp (40Hz)'));
saveas(gcf,['box_40Hz_PosMod_ttp.fig']);
saveas(gcf,['box_40Hz_PosMod_ttp.jpg']);

%Negative
ttp_struct.CA1_40Hz = neg_40_hip.locs;
ttp_struct.M1_40Hz = neg_40_cort.locs;

[neg_ttp_pvals_40] = KW_ranksum_dunnsidak_box(ttp_struct,bcolor([1,2],:));
ylabel('ttp (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod ttp (40Hz)'));
saveas(gcf,['box_40Hz_NegMod_ttp.fig']);
saveas(gcf,['box_40Hz_NegMod_ttp.jpg']);
% 
% %Rebound
% ttp_struct.CA1_40Hz = reb_40_hip.locs;
% ttp_struct.M1_40Hz = reb_40_cort.locs;
% 
% [reb_ttp_pvals_40] = KW_ranksum_dunnsidak_box(ttp_struct,bcolor([1,2],:));
% ylabel('ttp (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb ttp (40Hz)'));
% saveas(gcf,['box_40Hz_RebMod_ttp.fig']);
% saveas(gcf,['box_40Hz_RebMod_ttp.jpg']);
%% =================================== FWHM ================================%
%Positive
fwhm_struct.CA1_40Hz = pos_40_hip.fwhm;
fwhm_struct.M1_40Hz = pos_40_cort.fwhm;

[pos_fwhm_pvals_40] = KW_ranksum_dunnsidak_box(fwhm_struct,bcolor([1,2],:));
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod fwhm (40Hz)'));
saveas(gcf,['box_40Hz_PosMod_fwhm.fig']);
saveas(gcf,['box_40Hz_PosMod_fwhm.jpg']);

%Negative
fwhm_struct.CA1_40Hz = neg_40_hip.fwhm;
fwhm_struct.M1_40Hz = neg_40_cort.fwhm;

[neg_fwhm_pvals_40] = KW_ranksum_dunnsidak_box(fwhm_struct,bcolor([1,2],:));
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod fwhm (40Hz)'));
saveas(gcf,['box_40Hz_NegMod_fwhm.fig']);
saveas(gcf,['box_40Hz_NegMod_fwhm.jpg']);
% 
% %Rebound
% fwhm_struct.CA1_40Hz = reb_40_hip.fwhm;
% fwhm_struct.M1_40Hz = reb_40_cort.fwhm;
% 
% [reb_fwhm_pvals_40] = KW_ranksum_dunnsidak_box(fwhm_struct,bcolor([1,2],:));
% ylabel('fwhm (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb fwhm (40Hz)'));
% saveas(gcf,['box_40Hz_RebMod_fwhm.fig']);
% saveas(gcf,['box_40Hz_RebMod_fwhm.jpg']);
%% ================================ Peak Height ============================%
%Positive
pkht_struct.CA1_40Hz = pos_40_hip.pks;
pkht_struct.M1_40Hz = pos_40_cort.pks;

[pos_pkht_pvals_40] = KW_ranksum_dunnsidak_box(pkht_struct,bcolor([1,2],:));
ylabel('pkht (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod pkht (40Hz)'));
saveas(gcf,['box_40Hz_PosMod_pkht.fig']);
saveas(gcf,['box_40Hz_PosMod_pkht.jpg']);

%Negative
pkht_struct.CA1_40Hz = neg_40_hip.pks;
pkht_struct.M1_40Hz = neg_40_cort.pks;

[neg_pkht_pvals_40] = KW_ranksum_dunnsidak_box(pkht_struct,bcolor([1,2],:));
ylabel('pkht (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod pkht (40Hz)'));
saveas(gcf,['box_40Hz_NegMod_pkht.fig']);
saveas(gcf,['box_40Hz_NegMod_pkht.jpg']);

% %Rebound
% pkht_struct.CA1_40Hz = reb_40_hip.pks;
% pkht_struct.M1_40Hz = reb_40_cort.pks;
% 
% [reb_pkht_pvals_40] = KW_ranksum_dunnsidak_box(pkht_struct,bcolor([1,2],:));
% ylabel('pkht (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb pkht (40Hz)'));
% saveas(gcf,['box_40Hz_RebMod_pkht.fig']);
% saveas(gcf,['box_40Hz_RebMod_pkht.jpg']);
% %% =================================== LHS =================================%
% %Positive
% lhs_struct.CA1_40Hz = pos_40_hip.lhs;
% lhs_struct.M1_40Hz = pos_40_cort.lhs;
% 
% [pos_lhs_pvals_40] = KW_ranksum_dunnsidak_box(lhs_struct,bcolor([1,2],:));
% ylabel('lhs (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Pos Mod lhs (40Hz)'));
% saveas(gcf,['box_40Hz_PosMod_lhs.fig']);
% saveas(gcf,['box_40Hz_PosMod_lhs.jpg']);
% 
% %Negative
% lhs_struct.CA1_40Hz = neg_40_hip.lhs;
% lhs_struct.M1_40Hz = neg_40_cort.lhs;
% 
% [neg_lhs_pvals_40] = KW_ranksum_dunnsidak_box(lhs_struct,bcolor([1,2],:));
% ylabel('lhs (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Neg Mod lhs (40Hz)'));
% saveas(gcf,['box_40Hz_NegMod_lhs.fig']);
% saveas(gcf,['box_40Hz_NegMod_lhs.jpg']);
% 
% % %Rebound
% % lhs_struct.CA1_40Hz = reb_40_hip.lhs;
% % lhs_struct.M1_40Hz = reb_40_cort.lhs;
% % 
% % [reb_lhs_pvals_40] = KW_ranksum_dunnsidak_box(lhs_struct,bcolor([1,2],:));
% % ylabel('lhs (df/f/Frames)');
% % xlabel('Stimulation Frequency');
% % title(sprintf('Reb lhs (40Hz)'));
% % saveas(gcf,['box_40Hz_RebMod_lhs.fig']);
% % saveas(gcf,['box_40Hz_RebMod_lhs.jpg']);
% %% =================================== RHS =================================%
% %Positive
% rhs_struct.CA1_40Hz = pos_40_hip.rhs;
% rhs_struct.M1_40Hz = pos_40_cort.rhs;
% 
% [pos_rhs_pvals_40] = KW_ranksum_dunnsidak_box(rhs_struct,bcolor([1,2],:));
% ylabel('rhs (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Pos Mod rhs (40Hz)'));
% saveas(gcf,['box_40Hz_PosMod_rhs.fig']);
% saveas(gcf,['box_40Hz_PosMod_rhs.jpg']);
% 
% %Negative
% rhs_struct.CA1_40Hz = neg_40_hip.rhs;
% rhs_struct.M1_40Hz = neg_40_cort.rhs;
% 
% [neg_rhs_pvals_40] = KW_ranksum_dunnsidak_box(rhs_struct,bcolor([1,2],:));
% ylabel('rhs (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Neg Mod rhs (40Hz)'));
% saveas(gcf,['box_40Hz_NegMod_rhs.fig']);
% saveas(gcf,['box_40Hz_NegMod_rhs.jpg']);
% 
% % %Rebound
% % rhs_struct.CA1_40Hz = reb_40_hip.rhs;
% % rhs_struct.M1_40Hz = reb_40_cort.rhs;
% % 
% % [reb_rhs_pvals_40] = KW_ranksum_dunnsidak_box(rhs_struct,bcolor([1,2],:));
% % ylabel('rhs (df/f/Frames)');
% % xlabel('Stimulation Frequency');
% % title(sprintf('Reb rhs (40Hz)'));
% % saveas(gcf,['box_40Hz_RebMod_rhs.fig']);
% % saveas(gcf,['box_40Hz_RebMod_rhs.jpg']);
% 
%% Save Pvals struct
% pvals_struct.inc_slope.pos.Hz40 = pos_inc_slope_pvals_40;
% pvals_struct.inc_slope.neg.Hz40 = neg_inc_slope_pvals_40;
% %pvals_struct.inc_slope.reb.Hz40 = reb_inc_slope_pvals_40;
% 
% pvals_struct.dec_slope.pos.Hz40 = pos_dec_slope_pvals_40;
% pvals_struct.dec_slope.neg.Hz40 = neg_dec_slope_pvals_40;
% %pvals_struct.dec_slope.reb.Hz40 = reb_dec_slope_pvals_40;

pvals_struct.auc.pos.Hz40 = pos_auc_pvals_40;
pvals_struct.auc.neg.Hz40 = neg_auc_pvals_40;
%pvals_struct.auc.reb.Hz40 = reb_auc_pvals_40;

pvals_struct.fwhm.pos.Hz40 = pos_fwhm_pvals_40;
pvals_struct.fwhm.neg.Hz40 = neg_fwhm_pvals_40;
%pvals_struct.fwhm.reb.Hz40 = reb_fwhm_pvals_40;

pvals_struct.ttp.pos.Hz40 = pos_ttp_pvals_40;
pvals_struct.ttp.neg.Hz40 = neg_ttp_pvals_40;
%pvals_struct.ttp.reb.Hz40 = reb_ttp_pvals_40;

pvals_struct.pkht.pos.Hz40 = pos_pkht_pvals_40;
pvals_struct.pkht.neg.Hz40 = neg_pkht_pvals_40;
%pvals_struct.pkht.reb.Hz40 = reb_pkht_pvals_40;

% pvals_struct.lhs.pos.Hz40 = pos_lhs_pvals_40;
% pvals_struct.lhs.neg.Hz40 = neg_lhs_pvals_40;
% %pvals_struct.lhs.reb.Hz40 = reb_lhs_pvals_40;
% 
% pvals_struct.rhs.pos.Hz40 = pos_rhs_pvals_40;
% pvals_struct.rhs.neg.Hz40 = neg_rhs_pvals_40;
% %pvals_struct.rhs.reb.Hz40 = reb_rhs_pvals_40;
end