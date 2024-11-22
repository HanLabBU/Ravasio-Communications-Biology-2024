% spatial_relationship_check.m
% Author: Cara Ravasio
% Date: 06/21/22
% Purpose: Assess how often there is a spatial relationship present.
% Spatial relationship is defined by finding the distace between every
% neuron to neuron pair and comparing the average distance for class A-A
% pairings or A-B or A-C pairings etc. and comparing the distance
% distribution. (Where classes A, B, and C are the calcium modulation
% identities of neurons)

%% Load roi_data and maxmin projection for size of fov
maxmin = uiopen('maxmin_*');
uiopen('roi_data*');
%maxmin = maxmin_617429_rec2_fov1_40_25_trials_10_roi;

%% Find the centroid of all ROIs
% Code taken from Emma's spatial analysis modulation script ==============%
centroid_roi = zeros(length(roi_data.goodIdx),2);
% loop through each ROI
for k = 1:length(roi_data.goodIdx)
    neuron_inds = roi_data.pixel_idx{1,k};
    TempMask = zeros(size(maxmin));
    
%     % build Event Mask
%     if sum(EventInds == goodTraces(k))
%         EventMask(neuron_inds) = 1;
%         TempMask(neuron_inds) = 1;
%     end
%     % build Dff Mask
%     if sum(DffInds == goodTraces(k))
%         DffMask(neuron_inds) = 1;
%         TempMask(neuron_inds) = 1;
%     end
%     % Build Combo Mask
%     if sum(BothInds == goodTraces(k))
%         BothMask(neuron_inds) = 1;
%         TempMask(neuron_inds) = 1;
%     end
% 
%     if ~sum(sum(BothInds == goodTraces(k)) + sum(EventInds == goodTraces(k)) + sum(DffInds == goodTraces(k)))
%         NoneInds = [NoneInds 1];
%         NoneMask(neuron_inds) = 1;
%         TempMask(neuron_inds) = 1;
%     end
    TempMask(neuron_inds) = 1;
    centroid = regionprops(TempMask,'Centroid');
    centroid_roi(k,:) = cell2mat({centroid.Centroid}); % find the centroid of the neuron for neighbor analysis [x,y] coords   
end
%=========================================================================%
%% Compute the neuron pair distance matrix (upper/lower triangle matrix)
D = zeros(length(roi_data.goodIdx));
for i = 1:length(roi_data.goodIdx)
    x1 = centroid_roi(i,1);
    y1 = centroid_roi(i,2);
    for j = 1:length(roi_data.goodIdx)
        x2 = centroid_roi(j,1);
        y2 = centroid_roi(j,2);
        D(i,j) = sqrt((x1-x2).^2 + (y1-y2).^2);
    end
end
dist_col = nonzeros(tril(D));

figure;
histogram(dist_col);
title('Full ROI Distance Distribution')
%% Compare distance distributions for different classes
Fs=20;
[stats_test{},z_test{}] = stats_gcamp_DBS(roi_data.avg_trace_minusBG_new,Fs);
pos_mod = DBS_modulation_check(z_test,40,1,0,Fs);
non_mod = DBS_modulation_check(z_test,40,0,0,Fs);
neg_mod = DBS_modulation_check(z_test,40,-1,0,Fs);

pos_pos_col = [];
pos_non_col = [];
pos_neg_col = [];
neg_non_col = [];
neg_neg_col = [];
non_non_col = [];
for i=1:size(pos_mod.stim.neurons)
    for j=1:size(pos_mod.stim.neurons)
        pos_pos_col = [pos_pos_col; D(pos_mod.stim.neurons(i,2), pos_mod.stim.neurons(j,2))];
    end
    for j=1:size(non_mod.stim.neurons)
        pos_non_col = [pos_non_col; D(pos_mod.stim.neurons(i,2), non_mod.stim.neurons(j,2))];
    end
    for j=1:size(neg_mod.stim.neurons)
        pos_neg_col = [pos_neg_col; D(pos_mod.stim.neurons(i,2), neg_mod.stim.neurons(j,2))];
    end
end
pos_pos_col = nonzeros(pos_pos_col);
pos_non_col = nonzeros(pos_non_col);
pos_neg_col = nonzeros(pos_neg_col);

for i=1:size(neg_mod.stim.neurons)
    for j=1:size(neg_mod.stim.neurons)
        neg_neg_col = [neg_neg_col; D(neg_mod.stim.neurons(i,2), neg_mod.stim.neurons(j,2))];
    end
    for j=1:size(non_mod.stim.neurons)
        neg_non_col = [neg_non_col; D(neg_mod.stim.neurons(i,2), non_mod.stim.neurons(j,2))];
    end
end
neg_non_col = nonzeros(neg_non_col);
neg_neg_col = nonzeros(neg_neg_col);

for i=1:size(non_mod.stim.neurons)
    for j=1:size(non_mod.stim.neurons)
        non_non_col = [non_non_col; D(non_mod.stim.neurons(i,2), non_mod.stim.neurons(j,2))];
    end
end
non_non_col = nonzeros(non_non_col);

BW = 20;
figure;
subplot(2,3,1)
histogram(pos_pos_col,'BinWidth',BW);
title('Postive - Positive Distance Distribution');
subplot(2,3,2)
histogram(pos_non_col,'BinWidth',BW);
title('Postive - Non Distance Distribution');
subplot(2,3,3)
histogram(pos_neg_col,'BinWidth',BW);
title('Postive - Negative Distance Distribution');
subplot(2,3,4)
histogram(neg_non_col,'BinWidth',BW);
title('Negative - Non Distance Distribution');
subplot(2,3,5)
histogram(neg_neg_col,'BinWidth',BW);
title('Negative - Negative Distance Distribution');
subplot(2,3,6)
histogram(non_non_col,'BinWidth',BW);
title('Non - Non Distance Distribution');

