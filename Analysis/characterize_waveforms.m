% characterize_waveforms.m
% Date: 05/22/23
% Author: Cara
% Purpose: waveform_characterization.m in function format. returns stats
% from Wilcoxon (non-param t-test) and Kruskal-Wallis (non-param ANOVA) +
% dunn-sidak multcompare test

function [pos_40_CA1,neg_40_CA1,...
        pos_140_CA1,neg_140_CA1,...
        pos_1000_CA1,neg_1000_CA1,...
        pos_40_M1,neg_40_M1,...
        pos_140_M1,neg_140_M1,...
        pos_1000_M1,neg_1000_M1,...
        pvals_struct] =characterize_waveforms(pos_40_CA1,neg_40_CA1,...
                                            pos_140_CA1,neg_140_CA1,...
                                            pos_1000_CA1,neg_1000_CA1,...
                                            pos_40_M1,neg_40_M1,...
                                            pos_140_M1,neg_140_M1,...
                                            pos_1000_M1,neg_1000_M1,...
                                            colors)
%% Setup
Fs = 20; % Hz
pvals_struct = {};

color_40_CA1 = colors(1,:);
color_40_M1 = colors(2,:);
color_140_CA1 = colors(3,:);
color_140_M1 = colors(4,:);
color_1000_CA1 = colors(5,:);
color_1000_M1 = colors(6,:);

%% Session wise comparison of average waveforms (avg over a session)
%Any session with 3 or more neurons responding in certain manner are used
%to create an average waveform for the session

% pos hip
pos_40_CA1 = session_avg(pos_40_CA1);
pos_140_CA1 = session_avg(pos_140_CA1);
pos_1000_CA1 = session_avg(pos_1000_CA1);

% pos cort
pos_40_M1 = session_avg(pos_40_M1);
pos_140_M1 = session_avg(pos_140_M1);
pos_1000_M1 = session_avg(pos_1000_M1);

% neg hip
neg_40_CA1 = session_avg(neg_40_CA1);
neg_140_CA1 = session_avg(neg_140_CA1);
neg_1000_CA1 = session_avg(neg_1000_CA1);

% neg cort
neg_40_M1 = session_avg(neg_40_M1);
neg_140_M1 = session_avg(neg_140_M1);
neg_1000_M1 = session_avg(neg_1000_M1);

% % reb hip
% reb_40_CA1 = session_avg(reb_40_CA1);
% reb_140_CA1 = session_avg(reb_140_CA1);
% reb_1000_CA1 = session_avg(reb_1000_CA1);
% 
% % reb cort
% reb_40_M1 = session_avg(reb_40_M1);
% reb_140_M1 = session_avg(reb_140_M1);
% reb_1000_M1 = session_avg(reb_1000_M1);

%% Smooth Traces
smooth_win = 5;
%============================= Positive ==================================%
%pos hip
smooth_avg_pos_40_CA1 = smooth(pos_40_CA1.avg_trace)';
smooth_avg_pos_140_CA1 = smooth(pos_140_CA1.avg_trace)';
smooth_avg_pos_1000_CA1 = smooth(pos_1000_CA1.avg_trace)';

smooth_pos_40_CA1 = smoothdata(pos_40_CA1.traces,2,'movmean',smooth_win); %smooth data along the second dimension with a moving average window size 5
smooth_pos_140_CA1 = smoothdata(pos_140_CA1.traces,2,'movmean',smooth_win);
smooth_pos_1000_CA1 = smoothdata(pos_1000_CA1.traces,2,'movmean',smooth_win);

