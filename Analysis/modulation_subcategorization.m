% modulation_subcategorization.m
% Author: Cara R
% Date: 08/04/22
% Purpose: Classify the subcategorizations for different modulation combinations
% using the files from the DBS_modulation_check script.
%
% Note: Use ctrl+F to change all "1000"s, "11000"s, "1000"s to whatever freq of
% interest
addpath(genpath('~/handata_server/Cara_Ravasio/Code/GCaMP_Data_Extraction'));

pos_pos_mod_1000 = [];
pos_non_mod_1000 = [];
pos_neg_mod_1000 = [];

non_pos_mod_1000 = [];
non_non_mod_1000 = [];
non_neg_mod_1000 = [];

neg_pos_mod_1000 = [];
neg_non_mod_1000 = [];
neg_neg_mod_1000 = [];

%% Classify modulation category overlap for Positive transient
if ~isempty(pos_mod_1000.trans.neurons)
    for i = 1:size(pos_mod_1000.trans.neurons,1)
        % Positive sustained
        if ~isempty(pos_mod_1000.sust.neurons)
            for j = 1:size(pos_mod_1000.sust.neurons,1)
                if (pos_mod_1000.trans.neurons(i,1) == pos_mod_1000.sust.neurons(j,1)) && (pos_mod_1000.trans.neurons(i,2) == pos_mod_1000.sust.neurons(j,2))
                    pos_pos_mod_1000 = [pos_pos_mod_1000; pos_mod_1000.trans.neurons(i,:)];
                end
            end
        end
        
        % Non Sustained
        if ~isempty(non_mod_1000.sust.neurons)
            for j = 1:size(non_mod_1000.sust.neurons,1)
                if (pos_mod_1000.trans.neurons(i,1) == non_mod_1000.sust.neurons(j,1)) && (pos_mod_1000.trans.neurons(i,2) == non_mod_1000.sust.neurons(j,2))
                    pos_non_mod_1000 = [pos_non_mod_1000; pos_mod_1000.trans.neurons(i,:)];
                end
            end
        end
        
        % Neg Sustained
        if ~isempty(neg_mod_1000.sust.neurons)
            for j = 1:size(neg_mod_1000.sust.neurons,1)
                if (pos_mod_1000.trans.neurons(i,1) == neg_mod_1000.sust.neurons(j,1)) && (pos_mod_1000.trans.neurons(i,2) == neg_mod_1000.sust.neurons(j,2))
                    pos_neg_mod_1000 = [pos_neg_mod_1000; pos_mod_1000.trans.neurons(i,:)];
                end
            end
        end
        
    end
end

%% Classify modulation category overlap for Non transient
if ~isempty(non_mod_1000.trans.neurons)
    for i = 1:size(non_mod_1000.trans.neurons,1)
        % Positive sustained
        if ~isempty(pos_mod_1000.sust.neurons)
            for j = 1:size(pos_mod_1000.sust.neurons,1)
                if (non_mod_1000.trans.neurons(i,1) == pos_mod_1000.sust.neurons(j,1)) && (non_mod_1000.trans.neurons(i,2) == pos_mod_1000.sust.neurons(j,2))
                    non_pos_mod_1000 = [non_pos_mod_1000; non_mod_1000.trans.neurons(i,:)];
                end
            end
        end
        
        % Non Sustained
        if ~isempty(non_mod_1000.sust.neurons)
            for j = 1:size(non_mod_1000.sust.neurons,1)
                if (non_mod_1000.trans.neurons(i,1) == non_mod_1000.sust.neurons(j,1)) && (non_mod_1000.trans.neurons(i,2) == non_mod_1000.sust.neurons(j,2))
                    non_non_mod_1000 = [non_non_mod_1000; non_mod_1000.trans.neurons(i,:)];
                end
            end
        end
        
        % Neg Sustained
        if ~isempty(neg_mod_1000.sust.neurons)
            for j = 1:size(neg_mod_1000.sust.neurons,1)
                if (non_mod_1000.trans.neurons(i,1) == neg_mod_1000.sust.neurons(j,1)) && (non_mod_1000.trans.neurons(i,2) == neg_mod_1000.sust.neurons(j,2))
                    non_neg_mod_1000 = [non_neg_mod_1000; non_mod_1000.trans.neurons(i,:)];
                end
            end
        end
        
    end
end

%% Classify modulation category overlap for Negative transient
if ~isempty(neg_mod_1000.trans.neurons)
    for i = 1:size(neg_mod_1000.trans.neurons,1)
        % Positive sustained
        if ~isempty(pos_mod_1000.sust.neurons)
            for j = 1:size(pos_mod_1000.sust.neurons,1)
                if (neg_mod_1000.trans.neurons(i,1) == pos_mod_1000.sust.neurons(j,1)) && (neg_mod_1000.trans.neurons(i,2) == pos_mod_1000.sust.neurons(j,2))
                    neg_pos_mod_1000 = [neg_pos_mod_1000; neg_mod_1000.trans.neurons(i,:)];
                end
            end
        end
        
        % Non Sustained
        if ~isempty(non_mod_1000.sust.neurons)
            for j = 1:size(non_mod_1000.sust.neurons,1)
                if (neg_mod_1000.trans.neurons(i,1) == non_mod_1000.sust.neurons(j,1)) && (neg_mod_1000.trans.neurons(i,2) == non_mod_1000.sust.neurons(j,2))
                    neg_non_mod_1000 = [neg_non_mod_1000; neg_mod_1000.trans.neurons(i,:)];
                end
            end
        end
        
        % Neg Sustained
        if ~isempty(neg_mod_1000.sust.neurons)
            for j = 1:size(neg_mod_1000.sust.neurons,1)
                if (neg_mod_1000.trans.neurons(i,1) == neg_mod_1000.sust.neurons(j,1)) && (neg_mod_1000.trans.neurons(i,2) == neg_mod_1000.sust.neurons(j,2))
                    neg_neg_mod_1000 = [neg_neg_mod_1000; neg_mod_1000.trans.neurons(i,:)];
                end
            end
        end
        
    end
end

%% Visualize the matrix

modulation_cat_mat = [size(pos_pos_mod_1000,1), size(non_pos_mod_1000,1), size(neg_pos_mod_1000,1);...
                      size(pos_non_mod_1000,1), size(non_non_mod_1000,1), size(neg_non_mod_1000,1);...
                      size(pos_neg_mod_1000,1), size(non_neg_mod_1000,1), size(neg_neg_mod_1000,1)];

figure;
heatmap(modulation_cat_mat)
xlabel('Transient Pos | Non | Neg');
ylabel('Sustained Neg | Non | Pos');
title('1000Hz M1 Modulation Subcategorization')
