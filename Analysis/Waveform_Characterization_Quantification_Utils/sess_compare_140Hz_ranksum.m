%sess_compare_140Hz_ranksum.m
% Author: Cara Ravasio
% Date: 05/01/23
% Purpose: Just cleans up the waveform characterization script. Uses
% ranksum instead of ttest because it is not normally distributed

function pvals_struct = sess_compare_140Hz_ranksum(pos_140_hip,pos_140_cort,...
                                            neg_140_hip, neg_140_cort,...
                                            pvals_struct,bcolor)
%% ============================== Increasing Slope =========================%
%Positive
inc_slope_struct.CA1_140Hz = pos_140_hip.sess_inc_slope;
inc_slope_struct.M1_140Hz = pos_140_cort.sess_inc_slope;

[pos_inc_slope_pvals_140] = KW_ranksum_dunnsidak_box(inc_slope_struct,bcolor([3,4],:));
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod Increasing Slope (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_PosMod_Increasing_Slope.fig']);
saveas(gcf,['box_sess_140Hz_PosMod_Increasing_Slope.jpg']);

%Negative
inc_slope_struct.CA1_140Hz = neg_140_hip.sess_inc_slope;
inc_slope_struct.M1_140Hz = neg_140_cort.sess_inc_slope;

[neg_inc_slope_pvals_140] = KW_ranksum_dunnsidak_box(inc_slope_struct,bcolor([3,4],:));
ylabel('Increasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod Increasing Slope (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_NegMod_Increasing_Slope.fig']);
saveas(gcf,['box_sess_140Hz_NegMod_Increasing_Slope.jpg']);
% 
% %Rebound
% inc_slope_struct.CA1_140Hz = reb_140_hip.sess_inc_slope;
% inc_slope_struct.M1_140Hz = reb_140_cort.sess_inc_slope;
% 
% [reb_inc_slope_pvals_140] = KW_ranksum_dunnsidak_box(inc_slope_struct,bcolor([3,4],:));
% hold on;
% plot(ones(size(reb_140_hip.sess_inc_slope,1)),reb_140_hip.sess_inc_slope,'.','MarkerSize',12,'Color',bcolor(3,:))
% plot(2*ones(size(reb_140_cort.sess_inc_slope,1)),reb_140_cort.sess_inc_slope,'.','MarkerSize',12,'Color',bcolor(4,:))
% ylabel('Increasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb Increasing Slope (140Hz, Sess)'));
% saveas(gcf,['box_sess_140Hz_RebMod_Increasing_Slope.fig']);
% saveas(gcf,['box_sess_140Hz_RebMod_Increasing_Slope.jpg']);
%% ============================== Decreasing Slope =========================%
%Positive
dec_slope_struct.CA1_140Hz = pos_140_hip.sess_dec_slope;
dec_slope_struct.M1_140Hz = pos_140_cort.sess_dec_slope;

[pos_dec_slope_pvals_140] = KW_ranksum_dunnsidak_box(dec_slope_struct,bcolor([3,4],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod decreasing Slope (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_PosMod_decreasing_Slope.fig']);
saveas(gcf,['box_sess_140Hz_PosMod_decreasing_Slope.jpg']);

%Negative
dec_slope_struct.CA1_140Hz = neg_140_hip.sess_dec_slope;
dec_slope_struct.M1_140Hz = neg_140_cort.sess_dec_slope;

[neg_dec_slope_pvals_140] = KW_ranksum_dunnsidak_box(dec_slope_struct,bcolor([3,4],:));
ylabel('decreasing Slope (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod decreasing Slope (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_NegMod_decreasing_Slope.fig']);
saveas(gcf,['box_sess_140Hz_NegMod_decreasing_Slope.jpg']);

% %Rebound
% dec_slope_struct.CA1_140Hz = reb_140_hip.sess_dec_slope;
% dec_slope_struct.M1_140Hz = reb_140_cort.sess_dec_slope;
% 
% [reb_dec_slope_pvals_140] = KW_ranksum_dunnsidak_box(dec_slope_struct,bcolor([3,4],:));
% ylabel('decreasing Slope (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb decreasing Slope (140Hz, Sess)'));
% saveas(gcf,['box_sess_140Hz_RebMod_decreasing_Slope.fig']);
% saveas(gcf,['box_sess_140Hz_RebMod_decreasing_Slope.jpg']);
%==================================== AUC ================================%
%Positive
auc_struct.CA1_140Hz = pos_140_hip.sess_auc;
auc_struct.M1_140Hz = pos_140_cort.sess_auc;

[pos_auc_pvals_140] = KW_ranksum_dunnsidak_box(auc_struct,bcolor([3,4],:));
ylabel('AUC (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod AUC (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_PosMod_AUC.fig']);
saveas(gcf,['box_sess_140Hz_PosMod_AUC.jpg']);