smooth_sess_pos_40_CA1 = smoothdata(pos_40_CA1.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_pos_140_CA1 = smoothdata(pos_140_CA1.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_pos_1000_CA1 = smoothdata(pos_1000_CA1.session_avg_traces,2,'movmean',smooth_win);

%pos cort
smooth_avg_pos_40_M1 = smooth(pos_40_M1.avg_trace)';
smooth_avg_pos_140_M1 = smooth(pos_140_M1.avg_trace)';
smooth_avg_pos_1000_M1 = smooth(pos_1000_M1.avg_trace)';

smooth_pos_40_M1 = smoothdata(pos_40_M1.traces,2,'movmean',smooth_win); 
smooth_pos_140_M1 = smoothdata(pos_140_M1.traces,2,'movmean',smooth_win);
smooth_pos_1000_M1 = smoothdata(pos_1000_M1.traces,2,'movmean',smooth_win);

smooth_sess_pos_40_M1 = smoothdata(pos_40_M1.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_pos_140_M1 = smoothdata(pos_140_M1.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_pos_1000_M1 = smoothdata(pos_1000_M1.session_avg_traces,2,'movmean',smooth_win);

%=========================== Negative ====================================%
%neg hip
smooth_avg_neg_40_CA1 = smooth(neg_40_CA1.avg_trace)';
smooth_avg_neg_140_CA1 = smooth(neg_140_CA1.avg_trace)';
smooth_avg_neg_1000_CA1 = smooth(neg_1000_CA1.avg_trace)';

smooth_neg_40_CA1 = smoothdata(neg_40_CA1.traces,2,'movmean',smooth_win); 
smooth_neg_140_CA1 = smoothdata(neg_140_CA1.traces,2,'movmean',smooth_win);
smooth_neg_1000_CA1 = smoothdata(neg_1000_CA1.traces,2,'movmean',smooth_win);

smooth_sess_neg_40_CA1 = smoothdata(neg_40_CA1.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_neg_140_CA1 = smoothdata(neg_140_CA1.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_neg_1000_CA1 = smoothdata(neg_1000_CA1.session_avg_traces,2,'movmean',smooth_win);

%neg cort
smooth_avg_neg_40_M1 = smooth(neg_40_M1.avg_trace)';
smooth_avg_neg_140_M1 = smooth(neg_140_M1.avg_trace)';
smooth_avg_neg_1000_M1 = smooth(neg_1000_M1.avg_trace)';

smooth_neg_40_M1 = smoothdata(neg_40_M1.traces,2,'movmean',smooth_win); 
smooth_neg_140_M1 = smoothdata(neg_140_M1.traces,2,'movmean',smooth_win);
smooth_neg_1000_M1 = smoothdata(neg_1000_M1.traces,2,'movmean',smooth_win);

smooth_sess_neg_40_M1 = smoothdata(neg_40_M1.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_neg_140_M1 = smoothdata(neg_140_M1.session_avg_traces,2,'movmean',smooth_win);
smooth_sess_neg_1000_M1 = smoothdata(neg_1000_M1.session_avg_traces,2,'movmean',smooth_win);

% %========================== Rebound ======================================%
% %reb hip
% smooth_avg_reb_40_CA1 = smooth(reb_40_CA1.avg_trace)';
% smooth_avg_reb_140_CA1 = smooth(reb_140_CA1.avg_trace)';
% smooth_avg_reb_1000_CA1 = smooth(reb_1000_CA1.avg_trace)';
% 
% smooth_reb_40_CA1 = smoothdata(reb_40_CA1.traces,2,'movmean',smooth_win); 
% smooth_reb_140_CA1 = smoothdata(reb_140_CA1.traces,2,'movmean',smooth_win);
% smooth_reb_1000_CA1 = smoothdata(reb_1000_CA1.traces,2,'movmean',smooth_win);
% 
% smooth_sess_reb_40_CA1 = smoothdata(reb_40_CA1.session_avg_traces,2,'movmean',smooth_win);
% smooth_sess_reb_140_CA1 = smoothdata(reb_140_CA1.session_avg_traces,2,'movmean',smooth_win);
% smooth_sess_reb_1000_CA1 = smoothdata(reb_1000_CA1.session_avg_traces,2,'movmean',smooth_win);
% 
% %reb cort
% smooth_avg_reb_40_M1 = smooth(reb_40_M1.avg_trace)';
% smooth_avg_reb_140_M1 = smooth(reb_140_M1.avg_trace)';
% smooth_avg_reb_1000_M1 = smooth(reb_1000_M1.avg_trace)';
% 
% smooth_reb_40_M1 = smoothdata(reb_40_M1.traces,2,'movmean',smooth_win); 
% smooth_reb_140_M1 = smoothdata(reb_140_M1.traces,2,'movmean',smooth_win);
% smooth_reb_1000_M1 = smoothdata(reb_1000_M1.traces,2,'movmean',smooth_win);
% 
% smooth_sess_reb_40_M1 = smoothdata(reb_40_M1.session_avg_traces,2,'movmean',smooth_win);
% smooth_sess_reb_140_M1 = smoothdata(reb_140_M1.session_avg_traces,2,'movmean',smooth_win);
% smooth_sess_reb_1000_M1 = smoothdata(reb_1000_M1.session_avg_traces,2,'movmean',smooth_win);

%% Peak, FWHM, time-to-peak, and asymmetry

%========================== Positive =====================================%
% pos hip
[pos_40_CA1.avg_pk,pos_40_CA1.avg_loc,pos_40_CA1.avg_fwhm,...
pos_40_CA1.avg_lhs,pos_40_CA1.avg_rhs]=fwhm_and_pk(smooth_avg_pos_40_CA1,Fs,0);

[pos_40_CA1.pks, pos_40_CA1.locs, pos_40_CA1.fwhm,...
 pos_40_CA1.lhs,pos_40_CA1.rhs]=fwhm_and_pk(smooth_pos_40_CA1,Fs,0);

[pos_40_CA1.sess_pk,pos_40_CA1.sess_loc,pos_40_CA1.sess_fwhm,...
pos_40_CA1.sess_lhs,pos_40_CA1.sess_rhs]=fwhm_and_pk(smooth_sess_pos_40_CA1,Fs,0);

[pos_140_CA1.avg_pk,pos_140_CA1.avg_loc,pos_140_CA1.avg_fwhm,...
pos_140_CA1.avg_lhs,pos_140_CA1.avg_rhs]=fwhm_and_pk(smooth_avg_pos_140_CA1,Fs,0);

[pos_140_CA1.pks, pos_140_CA1.locs, pos_140_CA1.fwhm,...
 pos_140_CA1.lhs,pos_140_CA1.rhs]=fwhm_and_pk(smooth_pos_140_CA1,Fs,0);

[pos_140_CA1.sess_pk,pos_140_CA1.sess_loc,pos_140_CA1.sess_fwhm,...
pos_140_CA1.sess_lhs,pos_140_CA1.sess_rhs]=fwhm_and_pk(smooth_sess_pos_140_CA1,Fs,0);

[pos_1000_CA1.avg_pk,pos_1000_CA1.avg_loc,pos_1000_CA1.avg_fwhm,...
pos_1000_CA1.avg_lhs,pos_1000_CA1.avg_rhs]=fwhm_and_pk(smooth_avg_pos_1000_CA1,Fs,0);

[pos_1000_CA1.pks, pos_1000_CA1.locs, pos_1000_CA1.fwhm,...
 pos_1000_CA1.lhs,pos_1000_CA1.rhs]=fwhm_and_pk(smooth_pos_1000_CA1,Fs,0);

[pos_1000_CA1.sess_pk,pos_1000_CA1.sess_loc,pos_1000_CA1.sess_fwhm,...
pos_1000_CA1.sess_lhs,pos_1000_CA1.sess_rhs]=fwhm_and_pk(smooth_sess_pos_1000_CA1,Fs,0);

% pos cort
[pos_40_M1.avg_pk,pos_40_M1.avg_loc,pos_40_M1.avg_fwhm,...
pos_40_M1.avg_lhs,pos_40_M1.avg_rhs]=fwhm_and_pk(smooth_avg_pos_40_M1,Fs,0);

[pos_40_M1.pks, pos_40_M1.locs, pos_40_M1.fwhm,...
 pos_40_M1.lhs,pos_40_M1.rhs]=fwhm_and_pk(smooth_pos_40_M1,Fs,0);

[pos_40_M1.sess_pk,pos_40_M1.sess_loc,pos_40_M1.sess_fwhm,...
pos_40_M1.sess_lhs,pos_40_M1.sess_rhs]=fwhm_and_pk(smooth_sess_pos_40_M1,Fs,0);

[pos_140_M1.avg_pk,pos_140_M1.avg_loc,pos_140_M1.avg_fwhm,...
pos_140_M1.avg_lhs,pos_140_M1.avg_rhs]=fwhm_and_pk(smooth_avg_pos_140_M1,Fs,0);

[pos_140_M1.pks, pos_140_M1.locs, pos_140_M1.fwhm,...
 pos_140_M1.lhs,pos_140_M1.rhs]=fwhm_and_pk(smooth_pos_140_M1,Fs,0);

[pos_140_M1.sess_pk,pos_140_M1.sess_loc,pos_140_M1.sess_fwhm,...
pos_140_M1.sess_lhs,pos_140_M1.sess_rhs]=fwhm_and_pk(smooth_sess_pos_140_M1,Fs,0);

[pos_1000_M1.avg_pk,pos_1000_M1.avg_loc,pos_1000_M1.avg_fwhm,...
pos_1000_M1.avg_lhs,pos_1000_M1.avg_rhs]=fwhm_and_pk(smooth_avg_pos_1000_M1,Fs,0);

[pos_1000_M1.pks, pos_1000_M1.locs, pos_1000_M1.fwhm,...
 pos_1000_M1.lhs,pos_1000_M1.rhs]=fwhm_and_pk(smooth_pos_1000_M1,Fs,0);

[pos_1000_M1.sess_pk,pos_1000_M1.sess_loc,pos_1000_M1.sess_fwhm,...
pos_1000_M1.sess_lhs,pos_1000_M1.sess_rhs]=fwhm_and_pk(smooth_sess_pos_1000_M1,Fs,0);

%=========================== Negative ====================================%
% avg neg hip
[neg_40_CA1.avg_pk,neg_40_CA1.avg_loc,neg_40_CA1.avg_fwhm,...
neg_40_CA1.avg_lhs,neg_40_CA1.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_40_CA1,Fs,0);
neg_40_CA1.avg_pk = -neg_40_CA1.avg_pk;

[neg_40_CA1.pks, neg_40_CA1.locs, neg_40_CA1.fwhm,...
 neg_40_CA1.lhs,neg_40_CA1.rhs]=fwhm_and_pk(-smooth_neg_40_CA1,Fs,0);
neg_40_CA1.pks = -neg_40_CA1.pks;

[neg_40_CA1.sess_pk,neg_40_CA1.sess_loc,neg_40_CA1.sess_fwhm,...
neg_40_CA1.sess_lhs,neg_40_CA1.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_40_CA1,Fs,0);
neg_40_CA1.sess_pk = -neg_40_CA1.sess_pk;

[neg_140_CA1.avg_pk,neg_140_CA1.avg_loc,neg_140_CA1.avg_fwhm,...
neg_140_CA1.avg_lhs,neg_140_CA1.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_140_CA1,Fs,0);
neg_140_CA1.avg_pk = -neg_140_CA1.avg_pk;

[neg_140_CA1.pks, neg_140_CA1.locs, neg_140_CA1.fwhm,...
 neg_140_CA1.lhs,neg_140_CA1.rhs]=fwhm_and_pk(-smooth_neg_140_CA1,Fs,0);
neg_140_CA1.pks = -neg_140_CA1.pks;

[neg_140_CA1.sess_pk,neg_140_CA1.sess_loc,neg_140_CA1.sess_fwhm,...
neg_140_CA1.sess_lhs,neg_140_CA1.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_140_CA1,Fs,0);
neg_140_CA1.sess_pk = -neg_140_CA1.sess_pk;

[neg_1000_CA1.avg_pk,neg_1000_CA1.avg_loc,neg_1000_CA1.avg_fwhm,...
neg_1000_CA1.avg_lhs,neg_1000_CA1.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_1000_CA1,Fs,0);
neg_1000_CA1.avg_pk = -neg_1000_CA1.avg_pk;

[neg_1000_CA1.pks, neg_1000_CA1.locs, neg_1000_CA1.fwhm,...
 neg_1000_CA1.lhs,neg_1000_CA1.rhs]=fwhm_and_pk(-smooth_neg_1000_CA1,Fs,0);
neg_1000_CA1.pks = -neg_1000_CA1.pks;

[neg_1000_CA1.sess_pk,neg_1000_CA1.sess_loc,neg_1000_CA1.sess_fwhm,...
neg_1000_CA1.sess_lhs,neg_1000_CA1.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_1000_CA1,Fs,0);
neg_1000_CA1.sess_pk = -neg_1000_CA1.sess_pk;

% avg neg cort
[neg_40_M1.avg_pk,neg_40_M1.avg_loc,neg_40_M1.avg_fwhm,...
neg_40_M1.avg_lhs,neg_40_M1.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_40_M1,Fs,0);
neg_40_M1.avg_pk = -neg_40_M1.avg_pk;

[neg_40_M1.pks, neg_40_M1.locs, neg_40_M1.fwhm,...
 neg_40_M1.lhs,neg_40_M1.rhs]=fwhm_and_pk(-smooth_neg_40_M1,Fs,0);
neg_40_M1.pks = -neg_40_M1.pks;

[neg_40_M1.sess_pk,neg_40_M1.sess_loc,neg_40_M1.sess_fwhm,...
neg_40_M1.sess_lhs,neg_40_M1.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_40_M1,Fs,0);
neg_40_M1.sess_pk = -neg_40_M1.sess_pk;

[neg_140_M1.avg_pk,neg_140_M1.avg_loc,neg_140_M1.avg_fwhm,...
neg_140_M1.avg_lhs,neg_140_M1.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_140_M1,Fs,0);
neg_140_M1.avg_pk = -neg_140_M1.avg_pk;

[neg_140_M1.pks, neg_140_M1.locs, neg_140_M1.fwhm,...
 neg_140_M1.lhs,neg_140_M1.rhs]=fwhm_and_pk(-smooth_neg_140_M1,Fs,0);
neg_140_M1.pks = -neg_140_M1.pks;

[neg_140_M1.sess_pk,neg_140_M1.sess_loc,neg_140_M1.sess_fwhm,...
neg_140_M1.sess_lhs,neg_140_M1.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_140_M1,Fs,0);
neg_140_M1.sess_pk = -neg_140_M1.sess_pk;

[neg_1000_M1.avg_pk,neg_1000_M1.avg_loc,neg_1000_M1.avg_fwhm,...
neg_1000_M1.avg_lhs,neg_1000_M1.avg_rhs]=fwhm_and_pk(-smooth_avg_neg_1000_M1,Fs,0);
neg_1000_M1.avg_pk = -neg_1000_M1.avg_pk;

[neg_1000_M1.pks, neg_1000_M1.locs, neg_1000_M1.fwhm,...
 neg_1000_M1.lhs,neg_1000_M1.rhs]=fwhm_and_pk(-smooth_neg_1000_M1,Fs,0);
neg_1000_M1.pks = -neg_1000_M1.pks;

[neg_1000_M1.sess_pk,neg_1000_M1.sess_loc,neg_1000_M1.sess_fwhm,...
neg_1000_M1.sess_lhs,neg_1000_M1.sess_rhs]=fwhm_and_pk(-smooth_sess_neg_1000_M1,Fs,0);
neg_1000_M1.sess_pk = -neg_1000_M1.sess_pk;

% %================================ Rebound ================================%
% % avg reb hip
% [reb_40_CA1.avg_pk,reb_40_CA1.avg_loc,reb_40_CA1.avg_fwhm,...
% reb_40_CA1.avg_lhs,reb_40_CA1.avg_rhs]=fwhm_and_pk(smooth_avg_reb_40_CA1,Fs,1);
% 
% [reb_40_CA1.pks, reb_40_CA1.locs, reb_40_CA1.fwhm,...
%  reb_40_CA1.lhs,reb_40_CA1.rhs]=fwhm_and_pk(smooth_reb_40_CA1,Fs,1);
% 
% [reb_40_CA1.sess_pk,reb_40_CA1.sess_loc,reb_40_CA1.sess_fwhm,...
% reb_40_CA1.sess_lhs,reb_40_CA1.sess_rhs]=fwhm_and_pk(smooth_sess_reb_40_CA1,Fs,1);
% 
% [reb_140_CA1.avg_pk,reb_140_CA1.avg_loc,reb_140_CA1.avg_fwhm,...
% reb_140_CA1.avg_lhs,reb_140_CA1.avg_rhs]=fwhm_and_pk(smooth_avg_reb_140_CA1,Fs,1);
% 
% [reb_140_CA1.pks, reb_140_CA1.locs, reb_140_CA1.fwhm,...
%  reb_140_CA1.lhs,reb_140_CA1.rhs]=fwhm_and_pk(smooth_reb_140_CA1,Fs,1);
% 
% [reb_140_CA1.sess_pk,reb_140_CA1.sess_loc,reb_140_CA1.sess_fwhm,...
% reb_140_CA1.sess_lhs,reb_140_CA1.sess_rhs]=fwhm_and_pk(smooth_sess_reb_140_CA1,Fs,1);
% 
% [reb_1000_CA1.avg_pk,reb_1000_CA1.avg_loc,reb_1000_CA1.avg_fwhm,...
% reb_1000_CA1.avg_lhs,reb_1000_CA1.avg_rhs]=fwhm_and_pk(smooth_avg_reb_1000_CA1,Fs,1);
% 
% [reb_1000_CA1.pks, reb_1000_CA1.locs, reb_1000_CA1.fwhm,...
%  reb_1000_CA1.lhs,reb_1000_CA1.rhs]=fwhm_and_pk(smooth_reb_1000_CA1,Fs,1);
% 
% [reb_1000_CA1.sess_pk,reb_1000_CA1.sess_loc,reb_1000_CA1.sess_fwhm,...
% reb_1000_CA1.sess_lhs,reb_1000_CA1.sess_rhs]=fwhm_and_pk(smooth_sess_reb_1000_CA1,Fs,1);
% 
% % avg reb cort
% [reb_40_M1.avg_pk,reb_40_M1.avg_loc,reb_40_M1.avg_fwhm,...
% reb_40_M1.avg_lhs,reb_40_M1.avg_rhs]=fwhm_and_pk(smooth_avg_reb_40_M1,Fs,1);
% 
% [reb_40_M1.pks, reb_40_M1.locs, reb_40_M1.fwhm,...
%  reb_40_M1.lhs,reb_40_M1.rhs]=fwhm_and_pk(smooth_reb_40_M1,Fs,1);
% 
% [reb_40_M1.sess_pk,reb_40_M1.sess_loc,reb_40_M1.sess_fwhm,...
% reb_40_M1.sess_lhs,reb_40_M1.sess_rhs]=fwhm_and_pk(smooth_sess_reb_40_M1,Fs,1);
% 
% [reb_140_M1.avg_pk,reb_140_M1.avg_loc,reb_140_M1.avg_fwhm,...
% reb_140_M1.avg_lhs,reb_140_M1.avg_rhs]=fwhm_and_pk(smooth_avg_reb_140_M1,Fs,1);
% 
% [reb_140_M1.pks, reb_140_M1.locs, reb_140_M1.fwhm,...
%  reb_140_M1.lhs,reb_140_M1.rhs]=fwhm_and_pk(smooth_reb_140_M1,Fs,1);
% 
% [reb_140_M1.sess_pk,reb_140_M1.sess_loc,reb_140_M1.sess_fwhm,...
% reb_140_M1.sess_lhs,reb_140_M1.sess_rhs]=fwhm_and_pk(smooth_sess_reb_140_M1,Fs,1);
% 
% [reb_1000_M1.avg_pk,reb_1000_M1.avg_loc,reb_1000_M1.avg_fwhm,...
% reb_1000_M1.avg_lhs,reb_1000_M1.avg_rhs]=fwhm_and_pk(smooth_avg_reb_1000_M1,Fs,1);
% 
% [reb_1000_M1.pks, reb_1000_M1.locs, reb_1000_M1.fwhm,...
%  reb_1000_M1.lhs,reb_1000_M1.rhs]=fwhm_and_pk(smooth_reb_1000_M1,Fs,1);
% 
% [reb_1000_M1.sess_pk,reb_1000_M1.sess_loc,reb_1000_M1.sess_fwhm,...
% reb_1000_M1.sess_lhs,reb_1000_M1.sess_rhs]=fwhm_and_pk(smooth_sess_reb_1000_M1,Fs,1);
%% Slope
%================================== Positive =============================%
% pos hip
[pos_40_CA1.avg_inc_slope, pos_40_CA1.avg_dec_slope]= find_slopes(smooth_avg_pos_40_CA1,Fs,pos_40_CA1.avg_loc,0); %reb_flag=0
[pos_140_CA1.avg_inc_slope, pos_140_CA1.avg_dec_slope]= find_slopes(smooth_avg_pos_140_CA1,Fs,pos_140_CA1.avg_loc,0); 
[pos_1000_CA1.avg_inc_slope, pos_1000_CA1.avg_dec_slope]= find_slopes(smooth_avg_pos_1000_CA1,Fs,pos_1000_CA1.avg_loc,0); 

[pos_40_CA1.inc_slope, pos_40_CA1.dec_slope]= find_slopes(smooth_pos_40_CA1,Fs,pos_40_CA1.locs,0); %reb_flag=0
[pos_140_CA1.inc_slope, pos_140_CA1.dec_slope]= find_slopes(smooth_pos_140_CA1,Fs,pos_140_CA1.locs,0); 
[pos_1000_CA1.inc_slope, pos_1000_CA1.dec_slope]= find_slopes(smooth_pos_1000_CA1,Fs,pos_1000_CA1.locs,0); 

[pos_40_CA1.sess_inc_slope, pos_40_CA1.sess_dec_slope]= find_slopes(smooth_sess_pos_40_CA1,Fs,pos_40_CA1.sess_loc,0); %reb_flag=0
[pos_140_CA1.sess_inc_slope, pos_140_CA1.sess_dec_slope]= find_slopes(smooth_sess_pos_140_CA1,Fs,pos_140_CA1.sess_loc,0); 
[pos_1000_CA1.sess_inc_slope, pos_1000_CA1.sess_dec_slope]= find_slopes(smooth_sess_pos_1000_CA1,Fs,pos_1000_CA1.sess_loc,0); 

% pos cort
[pos_40_M1.avg_inc_slope, pos_40_M1.avg_dec_slope]= find_slopes(smooth_avg_pos_40_M1,Fs,pos_40_M1.avg_loc,0); %reb_flag=0
[pos_140_M1.avg_inc_slope, pos_140_M1.avg_dec_slope]= find_slopes(smooth_avg_pos_140_M1,Fs,pos_140_M1.avg_loc,0); 
[pos_1000_M1.avg_inc_slope, pos_1000_M1.avg_dec_slope]= find_slopes(smooth_avg_pos_1000_M1,Fs,pos_1000_M1.avg_loc,0); 

[pos_40_M1.inc_slope, pos_40_M1.dec_slope]= find_slopes(smooth_pos_40_M1,Fs,pos_40_M1.locs,0); %reb_flag=0
[pos_140_M1.inc_slope, pos_140_M1.dec_slope]= find_slopes(smooth_pos_140_M1,Fs,pos_140_M1.locs,0); 
[pos_1000_M1.inc_slope, pos_1000_M1.dec_slope]= find_slopes(smooth_pos_1000_M1,Fs,pos_1000_M1.locs,0); 

[pos_40_M1.sess_inc_slope, pos_40_M1.sess_dec_slope]= find_slopes(smooth_sess_pos_40_M1,Fs,pos_40_M1.sess_loc,0); %reb_flag=0
[pos_140_M1.sess_inc_slope, pos_140_M1.sess_dec_slope]= find_slopes(smooth_sess_pos_140_M1,Fs,pos_140_M1.sess_loc,0); 
[pos_1000_M1.sess_inc_slope, pos_1000_M1.sess_dec_slope]= find_slopes(smooth_sess_pos_1000_M1,Fs,pos_1000_M1.sess_loc,0); 

%================================= Negative ==============================%
% neg hip
[neg_40_CA1.avg_inc_slope, neg_40_CA1.avg_dec_slope]= find_slopes(smooth_avg_neg_40_CA1,Fs,neg_40_CA1.avg_loc,0); %reb_flag=0
[neg_140_CA1.avg_inc_slope, neg_140_CA1.avg_dec_slope]= find_slopes(smooth_avg_neg_140_CA1,Fs,neg_140_CA1.avg_loc,0);
[neg_1000_CA1.avg_inc_slope, neg_1000_CA1.avg_dec_slope]= find_slopes(smooth_avg_neg_1000_CA1,Fs,neg_1000_CA1.avg_loc,0);

[neg_40_CA1.inc_slope, neg_40_CA1.dec_slope]= find_slopes(smooth_neg_40_CA1,Fs,neg_40_CA1.locs,0); %reb_flag=0
[neg_140_CA1.inc_slope, neg_140_CA1.dec_slope]= find_slopes(smooth_neg_140_CA1,Fs,neg_140_CA1.locs,0);
[neg_1000_CA1.inc_slope, neg_1000_CA1.dec_slope]= find_slopes(smooth_neg_1000_CA1,Fs,neg_1000_CA1.locs,0);

[neg_40_CA1.sess_inc_slope, neg_40_CA1.sess_dec_slope]= find_slopes(smooth_sess_neg_40_CA1,Fs,neg_40_CA1.sess_loc,0); %reb_flag=0
[neg_140_CA1.sess_inc_slope, neg_140_CA1.sess_dec_slope]= find_slopes(smooth_sess_neg_140_CA1,Fs,neg_140_CA1.sess_loc,0);
[neg_1000_CA1.sess_inc_slope, neg_1000_CA1.sess_dec_slope]= find_slopes(smooth_sess_neg_1000_CA1,Fs,neg_1000_CA1.sess_loc,0);

% neg cort
[neg_40_M1.avg_inc_slope, neg_40_M1.avg_dec_slope]= find_slopes(smooth_avg_neg_40_M1,Fs,neg_40_M1.avg_loc,0); %reb_flag=0
[neg_140_M1.avg_inc_slope, neg_140_M1.avg_dec_slope]= find_slopes(smooth_avg_neg_140_M1,Fs,neg_140_M1.avg_loc,0);
[neg_1000_M1.avg_inc_slope, neg_1000_M1.avg_dec_slope]= find_slopes(smooth_avg_neg_1000_M1,Fs,neg_1000_M1.avg_loc,0);

[neg_40_M1.inc_slope, neg_40_M1.dec_slope]= find_slopes(smooth_neg_40_M1,Fs,neg_40_M1.locs,0); %reb_flag=0
[neg_140_M1.inc_slope, neg_140_M1.dec_slope]= find_slopes(smooth_neg_140_M1,Fs,neg_140_M1.locs,0);
[neg_1000_M1.inc_slope, neg_1000_M1.dec_slope]= find_slopes(smooth_neg_1000_M1,Fs,neg_1000_M1.locs,0);

[neg_40_M1.sess_inc_slope, neg_40_M1.sess_dec_slope]= find_slopes(smooth_sess_neg_40_M1,Fs,neg_40_M1.sess_loc,0); %reb_flag=0
[neg_140_M1.sess_inc_slope, neg_140_M1.sess_dec_slope]= find_slopes(smooth_sess_neg_140_M1,Fs,neg_140_M1.sess_loc,0);
[neg_1000_M1.sess_inc_slope, neg_1000_M1.sess_dec_slope]= find_slopes(smooth_sess_neg_1000_M1,Fs,neg_1000_M1.sess_loc,0);

% %================================== Rebound ==============================%
% % reb hip
% [reb_40_CA1.avg_inc_slope, reb_40_CA1.avg_dec_slope]= find_slopes(smooth_avg_reb_40_CA1,Fs,reb_40_CA1.avg_loc,1); %reb_flag=1
% [reb_140_CA1.avg_inc_slope, reb_140_CA1.avg_dec_slope]= find_slopes(smooth_avg_reb_140_CA1,Fs,reb_140_CA1.avg_loc,1); 
% [reb_1000_CA1.avg_inc_slope, reb_1000_CA1.avg_dec_slope]= find_slopes(smooth_avg_reb_1000_CA1,Fs,reb_1000_CA1.avg_loc,1); 
% 
% [reb_40_CA1.inc_slope, reb_40_CA1.dec_slope]= find_slopes(smooth_reb_40_CA1,Fs,reb_40_CA1.locs,1); %reb_flag=1
% [reb_140_CA1.inc_slope, reb_140_CA1.dec_slope]= find_slopes(smooth_reb_140_CA1,Fs,reb_140_CA1.locs,1); 
% [reb_1000_CA1.inc_slope, reb_1000_CA1.dec_slope]= find_slopes(smooth_reb_1000_CA1,Fs,reb_1000_CA1.locs,1); 
% 
% [reb_40_CA1.sess_inc_slope, reb_40_CA1.sess_dec_slope]= find_slopes(smooth_sess_reb_40_CA1,Fs,reb_40_CA1.sess_loc,1); %reb_flag=1
% [reb_140_CA1.sess_inc_slope, reb_140_CA1.sess_dec_slope]= find_slopes(smooth_sess_reb_140_CA1,Fs,reb_140_CA1.sess_loc,1); 
% [reb_1000_CA1.sess_inc_slope, reb_1000_CA1.sess_dec_slope]= find_slopes(smooth_sess_reb_1000_CA1,Fs,reb_1000_CA1.sess_loc,1); 
% 
% % reb cort
% [reb_40_M1.avg_inc_slope, reb_40_M1.avg_dec_slope]= find_slopes(smooth_avg_reb_40_M1,Fs,reb_40_M1.avg_loc,1); %reb_flag=1
% [reb_140_M1.avg_inc_slope, reb_140_M1.avg_dec_slope]= find_slopes(smooth_avg_reb_140_M1,Fs,reb_140_M1.avg_loc,1); 
% [reb_1000_M1.avg_inc_slope, reb_1000_M1.avg_dec_slope]= find_slopes(smooth_avg_reb_1000_M1,Fs,reb_1000_M1.avg_loc,1);
% 
% [reb_40_M1.inc_slope, reb_40_M1.dec_slope]= find_slopes(smooth_reb_40_M1,Fs,reb_40_M1.locs,1); %reb_flag=1
% [reb_140_M1.inc_slope, reb_140_M1.dec_slope]= find_slopes(smooth_reb_140_M1,Fs,reb_140_M1.locs,1); 
% [reb_1000_M1.inc_slope, reb_1000_M1.dec_slope]= find_slopes(smooth_reb_1000_M1,Fs,reb_1000_M1.locs,1);
% 
% [reb_40_M1.sess_inc_slope, reb_40_M1.sess_dec_slope]= find_slopes(smooth_sess_reb_40_M1,Fs,reb_40_M1.sess_loc,1); %reb_flag=1
% [reb_140_M1.sess_inc_slope, reb_140_M1.sess_dec_slope]= find_slopes(smooth_sess_reb_140_M1,Fs,reb_140_M1.sess_loc,1); 
% [reb_1000_M1.sess_inc_slope, reb_1000_M1.sess_dec_slope]= find_slopes(smooth_sess_reb_1000_M1,Fs,reb_1000_M1.sess_loc,1);

%% AUC
% %======================== Positive =======================================%
% % pos hip
% pos_40_CA1.avg_auc = trapz(smooth_avg_pos_40_CA1(5*Fs:end));
% pos_140_CA1.avg_auc = trapz(smooth_avg_pos_140_CA1(5*Fs:end));
% pos_1000_CA1.avg_auc = trapz(smooth_avg_pos_1000_CA1(5*Fs:end));
% 
% pos_40_CA1.auc = trapz(smooth_pos_40_CA1(:,5*Fs:end),2);
% pos_140_CA1.auc = trapz(smooth_pos_140_CA1(:,5*Fs:end),2);
% pos_1000_CA1.auc = trapz(smooth_pos_1000_CA1(:,5*Fs:end),2);
% 
% pos_40_CA1.sess_auc = trapz(smooth_sess_pos_40_CA1(:,5*Fs:end),2);
% pos_140_CA1.sess_auc = trapz(smooth_sess_pos_140_CA1(:,5*Fs:end),2);
% pos_1000_CA1.sess_auc = trapz(smooth_sess_pos_1000_CA1(:,5*Fs:end),2);
% 
% % pos cort
% pos_40_M1.avg_auc = trapz(smooth_avg_pos_40_M1(5*Fs:end));
% pos_140_M1.avg_auc = trapz(smooth_avg_pos_140_M1(5*Fs:end));
% pos_1000_M1.avg_auc = trapz(smooth_avg_pos_1000_M1(5*Fs:end));
% 
% pos_40_M1.auc = trapz(smooth_pos_40_M1(:,5*Fs:end),2);
% pos_140_M1.auc = trapz(smooth_pos_140_M1(:,5*Fs:end),2);
% pos_1000_M1.auc = trapz(smooth_pos_1000_M1(:,5*Fs:end),2);
% 
% pos_40_M1.sess_auc = trapz(smooth_sess_pos_40_M1(:,5*Fs:end),2);
% pos_140_M1.sess_auc = trapz(smooth_sess_pos_140_M1(:,5*Fs:end),2);
% pos_1000_M1.sess_auc = trapz(smooth_sess_pos_1000_M1(:,5*Fs:end),2);
% 
% %======================== Negative =======================================%
% % neg hip
% neg_40_CA1.avg_auc = trapz(smooth_avg_neg_40_CA1(5*Fs:end));
% neg_140_CA1.avg_auc = trapz(smooth_avg_neg_140_CA1(5*Fs:end));
% neg_1000_CA1.avg_auc = trapz(smooth_avg_neg_1000_CA1(:,5*Fs:end));
% 
% neg_40_CA1.auc = trapz(smooth_neg_40_CA1(:,5*Fs:end),2);
% neg_140_CA1.auc = trapz(smooth_neg_140_CA1(:,5*Fs:end),2);
% neg_1000_CA1.auc = trapz(smooth_neg_1000_CA1(:,5*Fs:end),2);
% 
% neg_40_CA1.sess_auc = trapz(smooth_sess_neg_40_CA1(:,5*Fs:end),2);
% neg_140_CA1.sess_auc = trapz(smooth_sess_neg_140_CA1(:,5*Fs:end),2);
% neg_1000_CA1.sess_auc = trapz(smooth_sess_neg_1000_CA1(:,5*Fs:end),2);
% 
% % neg cort
% neg_40_M1.avg_auc = trapz(smooth_avg_neg_40_M1(5*Fs:end));
% neg_140_M1.avg_auc = trapz(smooth_avg_neg_140_M1(5*Fs:end));
% neg_1000_M1.avg_auc = trapz(smooth_avg_neg_1000_M1(5*Fs:end));
% 
% neg_40_M1.auc = trapz(smooth_neg_40_M1(:,5*Fs:end),2);
% neg_140_M1.auc = trapz(smooth_neg_140_M1(:,5*Fs:end),2);
% neg_1000_M1.auc = trapz(smooth_neg_1000_M1(:,5*Fs:end),2);
% 
% neg_40_M1.sess_auc = trapz(smooth_sess_neg_40_M1(:,5*Fs:end),2);
% neg_140_M1.sess_auc = trapz(smooth_sess_neg_140_M1(:,5*Fs:end),2);
% neg_1000_M1.sess_auc = trapz(smooth_sess_neg_1000_M1(:,5*Fs:end),2);
%======================== Positive =======================================%
% pos hip
pos_40_CA1.avg_auc = trapz(smooth_avg_pos_40_CA1(5*Fs:10*Fs));
pos_140_CA1.avg_auc = trapz(smooth_avg_pos_140_CA1(5*Fs:10*Fs));
pos_1000_CA1.avg_auc = trapz(smooth_avg_pos_1000_CA1(5*Fs:10*Fs));

pos_40_CA1.auc = trapz(smooth_pos_40_CA1(:,5*Fs:10*Fs),2);
pos_140_CA1.auc = trapz(smooth_pos_140_CA1(:,5*Fs:10*Fs),2);
pos_1000_CA1.auc = trapz(smooth_pos_1000_CA1(:,5*Fs:10*Fs),2);

pos_40_CA1.sess_auc = trapz(smooth_sess_pos_40_CA1(:,5*Fs:10*Fs),2);
pos_140_CA1.sess_auc = trapz(smooth_sess_pos_140_CA1(:,5*Fs:10*Fs),2);
pos_1000_CA1.sess_auc = trapz(smooth_sess_pos_1000_CA1(:,5*Fs:10*Fs),2);

% pos cort
pos_40_M1.avg_auc = trapz(smooth_avg_pos_40_M1(5*Fs:10*Fs));
pos_140_M1.avg_auc = trapz(smooth_avg_pos_140_M1(5*Fs:10*Fs));
pos_1000_M1.avg_auc = trapz(smooth_avg_pos_1000_M1(5*Fs:10*Fs));

pos_40_M1.auc = trapz(smooth_pos_40_M1(:,5*Fs:10*Fs),2);
pos_140_M1.auc = trapz(smooth_pos_140_M1(:,5*Fs:10*Fs),2);
pos_1000_M1.auc = trapz(smooth_pos_1000_M1(:,5*Fs:10*Fs),2);

pos_40_M1.sess_auc = trapz(smooth_sess_pos_40_M1(:,5*Fs:10*Fs),2);
pos_140_M1.sess_auc = trapz(smooth_sess_pos_140_M1(:,5*Fs:10*Fs),2);
pos_1000_M1.sess_auc = trapz(smooth_sess_pos_1000_M1(:,5*Fs:10*Fs),2);

%======================== Negative =======================================%
% neg hip
neg_40_CA1.avg_auc = trapz(smooth_avg_neg_40_CA1(5*Fs:10*Fs));
neg_140_CA1.avg_auc = trapz(smooth_avg_neg_140_CA1(5*Fs:10*Fs));
neg_1000_CA1.avg_auc = trapz(smooth_avg_neg_1000_CA1(:,5*Fs:10*Fs));

neg_40_CA1.auc = trapz(smooth_neg_40_CA1(:,5*Fs:10*Fs),2);
neg_140_CA1.auc = trapz(smooth_neg_140_CA1(:,5*Fs:10*Fs),2);
neg_1000_CA1.auc = trapz(smooth_neg_1000_CA1(:,5*Fs:10*Fs),2);

neg_40_CA1.sess_auc = trapz(smooth_sess_neg_40_CA1(:,5*Fs:10*Fs),2);
neg_140_CA1.sess_auc = trapz(smooth_sess_neg_140_CA1(:,5*Fs:10*Fs),2);
neg_1000_CA1.sess_auc = trapz(smooth_sess_neg_1000_CA1(:,5*Fs:10*Fs),2);

% neg cort
neg_40_M1.avg_auc = trapz(smooth_avg_neg_40_M1(5*Fs:10*Fs));
neg_140_M1.avg_auc = trapz(smooth_avg_neg_140_M1(5*Fs:10*Fs));
neg_1000_M1.avg_auc = trapz(smooth_avg_neg_1000_M1(5*Fs:10*Fs));

neg_40_M1.auc = trapz(smooth_neg_40_M1(:,5*Fs:10*Fs),2);
neg_140_M1.auc = trapz(smooth_neg_140_M1(:,5*Fs:10*Fs),2);
neg_1000_M1.auc = trapz(smooth_neg_1000_M1(:,5*Fs:10*Fs),2);

neg_40_M1.sess_auc = trapz(smooth_sess_neg_40_M1(:,5*Fs:10*Fs),2);
neg_140_M1.sess_auc = trapz(smooth_sess_neg_140_M1(:,5*Fs:10*Fs),2);
neg_1000_M1.sess_auc = trapz(smooth_sess_neg_1000_M1(:,5*Fs:10*Fs),2);
% %======================== Rebound =======================================%
% % reb hip
% reb_40_CA1.avg_auc = trapz(smooth_avg_reb_40_CA1);
% reb_140_CA1.avg_auc = trapz(smooth_avg_reb_140_CA1);
% reb_1000_CA1.avg_auc = trapz(smooth_avg_reb_1000_CA1);
% 
% reb_40_CA1.auc = trapz(smooth_reb_40_CA1,2);
% reb_140_CA1.auc = trapz(smooth_reb_140_CA1,2);
% reb_1000_CA1.auc = trapz(smooth_reb_1000_CA1,2);
% 
% reb_40_CA1.sess_auc = trapz(smooth_sess_reb_40_CA1,2);
% reb_140_CA1.sess_auc = trapz(smooth_sess_reb_140_CA1,2);
% reb_1000_CA1.sess_auc = trapz(smooth_sess_reb_1000_CA1,2);
% 
% reb_40_CA1.avg_pre_reb_auc = trapz(smooth_avg_reb_40_CA1(5*Fs:10*Fs));
% reb_140_CA1.avg_pre_reb_auc = trapz(smooth_avg_reb_140_CA1(5*Fs:10*Fs));
% reb_1000_CA1.avg_pre_reb_auc = trapz(smooth_avg_reb_1000_CA1(5*Fs:10*Fs));
% 
% reb_40_CA1.pre_reb_auc = trapz(smooth_reb_40_CA1(:,5*Fs:10*Fs),2);
% reb_140_CA1.pre_reb_auc = trapz(smooth_reb_140_CA1(:,5*Fs:10*Fs),2);
% reb_1000_CA1.pre_reb_auc = trapz(smooth_reb_1000_CA1(:,5*Fs:10*Fs),2);
% 
% reb_40_CA1.sess_pre_reb_auc = trapz(smooth_sess_reb_40_CA1(:,5*Fs:10*Fs),2);
% reb_140_CA1.sess_pre_reb_auc = trapz(smooth_sess_reb_140_CA1(:,5*Fs:10*Fs),2);
% reb_1000_CA1.sess_pre_reb_auc = trapz(smooth_sess_reb_1000_CA1(:,5*Fs:10*Fs),2);
% 
% reb_40_CA1.avg_only_reb_auc = trapz(smooth_avg_reb_40_CA1(5*Fs:10*Fs));
% reb_140_CA1.avg_only_reb_auc = trapz(smooth_avg_reb_140_CA1(5*Fs:10*Fs));
% reb_1000_CA1.avg_only_reb_auc = trapz(smooth_avg_reb_1000_CA1(5*Fs:10*Fs));
% 
% reb_40_CA1.only_reb_auc = trapz(smooth_reb_40_CA1(:,5*Fs:10*Fs),2);
% reb_140_CA1.only_reb_auc = trapz(smooth_reb_140_CA1(:,5*Fs:10*Fs),2);
% reb_1000_CA1.only_reb_auc = trapz(smooth_reb_1000_CA1(:,5*Fs:10*Fs),2);
% 
% reb_40_CA1.sess_only_reb_auc = trapz(smooth_sess_reb_40_CA1(:,5*Fs:10*Fs),2);
% reb_140_CA1.sess_only_reb_auc = trapz(smooth_sess_reb_140_CA1(:,5*Fs:10*Fs),2);
% reb_1000_CA1.sess_only_reb_auc = trapz(smooth_sess_reb_1000_CA1(:,5*Fs:10*Fs),2);
% 
% % reb cort
% reb_40_M1.avg_auc = trapz(smooth_avg_reb_40_M1);
% reb_140_M1.avg_auc = trapz(smooth_avg_reb_140_M1);
% reb_1000_M1.avg_auc = trapz(smooth_avg_reb_1000_M1);
% 
% reb_40_M1.auc = trapz(smooth_reb_40_M1,2);
% reb_140_M1.auc = trapz(smooth_reb_140_M1,2);
% reb_1000_M1.auc = trapz(smooth_reb_1000_M1,2);
% 
% reb_40_M1.sess_auc = trapz(smooth_sess_reb_40_M1,2);
% reb_140_M1.sess_auc = trapz(smooth_sess_reb_140_M1,2);
% reb_1000_M1.sess_auc = trapz(smooth_sess_reb_1000_M1,2);
% 
% reb_40_M1.avg_pre_reb_auc = trapz(smooth_avg_reb_40_M1(5*Fs:10*Fs));
% reb_140_M1.avg_pre_reb_auc = trapz(smooth_avg_reb_140_M1(5*Fs:10*Fs));
% reb_1000_M1.avg_pre_reb_auc = trapz(smooth_avg_reb_1000_M1(5*Fs:10*Fs));
% 
% reb_40_M1.pre_reb_auc = trapz(smooth_reb_40_M1(:,5*Fs:10*Fs),2);
% reb_140_M1.pre_reb_auc = trapz(smooth_reb_140_M1(:,5*Fs:10*Fs),2);
% reb_1000_M1.pre_reb_auc = trapz(smooth_reb_1000_M1(:,5*Fs:10*Fs),2);
% 
% reb_40_M1.sess_pre_reb_auc = trapz(smooth_sess_reb_40_M1(:,5*Fs:10*Fs),2);
% reb_140_M1.sess_pre_reb_auc = trapz(smooth_sess_reb_140_M1(:,5*Fs:10*Fs),2);
% reb_1000_M1.sess_pre_reb_auc = trapz(smooth_sess_reb_1000_M1(:,5*Fs:10*Fs),2);
% 
% reb_40_M1.avg_only_reb_auc = trapz(smooth_avg_reb_40_M1(5*Fs:10*Fs));
% reb_140_M1.avg_only_reb_auc = trapz(smooth_avg_reb_140_M1(5*Fs:10*Fs));
% reb_1000_M1.avg_onlyl_reb_auc = trapz(smooth_avg_reb_1000_M1(5*Fs:10*Fs));
% 
% reb_40_M1.only_reb_auc = trapz(smooth_reb_40_M1(:,5*Fs:10*Fs),2);
% reb_140_M1.only_reb_auc = trapz(smooth_reb_140_M1(:,5*Fs:10*Fs),2);
% reb_1000_M1.only_reb_auc = trapz(smooth_reb_1000_M1(:,5*Fs:10*Fs),2);
% 
% reb_40_M1.sess_only_reb_auc = trapz(smooth_sess_reb_40_M1(:,5*Fs:10*Fs),2);
% reb_140_M1.sess_only_reb_auc = trapz(smooth_sess_reb_140_M1(:,5*Fs:10*Fs),2);
% reb_1000_M1.sess_only_reb_auc = trapz(smooth_sess_reb_1000_M1(:,5*Fs:10*Fs),2);
%% Box Plots -- Compare within CA1 (Kruskal-Wallis)
%Neuron-Wise
pvals_struct = compare_CA1_KW(pos_40_CA1,pos_140_CA1,pos_1000_CA1,...
                                            neg_40_CA1, neg_140_CA1, neg_1000_CA1,...
                                            pvals_struct,colors);
% Session-Wise
pvals_struct = sess_compare_CA1_KW(pos_40_CA1,pos_140_CA1,pos_1000_CA1,...
                                                neg_40_CA1, neg_140_CA1, neg_1000_CA1,...
                                                pvals_struct,colors);
%% Box Plots -- Compare within M1 (Kuskal-Wallis)
% %Neuron-Wise
pvals_struct = compare_M1_KW(pos_40_M1,pos_140_M1,pos_1000_M1,...
                                 neg_40_M1, neg_140_M1, neg_1000_M1,...
                                 pvals_struct,colors);
                             
% Session-Wise
pvals_struct = sess_compare_M1_KW(pos_40_M1,pos_140_M1,pos_1000_M1,...
                                            neg_40_M1, neg_140_M1, neg_1000_M1,...
                                            pvals_struct,colors);
%% Box Plots -- Compare within 40Hz (Wilcoxon Ranksum)
%Neuron-Wise
pvals_struct = compare_40Hz_ranksum(pos_40_CA1,pos_40_M1,...
                                            neg_40_CA1, neg_40_M1,...
                                            pvals_struct,colors);
% Session-Wise
pvals_struct = sess_compare_40Hz_ranksum(pos_40_CA1,pos_40_M1,...
                                            neg_40_CA1, neg_40_M1,...
                                            pvals_struct,colors);
%% Box Plots -- Compare within 140Hz (Wilcoxon Ranksum)
%Neuron-Wise
pvals_struct = compare_140Hz_ranksum(pos_140_CA1,pos_140_M1,...
                                            neg_140_CA1, neg_140_M1,...
                                            pvals_struct,colors);

% Session-Wise
pvals_struct = sess_compare_140Hz_ranksum(pos_140_CA1,pos_140_M1,...
                                            neg_140_CA1, neg_140_M1,...
                                            pvals_struct,colors);
%% Box Plots -- Compare within 1000Hz (Wilcoxon Ranksum)
%Neuron-Wise
pvals_struct = compare_1000Hz_ranksum(pos_1000_CA1,pos_1000_M1, ...
                                             neg_1000_CA1,neg_1000_M1,...
                                             pvals_struct,colors);
% Session-Wise
pvals_struct = sess_compare_1000Hz_ranksum(pos_1000_CA1,pos_1000_M1, ...
                                             neg_1000_CA1,neg_1000_M1,...
                                             pvals_struct,colors);
%% Plot the average of the session average traces 
%(this weighs every session as opposed to every neuron equally)

%Positive
avg_sess_avg_pos_40_CA1 = smooth(mean(pos_40_CA1.session_avg_traces,1));
avg_sess_avg_pos_140_CA1 = smooth(mean(pos_140_CA1.session_avg_traces,1));
avg_sess_avg_pos_1000_CA1 = smooth(mean(pos_1000_CA1.session_avg_traces,1));

avg_sess_avg_pos_40_M1 = smooth(mean(pos_40_M1.session_avg_traces,1));
avg_sess_avg_pos_140_M1 = smooth(mean(pos_140_M1.session_avg_traces,1));
avg_sess_avg_pos_1000_M1 = smooth(mean(pos_1000_M1.session_avg_traces,1));

%Negative
avg_sess_avg_neg_40_CA1 = smooth(mean(neg_40_CA1.session_avg_traces,1));
avg_sess_avg_neg_140_CA1 = smooth(mean(neg_140_CA1.session_avg_traces,1));
avg_sess_avg_neg_1000_CA1 = smooth(mean(neg_1000_CA1.session_avg_traces,1));

avg_sess_avg_neg_40_M1 = smooth(mean(neg_40_M1.session_avg_traces,1));
avg_sess_avg_neg_140_M1 = smooth(mean(neg_140_M1.session_avg_traces,1));
avg_sess_avg_neg_1000_M1 = smooth(mean(neg_1000_M1.session_avg_traces,1));

%Rebound
% avg_sess_avg_reb_40_CA1 = smooth(mean(reb_40_CA1.session_avg_traces,1));
% avg_sess_avg_reb_140_CA1 = smooth(mean(reb_140_CA1.session_avg_traces,1));
% avg_sess_avg_reb_1000_CA1 = smooth(mean(reb_1000_CA1.session_avg_traces,1));
% 
% avg_sess_avg_reb_40_M1 = smooth(mean(reb_40_M1.session_avg_traces,1));
% avg_sess_avg_reb_140_M1 = smooth(mean(reb_140_M1.session_avg_traces,1));
% avg_sess_avg_reb_1000_M1 = smooth(mean(reb_1000_M1.session_avg_traces,1));

figure; hold on
plot(avg_sess_avg_pos_40_CA1,'-','Color',color_40_CA1)
plot(avg_sess_avg_pos_140_CA1,'-','Color',color_140_CA1)
plot(avg_sess_avg_pos_1000_CA1,'-','Color',color_1000_CA1)
plot(avg_sess_avg_pos_40_M1,'--','Color',color_40_M1)
plot(avg_sess_avg_pos_140_M1,'--','Color',color_140_M1)
plot(avg_sess_avg_pos_1000_M1,'--','Color',color_1000_M1)
title('Pos Mod: Avg of Session Avgs')

figure; hold on
plot(avg_sess_avg_neg_40_CA1,'-','Color',color_40_CA1)
plot(avg_sess_avg_neg_140_CA1,'-','Color',color_140_CA1)
plot(avg_sess_avg_neg_1000_CA1,'-','Color',color_1000_CA1)
plot(avg_sess_avg_neg_40_M1,'--','Color',color_40_M1)
plot(avg_sess_avg_neg_140_M1,'--','Color',color_140_M1)
plot(avg_sess_avg_neg_1000_M1,'--','Color',color_1000_M1)
title('Neg Mod: Avg of Session Avgs')
% 
% figure; hold on
% plot(avg_sess_avg_reb_40_CA1,'-','Color',color_40_CA1)
% plot(avg_sess_avg_reb_140_CA1,'-','Color',color_140_CA1)
% plot(avg_sess_avg_reb_1000_CA1,'-','Color',color_1000_CA1)
% plot(avg_sess_avg_reb_40_M1,'--','Color',color_40_M1)
% plot(avg_sess_avg_reb_140_M1,'--','Color',color_140_M1)
% plot(avg_sess_avg_reb_1000_M1,'--','Color',color_1000_M1)
% title('Reb: Avg of Session Avgs')


% Now plot normal avg traces
figure; hold on
plot(pos_40_CA1.avg_trace,'-','Color',color_40_CA1)
plot(pos_140_CA1.avg_trace,'-','Color',color_140_CA1)
plot(pos_1000_CA1.avg_trace,'-','Color',color_1000_CA1)
plot(pos_40_M1.avg_trace,'--','Color',color_40_M1)
plot(pos_140_M1.avg_trace,'--','Color',color_140_M1)
plot(pos_1000_M1.avg_trace,'--','Color',color_1000_M1)
title('Pos Mod: Avg trace')

figure; hold on
plot(neg_40_CA1.avg_trace,'-','Color',color_40_CA1)
plot(neg_140_CA1.avg_trace,'-','Color',color_140_CA1)
plot(neg_1000_CA1.avg_trace,'-','Color',color_1000_CA1)
plot(neg_40_M1.avg_trace,'--','Color',color_40_M1)
plot(neg_140_M1.avg_trace,'--','Color',color_140_M1)
plot(neg_1000_M1.avg_trace,'--','Color',color_1000_M1)
title('Neg Mod: Avg trace')
% 
% figure; hold on
% plot(reb_40_CA1.avg_trace,'-','Color',color_40_CA1)
% plot(reb_140_CA1.avg_trace,'-','Color',color_140_CA1)
% plot(reb_1000_CA1.avg_trace,'-','Color',color_1000_CA1)
% plot(reb_40_M1.avg_trace,'--','Color',color_40_M1)
% plot(reb_140_M1.avg_trace,'--','Color',color_140_M1)
% plot(reb_1000_M1.avg_trace,'--','Color',color_1000_M1)
% title('Reb: Avg trace')

%% Save all Data structures to save_path
save('pvals_struct.mat','pvals_struct');
%============================== Positive =================================%
save('pos_40_CA1.mat','pos_40_CA1');
save('pos_140_CA1.mat','pos_140_CA1');
save('pos_1000_CA1.mat','pos_1000_CA1');

save('pos_40_M1.mat','pos_40_M1');
save('pos_140_M1.mat','pos_140_M1');
save('pos_1000_M1.mat','pos_1000_M1');

%=============================== Negative ================================%
save('neg_40_CA1.mat','neg_40_CA1');
save('neg_140_CA1.mat','neg_140_CA1');
save('neg_1000_CA1.mat','neg_1000_CA1');

save('neg_40_M1.mat','neg_40_M1');
save('neg_140_M1.mat','neg_140_M1');
save('neg_1000_M1.mat','neg_1000_M1');

% %========================= Rebound =======================================%
% save('reb_40_CA1.mat','reb_40_CA1');
% save('reb_140_CA1.mat','reb_140_CA1');
% save('reb_1000_CA1.mat','reb_1000_CA1');
% 
% save('reb_40_M1.mat','reb_40_M1');
% save('reb_140_M1.mat','reb_140_M1');
% save('reb_1000_M1.mat','reb_1000_M1');
end