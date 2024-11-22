% Efield_modelling.m
% Author: Cara
% Date: 06/11/24
% Purpose address reviewer comments from transient DBS manuscript about the
% effect of distance from electrode on modulation identity.

%% Setup
addpath(genpath('~/handata_server/Cara_Ravasio/Code/GCaMP_Data_Extraction'));
hip_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/Good_Recordings_Data_Files';
cort_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Neocortex/Good_Recordings_Data_Files';
sham_path = '~/handata_server/eng_research_handata3/Cara_Ravasio/Transient_DBS_Ctrl/output_ctrl_data';
save_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Paper_Figures_Clean_Data';

pixel_size = 1.18e-6; %1.18um/pixel conveted to meters (10x obj, 6.8um/pixel cam, 2x2 binning)
%% Load in all data

load([hip_path '/data40_CA1.mat']);
load([hip_path '/data140_CA1.mat']);
load([hip_path '/data1000_CA1.mat']);
data40_CA1 = data40;
data140_CA1 = data140;
data1000_CA1 = data1000;

load([cort_path '/data40_M1.mat']);
load([cort_path '/data140_M1.mat']);
load([cort_path '/data1000_M1.mat']);
data40_M1 = data40;
data140_M1 = data140;
data1000_M1 = data1000;

 %- CA1 -%
    load([save_path '/neg_mod_40_CA1.mat']);
    load([save_path '/non_mod_40_CA1.mat']);
    load([save_path '/pos_mod_40_CA1.mat']);

    load([save_path '/neg_mod_140_CA1.mat']);
    load([save_path '/non_mod_140_CA1.mat']);
    load([save_path '/pos_mod_140_CA1.mat']);

    load([save_path '/neg_mod_1000_CA1.mat']);
    load([save_path '/non_mod_1000_CA1.mat']);
    load([save_path '/pos_mod_1000_CA1.mat']);

%- M1 -%
    load([save_path '/neg_mod_40_M1.mat']);
    load([save_path '/non_mod_40_M1.mat']);
    load([save_path '/pos_mod_40_M1.mat']);

    load([save_path '/neg_mod_140_M1.mat']);
    load([save_path '/non_mod_140_M1.mat']);
    load([save_path '/pos_mod_140_M1.mat']);

    load([save_path '/neg_mod_1000_M1.mat']);
    load([save_path '/non_mod_1000_M1.mat']);
    load([save_path '/pos_mod_1000_M1.mat']);

%% Choose your recording
% % region = 0 -> 'CA1','C00014138',...
% % region = 1 -> 'M1' ,'C00023114'
% region = [0,0,...     % 40Hz CA1
%           0,0,0,...   % 140Hz CA1
%           0,0,0,0,... % 1000Hz CA1
%           1,...       % 40Hz M1
%           1,1,...     % 140Hz M1
%           1,1];       % 1000Hz M1
% rec_name = [2,5,... 
%             2,3,5,... 
%             10,10,10,11,...
%             3,...
%             3,3,...
%             6,7];
% freq = [40, 40,...
%         140, 140, 140,...
%         1000,1000,1000,1000,...
%         40,...
%         140,140,...
%         1000,1000];
% curr = [30, 30, ...
%         20,25,20,...
%         20,20,20,20,...
%         70,...
%         70,70,...
%         200,280];
% rec_num = [12, 15,...
%            13,14,16,...
%            4,5,6,7,...
%            8,...
%            7,8,...
%            2,3];
% % fov = 0 -> no fov info
% fov = [0,0,...
%        0,0,0,...
%        1,2,3,0,...
%        1,...
%        1,2,...
%        0,0];

% - CHANGE THIS -%
region = 'Hippocampus'; %'Hippocampus'; %'Neocortex';
reg = 'CA1';%'CA1'; %'M1';
mouse = 'C00014138'; %'C00014138'; %'C00023114';
rec_name = 9;
freq = 1000; %Hz - stim freq
curr = 20; %uA - stim amplitude
fov  = [];
rec_num = 10; % which idx in the data struct

if isempty(fov)
    maxmin_path = ['~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/', region, ...
        '/', mouse, '/rec', num2str(rec_name), '/' num2str(freq), 'Hz/motion_corrected']; %/fov' num2str(fov) '
else
    maxmin_path = ['~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/', region, ...
        '/', mouse, '/rec', num2str(rec_name), '/' num2str(freq), 'Hz/fov' num2str(fov) '/motion_corrected']; %/fov' num2str(fov) '

end
temp = dir([maxmin_path '/*.tif']);
frame= imread([maxmin_path '/' temp.name]);

ROIs = data1000_CA1(rec_num).roi_data;
pos_neurons = pos_mod_1000_CA1.neurons(pos_mod_1000_CA1.neurons(:,1)==rec_num,2);
neg_neurons = neg_mod_1000_CA1.neurons(neg_mod_1000_CA1.neurons(:,1)==rec_num,2);
non_neurons = non_mod_1000_CA1.neurons(non_mod_1000_CA1.neurons(:,1)==rec_num,2);
% 
% ROIs = data40_M1(rec_num).roi_data;
% pos_neurons = pos_mod_40_M1.neurons(pos_mod_40_M1.neurons(:,1)==rec_num,2);
% neg_neurons = neg_mod_40_M1.neurons(neg_mod_40_M1.neurons(:,1)==rec_num,2);
% non_neurons = non_mod_40_M1.neurons(non_mod_40_M1.neurons(:,1)==rec_num,2);

%% Visualize cells
% Display average image
[rows, cols] = size(frame);
roiIdx = [];
figure('Renderer', 'painters', 'Position', [0 0 cols rows]);%2000 1500]);
imshow(frame,[median(median(frame))-300, median(median(frame))+1000]);
hold on;

% Show the ROIs on the maxmin image
%test=[204,178,31,161];
for i=1:numel(ROIs.goodIdx)%4
    binmask = zeros(size(frame));
    roi_pixels = cell2mat(ROIs.pixel_idx(ROIs.goodIdx(i)));%cell2mat(ROIs.pixel_idx(ROIs.goodIdx(test(i))));
    binmask(roi_pixels) = 1;
    binmask = imfill(binmask, 'holes');
    B = bwboundaries(binmask);
    hold on;
    try
        if any(ROIs.goodIdx(pos_neurons) == ROIs.goodIdx(i)) 
            visboundaries(B, 'LineStyle', ':', 'EnhanceVisibility', false, 'Color', 'red');
        elseif any(ROIs.goodIdx(non_neurons) == ROIs.goodIdx(i)) 
            %visboundaries(B, 'LineStyle', ':', 'EnhanceVisibility', false, 'Color', 'green');
        elseif any(ROIs.goodIdx(neg_neurons) == ROIs.goodIdx(i)) 
            visboundaries(B, 'LineStyle', ':', 'EnhanceVisibility', false, 'Color', 'blue');
        end
    catch
        visboundaries(B, 'LineStyle', ':', 'EnhanceVisibility', false, 'Color', 'yellow');
    end
    % Use the mid rectangle of area function to find a center point
    polyin = polyshape(B{1,1});
    [x,y] = centroid(polyin);
    %text(y, x, num2str(i), 'Color', 'cyan', 'FontSize', 10);

    % log the center of each roi for use later
     x = round(x);
     y = round(y);
    roiIdx = vertcat(roiIdx, [y,x]);
end

if isempty(fov)
    title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name)]);
else
    title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name), ' fov' num2str(fov)]);
end
%% Mark the tip  and orientation of the electrode
% Mark the tip of the electrode first
[x, y] = ginput(1); % Mark coordinates of the middle of the tip of electrode
x = round(x);
y = round(y);
tipIdx = [x,y];
hold on;
plot(x, y, 'y+', 'MarkerSize', 10, 'LineWidth', 2);
hold off;

% Use the second point to determine the orientation of the electrode in the window
[x, y] = ginput(1); % Mark coordinates of the middle of the base of electrode
x = round(x);
y = round(y);
baseIdx = [x, y];
hold on;
plot(x, y, 'y+', 'MarkerSize', 10, 'LineWidth', 2);
hold off;

%Plot corners
corners = [1,1; size(frame,2),1; size(frame,2),size(frame,1); 1,size(frame,1)];
hold on
plot(corners(:,1),corners(:,2),'ko','MarkerSize',12);
if isempty(fov)
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name), '_marked_fov.fig']); % '_fov' num2str(fov),
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name), '_marked_fov.jpg']); %  '_fov' num2str(fov),
else
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name),'_fov' num2str(fov), '_marked_fov.fig']); % '_fov' num2str(fov),
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name),'_fov' num2str(fov), '_marked_fov.jpg']); %  '_fov' num2str(fov),
end

%% #activated and #suppressed vs square distance from tip
% Define the field point (example coordinates in x-y-z space)
% THIS WILL BE THE NEURON CENTROID RELATIVE TO ELECTRODE TIP
% Rotate ROI coordinates to be in the x'-y' plane where the electrode
% orientation determines the y' axis and the x'-axis is perpendicular
% Convert from pixel idx to m for all calculations.

% Calculate all corners and ROIs distance relative to tip
cornerDist = corners - tipIdx;
relDist = roiIdx - tipIdx;
pixel_size = 1.18e-6; % 1.18um/pixel conveted to meters (10x obj, 6.8um/pixel cam, 2x2 binning)
adj = (baseIdx(1,2)-tipIdx(1,2))*pixel_size; % length of adjacent leg (y-axis) converted to meters
opp = (baseIdx(1,1)-tipIdx(1,1))*pixel_size; % length of opposite leg (x-axis) converted to meters
hypot = sqrt(adj^2+opp^2); % length of hypotenuse
theta = acos(adj/hypot); % arccos(adj/hypot) to find theta