%Negative
auc_struct.CA1_140Hz = neg_140_hip.sess_auc;
auc_struct.M1_140Hz = neg_140_cort.sess_auc;

[neg_auc_pvals_140] = KW_ranksum_dunnsidak_box(auc_struct,bcolor([3,4],:));
ylabel('AUC (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod AUC (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_NegMod_AUC.fig']);
saveas(gcf,['box_sess_140Hz_NegMod_AUC.jpg']);

% %Rebound
% auc_struct.CA1_140Hz = reb_140_hip.sess_auc;
% auc_struct.M1_140Hz = reb_140_cort.sess_auc;
% 
% [reb_auc_pvals_140] = KW_ranksum_dunnsidak_box(auc_struct,bcolor([3,4],:));
% ylabel('AUC (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb AUC (140Hz, Sess)'));
% saveas(gcf,['box_sess_140Hz_RebMod_AUC.fig']);
% saveas(gcf,['box_sess_140Hz_RebMod_AUC.jpg']);
%% ================================ Time-To_Peak ===========================%
%Positive
ttp_struct.CA1_140Hz = pos_140_hip.sess_loc;
ttp_struct.M1_140Hz = pos_140_cort.sess_loc;

[pos_ttp_pvals_140] = KW_ranksum_dunnsidak_box(ttp_struct,bcolor([3,4],:));
ylabel('ttp (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod ttp (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_PosMod_ttp.fig']);
saveas(gcf,['box_sess_140Hz_PosMod_ttp.jpg']);

%Negative
ttp_struct.CA1_140Hz = neg_140_hip.sess_loc;
ttp_struct.M1_140Hz = neg_140_cort.sess_loc;

[neg_ttp_pvals_140] = KW_ranksum_dunnsidak_box(ttp_struct,bcolor([3,4],:));
ylabel('ttp (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod ttp (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_NegMod_ttp.fig']);
saveas(gcf,['box_sess_140Hz_NegMod_ttp.jpg']);

% %Rebound
% ttp_struct.CA1_140Hz = reb_140_hip.sess_loc;
% ttp_struct.M1_140Hz = reb_140_cort.sess_loc;
% 
% [reb_ttp_pvals_140] = KW_ranksum_dunnsidak_box(ttp_struct,bcolor([3,4],:));
% ylabel('ttp (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb ttp (140Hz, Sess)'));
% saveas(gcf,['box_sess_140Hz_RebMod_ttp.fig']);
% saveas(gcf,['box_sess_140Hz_RebMod_ttp.jpg']);
%% =================================== FWHM ================================%
%Positive
fwhm_struct.CA1_140Hz = pos_140_hip.sess_fwhm;
fwhm_struct.M1_140Hz = pos_140_cort.sess_fwhm;

[pos_fwhm_pvals_140] = KW_ranksum_dunnsidak_box(fwhm_struct,bcolor([3,4],:));
hold on;
plot(ones(size(pos_140_hip.sess_fwhm,1)),pos_140_hip.sess_fwhm,'.','MarkerSize',12,'Color',bcolor(3,:))
plot(2*ones(size(pos_140_cort.sess_fwhm,1)),pos_140_cort.sess_fwhm,'.','MarkerSize',12,'Color',bcolor(4,:))
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod fwhm (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_PosMod_fwhm.fig']);
saveas(gcf,['box_sess_140Hz_PosMod_fwhm.jpg']);

%Negative
fwhm_struct.CA1_140Hz = neg_140_hip.sess_fwhm;
fwhm_struct.M1_140Hz = neg_140_cort.sess_fwhm;

[neg_fwhm_pvals_140] = KW_ranksum_dunnsidak_box(fwhm_struct,bcolor([3,4],:));
hold on;
plot(ones(size(neg_140_hip.sess_fwhm,1)),neg_140_hip.sess_fwhm,'.','MarkerSize',12,'Color',bcolor(3,:))
plot(2*ones(size(neg_140_cort.sess_fwhm,1)),neg_140_cort.sess_fwhm,'.','MarkerSize',12,'Color',bcolor(4,:))
ylabel('fwhm (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod fwhm (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_NegMod_fwhm.fig']);
saveas(gcf,['box_sess_140Hz_NegMod_fwhm.jpg']);

