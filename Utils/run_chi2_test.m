% run_chi2_test.m
% Author: Cara
% Date: 09/18/23
% Purpose: run chi2 test on all possible combinations of the pie/bar chart
% data.

function chi2test_stats = run_chi2_test(bar_mat)
%% Chi-Squared Test
    % matrix setup
    % col1: Neg, col2: Pos, col3: Non
    % row1: 40Hz CA1, row2: 140Hz CA1, row3: 1000Hz CA1
    % row4: 40Hz M1, row5: 140Hz M1, row6: 1000Hz M1
%% - CA1 -%
% 3x3 contingency tables
% Observed data
observed = bar_mat(1:3,:);
chi2test_stats.CA1.observed = observed;
[chi2test_stats.CA1.p, ...
 chi2test_stats.CA1.p_adj,...
 chi2test_stats.CA1.w, ...
 chi2test_stats.CA1.df,...
 chi2test_stats.CA1.chi2stat, ...
 chi2test_stats.CA1.expected] = chi2test_Cara(observed); % based on  Peder Axensten chi2test.m

observed = [bar_mat(1:3,2),sum([bar_mat(1:3,logical([1 0 1]))],2)];
chi2test_stats.CA1.pos_notpos.observed = observed;
[chi2test_stats.CA1.pos_notpos.p, ...
 chi2test_stats.CA1.pos_notpos.p_adj,...
 chi2test_stats.CA1.pos_notpos.w, ...
 chi2test_stats.CA1.pos_notpos.df,...
 chi2test_stats.CA1.pos_notpos.chi2stat, ...
 chi2test_stats.CA1.pos_notpos.expected] = chi2test_Cara(observed);

 observed = [bar_mat(1:3,1),sum([bar_mat(1:3,2:3)],2)];
chi2test_stats.CA1.neg_notneg.observed = observed;
[chi2test_stats.CA1.neg_notneg.p, ...
 chi2test_stats.CA1.neg_notneg.p_adj,...
 chi2test_stats.CA1.neg_notneg.w, ...
 chi2test_stats.CA1.neg_notneg.df,...
 chi2test_stats.CA1.neg_notneg.chi2stat, ...
 chi2test_stats.CA1.neg_notneg.expected] = chi2test_Cara(observed);

% 2x2 contingency tables
% 40vs140; pos/not-pos
observed = [bar_mat(1:2,2),sum([bar_mat(1:2,logical([1 0 1]))],2)];
chi2test_stats.CA1.hz40_140.pos_notpos.observed = observed;
[chi2test_stats.CA1.hz40_140.pos_notpos.p,...
 chi2test_stats.CA1.hz40_140.pos_notpos.p_adj, ...
 chi2test_stats.CA1.hz40_140.pos_notpos.w, ...
 chi2test_stats.CA1.hz40_140.pos_notpos.df,...
 chi2test_stats.CA1.hz40_140.pos_notpos.chi2stat, ...
 chi2test_stats.CA1.hz40_140.pos_notpos.expected] = chi2test_Cara(observed);

% 40vs1000; pos/not-pos
observed = [bar_mat(logical([1 0 1]),2),sum([bar_mat(logical([1 0 1]),logical([1 0 1]))],2)];
chi2test_stats.CA1.hz40_1000.pos_notpos.observed = observed;
[chi2test_stats.CA1.hz40_1000.pos_notpos.p,...
 chi2test_stats.CA1.hz40_1000.pos_notpos.p_adj, ...
 chi2test_stats.CA1.hz40_1000.pos_notpos.w, ...
 chi2test_stats.CA1.hz40_1000.pos_notpos.df,...
 chi2test_stats.CA1.hz40_1000.pos_notpos.chi2stat, ...
 chi2test_stats.CA1.hz40_1000.pos_notpos.expected] = chi2test_Cara(observed);