% grid coordinates where the electrode tip is 0mm,0mm,0mm
corners = [1, 1; 1,size(frame,2); size(frame,1),1; size(frame)];
x_prime = (corners(:,1)-tipIdx(:,1)).*pixel_size.*cos(theta) - (corners(:,2)-tipIdx(:,2)).*pixel_size.*sin(theta); % x' coord converted to meters
y_prime = (corners(:,1)-tipIdx(:,1)).*pixel_size.*sin(theta) + (corners(:,2)-tipIdx(:,2)).*pixel_size.*cos(theta); % y' coord converted to meters

x_range = min(x_prime)-40e-6:5e-6:max(x_prime)+40e-6 ; % x-limits as determined by my fov and the tip location
y_range = min(y_prime)-40e-6:5e-6:max(y_prime)+40e-6; % ylimits as determined by my fov and the tip location
z_range = -100e-6:20e-6:100e-6; % 100um above tip and 100um below tip (limit of 600um below glass for resolvability)

% x_range = -900e-6:5e-6:900e-6 ; % x-limits as determined by my fov and the tip location
% y_range = -900e-6:5e-6:900e-6 ;
% z_range = 0;
% Create the grid
[X,Y,Z] = meshgrid(x_range,y_range,z_range);

%% Square Distance to electrode -- Address Reviewer 1

% Inverse square law says the electric field dissipates at a rate
% proportional to the reciprocal of the square distance. 
% I1/I2 = d2^2/d1^2
% Let I1 = 1 (maximum E field strength) at d1 = ~1um (very near electrode)
% Calculate I2 for the entire grid

%Note: the cortex seems to require (y,x) instead of (x,y)--CRR 07/17/24
E_invSq = ((1)*(1e-6)^2)./(X(:,:,6).^2+Y(:,:,6).^2);
[V_d2_x, V_d2_y] = gradient(E_invSq);
figure
if strcmp(reg, 'CA1')
    s = surf(X(:,:,6),Y(:,:,6),Z(:,:,6),log(E_invSq));
    %s = surf(X(:,:,6),Y(:,:,6),Z(:,:,6),sqrt(V_d2_x.^2 + V_d2_y.^2));
else
    s = surf(Y(:,:,6),X(:,:,6),Z(:,:,6),log(E_invSq));
end
axis xy
s.EdgeColor = 'none';
s.FaceColor = 'interp';
s.FaceAlpha = 1; %0.5;
hold on
view(2)
neurons = [];
for i=1:numel(ROIs.goodIdx)
    if strcmp(reg,'CA1')
        x_pos = relDist(i,1)*pixel_size*cos(theta) - relDist(i,2)*pixel_size*sin(theta); % x' coord converted to meters
        y_pos = relDist(i,1)*pixel_size*sin(theta) + relDist(i,2)*pixel_size*cos(theta); % y' coord converted to meter
    else
        y_pos = relDist(i,1)*pixel_size*cos(theta) - relDist(i,2)*pixel_size*sin(theta); % x' coord converted to meters
        x_pos = relDist(i,1)*pixel_size*sin(theta) + relDist(i,2)*pixel_size*cos(theta); % y' coord converted to meters
    end
    z_pos = 0; % Assume the neuron is in the same plane as the electrode tip

    % plot and identify neurons of interest for this recording
    if any(ROIs.goodIdx(pos_neurons) == ROIs.goodIdx(i)) 
        plot3(x_pos,y_pos,z_pos, 'r.');
        neurons = [neurons; 1, i, relDist(i,1), relDist(i,2)];
    elseif any(ROIs.goodIdx(non_neurons) == ROIs.goodIdx(i)) 
        plot3(x_pos,y_pos,z_pos, 'g.');
        neurons = [neurons; 0, i, relDist(i,1), relDist(i,2)];
    elseif any(ROIs.goodIdx(neg_neurons) == ROIs.goodIdx(i)) 
        plot3(x_pos,y_pos,z_pos, 'b.');
        neurons = [neurons; -1, i, relDist(i,1), relDist(i,2)];
    end
end
cb = colorbar;
plot(0,0,'m+'); %electrode tip location

%plot the corners of the fov
if strcmp(reg,'CA1')
    x_pos = cornerDist(:,1)*pixel_size*cos(theta) - cornerDist(:,2)*pixel_size*sin(theta); % x' coord converted to meters
    y_pos = cornerDist(:,1)*pixel_size*sin(theta) + cornerDist(:,2)*pixel_size*cos(theta); % y' coord converted to meters
else
    y_pos = cornerDist(:,1)*pixel_size*cos(theta) - cornerDist(:,2)*pixel_size*sin(theta); % x' coord converted to meters
    x_pos = cornerDist(:,1)*pixel_size*sin(theta) + cornerDist(:,2)*pixel_size*cos(theta); % y' coord converted to meters
end
plot(x_pos,y_pos,'ko','MarkerSize',12);

view(2) %2D view

xlabel('distance (m)');
ylabel('distance(m)');
ylabel(cb,'log(%E field strength) (% max V/m)');
clim([-13,-5]);
if isempty(fov)
    title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name),' Idealized Electric Field Projection']); %, ' fov' num2str(fov)
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name), '_idealEFieldSurf.fig']); %,'_fov' num2str(fov)
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name), '_idealEFieldSurf.jpg']); %,'_fov' num2str(fov)
else
    title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name),' fov' num2str(fov),' Idealized Electric Field Projection']); %, ' fov' num2str(fov)
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name),'_fov' num2str(fov), '_idealEFieldSurf.fig']); %,'_fov' num2str(fov)
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name),'_fov' num2str(fov), '_idealEFieldSurf.jpg']); %,'_fov' num2str(fov)
end

%% Example recordings neuron structs for meta analysis
% idx = numel(ex_fovs)+1;
% ex_fovs(idx).reg = reg;
% ex_fovs(idx).freq = freq;
% ex_fovs(idx).rec = rec_name;
% ex_fovs(idx).fov = fov;
% ex_fovs(idx).curr = curr;
% ex_fovs(idx).neurons = neurons;
% % ROIs = data1000_CA1(rec_num).roi_data;
% % avg_traces = ROIs.avg_trace_minusBG_scaled(ROIs.goodIdx,:);
% % ex_fovs(idx).avg_traces = avg_traces;
% % ex_fovs(idx).auc = trapz(avg_traces(:,100:200),2);
save([save_path '/ex_fovs.mat'],'ex_fovs')
%% More plots for reviewer 1
% create masks for neurons of interest
pos_mask = neurons(:,1) == 1;
non_mask = neurons(:,1) == 0;
neg_mask = neurons(:,1) == -1;

dist2 = (neurons(:,3).*pixel_size).^2 + (neurons(:,4).*pixel_size).^2;
dist = sqrt(dist2);
invdist2 =1./((neurons(:,3).*pixel_size).^2 + (neurons(:,4).*pixel_size).^2);

% Histogram of neuron identities over sq-dist
figure;
tiledlayout(4,1);
ax(1) = nexttile;
h = histogram(dist2, 'FaceColor','yellow','FaceAlpha',0.5,'EdgeColor','none');
title('All neurons')
ylabel('# neurons')
ax(2) = nexttile;
hp = histogram(dist2(pos_mask),'FaceColor','red','FaceAlpha',0.5,'EdgeColor','none');
title('Activated neurons')
ylabel('# neurons')
ax(3) = nexttile;
hn = histogram(dist2(neg_mask),'FaceColor','blue','FaceAlpha',0.5,'EdgeColor','none');
title('Suppressed neurons')
ylabel('# neurons')
ax(4) = nexttile;
ho = histogram(dist2(non_mask),'FaceColor','green','FaceAlpha',0.5,'EdgeColor','none');
title('Unchanged neurons')
ylabel('#neurons')
linkaxes(ax,'xy') % (logical([1 0 1 1]))
xlabel('distance^2 (m^2)')
if isempty(fov)
    title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name),' Neuron Distribution']); %' fov' num2str(fov),
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name),'_neuronID_distrib_sqdist.fig']); % '_fov' num2str(fov),
else
    title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name),' fov' num2str(fov),' Neuron Distribution']); %' fov' num2str(fov),
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name),'_fov' num2str(fov),'_neuronID_distrib_sqdist.fig']); % '_fov' num2str(fov),
end

% scatter of AUC over sq-dist for each neuron ID
figure;
hold on
x_fit = linspace(0,max(dist2),100);
avg_traces = ROIs.avg_trace_minusBG_scaled(ROIs.goodIdx,:);
auc = trapz(avg_traces(:,100:200),2);

% plot(dist2(pos_mask),auc(pos_mask),'r.');
% p = polyfit(dist2(pos_mask),auc(pos_mask),1);
% pos_fit = polyval(p,x_fit);
% y_fit = polyval(p,dist2(pos_mask));
% R2_pos = 1 - (sum((auc(pos_mask) - y_fit).^2) / sum((auc(pos_mask) - mean(auc(pos_mask))).^2));
% c_pos = corr(dist2(pos_mask),auc(pos_mask));


plot(dist2(neg_mask),auc(neg_mask),'b.');
p = polyfit(dist2(neg_mask),auc(neg_mask),1);
neg_fit = polyval(p,x_fit);
y_fit = polyval(p,dist2(neg_mask));
R2_neg = 1 - (sum((auc(neg_mask) - y_fit).^2) / sum((auc(neg_mask) - mean(auc(neg_mask))).^2));
c_neg = corr(dist2(neg_mask),auc(neg_mask));

plot(dist2(non_mask),auc(non_mask),'g.');
p = polyfit(dist2(non_mask),auc(non_mask),1);
non_fit = polyval(p,x_fit);
y_fit = polyval(p,dist2(non_mask));
R2_non = 1 - (sum((auc(non_mask) - y_fit).^2) / sum((auc(non_mask) - mean(auc(non_mask))).^2));
c_non = corr(dist2(non_mask),auc(non_mask));
yl = ylim;

plot(x_fit, pos_fit,'r--');
plot(x_fit,neg_fit, 'b--');
plot(x_fit,non_fit, 'g--');