% %Rebound
% fwhm_struct.CA1_140Hz = reb_140_hip.sess_fwhm;
% fwhm_struct.M1_140Hz = reb_140_cort.sess_fwhm;
% 
% [reb_fwhm_pvals_140] = KW_ranksum_dunnsidak_box(fwhm_struct,bcolor([3,4],:));
% hold on;
% plot(ones(size(reb_140_hip.sess_fwhm,1)),reb_140_hip.sess_fwhm,'.','MarkerSize',12,'Color',bcolor(3,:))
% plot(2*ones(size(reb_140_cort.sess_fwhm,1)),reb_140_cort.sess_fwhm,'.','MarkerSize',12,'Color',bcolor(4,:))
% ylabel('fwhm (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb fwhm (140Hz, Sess)'));
% saveas(gcf,['box_sess_140Hz_RebMod_fwhm.fig']);
% saveas(gcf,['box_sess_140Hz_RebMod_fwhm.jpg']);
%% ================================ Peak Height ============================%
%Positive
pkht_struct.CA1_140Hz = pos_140_hip.sess_pk;
pkht_struct.M1_140Hz = pos_140_cort.sess_pk;

[pos_pkht_pvals_140] = KW_ranksum_dunnsidak_box(pkht_struct,bcolor([3,4],:));
ylabel('pkht (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod pkht (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_PosMod_pkht.fig']);
saveas(gcf,['box_sess_140Hz_PosMod_pkht.jpg']);

%Negative
pkht_struct.CA1_140Hz = neg_140_hip.sess_pk;
pkht_struct.M1_140Hz = neg_140_cort.sess_pk;

[neg_pkht_pvals_140] = KW_ranksum_dunnsidak_box(pkht_struct,bcolor([3,4],:));
ylabel('pkht (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod pkht (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_NegMod_pkht.fig']);
saveas(gcf,['box_sess_140Hz_NegMod_pkht.jpg']);

% %Rebound
% pkht_struct.CA1_140Hz = reb_140_hip.sess_pk;
% pkht_struct.M1_140Hz = reb_140_cort.sess_pk;
% 
% [reb_pkht_pvals_140] = KW_ranksum_dunnsidak_box(pkht_struct,bcolor([3,4],:));
% hold on;
% plot(ones(size(reb_140_hip.sess_pk,1)),reb_140_hip.sess_pk,'.','MarkerSize',12,'Color',bcolor(3,:))
% plot(2*ones(size(reb_140_cort.sess_pk,1)),reb_140_cort.sess_pk,'.','MarkerSize',12,'Color',bcolor(4,:))
% ylabel('pkht (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb pkht (140Hz, Sess)'));
% saveas(gcf,['box_sess_140Hz_RebMod_pkht.fig']);
% saveas(gcf,['box_sess_140Hz_RebMod_pkht.jpg']);
%% =================================== LHS =================================%
%Positive
lhs_struct.CA1_140Hz = pos_140_hip.sess_lhs;
lhs_struct.M1_140Hz = pos_140_cort.sess_lhs;

[pos_lhs_pvals_140] = KW_ranksum_dunnsidak_box(lhs_struct,bcolor([3,4],:));
hold on;
plot(ones(size(pos_140_hip.sess_lhs,1)),pos_140_hip.sess_lhs,'.','MarkerSize',12,'Color',bcolor(3,:))
plot(2*ones(size(pos_140_cort.sess_lhs,1)),pos_140_cort.sess_lhs,'.','MarkerSize',12,'Color',bcolor(4,:))
ylabel('lhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod lhs (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_PosMod_lhs.fig']);
saveas(gcf,['box_sess_140Hz_PosMod_lhs.jpg']);

%Negative
lhs_struct.CA1_140Hz = neg_140_hip.sess_lhs;
lhs_struct.M1_140Hz = neg_140_cort.sess_lhs;

[neg_lhs_pvals_140] = KW_ranksum_dunnsidak_box(lhs_struct,bcolor([3,4],:));
hold on;
plot(ones(size(neg_140_hip.sess_lhs,1)),neg_140_hip.sess_lhs,'.','MarkerSize',12,'Color',bcolor(3,:))
plot(2*ones(size(neg_140_cort.sess_lhs,1)),neg_140_cort.sess_lhs,'.','MarkerSize',12,'Color',bcolor(4,:))
ylabel('lhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod lhs (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_NegMod_lhs.fig']);
saveas(gcf,['box_sess_140Hz_NegMod_lhs.jpg']);
% 
% %Rebound
% lhs_struct.CA1_140Hz = reb_140_hip.sess_lhs;
% lhs_struct.M1_140Hz = reb_140_cort.sess_lhs;
% 
% [reb_lhs_pvals_140] = KW_ranksum_dunnsidak_box(lhs_struct,bcolor([3,4],:));
% ylabel('lhs (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb lhs (140Hz, Sess)'));
% saveas(gcf,['box_sess_140Hz_RebMod_lhs.fig']);
% saveas(gcf,['box_sess_140Hz_RebMod_lhs.jpg']);
%% =================================== RHS =================================%
%Positive
rhs_struct.CA1_140Hz = pos_140_hip.sess_rhs;
rhs_struct.M1_140Hz = pos_140_cort.sess_rhs;