% 140vs1000; pos/not-pos
observed = [bar_mat(2:3,2),sum([bar_mat(2:3,logical([1 0 1]))],2)];
chi2test_stats.CA1.hz140_1000.pos_notpos.observed = observed;
[chi2test_stats.CA1.hz140_1000.pos_notpos.p,...
 chi2test_stats.CA1.hz140_1000.pos_notpos.p_adj, ...
 chi2test_stats.CA1.hz140_1000.pos_notpos.w, ...
 chi2test_stats.CA1.hz140_1000.pos_notpos.df,...
 chi2test_stats.CA1.hz140_1000.pos_notpos.chi2stat, ...
 chi2test_stats.CA1.hz140_1000.pos_notpos.expected] = chi2test_Cara(observed);

% 40vs140; neg/not-neg
observed = [bar_mat(1:2,1),sum([bar_mat(1:2,2:3)],2)];
chi2test_stats.CA1.hz40_140.neg_notneg.observed = observed;
[chi2test_stats.CA1.hz40_140.neg_notneg.p,...
 chi2test_stats.CA1.hz40_140.neg_notneg.p_adj, ...
 chi2test_stats.CA1.hz40_140.neg_notneg.w, ...
 chi2test_stats.CA1.hz40_140.neg_notneg.df,...
 chi2test_stats.CA1.hz40_140.neg_notneg.chi2stat, ...
 chi2test_stats.CA1.hz40_140.neg_notneg.expected] = chi2test_Cara(observed);

% 40vs1000; neg/not-neg
observed = [bar_mat(logical([1 0 1]),1),sum([bar_mat(logical([1 0 1]),2:3)],2)];
chi2test_stats.CA1.hz40_1000.neg_notneg.observed = observed;
[chi2test_stats.CA1.hz40_1000.neg_notneg.p,...
 chi2test_stats.CA1.hz40_1000.neg_notneg.p_adj, ...
 chi2test_stats.CA1.hz40_1000.neg_notneg.w, ...
 chi2test_stats.CA1.hz40_1000.neg_notneg.df,...
 chi2test_stats.CA1.hz40_1000.neg_notneg.chi2stat, ...
 chi2test_stats.CA1.hz40_1000.neg_notneg.expected] = chi2test_Cara(observed);

% 140vs1000; neg/not-neg
observed = [bar_mat(2:3,1),sum([bar_mat(2:3,2:3)],2)];
chi2test_stats.CA1.hz140_1000.neg_notneg.observed = observed;
[chi2test_stats.CA1.hz140_1000.neg_notneg.p,...
 chi2test_stats.CA1.hz140_1000.neg_notneg.p_adj, ...
 chi2test_stats.CA1.hz140_1000.neg_notneg.w, ...
 chi2test_stats.CA1.hz140_1000.neg_notneg.df,...
 chi2test_stats.CA1.hz140_1000.neg_notneg.chi2stat, ...
 chi2test_stats.CA1.hz140_1000.neg_notneg.expected] = chi2test_Cara(observed);

