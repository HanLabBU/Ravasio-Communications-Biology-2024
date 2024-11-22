% struct2table_Cara.m
% Date: 01/22/24
% Purpose: Turn the modulatd neuron structure into a table to be saved as a
% csv and analyzed in python.
% NOTE: mod, region, and frequency must be put in with " " NOT ' ' because
% otherwise it is treated as a char array not a string.

%Example: neg_40_CA1_tbl = struct2table_Cara(neg_40_CA1, "neg","CA1","40")

%% Converting modulated neuron struct to table and saving in csv format
neg_40_CA1_tbl = struct2table_Cara(neg_40_CA1, "neg","CA1","40");
neg_140_CA1_tbl = struct2table_Cara(neg_140_CA1, "neg","CA1","140");
neg_1000_CA1_tbl = struct2table_Cara(neg_1000_CA1, "neg","CA1","1000");
pos_40_CA1_tbl = struct2table_Cara(pos_40_CA1, "pos","CA1","40");
pos_140_CA1_tbl = struct2table_Cara(pos_140_CA1, "pos","CA1","140");
pos_1000_CA1_tbl = struct2table_Cara(pos_1000_CA1, "pos","CA1","1000");
non_40_CA1_tbl = struct2table_Cara(non_mod_40_CA1,"non","CA1","40");
non_140_CA1_tbl = struct2table_Cara(non_mod_140_CA1,"non","CA1","140");
non_1000_CA1_tbl = struct2table_Cara(non_mod_1000_CA1,"non","CA1","1000");

neg_40_M1_tbl = struct2table_Cara(neg_40_M1, "neg","M1","40");
neg_140_M1_tbl = struct2table_Cara(neg_140_M1, "neg","M1","140");
neg_1000_M1_tbl = struct2table_Cara(neg_1000_M1, "neg","M1","1000");
pos_40_M1_tbl = struct2table_Cara(pos_40_M1, "pos","M1","40");
pos_140_M1_tbl = struct2table_Cara(pos_140_M1, "pos","M1","140");
pos_1000_M1_tbl = struct2table_Cara(pos_1000_M1, "pos","M1","1000");
non_40_M1_tbl = struct2table_Cara(non_mod_40_M1,"non","M1","40");
non_140_M1_tbl = struct2table_Cara(non_mod_140_M1,"non","M1","140");
non_1000_M1_tbl = struct2table_Cara(non_mod_1000_M1,"non","M1","1000");

mod_table = vertcat(neg_40_CA1_tbl,neg_140_CA1_tbl,neg_1000_CA1_tbl,...
                    neg_40_M1_tbl,neg_140_M1_tbl,neg_1000_M1_tbl,...
                    pos_40_CA1_tbl,pos_140_CA1_tbl,pos_1000_CA1_tbl,...
                    pos_40_M1_tbl,pos_140_M1_tbl,pos_1000_M1_tbl,...
                    non_40_CA1_tbl,non_140_CA1_tbl,non_1000_CA1_tbl,...
                    non_40_M1_tbl,non_140_M1_tbl,non_1000_M1_tbl);
                
writetable(mod_table,'~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/mod_table.csv');              
%save('~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/mod_table.mat','mod_table');   

figure;
for i=1:25
    subplot(5,5,i)
    plot([1/20:1/20:20], example_traces.hz140.pos.CA1.traces(i,:));
    hold on
    plot([1/20:1/20:20], squeeze(example_traces.hz140.pos.CA1.trial_traces{i,1}(:,:,:)), 'Color',[0.8 0.8 0.8]);
    title(['Rec' num2str(example_traces.hz140.pos.CA1.neurons(i,1))...
        ', Neuron' num2str(example_traces.hz140.pos.CA1.neurons(i,2))]);
end
%% Function definition

function tbl = struct2table_Cara(mod_struct, mod, reg, freq)

% Determine number of entries
n_trials = (cellfun(@(x) size(x,3),mod_struct.trial_traces))';
N = sum(n_trials); %total number of entries needed for every trial of every neuron

% Setup fields for the table (#rows = #total trials)
mod_ID = repelem(mod,N)';
brain_reg = repelem(reg,N)';
stim_freq = repelem(freq,N)';
rec_sess = repelem(mod_struct.neurons(:,1),n_trials);
neuron_ID = repelem(mod_struct.neurons(:,2),n_trials);
trial_ID = [];
trial_traces = [];
for i = 1:numel(n_trials)
    trial_ID = vertcat(trial_ID, [1:1:n_trials(i)]');
    trial_traces = vertcat(trial_traces, squeeze(mod_struct.trial_traces{1,i})');
end
%avg_traces = (cellfun(@(x) mean(x,3), mod_struct.trial_traces,'UniformOutput',false))';

% Construct Table
tbl = table(mod_ID, brain_reg, stim_freq, rec_sess, neuron_ID, trial_ID, trial_traces);
        
end