[pos_rhs_pvals_140] = KW_ranksum_dunnsidak_box(rhs_struct,bcolor([3,4],:));
ylabel('rhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Pos Mod rhs (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_PosMod_rhs.fig']);
saveas(gcf,['box_sess_140Hz_PosMod_rhs.jpg']);

%Negative
rhs_struct.CA1_140Hz = neg_140_hip.sess_rhs;
rhs_struct.M1_140Hz = neg_140_cort.sess_rhs;

[neg_rhs_pvals_140] = KW_ranksum_dunnsidak_box(rhs_struct,bcolor([3,4],:));
ylabel('rhs (df/f/Frames)');
xlabel('Stimulation Frequency');
title(sprintf('Neg Mod rhs (140Hz, Sess)'));
saveas(gcf,['box_sess_140Hz_NegMod_rhs.fig']);
saveas(gcf,['box_sess_140Hz_NegMod_rhs.jpg']);

% %Rebound
% rhs_struct.CA1_140Hz = reb_140_hip.sess_rhs;
% rhs_struct.M1_140Hz = reb_140_cort.sess_rhs;
% 
% [reb_rhs_pvals_140] = KW_ranksum_dunnsidak_box(rhs_struct,bcolor([3,4],:));
% ylabel('rhs (df/f/Frames)');
% xlabel('Stimulation Frequency');
% title(sprintf('Reb rhs (140Hz, Sess)'));
% saveas(gcf,['box_sess_140Hz_RebMod_rhs.fig']);
% saveas(gcf,['box_sess_140Hz_RebMod_rhs.jpg']);

%% Save Pvals struct
pvals_struct.sess.inc_slope.pos.Hz140 = pos_inc_slope_pvals_140;
pvals_struct.sess.inc_slope.neg.Hz140 = neg_inc_slope_pvals_140;
%pvals_struct.sess.inc_slope.reb.Hz140 = reb_inc_slope_pvals_140;

pvals_struct.sess.dec_slope.pos.Hz140 = pos_dec_slope_pvals_140;
pvals_struct.sess.dec_slope.neg.Hz140 = neg_dec_slope_pvals_140;
%pvals_struct.sess.dec_slope.reb.Hz140 = reb_dec_slope_pvals_140;

pvals_struct.sess.auc.pos.Hz140 = pos_auc_pvals_140;
pvals_struct.sess.auc.neg.Hz140 = neg_auc_pvals_140;
%pvals_struct.sess.auc.reb.Hz140 = reb_auc_pvals_140;

pvals_struct.sess.fwhm.pos.Hz140 = pos_fwhm_pvals_140;
pvals_struct.sess.fwhm.neg.Hz140 = neg_fwhm_pvals_140;
%pvals_struct.sess.fwhm.reb.Hz140 = reb_fwhm_pvals_140;

pvals_struct.sess.ttp.pos.Hz140 = pos_ttp_pvals_140;
pvals_struct.sess.ttp.neg.Hz140 = neg_ttp_pvals_140;
%pvals_struct.sess.ttp.reb.Hz140 = reb_ttp_pvals_140;

pvals_struct.sess.pkht.pos.Hz140 = pos_pkht_pvals_140;
pvals_struct.sess.pkht.neg.Hz140 = neg_pkht_pvals_140;
%pvals_struct.sess.pkht.reb.Hz140 = reb_pkht_pvals_140;

pvals_struct.sess.lhs.pos.Hz140 = pos_lhs_pvals_140;
pvals_struct.sess.lhs.neg.Hz140 = neg_lhs_pvals_140;
%pvals_struct.sess.lhs.reb.Hz140 = reb_lhs_pvals_140;

pvals_struct.sess.rhs.pos.Hz140 = pos_rhs_pvals_140;
pvals_struct.sess.rhs.neg.Hz140 = neg_rhs_pvals_140;
%pvals_struct.sess.rhs.reb.Hz140 = reb_rhs_pvals_140;
end