ylim(yl)
% legend({'activated','suppressed','unchanged',...
%         ['activated fit (corr coef = ' num2str(c_pos) ', R^2 = ' num2str(R2_pos) ')'], ...
%         ['suppressed fit (corr coef = ' num2str(c_neg) ', R^2 = ' num2str(R2_neg) ')'], ...
%         ['unchanged fit (corr coef = ' num2str(c_non) ', R^2 = ' num2str(R2_non) ')']})
legend({'suppressed','unchanged',...
        ['suppressed fit (corr coef = ' num2str(c_neg) ', R^2 = ' num2str(R2_neg) ')'], ...
        ['unchanged fit (corr coef = ' num2str(c_non) ', R^2 = ' num2str(R2_non) ')']})
xlabel('distance^2 (m^2)')
ylabel('AUC amplitude of avg trace')
if isempty(fov)
    title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name),' Correlating calcium modulation with square distance to electrode']); %' fov' num2str(fov),
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name),'_auc_vs_sqdist.fig']); % '_fov' num2str(fov),
else
    title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name),' fov' num2str(fov),' Correlating calcium modulation with square distance to electrode']); %' fov' num2str(fov),
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name),'_fov' num2str(fov),'_auc_vs_sqdist.fig']); % '_fov' num2str(fov),
end


% scatter of AUC over dist for each neuron ID
figure;
hold on

avg_traces = ROIs.avg_trace_minusBG_scaled(ROIs.goodIdx,:);
auc = trapz(avg_traces(:,100:200),2);

plot(dist(pos_mask)*10^6,auc(pos_mask),'r.');
plot(dist(neg_mask)*10^6,auc(neg_mask),'b.');
plot(dist(non_mask)*10^6,auc(non_mask),'g.');

legend({'activated','suppressed','unchanged'})
xlabel('distance (um)')
ylabel('AUC amplitude of avg trace')
if isempty(fov)
    title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name),' Correlating calcium modulation with distance to electrode']); %' fov' num2str(fov),
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name),'_auc_vs_dist.fig']); % '_fov' num2str(fov),
else
    title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name),' fov' num2str(fov),' Correlating calcium modulation with distance to electrode']); %' fov' num2str(fov),
    saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name),'_fov' num2str(fov),'_auc_vs_dist.fig']); % '_fov' num2str(fov),
end
%% Meta analysis of dist to electrode and AUC
figure;
tiledlayout(2,3);
hold on
for j = 1:6
    ax(j) = nexttile;
    hold on
   if j < 4
        test_reg = 'CA1';
   else
       test_reg = 'M1';
   end

   if rem(j,3) == 1
       test_freq = 40;
   elseif rem(j,3) == 2
       test_freq = 140;
   else
       test_freq = 1000;
   end
    marks = {'.','+','*','o','.','+','*','o','.','+','*','o','.','+','*','o','.','+','*','o','.','+','*','o',};
    
    non_dist_mat = []; non_auc_mat = [];
    pos_dist_mat = []; pos_auc_mat = [];
    neg_dist_mat = []; neg_auc_mat = [];
    for i=1:numel(ex_fovs)
        if strcmp(ex_fovs(i).reg, test_reg) && (ex_fovs(i).freq == test_freq)
            pos_mask = ex_fovs(i).neurons(:,1) == 1;
            non_mask = ex_fovs(i).neurons(:,1) == 0;
            neg_mask = ex_fovs(i).neurons(:,1) == -1;
            dist = (ex_fovs(i).neurons(:,3).*pixel_size).^2 + (ex_fovs(i).neurons(:,4).*pixel_size).^2;
            
            non_dist_mat = vertcat(non_dist_mat,dist(non_mask)*10^12);
            non_auc_mat = vertcat(non_auc_mat,ex_fovs(i).auc(non_mask));
            plot(dist(non_mask)*10^12,ex_fovs(i).auc(non_mask),'g.','Marker', '.');% marks{1,i});
            % p = polyfit(dist(non_mask)*10^12,ex_fovs(i).auc(non_mask),1);
            % non_fit = polyval(p,x_fit);
            % y_fit = polyval(p,dist(non_mask));
            % R2_non = 1 - (sum((ex_fovs(i).auc(non_mask) - y_fit).^2) / sum((ex_fovs(i).auc(non_mask) - mean(ex_fovs(i).auc(non_mask))).^2));

            pos_dist_mat = vertcat(pos_dist_mat,dist(pos_mask)*10^12);
            pos_auc_mat = vertcat(pos_auc_mat,ex_fovs(i).auc(pos_mask));
            plot(dist(pos_mask)*10^12,ex_fovs(i).auc(pos_mask),'r.','Marker', '.'); %marks{1,i});
            % p = polyfit(dist(pos_mask)*10^12,ex_fovs(i).auc(pos_mask),1);
            % pos_fit = polyval(p,x_fit);
            % y_fit = polyval(p,dist(pos_mask));
            % R2_pos = 1 - (sum((ex_fovs(i).auc(pos_mask) - y_fit).^2) / sum((ex_fovs(i).auc(pos_mask) - mean(ex_fovs(i).auc(pos_mask))).^2));

            neg_dist_mat = vertcat(neg_dist_mat,dist(neg_mask)*10^12);
            neg_auc_mat = vertcat(neg_auc_mat,ex_fovs(i).auc(neg_mask));
            plot(dist(neg_mask)*10^12,ex_fovs(i).auc(neg_mask),'b.','Marker', '.'); % marks{1,i});

        else
        end
    end
    x_fit = 1:500:600000;
    
    p = polyfit(non_dist_mat,non_auc_mat,1);
    non_fit = polyval(p,x_fit);
    y_fit = polyval(p,non_dist_mat);
    R2_non = 1 - (sum((non_auc_mat - y_fit).^2) / sum((non_auc_mat - mean(non_auc_mat)).^2));

    p = polyfit(pos_dist_mat,pos_auc_mat,1);
    pos_fit = polyval(p,x_fit);
    y_fit = polyval(p,pos_dist_mat);
    R2_pos = 1 - (sum((pos_auc_mat - y_fit).^2) / sum((pos_auc_mat - mean(pos_auc_mat)).^2));

    p = polyfit(neg_dist_mat,neg_auc_mat,1);
    neg_fit = polyval(p,x_fit);
    y_fit = polyval(p,neg_dist_mat);
    R2_neg = 1 - (sum((neg_auc_mat - y_fit).^2) / sum((neg_auc_mat - mean(neg_auc_mat)).^2));
    
    plot(x_fit,non_fit,'g--')
    plot(x_fit,pos_fit,'r--')
    plot(x_fit,neg_fit,'b--')
    
    title([num2str(test_freq) 'Hz ' test_reg])
    xlabel('distance (um^2)');
    ylabel('auc (a.u.)');
    legend(strcat('non (n = ', num2str(numel(non_auc_mat)), ') R = ', num2str(R2_non)),...
        strcat('pos (n = ', num2str(numel(pos_auc_mat)), ') R = ', num2str(R2_pos)),...
        strcat('neg (n = ', num2str(numel(neg_auc_mat)), ') R = ', num2str(R2_neg)),...
        'non fit','pos fit', 'neg fit')
end
linkaxes(ax)
saveas(gcf,[save_path '/Spatial_Analysis/auc_vs_dist2.fig']); 


% Look at how neurons are distributed relative to electrode (stacked bar plot)
neuronIDs = []; reg_all = []; freq_all = []; rec_all = []; dist_um = []; auc_all = []; avg_trace_all = [];
for i=1:numel(ex_fovs)
    neuronIDs = [neuronIDs; ex_fovs(i).neurons(:,1)];
    reg_all = [reg_all; repmat(convertCharsToStrings(ex_fovs(i).reg),...
                               [size(ex_fovs(i).neurons,1),1])];
    freq_all = [freq_all; repmat(ex_fovs(i).freq,[size(ex_fovs(i).neurons,1),1])];
    rec_all = [rec_all; repmat(ex_fovs(i).rec,[size(ex_fovs(i).neurons,1),1])];
    dist_um = [dist_um; sqrt((ex_fovs(i).neurons(:,3).*pixel_size).^2 + ...
                             (ex_fovs(i).neurons(:,4).*pixel_size).^2).*10^(6)];
    auc_all = [auc_all; ex_fovs(i).auc];
    avg_trace_all = [avg_trace_all; ex_fovs(i).avg_traces];
end
%% Meta analysis binned neurons
bins =200:200:800; %100:100;800
binstep = bins(2)-bins(1);