% 40Hz; pos_neg
observed = [bar_mat(1,1:2)',[sum(bar_mat(1,2:3));sum(bar_mat(1,logical([1 0 1])))]];
chi2test_stats.CA1.hz40.pos_neg.observed = observed;
[chi2test_stats.CA1.hz40.pos_neg.p,...
 chi2test_stats.CA1.hz40.pos_neg.p_adj, ...
 chi2test_stats.CA1.hz40.pos_neg.w, ...
 chi2test_stats.CA1.hz40.pos_neg.df,...
 chi2test_stats.CA1.hz40.pos_neg.chi2stat, ...
 chi2test_stats.CA1.hz40.pos_neg.expected] = chi2test_Cara(observed);

% 140Hz; pos_neg
observed = [bar_mat(2,1:2)',[sum(bar_mat(2,2:3));sum(bar_mat(2,logical([1 0 1])))]];
chi2test_stats.CA1.hz140.pos_neg.observed = observed;
[chi2test_stats.CA1.hz140.pos_neg.p,...
 chi2test_stats.CA1.hz140.pos_neg.p_adj, ...
 chi2test_stats.CA1.hz140.pos_neg.w, ...
 chi2test_stats.CA1.hz140.pos_neg.df,...
 chi2test_stats.CA1.hz140.pos_neg.chi2stat, ...
 chi2test_stats.CA1.hz140.pos_neg.expected] = chi2test_Cara(observed);

% 1000Hz; pos_neg
observed = [bar_mat(3,1:2)',[sum(bar_mat(3,2:3));sum(bar_mat(3,logical([1 0 1])))]];
chi2test_stats.CA1.hz1000.pos_neg.observed = observed;
[chi2test_stats.CA1.hz1000.pos_neg.p,...
 chi2test_stats.CA1.hz1000.pos_neg.p_adj, ...
 chi2test_stats.CA1.hz1000.pos_neg.w, ...
 chi2test_stats.CA1.hz1000.pos_neg.df,...
 chi2test_stats.CA1.hz1000.pos_neg.chi2stat, ...
 chi2test_stats.CA1.hz1000.pos_neg.expected] = chi2test_Cara(observed);

%% - M1 -%
% 3x3 contingency tables
% Observed data
observed = bar_mat(4:6,:);
chi2test_stats.M1.observed = observed;
[chi2test_stats.M1.p, ...
 chi2test_stats.M1.p_adj,...
 chi2test_stats.M1.w, ...
 chi2test_stats.M1.df,...
 chi2test_stats.M1.chi2stat, ...
 chi2test_stats.M1.expected] = chi2test_Cara(observed); % based on  Peder Axensten chi2test.m


observed = [bar_mat(1:3,2),sum([bar_mat(1:3,logical([1 0 1]))],2)];
chi2test_stats.M1.pos_notpos.observed = observed;
[chi2test_stats.M1.pos_notpos.p, ...
 chi2test_stats.M1.pos_notpos.p_adj,...
 chi2test_stats.M1.pos_notpos.w, ...
 chi2test_stats.M1.pos_notpos.df,...
 chi2test_stats.M1.pos_notpos.chi2stat, ...
 chi2test_stats.M1.pos_notpos.expected] = chi2test_Cara(observed);

 observed = [bar_mat(1:3,1),sum([bar_mat(1:3,2:3)],2)];
chi2test_stats.M1.neg_notneg.observed = observed;
[chi2test_stats.M1.neg_notneg.p, ...
 chi2test_stats.M1.neg_notneg.p_adj,...
 chi2test_stats.M1.neg_notneg.w, ...
 chi2test_stats.M1.neg_notneg.df,...
 chi2test_stats.M1.neg_notneg.chi2stat, ...
 chi2test_stats.M1.neg_notneg.expected] = chi2test_Cara(observed);

% 2x2 contingency tables
% 40vs140; pos/not-pos
observed = [bar_mat(4:5,2),sum([bar_mat(4:5,logical([1 0 1 ]))],2)];
chi2test_stats.M1.hz40_140.pos_notpos.observed = observed;
[chi2test_stats.M1.hz40_140.pos_notpos.p,...
 chi2test_stats.M1.hz40_140.pos_notpos.p_adj, ...
 chi2test_stats.M1.hz40_140.pos_notpos.w, ...
 chi2test_stats.M1.hz40_140.pos_notpos.df,...
 chi2test_stats.M1.hz40_140.pos_notpos.chi2stat, ...
 chi2test_stats.M1.hz40_140.pos_notpos.expected] = chi2test_Cara(observed);

% 40vs1000; pos/not-pos
observed = [bar_mat(logical([0 0 0 1 0 1]),2),sum([bar_mat(logical([0 0 0 1 0 1]),logical([1 0 1]))],2)];
chi2test_stats.M1.hz40_1000.pos_notpos.observed = observed;
[chi2test_stats.M1.hz40_1000.pos_notpos.p,...
 chi2test_stats.M1.hz40_1000.pos_notpos.p_adj, ...
 chi2test_stats.M1.hz40_1000.pos_notpos.w, ...
 chi2test_stats.M1.hz40_1000.pos_notpos.df,...
 chi2test_stats.M1.hz40_1000.pos_notpos.chi2stat, ...
 chi2test_stats.M1.hz40_1000.pos_notpos.expected] = chi2test_Cara(observed);

% 140vs1000; pos/not-pos
observed = [bar_mat(5:6,2),sum([bar_mat(5:6,logical([1 0 1]))],2)];
chi2test_stats.M1.hz140_1000.pos_notpos.observed = observed;
[chi2test_stats.M1.hz140_1000.pos_notpos.p,...
 chi2test_stats.M1.hz140_1000.pos_notpos.p_adj, ...
 chi2test_stats.M1.hz140_1000.pos_notpos.w, ...
 chi2test_stats.M1.hz140_1000.pos_notpos.df,...
 chi2test_stats.M1.hz140_1000.pos_notpos.chi2stat, ...
 chi2test_stats.M1.hz140_1000.pos_notpos.expected] = chi2test_Cara(observed);

% 40vs140; neg/not-neg
observed = [bar_mat(4:5,1),sum([bar_mat(4:5,2:3)],2)];
chi2test_stats.M1.hz40_140.neg_notneg.observed = observed;
[chi2test_stats.M1.hz40_140.neg_notneg.p,...
 chi2test_stats.M1.hz40_140.neg_notneg.p_adj, ...
 chi2test_stats.M1.hz40_140.neg_notneg.w, ...
 chi2test_stats.M1.hz40_140.neg_notneg.df,...
 chi2test_stats.M1.hz40_140.neg_notneg.chi2stat, ...
 chi2test_stats.M1.hz40_140.neg_notneg.expected] = chi2test_Cara(observed);

% 40vs1000; neg/not-neg
observed = [bar_mat(logical([0 0 0 1 0 1]),1),sum([bar_mat(logical([0 0 0 1 0 1]),2:3)],2)];
chi2test_stats.M1.hz40_1000.neg_notneg.observed = observed;
[chi2test_stats.M1.hz40_1000.neg_notneg.p,...
 chi2test_stats.M1.hz40_1000.neg_notneg.p_adj, ...
 chi2test_stats.M1.hz40_1000.neg_notneg.w, ...
 chi2test_stats.M1.hz40_1000.neg_notneg.df,...
 chi2test_stats.M1.hz40_1000.neg_notneg.chi2stat, ...
 chi2test_stats.M1.hz40_1000.neg_notneg.expected] = chi2test_Cara(observed);

% 140vs1000; neg/not-neg
observed = [bar_mat(5:6,1),sum([bar_mat(5:6,2:3)],2)];
chi2test_stats.M1.hz140_1000.neg_notneg.observed = observed;
[chi2test_stats.M1.hz140_1000.neg_notneg.p,...
 chi2test_stats.M1.hz140_1000.neg_notneg.p_adj, ...
 chi2test_stats.M1.hz140_1000.neg_notneg.w, ...
 chi2test_stats.M1.hz140_1000.neg_notneg.df,...
 chi2test_stats.M1.hz140_1000.neg_notneg.chi2stat, ...
 chi2test_stats.M1.hz140_1000.neg_notneg.expected] = chi2test_Cara(observed);

% 40Hz; pos_neg
observed = [bar_mat(4,1:2)',[sum(bar_mat(4,2:3));sum(bar_mat(4,logical([1 0 1])))]];
chi2test_stats.M1.hz40.pos_neg.observed = observed;
[chi2test_stats.M1.hz40.pos_neg.p,...
 chi2test_stats.M1.hz40.pos_neg.p_adj, ...
 chi2test_stats.M1.hz40.pos_neg.w, ...
 chi2test_stats.M1.hz40.pos_neg.df,...
 chi2test_stats.M1.hz40.pos_neg.chi2stat, ...
 chi2test_stats.M1.hz40.pos_neg.expected] = chi2test_Cara(observed);

% 140Hz; pos_neg
observed = [bar_mat(5,1:2)',[sum(bar_mat(5,2:3));sum(bar_mat(5,logical([1 0 1])))]];
chi2test_stats.M1.hz140.pos_neg.observed = observed;
[chi2test_stats.M1.hz140.pos_neg.p,...
 chi2test_stats.M1.hz140.pos_neg.p_adj, ...
 chi2test_stats.M1.hz140.pos_neg.w, ...
 chi2test_stats.M1.hz140.pos_neg.df,...
 chi2test_stats.M1.hz140.pos_neg.chi2stat, ...
 chi2test_stats.M1.hz140.pos_neg.expected] = chi2test_Cara(observed);

% 1000Hz; pos_neg
observed = [bar_mat(6,1:2)',[sum(bar_mat(6,2:3));sum(bar_mat(6,logical([1 0 1])))]];
chi2test_stats.M1.hz1000.pos_neg.observed = observed;
[chi2test_stats.M1.hz1000.pos_neg.p,...
 chi2test_stats.M1.hz1000.pos_neg.p_adj, ...
 chi2test_stats.M1.hz1000.pos_neg.w, ...
 chi2test_stats.M1.hz1000.pos_neg.df,...
 chi2test_stats.M1.hz1000.pos_neg.chi2stat, ...
 chi2test_stats.M1.hz1000.pos_neg.expected] = chi2test_Cara(observed);
%% Mod_Nonmod
%- within CA1 -%
% 40vs140Hz; mod_nonmod
observed = [sum(bar_mat(1:2,1:2),2),bar_mat(1:2,3)];
chi2test_stats.CA1.hz40_140.mod_nonmod.observed = observed;
[chi2test_stats.CA1.hz40_140.mod_nonmod.p,...
 chi2test_stats.CA1.hz40_140.mod_nonmod.p_adj, ...
 chi2test_stats.CA1.hz40_140.mod_nonmod.w, ...
 chi2test_stats.CA1.hz40_140.mod_nonmod.df,...
 chi2test_stats.CA1.hz40_140.mod_nonmod.chi2stat, ...
 chi2test_stats.CA1.hz40_140.mod_nonmod.expected] = chi2test_Cara(observed);

% 40vs1000Hz; mod_nonmod
observed = [sum(bar_mat(logical([1 0 1 0 0 0]),1:2),2),bar_mat(logical([1 0 1 0 0 0]),3)];
chi2test_stats.CA1.hz40_1000.mod_nonmod.observed = observed;
[chi2test_stats.CA1.hz40_1000.mod_nonmod.p,...
 chi2test_stats.CA1.hz40_1000.mod_nonmod.p_adj, ...
 chi2test_stats.CA1.hz40_1000.mod_nonmod.w, ...
 chi2test_stats.CA1.hz40_1000.mod_nonmod.df,...
 chi2test_stats.CA1.hz40_1000.mod_nonmod.chi2stat, ...
 chi2test_stats.CA1.hz40_1000.mod_nonmod.expected] = chi2test_Cara(observed);

% 140vs1000Hz; mod_nonmod
observed = [sum(bar_mat(2:3,1:2),2),bar_mat(2:3,3)];
chi2test_stats.CA1.hz140_1000.mod_nonmod.observed = observed;
[chi2test_stats.CA1.hz140_1000.mod_nonmod.p,...
 chi2test_stats.CA1.hz140_1000.mod_nonmod.p_adj, ...
 chi2test_stats.CA1.hz140_1000.mod_nonmod.w, ...
 chi2test_stats.CA1.hz140_1000.mod_nonmod.df,...
 chi2test_stats.CA1.hz140_1000.mod_nonmod.chi2stat, ...
 chi2test_stats.CA1.hz140_1000.mod_nonmod.expected] = chi2test_Cara(observed);

%- within M1 -%
% 40vs140Hz; mod_nonmod
observed = [sum(bar_mat(4:5,1:2),2),bar_mat(4:5,3)];
chi2test_stats.M1.hz40_140.mod_nonmod.observed = observed;
[chi2test_stats.M1.hz40_140.mod_nonmod.p,...
 chi2test_stats.M1.hz40_140.mod_nonmod.p_adj, ...
 chi2test_stats.M1.hz40_140.mod_nonmod.w, ...
 chi2test_stats.M1.hz40_140.mod_nonmod.df,...
 chi2test_stats.M1.hz40_140.mod_nonmod.chi2stat, ...
 chi2test_stats.M1.hz40_140.mod_nonmod.expected] = chi2test_Cara(observed);

% 40vs1000Hz; mod_nonmod
observed = [sum(bar_mat(logical([0 0 0 1 0 1]),1:2),2),bar_mat(logical([0 0 0 1 0 1]),3)];
chi2test_stats.M1.hz40_1000.mod_nonmod.observed = observed;
[chi2test_stats.M1.hz40_1000.mod_nonmod.p,...
 chi2test_stats.M1.hz40_1000.mod_nonmod.p_adj, ...
 chi2test_stats.M1.hz40_1000.mod_nonmod.w, ...
 chi2test_stats.M1.hz40_1000.mod_nonmod.df,...
 chi2test_stats.M1.hz40_1000.mod_nonmod.chi2stat, ...
 chi2test_stats.M1.hz40_1000.mod_nonmod.expected] = chi2test_Cara(observed);

% 140vs1000Hz; mod_nonmod
observed = [sum(bar_mat(5:6,1:2),2),bar_mat(5:6,3)];
chi2test_stats.M1.hz140_1000.mod_nonmod.observed = observed;
[chi2test_stats.M1.hz140_1000.mod_nonmod.p,...
 chi2test_stats.M1.hz140_1000.mod_nonmod.p_adj, ...
 chi2test_stats.M1.hz140_1000.mod_nonmod.w, ...
 chi2test_stats.M1.hz140_1000.mod_nonmod.df,...
 chi2test_stats.M1.hz140_1000.mod_nonmod.chi2stat, ...
 chi2test_stats.M1.hz140_1000.mod_nonmod.expected] = chi2test_Cara(observed);

%- Within Frequency -%
% 40Hz; mod_nonmod
observed = [sum(bar_mat(logical([1 0 0 1 0 0]),1:2),2),bar_mat(logical([1 0 0 1 0 0]),3)];
chi2test_stats.hz40.mod_nonmod.observed = observed;
[chi2test_stats.hz40.mod_nonmod.p,...
 chi2test_stats.hz40.mod_nonmod.p_adj, ...
 chi2test_stats.hz40.mod_nonmod.w, ...
 chi2test_stats.hz40.mod_nonmod.df,...
 chi2test_stats.hz40.mod_nonmod.chi2stat, ...
 chi2test_stats.hz40.mod_nonmod.expected] = chi2test_Cara(observed);

% 140Hz; mod_nonmod
observed = [sum(bar_mat(logical([0 1 0 0 1 0]),1:2),2),bar_mat(logical([0 1 0 0 1 0]),3)];
chi2test_stats.hz140.mod_nonmod.observed = observed;
[chi2test_stats.hz140.mod_nonmod.p,...
 chi2test_stats.hz140.mod_nonmod.p_adj, ...
 chi2test_stats.hz140.mod_nonmod.w, ...
 chi2test_stats.hz140.mod_nonmod.df,...
 chi2test_stats.hz140.mod_nonmod.chi2stat, ...
 chi2test_stats.hz140.mod_nonmod.expected] = chi2test_Cara(observed);

% 1000Hz; mod_nonmod
observed = [sum(bar_mat(logical([0 0 1 0 0 1]),1:2),2),bar_mat(logical([0 0 1 0 0 1]),3)];
chi2test_stats.hz1000.mod_nonmod.observed = observed;
[chi2test_stats.hz1000.mod_nonmod.p,...
 chi2test_stats.hz1000.mod_nonmod.p_adj, ...
 chi2test_stats.hz1000.mod_nonmod.w, ...
 chi2test_stats.hz1000.mod_nonmod.df,...
 chi2test_stats.hz1000.mod_nonmod.chi2stat, ...
 chi2test_stats.hz1000.mod_nonmod.expected] = chi2test_Cara(observed);
end