f1 = figure;
t1 = tiledlayout(2,3);
f2 = figure;
t2 = tiledlayout(2,3);
f3 = figure;
t3 = tiledlayout(2,3);
clearvars auc_distrib
for j = 1:6
    figure(f1)
    ax1(j) = nexttile;
    hold on
   if j < 4
        test_reg = 'CA1';
   else
       test_reg = 'M1';
   end

   if rem(j,3) == 1
       test_freq = 40;
   elseif rem(j,3) == 2
       test_freq = 140;
   else
       test_freq = 1000;
   end

    pos_mask = (neuronIDs == 1) & strcmp(reg_all, test_reg) & (freq_all == test_freq);
    non_mask = (neuronIDs == 0) & strcmp(reg_all, test_reg) & (freq_all == test_freq);
    neg_mask = (neuronIDs == -1) & strcmp(reg_all, test_reg) & (freq_all == test_freq);
    bars = []; avg_auc = []; std_auc = []; dist_cat_vec = dist_um;
    for i=bins
        bars = [bars; sum(dist_um(pos_mask)>i-binstep & dist_um(pos_mask)<=i),...
                      sum(dist_um(neg_mask)>i-binstep & dist_um(neg_mask)<=i),...
                      sum(dist_um(non_mask)>i-binstep & dist_um(non_mask)<=i)];
        dist_um_lim1 = dist_um > i-binstep;
        dist_um_lim2 = dist_um <= i;
        
        dist_cat_vec((dist_cat_vec>i-binstep) & (dist_cat_vec <=i)) = i/binstep;
        avg_auc = [avg_auc; median(auc_all(pos_mask & dist_um_lim1 & dist_um_lim2)),...
                      median(auc_all(neg_mask & dist_um_lim1 & dist_um_lim2)),...
                      median(auc_all(non_mask & dist_um_lim1 & dist_um_lim2))];
        auc_distrib.pos{j,i/binstep} = auc_all(pos_mask & dist_um_lim1 & dist_um_lim2);
        auc_distrib.neg{j,i/binstep} = auc_all(neg_mask & dist_um_lim1 & dist_um_lim2);
        auc_distrib.non{j,i/binstep} = auc_all(non_mask & dist_um_lim1 & dist_um_lim2);

        std_auc = [std_auc; std(auc_all(pos_mask & dist_um_lim1 & dist_um_lim2)),...
                      std(auc_all(neg_mask & dist_um_lim1 & dist_um_lim2)),...
                      std(auc_all(non_mask & dist_um_lim1 & dist_um_lim2))];
    end
    dist_cat_vec(dist_cat_vec == 4) = 3; %merge the neurons beyond 600um with those beyond 400um- CRR 08/01/24

    figure(f1)
    bars_plot = [bars(1:2,1:2); sum(bars(3:4,1:2),1)];
    bar_sum = sum([bars(1:2,:); sum(bars(3:4,:),1)],2);
    b = bar(bins(1:3),bars_plot./bar_sum,'grouped');
    b(1,1).FaceColor = [1 0 0];
    b(1,2).FaceColor = [0 0 1];
    %b(1,3).FaceColor = [0 1 0];

    title([num2str(test_freq) 'Hz ' test_reg])
    xlabel('distance bin (um)');
    ylabel('# neurons');

%- Pos vs non-pos -%    
    % Run Stats on bar plot (Chi^2 test) [only use Chi^2 when n>=1000]
     cat_mask = strcmp(reg_all, test_reg) & (freq_all == test_freq); % & dist_cat_vec~=4; %ignore all neurons more than 600 um away
     neuronID_cat_vec = neuronIDs(cat_mask);
     neuronID_cat_vec(neuronID_cat_vec==-1) = 0; % only consider pos vs non-pos
     [postbl, chi2stat(j), p(j)] = crosstab(neuronID_cat_vec,dist_cat_vec(cat_mask));

     %Now break into 2x2 contingency tables (Chi2 test)
     % <200um vs <400um
     mask200v400 = strcmp(reg_all, test_reg) & (freq_all == test_freq) & dist_cat_vec<3; %ignore all neurons more than 400 um away
     neuronID_cat_vec = neuronIDs(mask200v400);
     neuronID_cat_vec(neuronID_cat_vec==-1) = 0; % only consider pos vs non-pos
     [postbl_200v400, chi2stat200v400(j),p200v400(j)] = crosstab(neuronID_cat_vec,dist_cat_vec(mask200v400));
     try
        [h_fisher_200v400(j),p_fisher_200v400(j)] = fishertest(postbl_200v400);
     catch
     end
          
     % <200um vs <600 um
     mask200v600 = strcmp(reg_all, test_reg) & (freq_all == test_freq) & dist_cat_vec~=2; %& dist_cat_vec~=4 %ignore all neurons more than 600 um away and between 200-400um
     neuronID_cat_vec = neuronIDs(mask200v600);
     neuronID_cat_vec(neuronID_cat_vec==-1) = 0; % only consider pos vs non-pos
     [postbl_200v600, chi2stat200v600(j),p200v600(j)] = crosstab(neuronID_cat_vec,dist_cat_vec(mask200v600));
     try
        [h_fisher_200v600(j),p_fisher_200v600(j)] = fishertest(postbl_200v600);
     catch
     end

     % <400um vs <600 um
     mask400v600 = strcmp(reg_all, test_reg) & (freq_all == test_freq) & dist_cat_vec~=1; %& dist_cat_vec~=4 %ignore all neurons more than 600 um away and <200um
     neuronID_cat_vec = neuronIDs(mask400v600);
     neuronID_cat_vec(neuronID_cat_vec==-1) = 0; % only consider pos vs non-pos
     [postbl_400v600, chi2stat400v600(j),p400v600(j)] = crosstab(neuronID_cat_vec,dist_cat_vec(mask400v600));
     try
        [h_fisher_400v600(j),p_fisher_400v600(j)] = fishertest(postbl_400v600);
     catch
     end

%- Neg vs non-neg -%
     % Run Stats on bar plot (Chi^2 test) [only use Chi^2 when n>=1000]
     cat_mask = strcmp(reg_all, test_reg) & (freq_all == test_freq); % & dist_cat_vec~=4; %ignore all neurons more than 600 um away
     neuronID_cat_vec = neuronIDs(cat_mask);
     neuronID_cat_vec(neuronID_cat_vec==1) = 0; % only consider neg vs non-neg
     [negtbl, chi2stat_neg(j), p_neg(j)] = crosstab(neuronID_cat_vec,dist_cat_vec(cat_mask));

     %Now break into 2x2 contingency tables (Chi2 test)
     % <200um vs <400um
     mask200v400 = strcmp(reg_all, test_reg) & (freq_all == test_freq) & dist_cat_vec<3; %ignore all neurons more than 400 um away
     neuronID_cat_vec = neuronIDs(mask200v400);
     neuronID_cat_vec(neuronID_cat_vec== 1) = 0; % only consider neg vs non-neg
     [negtbl_200v400, chi2stat200v400_neg(j),p200v400_neg(j)] = crosstab(neuronID_cat_vec,dist_cat_vec(mask200v400));
     try
        [h_fisher_200v400_neg(j),p_fisher_200v400_neg(j)] = fishertest(negtbl_200v400);
     catch
     end
          
     % <200um vs <600 um
     mask200v600 = strcmp(reg_all, test_reg) & (freq_all == test_freq) & dist_cat_vec~=2; %& dist_cat_vec~=4 %ignore all neurons more than 600 um away and between 200-400um
     neuronID_cat_vec = neuronIDs(mask200v600);
     neuronID_cat_vec(neuronID_cat_vec==1) = 0; % only consider neg vs non-neg
     [negtbl_200v600, chi2stat200v600_neg(j),p200v600_neg(j)] = crosstab(neuronID_cat_vec,dist_cat_vec(mask200v600));
     try
        [h_fisher_200v600_neg(j),p_fisher_200v600_neg(j)] = fishertest(negtbl_200v600);
     catch
     end

     % <400um vs <600 um
     mask400v600 = strcmp(reg_all, test_reg) & (freq_all == test_freq) & dist_cat_vec~=1; %& dist_cat_vec~=4 %ignore all neurons more than 600 um away and <200um
     neuronID_cat_vec = neuronIDs(mask400v600);
     neuronID_cat_vec(neuronID_cat_vec==-1) = 0; % only consider pos vs non-pos
     [negtbl_400v600, chi2stat400v600_neg(j),p400v600_neg(j)] = crosstab(neuronID_cat_vec,dist_cat_vec(mask400v600));
     try
        [h_fisher_400v600_neg(j),p_fisher_400v600_neg(j)] = fishertest(negtbl_400v600);
     catch
     end

%- AUC -%     
    figure(f2)
    ax2(j) = nexttile;
    hold on
    try
    violinplot(vertcat(vertcat(auc_distrib.pos{j,:}), vertcat(auc_distrib.neg{j,:})),...
                        [ones(numel(auc_distrib.pos{j,1}),1);...
                         2*ones(numel(auc_distrib.pos{j,2}),1);...
                         3*ones(numel(auc_distrib.pos{j,3}),1); ...
                         3*ones(numel(auc_distrib.pos{j,4}),1);...
                         4*ones(numel(auc_distrib.neg{j,1}),1);...
                         5*ones(numel(auc_distrib.neg{j,2}),1);...
                         6*ones(numel(auc_distrib.neg{j,3}),1);...
                         6*ones(numel(auc_distrib.neg{j,4}),1)],... %3 used to be 4, but we are merging nuerons beyond 600um with 400-600um bin
                         'ViolinColor',[1 0 0; 1 0 0; 1 0 0; 0 0 1; 0 0 1; 0 0 1],'ViolinAlpha',0.05); 
    catch
    end

    %errorbar(bins,avg_auc(:,1),std_auc(:,1),'r.','MarkerSize',12);
    %errorbar(bins,avg_auc(:,2),std_auc(:,2),'b.','MarkerSize',12);
    %errorbar(bins,avg_auc(:,3),std_auc(:,3), 'g.','MarkerSize',12);

    % Run stats on avg auc values (ranksum)
    [ppos_auc(j),~,stats] = kruskalwallis(vertcat(auc_distrib.pos{j,1:4}),...
                        [ones(numel(auc_distrib.pos{j,1}),1);...
                         2*ones(numel(auc_distrib.pos{j,2}),1);...
                         3*ones(numel(auc_distrib.pos{j,3}),1);...
                         3*ones(numel(auc_distrib.pos{j,4}),1)],'off'); %merge neurons <600um away with 400-600um bin

    try
        c{j} = multcompare(stats,"CriticalValueType","dunn-sidak",'Display','off');
    catch
    end
    try
    d_pos_200v400(j) = table2array(meanEffectSize(vertcat(auc_distrib.pos{j,1}),vertcat(auc_distrib.pos{j,2}), ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
    d_pos_200v600(j) = table2array(meanEffectSize(auc_distrib.pos{j,1},vertcat(auc_distrib.pos{j,3:4}), ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
   d_pos_400v600(j) = table2array(meanEffectSize(auc_distrib.pos{j,2},vertcat(auc_distrib.pos{j,3:4}), ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
    catch
    end

   [pneg_auc(j),~,stats] = kruskalwallis(vertcat(auc_distrib.neg{j,1:4}),...
                        [ones(numel(auc_distrib.neg{j,1}),1);...
                         2*ones(numel(auc_distrib.neg{j,2}),1);...
                         3*ones(numel(auc_distrib.neg{j,3}),1);...
                         3*ones(numel(auc_distrib.neg{j,4}),1)],'off'); %merge neurons <600um away with 400-600um bin

    try
        c_neg{j} = multcompare(stats,"CriticalValueType","dunn-sidak",'Display','off');
    catch
    end
    try
   d_neg_200v400(j) = table2array(meanEffectSize(auc_distrib.neg{j,1},auc_distrib.neg{j,2}, ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
    d_neg_200v600(j) = table2array(meanEffectSize(auc_distrib.neg{j,1},vertcat(auc_distrib.neg{j,3:4}), ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
   d_neg_400v600(j) = table2array(meanEffectSize(auc_distrib.neg{j,2},vertcat(auc_distrib.neg{j,3:4}), ...
                            Effect="cliff",ConfidenceIntervalType="none",...
                            VarianceType = "unequal"));
    catch
    end
    title([num2str(test_freq) 'Hz ' test_reg])
    xlabel('distance bin (um)');
    ylabel('auc (a.u.)');

    figure(f3)
    ax3(j) = nexttile;
    hold on
    lins = {'-','-','-'}; 

    for i=1:3
        %plot pos traces +/- 95CI
        posmaskbin = strcmp(reg_all, test_reg) & (freq_all == test_freq) & dist_cat_vec==i & neuronIDs == 1; %ignore all neurons more than 600 um away and <200um
        avg_traces = avg_trace_all(posmaskbin,:);
        
        ts = tinv([0.025  0.975],size(avg_traces,1)-1);      % T-Score
        sem_avg = std(avg_traces,1)./sqrt(size(avg_traces,1))*ts(2);
        avg_trace = mean(avg_traces,1);
        curve1 = avg_trace + sem_avg;
        curve2 = avg_trace - sem_avg;
        x = [1:400];
        x2 = [x, fliplr(x)];
        y2 = [curve1(1:end), fliplr(curve2(1:end))];

        h = fill(x2,y2, [1-0.2*(i-1) 0 0],'LineStyle','none','HandleVisibility','off'); %shade in sem area
        h.FaceAlpha = 0.25; %make sem area transparent
        plot(x, avg_trace,'Color', [1-0.2*(i-1) 0 0],'LineStyle',lins{i});

        %Plot neg traces +/- 95CI
        negmaskbin = strcmp(reg_all, test_reg) & (freq_all == test_freq) & dist_cat_vec==i & neuronIDs == -1; %ignore all neurons more than 600 um away and <200um
        avg_traces = avg_trace_all(negmaskbin,:);

        ts = tinv([0.025  0.975],size(avg_traces,1)-1);      % T-Score
        sem_avg = std(avg_traces,1)./sqrt(size(avg_traces,1))*ts(2);
        avg_trace = mean(avg_traces,1);
        curve1 = avg_trace + sem_avg;
        curve2 = avg_trace - sem_avg;
        x2 = [x, fliplr(x)];
        y2 = [curve1(1:end), fliplr(curve2(1:end))];

        h = fill(x2,y2, [0 0 1-0.4*(i-1)],'LineStyle','none','HandleVisibility','off'); %shade in sem area
        h.FaceAlpha = 0.25; %make sem area transparent
        plot(x, avg_trace,'Color',[0 0 1-0.4*(i-1)],'LineStyle',lins{i},'HandleVisibility','off');
    end


    xline([100 200])
    legend('<200um','<400um','<600um')
    ylim([-0.12, 0.35])
    title('Average trace at binned distances');
    xlabel('frame');
    ylabel('%df/f');

end
%linkaxes(ax3)
saveas(gcf,[save_path '/ avg_tracesplusMinus_95CI_vs_dist.fig'])

figure(f1)
linkaxes(ax1)
title(t1,'Distribution of neurons relative to the electrode')
saveas(gcf,[save_path '/ total_nrn_distrib_vs_dist.fig'])

figure(f2)
title(t2,'Average strength of response vs distance from electrode')
linkaxes(ax2)
saveas(gcf,[save_path '/ total_nrn_auc_vs_dist.fig'])

%% Session-wise analysis of CA1 recs for AUC and ID class vs distance
bins =200:200:800;
binstep = bins(2)-bins(1);

f1 = figure;
t1 = tiledlayout(4,4);
f2 = figure;
t2 = tiledlayout(4,4);
clearvars auc_distrib p_posauc h_posauc p_negauc h_negauc p_nonauc h_nonauc
for j = 1:3
    test_reg = 'CA1';

   if rem(j,3) == 1
       test_freq = 40;
   elseif rem(j,3) == 2
       test_freq = 140;
   else
       test_freq = 1000;
   end

   rec_n = unique(rec_all((freq_all == test_freq) & strcmp(reg_all,test_reg)));
   for k = 1:numel(rec_n)
        pos_mask = (neuronIDs == 1) & strcmp(reg_all, test_reg) & (freq_all == test_freq) & (rec_all == rec_n(k));
        non_mask = (neuronIDs == 0) & strcmp(reg_all, test_reg) & (freq_all == test_freq) & (rec_all == rec_n(k));
        neg_mask = (neuronIDs == -1) & strcmp(reg_all, test_reg) & (freq_all == test_freq) & (rec_all == rec_n(k));
        bars = []; avg_auc = []; std_auc = [];
        for i=bins
            bars = [bars; sum(dist_um(pos_mask)>i-binstep & dist_um(pos_mask)<=i),...
                          sum(dist_um(neg_mask)>i-binstep & dist_um(neg_mask)<=i),...
                          sum(dist_um(non_mask)>i-binstep & dist_um(non_mask)<=i)];
    
            dist_um_lim1 = dist_um > i-binstep;
            dist_um_lim2 = dist_um <= i;
            avg_auc = [avg_auc; median(auc_all(pos_mask & dist_um_lim1 & dist_um_lim2)),...
                          median(auc_all(neg_mask & dist_um_lim1 & dist_um_lim2)),...
                          median(auc_all(non_mask & dist_um_lim1 & dist_um_lim2))];
            auc_distrib.pos{j,k,i/binstep} = auc_all(pos_mask & dist_um_lim1 & dist_um_lim2);
            auc_distrib.neg{j,k,i/binstep} = auc_all(neg_mask & dist_um_lim1 & dist_um_lim2);
            auc_distrib.non{j,k,i/binstep} = auc_all(non_mask & dist_um_lim1 & dist_um_lim2);
    
            std_auc = [std_auc; std(auc_all(pos_mask & dist_um_lim1 & dist_um_lim2)),...
                          std(auc_all(neg_mask & dist_um_lim1 & dist_um_lim2)),...
                          std(auc_all(non_mask & dist_um_lim1 & dist_um_lim2))];
        end
        
        figure(f1)
        ax1(j) = nexttile;
        hold on
        b = bar(bins,bars,'stacked');
        b(1,1).FaceColor = [1 0 0];
        b(1,2).FaceColor = [0 0 1];
        b(1,3).FaceColor = [0 1 0];
    
        title([num2str(test_freq) 'Hz ' test_reg])
        xlabel('distance bin (um)');
        ylabel('# neurons');
        % Run Stats on ID distance breakdown (Fishers)
        % [h_posfish{j,k}, p_posfish{j,k}] = fishertest([bars(1,1), bars(2,1); ...
        %                                             bars(1,2)+bars(1,3), bars(2,2)+bars(2,3) ]');
        % [h_negfish{j,k}, p_negfish{j,k}] = fishertest([bars(1,2), bars(2,2); ...
        %                                             bars(1,1)+bars(1,3), bars(2,1)+bars(2,3) ]');
        % [h_nonfish{j,k}, p_nonfish{j,k}] = fishertest([bars(1,3), bars(2,3); ...
        %                                             bars(1,2)+bars(1,1), bars(2,2)+bars(2,1) ]');

        figure(f2)
        ax2(j) = nexttile;
        hold on
        violinplot(vertcat(auc_distrib.pos{j,k,:}),...
                        [ones(numel(auc_distrib.pos{j,k,1}),1);...
                         2*ones(numel(auc_distrib.pos{j,k,2}),1)],...
                         'ViolinColor',[1 0 0],'ViolinAlpha',0.05);
        % violinplot(vertcat(auc_distrib.neg{j,k,:}),...
        %                 [ones(numel(auc_distrib.neg{j,k,1}),1);...
        %                  2*ones(numel(auc_distrib.neg{j,k,2}),1)],...
        %                  'ViolinColor',[0 0 1],'ViolinAlpha',0.05);
        title([num2str(test_freq) 'Hz ' test_reg])
        xlabel('distance bin (um)');
        ylabel('auc (a.u.)');

        % Run Stats on AUC (ranksum)
        % [p_posauc{j,k}, h_posauc{j,k}] = ranksum(auc_distrib.pos{j,k,1},auc_distrib.pos{j,k,3});
        % [p_negauc{j,k}, h_negauc{j,k}] = ranksum(auc_distrib.neg{j,k,1},auc_distrib.neg{j,k,3});
        % [p_nonauc{j,k}, h_nonauc{j,k}] = ranksum(auc_distrib.non{j,k,1},auc_distrib.non{j,k,3});
    end
end
%%
clearvars -except ex_fovs data40_CA1 data140_CA1 data1000_CA1 data40_M1 data140_M1 data1000_M1 save_path pixel_size
%% Estimate the strength of the electric field at any roi centroid
% Assumptions: (All coordinates were quantified using the Matt Gaidica Mouse Brain Atlas, Saggital slice) 
%  1. The electrode tip is the center of our 3mm window if we can see it...
%     therefore use coordinates: A/P -2.0, M/L 1.8, D/V -0.75
%     The electrode tip coordinates for the sensorimotor cortex: A/P 1.5,
%     M/L 1.5, D/V -0.25
%  2. For Hippocampal surgeries, the ground pin was roughly in line with
%     the center of the windo and roughly in the middle of the sensorimotor 
%     cortex... Therefore assume coordinates A/P 1.25, M/L 1.8, D/V -0.5
%  3. Surface area of electrode tip is ~ 1.27e4 um^2 (127um diameter, steel 
%     core, polyamide coated wire)
%  4. Surface area of skull screw is ~0.047 in^2, or ~0.031cm^2 ...
%     % Code to calculate
%     SAscrew = pi*(0.023/2)*(2*(0.023/2)) + (0.094-(0.023/2*sqrt(3))-0.02)*(pi*0.023); % (inch^2) conical pyramid SA (w/o base)+ cone SA (w/o bases)
%     SAscrew = SAscrew * (2.54^2); %Scale from in^2 to cm^2
%  5. Resistivity of homogenous iso-tropic brain matter is ~300 Ohm-cm
%     (ref: Moffit & McIntyre, Clin Neurophys 2005) <- Warren Grill cites
%  6. The electrode is pointing exaclty in the direction of the screw (for
%     field orientation)

%  % Distance between two stimulating points
% if strcmp('CA1',reg)
%     APdiff = abs(1.25 - -2.0); % A/P coord of screw and electrode (mm)
%     MLdiff = abs(1.8 - 1.8); % M/L coord of screw and electrode (mm)
%     DVdiff = abs(-0.5 - -0.75); % D/V coord of screw and electrode (mm)
%     d = sqrt((APdiff)^2+(MLdiff)^2+(DVdiff)^2); % calculate distance between these two points
% elseif strcmp('M1',reg)
%     APdiff = abs(1.25 - 1.5); % A/P coord of screw and electrode (mm)
%     MLdiff = abs(1.8 - 1.5); % M/L coord of screw and electrode (mm)
%     DVdiff = abs(-0.5 - -0.25); % D/V coord of screw and electrode (mm)
%     d = sqrt((APdiff)^2+(MLdiff)^2+(DVdiff)^2); % calculate distance between these two points
% end

% Object 1: 
% Cylinder oriented along the z-axis with height 0.0541in and radius of
% 0.0115in, centered with its top at 3.25mm, 0mm, -1.6mm in x-y-z space.
% Attached to a cone oriented with its tip facing down with a base radius
% of 0.0115in and a height of 0.5mm base to tip with its base centered at
% 3.25mm, 0mm, -1.1mm. Object 1 has a uniform volume charge rho of +Q.
%
% Object 2:
% Disk oriented in the y-axis with radius of 65um centered at 0mm, 0mm, 0mm
% (everything will be measured relative to the tip of the electrode).
% Object 2 has a uniform surface charge density sigma of -Q.
%
% The total electric field at some chosen field point will be a 
% superposition of these three pieces. For now assume homogenous isotropic
% brain matter. Uses Gauss' law to define the integrands for each electric
% field component Ex, Ey, and Ez.

% Define constants and parameters
% permittivity of brain matter -> IT'IS tissue properties database -> dielectric properties
if freq == 40
    e0 = 1.64e7; % 40Hz
    phw = 200e-6; % 40Hz and 140Hz
elseif freq == 140
    e0 = 2.16e7; % 140Hz
    phw = 200e-6; % 40Hz and 140Hz
elseif freq == 1000
    e0 = 1.64e5; % 1000Hz 
    phw = 45e-6; % 1000Hz
end
Q = (curr*10^-6) * phw; % Total charge, C (example value)


% Cylinder parameters
h_cyl = 0.0541 * 0.0254; % Height of cylinder in meters
R_cyl = 0.0115 * 0.0254; % Radius of cylinder in meters
center_cyl = [APdiff*10^-3, MLdiff*10^-3, DVdiff*10^-3]; % Center of top of cylinder in meters

% Cone parameters
R_cone = 0.0115 * 0.0254; % Base radius in meters
h_cone = 0.5e-3; % Height in meters
base_center_cone = [APdiff*10^-3, MLdiff*10^-3, DVdiff*10^-3-h_cyl]; % Base center in meters
tip_cone = [APdiff*10^-3, MLdiff*10^-3, DVdiff*10^-3-h_cyl-h_cone]; % Tip in meters

% Disk parameters
R_disk = 65e-6; % Radius in meters
center_disk = [0, 0, 0]; % Center at origin

% Define the field point (example coordinates in x-y-z space)
% THIS WILL BE THE NEURON CENTROID RELATIVE TO ELECTRODE TIP
% Rotate ROI coordinates to be in the x'-y' plane where the electrode
% orientation determines the y' axis and the x'-axis is perpendicular
% Convert from pixel idx to m for all calculations.
%
% pixel_size = 1.18e-6; % 1.18um/pixel conveted to meters (10x obj, 6.8um/pixel cam, 2x2 binning)
% adj = (tipIdx(1,2)-baseIdx(1,2))*pixel_size; % length of adjacent leg (y-axis) converted to meters
% opp = (tipIdx(1,1)-baseIdx(1,1))*pixel_size; % length of opposite leg (x-axis) converted to meters
% hypot = sqrt(adj^2+opp^2); % length of hypotenuse
% theta = acos(adj/hypot); % arccos(adj/hypot) to find theta
% 
% x_field = relDist(155,1)*pixel_size*cos(theta) + relDist(155,2)*pixel_size*sin(theta); % x' coord converted to meters
% y_field = -relDist(155,1)*pixel_size*sin(theta) + relDist(155,2)*pixel_size*cos(theta); % y' coord converted to meters
% z_field = 0; % Assume the neuron is in the same plane as the electrode tip
% clearvars E_total_x E_total_y E_total_z
% for i= 1:size(X,1)
%     for j = 1:size(X,2)
%         for k = 1:size(X,3)
%             %Note: meshgrid() changes x-y-z to y-x-z for some reason...
%             x_field = X(i,j,k) ; % x' coord converted to meters
%             y_field = Y(i,j,k); % y' coord converted to meters
%             z_field = Z(i,j,k); % Assume the neuron is in the same plane as the electrode tip
% 
%             % Calculate volume and surface charge densities
%             V_cyl = pi * R_cyl^2 * h_cyl;
%             V_cone = (1/3) * pi * R_cone^2 * h_cone;
%             V_total = V_cyl + V_cone;
%             rho = Q / V_total;
% 
%             A_disk = pi * R_disk^2;
%             sigma = -Q / A_disk;
% 
%             % Define the integrands for the cylinder
%             integrand_cyl_x = @(r, phi, z_prime) ...
%                 (rho / (4 * pi * e0)) * ...
%                 (x_field - (r .* cos(phi) + center_cyl(1))) ./ ...
%                 ((x_field - (r .* cos(phi) + center_cyl(1))).^2 + ...
%                 (y_field - (r .* sin(phi) + center_cyl(2))).^2 + ...
%                 (z_field - (z_prime + center_cyl(3))).^2).^(3/2) .* r;
% 
%             integrand_cyl_y = @(r, phi, z_prime) ...
%                 (rho / (4 * pi * e0)) * ...
%                 (y_field - (r .* sin(phi) + center_cyl(2))) ./ ...
%                 ((x_field - (r .* cos(phi) + center_cyl(1))).^2 + ...
%                 (y_field - (r .* sin(phi) + center_cyl(2))).^2 + ...
%                 (z_field - (z_prime + center_cyl(3))).^2).^(3/2) .* r;
% 
%             integrand_cyl_z = @(r, phi, z_prime) ...
%                 (rho / (4 * pi * e0)) * ...
%                 (z_field - (z_prime + center_cyl(3))) ./ ...
%                 ((x_field - (r .* cos(phi) + center_cyl(1))).^2 + ...
%                 (y_field - (r .* sin(phi) + center_cyl(2))).^2 + ...
%                 (z_field - (z_prime + center_cyl(3))).^2).^(3/2) .* r;
% 
%             % Perform the numerical integration for the cylinder
%             E_cyl_x = integral3(@(r, phi, z_prime) integrand_cyl_x(r, phi, z_prime), ...
%                           0, R_cyl, 0, 2 * pi, 0, h_cyl);
%             E_cyl_y = integral3(@(r, phi, z_prime) integrand_cyl_y(r, phi, z_prime), ...
%                           0, R_cyl, 0, 2 * pi, 0, h_cyl);
%             E_cyl_z = integral3(@(r, phi, z_prime) integrand_cyl_z(r, phi, z_prime), ...
%                           0, R_cyl, 0, 2 * pi, 0, h_cyl);
% 
%             % Define the integrands for the cone
%             integrand_cone_x = @(r, phi, z_prime) ...
%                 (rho / (4 * pi * e0)) * ...
%                 (x_field - (r .* cos(phi) + base_center_cone(1))) ./ ...
%                 ((x_field - (r .* cos(phi) + base_center_cone(1))).^2 + ...
%                 (y_field - (r .* sin(phi) + base_center_cone(2))).^2 + ...
%                 (z_field - (z_prime + base_center_cone(3))).^2).^(3/2) .* r;
% 
%             integrand_cone_y = @(r, phi, z_prime) ...
%                 (rho / (4 * pi * e0)) * ...
%                 (y_field - (r .* sin(phi) + base_center_cone(2))) ./ ...
%                 ((x_field - (r .* cos(phi) + base_center_cone(1))).^2 + ...
%                 (y_field - (r .* sin(phi) + base_center_cone(2))).^2 + ...
%                 (z_field - (z_prime + base_center_cone(3))).^2).^(3/2) .* r;
% 
%             integrand_cone_z = @(r, phi, z_prime) ...
%                 (rho / (4 * pi * e0)) * ...
%                 (z_field - (z_prime + base_center_cone(3))) ./ ...
%                 ((x_field - (r .* cos(phi) + base_center_cone(1))).^2 + ...
%                 (y_field - (r .* sin(phi) + base_center_cone(2))).^2 + ...
%                 (z_field - (z_prime + base_center_cone(3))).^2).^(3/2) .* r;
% 
%             % Perform the numerical integration for the cone
%             E_cone_x = integral3(@(r, phi, z_prime) integrand_cone_x(r, phi, z_prime), ...
%                           0, R_cone, 0, 2 * pi, -h_cone, 0);
%             E_cone_y = integral3(@(r, phi, z_prime) integrand_cone_y(r, phi, z_prime), ...
%                           0, R_cone, 0, 2 * pi, -h_cone, 0);
%             E_cone_z = integral3(@(r, phi, z_prime) integrand_cone_z(r, phi, z_prime), ...
%                           0, R_cone, 0, 2 * pi, -h_cone, 0);
% 
%             % Define the integrands for the disk
%             integrand_disk_x = @(r, phi) ...
%                 (sigma / (4 * pi * e0)) * ...
%                 (x_field - r .* cos(phi)) ./ ...
%                 ((x_field - r .* cos(phi)).^2 + ...
%                 (y_field - r .* sin(phi)).^2 + ...
%                 (z_field - center_disk(3)).^2).^(3/2) .* r;
% 
%             integrand_disk_y = @(r, phi) ...
%                 (sigma / (4 * pi * e0)) * ...
%                 (y_field - r .* sin(phi)) ./ ...
%                 ((x_field - r .* cos(phi)).^2 + ...
%                 (y_field - r .* sin(phi)).^2 + ...
%                 (z_field - center_disk(3)).^2).^(3/2) .* r;
% 
%             integrand_disk_z = @(r, phi) ...
%                 (sigma / (4 * pi * e0)) * ...
%                 (z_field - center_disk(3)) ./ ...
%                 ((x_field - r .* cos(phi)).^2 + ...
%                 (y_field - r .* sin(phi)).^2 + ...
%                 (z_field - center_disk(3)).^2).^(3/2) .* r;
% 
%             % Perform the numerical integration for the disk
%             E_disk_x = integral2(@(r, phi) integrand_disk_x(r, phi), 0, R_disk, 0, 2 * pi);
%             E_disk_y = integral2(@(r, phi) integrand_disk_y(r, phi), 0, R_disk, 0, 2 * pi);
%             E_disk_z = integral2(@(r, phi) integrand_disk_z(r, phi), 0, R_disk, 0, 2 * pi);
% 
%             % Total electric field components at the field point
%             E_total_x(i,j,k) = E_cyl_x + E_cone_x + E_disk_x;
%             E_total_y(i,j,k) = E_cyl_y + E_cone_y + E_disk_y;
%             E_total_z(i,j,k) = E_cyl_z + E_cone_z + E_disk_z;
% 
%             % % Display the results
%             % fprintf('Electric field components at the field point:\n');
%             % fprintf('E_x = %.3e V/m\n', E_total_x(i,j,k));
%             % fprintf('E_y = %.3e V/m\n', E_total_y(i,j,k));
%             % fprintf('E_z = %.3e V/m\n', E_total_z(i,j,k));
%         end
%     end
% end
% U = E_total_x;
% V = E_total_y;
% W = E_total_z;

% % Plot electric field near electrode tip as a quiver plot
% figure
% quiver3(X,Y,Z,U,V,W);
% hold on
% plot3(0,0,0,'m+');
% for i=1:numel(ROIs.goodIdx)
%     x_pos = relDist(i,1)*pixel_size*cos(theta) - relDist(i,2)*pixel_size*sin(theta); % x' coord converted to meters
%     y_pos = relDist(i,1)*pixel_size*sin(theta) + relDist(i,2)*pixel_size*cos(theta); % y' coord converted to meters
%     z_pos = 0; % Assume the neuron is in the same plane as the electrode tip
% 
%     if any(ROIs.goodIdx(pos_neurons) == ROIs.goodIdx(i)) 
%         plot3(x_pos,y_pos,z_pos, 'r.');
%     elseif any(ROIs.goodIdx(non_neurons) == ROIs.goodIdx(i)) 
%         plot3(x_pos,y_pos,z_pos, 'g.');
%     elseif any(ROIs.goodIdx(neg_neurons) == ROIs.goodIdx(i)) 
%         plot3(x_pos,y_pos,z_pos, 'b.');
%     end
% end
% xlabel('x-axis (m)')
% ylabel('y-axis (m) [parallel to electrode]')
% zlabel('z-axis (m)')
% title('Electric field strength near the electrode tip')

% % Surface plot
% figure;
% E_mag = sum(cat(4,E_total_x.^2, E_total_y.^2 , E_total_z.^2),4,'omitnan');
% s = surf(X(:,:,6),Y(:,:,6),Z(:,:,6),log(E_mag(:,:,6))); % idx of 6 in z range is the imaging plane (z = 0)
% axis xy;
% s.EdgeColor = 'none';
% s.FaceColor = 'interp';
% s.FaceAlpha = 0.5;
% hold on
% for i=1:numel(ROIs.goodIdx)
%     x_pos = relDist(i,1)*pixel_size*cos(theta) - relDist(i,2)*pixel_size*sin(theta); % x' coord converted to meters
%     y_pos = relDist(i,1)*pixel_size*sin(theta) + relDist(i,2)*pixel_size*cos(theta); % y' coord converted to meters
%     z_pos = 0; % Assume the neuron is in the same plane as the electrode tip
% 
%     if any(ROIs.goodIdx(pos_neurons) == ROIs.goodIdx(i)) 
%         plot3(x_pos,y_pos,z_pos, 'r.');
%     elseif any(ROIs.goodIdx(non_neurons) == ROIs.goodIdx(i)) 
%         plot3(x_pos,y_pos,z_pos, 'g.');
%     elseif any(ROIs.goodIdx(neg_neurons) == ROIs.goodIdx(i)) 
%         plot3(x_pos,y_pos,z_pos, 'b.');
%     end
% end
% cb = colorbar;
% plot(0,0,'m+'); %electrode tip location
% quiver(X(:,:,6),Y(:,:,6),U(:,:,6),V(:,:,6),'Color','k');
% 
% %plot the corners of the fov
% x_pos = cornerDist(:,1)*pixel_size*cos(theta) - cornerDist(:,2)*pixel_size*sin(theta); % x' coord converted to meters
% y_pos = cornerDist(:,1)*pixel_size*sin(theta) + cornerDist(:,2)*pixel_size*cos(theta); % y' coord converted to meters
% plot(x_pos,y_pos,'ko','MarkerSize',12);
% 
% view(2) %2D view
% 
% xlabel('distance (m)');
% ylabel('distance(m)');
% ylabel(cb,'log(E field strength) (V/m)');
% title([mouse, ' ', region, ' ', num2str(freq), 'Hz rec' num2str(rec_name), ' fov' num2str(fov), ' Electric Field Projection']); %, ' fov' num2str(fov)
% saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name), '_fov' num2str(fov), '_eFieldSurf.fig']); %,'_fov' num2str(fov)
% saveas(gcf,[save_path '/Spatial_Analysis/' mouse, '_', reg, '_', num2str(freq), 'Hz_rec' num2str(rec_name), '_fov' num2str(fov), '_eFieldSurf.jpg']); %,'_fov' num2str(fov)

%% Analysis of spatial distribution patterns (all rec; not relative to electrode)
region = 'Neocortex';
data = data1000_M1;
pos_mod = pos_mod_1000_M1;
non_mod = non_mod_1000_M1;
neg_mod = neg_mod_1000_M1;

%figure
%tiledlayout(ceil(sqrt(numel(data))),floor(sqrt(numel(data))))
clearvars sp_analys
for i = 1:numel(data)
    temp = strsplit(data(i).name,'_');
    mouse = temp{3};
    rec = temp{4};
    fov = temp{5};
    freq = temp{6};
    curr = temp{7};

    try
        maxmin_path = ['~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/', region, ...
        '/', mouse, '/', rec, '/' freq, 'Hz/' fov '/motion_corrected']; 
        temp = dir([maxmin_path '/*.tif']);
        frame= imread([maxmin_path '/' temp.name]);
    catch
        try
            maxmin_path = ['~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/', region, ...
            '/', mouse, '/', rec, '/' freq, 'Hz/motion_corrected'];
            temp = dir([maxmin_path '/*.tif']);
            frame= imread([maxmin_path '/' temp.name]); 
        catch
            maxmin_path = ['~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/', region, ...
            '/', mouse, '/', rec, '/' freq, 'Hz/' curr, 'uA/motion_corrected'];
            temp = dir([maxmin_path '/*.tif']);
            frame= imread([maxmin_path '/' temp.name]); 
        end
    end

    ROIs = data(i).roi_data;
    pos_neurons = pos_mod.neurons(pos_mod.neurons(:,1)==i,2);
    neg_neurons = neg_mod.neurons(neg_mod.neurons(:,1)==i,2);
    non_neurons = non_mod.neurons(non_mod.neurons(:,1)==i,2);


    neurons = [];
    for j=1:numel(ROIs.goodIdx)
        binmask = zeros(size(frame));
        % Get roi position in space (pixel)
        roi_pixels = cell2mat(ROIs.pixel_idx(ROIs.goodIdx(j)));
        binmask(roi_pixels) = 1;
        binmask = imfill(binmask, 'holes');
        B = bwboundaries(binmask);
        % Use the mid rectangle of area function to find a center point
        polyin = polyshape(B{1,1});
        [x,y] = centroid(polyin);
    
        % log the center of each roi for use later
         x = round(x);
         y = round(y);
        %roiIdx = vertcat(roiIdx, [y,x]);
    
        if any(ROIs.goodIdx(pos_neurons) == ROIs.goodIdx(j)) 
            neurons = vertcat(neurons, [1, j, y, x]);
        elseif any(ROIs.goodIdx(non_neurons) == ROIs.goodIdx(j)) 
            neurons = vertcat(neurons, [0, j, y, x]);
        elseif any(ROIs.goodIdx(neg_neurons) == ROIs.goodIdx(j)) 
            neurons = vertcat(neurons, [-1, j, y, x]);
        end
    end
     
    sp_analys(i).pos_mask = neurons(:,1) == 1;
    sp_analys(i).non_mask = neurons(:,1) == 0;
    sp_analys(i).neg_mask = neurons(:,1) == -1;
    
    % Create a distribution of median distances between neurons
    d_distrib = [];
    for j = 1:size(neurons,1)
        d_distrib = [d_distrib, sqrt((neurons(:,3)-neurons(j,3)).^2 + (neurons(:,4)-neurons(j,4)).^2)];
        d_distrib(j,j) = NaN;
    end
    
    sp_analys(i).d_distrib = d_distrib;

   % Silhouette Score Approach 
   %[s,h]= silhouette([neurons(:,3),neurons(:,4)], neurons(:,1),'Euclidean');
   s = silhouette([neurons(:,3),neurons(:,4)], neurons(:,1),'Euclidean');
   [B, ~] = sort(neurons(:,1));
   sp_analys(i).s = s;

   if (size(neurons,1) > 10) && ...
      (sum(sp_analys(i).pos_mask) >= 3 || sum(sp_analys(i).pos_mask) == 0) && ...
      (sum(sp_analys(i).neg_mask) >= 3 || sum(sp_analys(i).neg_mask) == 0)

        sp_analys(i).avg_s = mean(s,'omitnan');
   else
       sp_analys(i).avg_s = NaN;
   end
   
   % figure
   % hold on
   % barh(find(B == 1), sort(sp_analys(i).s(sp_analys(i).pos_mask)), 'FaceColor', 'r', 'EdgeColor', 'none');
   % barh(find(B == 0), sort(sp_analys(i).s(sp_analys(i).non_mask)), 'FaceColor', 'g', 'EdgeColor', 'none');
   % barh(find(B == -1), sort(sp_analys(i).s(sp_analys(i).neg_mask)), 'FaceColor', 'b', 'EdgeColor', 'none');
   % xlim([-1 1]);
   % nexttile
   % 
   % sp_analys(i).med_non_s = median(s(sp_analys(i).non_mask));
   % if numel(pos_neurons) >= 3
   %     sp_analys(i).med_pos_s = median(s(sp_analys(i).pos_mask));
   % else
   %     sp_analys(i).med_pos_s = NaN;
   % end
   % 
   % if numel(neg_neurons) >= 3
   %     sp_analys(i).med_neg_s = median(s(sp_analys(i).neg_mask));
   % else
   %     sp_analys(i).med_neg_s = NaN;
   % end
  

   % Bootstrapped approach
   % % Randomly select (with replacement) 100 non-activated neurons and find
   % % their median distance to the real activated neurons. Make a
   % % distribution calculate 95% CI, compare the actual median distances of
   % % activated neurons and see how many are beyond CI.
   % if numel(pos_neurons) >= 3 % must have at least 3 activated neurons
   %     temp = [non_neurons;neg_neurons];
   %     rand_nrn = randi(numel(temp),[1,100]); % choose 100 random on-activated neurons (with replacement)
   %     pos_boot_distrib = median(d_distrib(temp(rand_nrn),sp_analys(i).pos_mask),2);
   %  else
   %     pos_boot_distrib = NaN;
   %  end
   % 
   %  % Repeat for supressed neurons
   %  if numel(neg_neurons) >= 3 % must have at least 3 activated neurons
   %     temp = [non_neurons;pos_neurons];
   %     rand_nrn = randi(numel(temp),[1,100]); % choose 100 random on-activated neurons (with replacement)
   %     neg_boot_distrib = median(d_distrib(temp(rand_nrn),sp_analys(i).neg_mask),2);
   %  else
   %     neg_boot_distrib = NaN;
   %  end

   % Linear Regression Approach
   if size(neurons,1) > 10
       tbl = table(neurons(:,3), neurons(:,4),neurons(:,1),'VariableNames',{'x-pos','y-pos','ID'});
       sp_analys(i).lm = fitlm(tbl);

       tbl = table(neurons(:,3), neurons(:,4),double(sp_analys(i).pos_mask),'VariableNames',{'x-pos','y-pos','ID'});
       sp_analys(i).lm_pos = fitlm(tbl);

       tbl = table(neurons(:,3), neurons(:,4),double(sp_analys(i).neg_mask),'VariableNames',{'x-pos','y-pos','ID'});
       sp_analys(i).lm_neg = fitlm(tbl);
   end
end
sp_analys_1000M1 = sp_analys;
%% Histogram of distance to other neurons
cell_d_distrib = {sp_analys(:).d_distrib};
med_ds = cellfun(@(x) median(x,1,'omitnan'), cell_d_distrib,'UniformOutput',false);
med_ds = [med_ds{:}];

for i=1:numel(sp_analys)
    med_pos_pos(i) = median(sp_analys(i).d_distrib(sp_analys(i).pos_mask,sp_analys(i).pos_mask),'all','omitnan');
    med_pos_non(i) = median(sp_analys(i).d_distrib(sp_analys(i).pos_mask,sp_analys(i).non_mask),'all','omitnan');
    med_neg_neg(i) = median(sp_analys(i).d_distrib(sp_analys(i).neg_mask,sp_analys(i).neg_mask),'all','omitnan');
    med_neg_non(i) = median(sp_analys(i).d_distrib(sp_analys(i).neg_mask,sp_analys(i).non_mask),'all','omitnan');
    med_non_non(i) = median(sp_analys(i).d_distrib(sp_analys(i).non_mask,sp_analys(i).non_mask),'all','omitnan');
end

figure
histogram(med_ds)
hold on
plot(med_neg_neg,10*ones(size(med_neg_neg)),'b.');
plot(med_neg_non,30*ones(size(med_neg_non)),'c.');
plot(med_non_non,50*ones(size(med_non_non)),'g.');
plot(med_pos_pos,70*ones(size(med_neg_non)),'r.');
plot(med_pos_non,90*ones(size(med_pos_non)),'m.');

%% current density calculation -- Address Reviewer 3 comment
% Calc Surface area of screw
%A_screw = pi*R_cone*sqrt(h_cone^2+R_cone^2) + h_cyl*2*pi*R_cyl;
% R_disk = 63.5e-6; % in meters 127um diameter core wire
% A_wire = pi * R_disk^2;
R_disk = 8.44e-6; % in meters 127um diameter core wire
A_wire = pi * R_disk^2;

curr = 20;
phw = 45e-6;
electrode_area_mm2 = A_wire*1000*1000; %(A_screw+A_wire)*1000*1000
electrode_area_cm2 = A_wire*100*100; %(A_screw+A_wire)*100*100
charge_per_ph = curr*phw % output in uC/phase
charge_dens = (charge_per_ph)/(electrode_area_cm2) %Magnitude of current density is I/A; output in uC/cm^2/phase
k = log(charge_dens)+log(charge_per_ph) % Based on Shannon, IEEE 1992 "A model of safe levels for electrical stimulation"

e0_40 = 1.64e7; %Epsilon is a frequency dependent brain matter permittivity (see above section on e0)
e0_140 = 2.16e7;
e0_1000 = 1.64e5;
Emax = ((charge_dens/1e6)*(100*100))/(2*e0_1000); %charge density in C/m^2/phase

sf_200um = 2.5e-5; %scaling factor at 200um
sf_400um = 6.25e-6; %scaling factor at 400um
sf_600um = 2.78e-6; %scaling factor at 600um
E_200um = Emax*sf_200um
E_400um = Emax*sf_400um
E_600um = Emax*sf_600um

%% Save Spatial analysis data as csv for source data
spatial_analysis_source_data = table([],[],[],[],[],[],[],[],[],[],'VariableNames',...
                    {'brain_region','stim_freq_Hz','mouseID','rec_num',...
                     'current_uA','neuron_num','stim_evoked_responseID',...
                     'x_dist_from_electrode_pixels','y_dist_from_electrode_pixels',...
                     'BG_subtracted_scaled_average_trace_frame'});

for i=1:numel(ex_fovs) %iterate through each recording with an electrode
    reps = size(ex_fovs(i).neurons,1);
 
    if strcmp(ex_fovs(i).reg, 'CA1')
        temp_reg = "CA1";
        temp_mouse = "C00014138";
    elseif strcmp(ex_fovs(i).reg, 'M1')
        temp_reg = "Cortex";
        temp_mouse = "C00023114";
    end
    temp_freq = ex_fovs(i).freq;
    temp_rec = ex_fovs(i).rec;
    temp_curr = ex_fovs(i).curr;
    temp_neuron = ex_fovs(i).neurons(:,2);
    temp_x_dist = ex_fovs(i).neurons(:,3);
    temp_y_dist = ex_fovs(i).neurons(:,4);
    temp_ID = string.empty(reps,0);
    temp_ID(ex_fovs(i).neurons(:,1) == 1) = "activated";
    temp_ID(ex_fovs(i).neurons(:,1) == -1) = "suppressed";
    temp_ID(ex_fovs(i).neurons(:,1) == 0) = "unchanged";
    temp_ID = temp_ID';
    temp_traces = ex_fovs(i).avg_traces;

    temp_tbl = table(repmat(temp_reg,[reps,1]), repmat(temp_freq,[reps,1]),...
                repmat(temp_mouseID,[reps,1]),repmat(temp_rec,[reps,1]),...
                repmat(temp_curr,[reps,1]),temp_neuron,...
                temp_ID,temp_x_dist, temp_y_dist, temp_traces,...
                'VariableNames',...
                 {'brain_region','stim_freq_Hz','mouseID','rec_num',...
                  'current_uA','neuron_num','stim_evoked_responseID',...
                  'x_dist_from_electrode_pixels','y_dist_from_electrode_pixels',...
                  'BG_subtracted_scaled_average_trace_frame'});

    spatial_analysis_source_data = [spatial_analysis_source_data; temp_tbl];
end
writetable(spatial_analysis_source_data,'spatial_analysis_source_data_table.csv');

