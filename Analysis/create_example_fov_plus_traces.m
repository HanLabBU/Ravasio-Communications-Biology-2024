% create_example_fov_plus_traces.m
% Author: Cara R
% Date: 06/22/23
% Purpose: create a figure using the maxmin projection that circles
% specific neurons and then plots those neurons' traces in a separate
% figure.

function create_example_fov_plus_traces(frame, ROIs)
% frame is the maxmin projection for a recording
% ROIs is the roi_data struct
    Fs = 20; %Hz
%% Circle neurons in maxmin projection
    % Display average image
    [rows, cols] = size(frame);
    figure('Renderer', 'painters', 'Position', [0 0 cols rows]);%2000 1500]);
    imagesc(frame,[median(median(frame))-500, median(median(frame))+5000]);
    hold on;
    colormap(gray);
    
    % Show the ROIs on the maxmin image
    test=[93,100,161,204];
    for i=1:numel(test)
        binmask = zeros(size(frame));
        roi_pixels = cell2mat(ROIs.pixel_idx(ROIs.goodIdx(test(i))));
        binmask(roi_pixels) = 1;
        binmask = imfill(binmask, 'holes');
        B = bwboundaries(binmask);
        hold on;
        visboundaries(B, 'LineStyle', '-', 'EnhanceVisibility', false, 'Color', 'yellow');

        % Use the mid rectangle of area function to find a center point
        polyin = polyshape(B{1,1});
        [x,y] = centroid(polyin);
        text(y+10, x+10, num2str(test(i)), 'Color', 'cyan', 'FontSize', 12);
    end
    
    % Plot the scale bar
    image_pixel_size = 1.18; %um/pixel %calculated for ORCA-Fusion C14440 camera
    % with 2x2 binning, 10x objective, and tube+focal length contribution 
    % of 0.1 to magnification.
    scale_bar(1) = 511; %starting x-pixelvalue
    scale_bar(2) = 666; %y-pixelvalue
    scale_bar(3) = round(100/image_pixel_size,0); % 100um scale bar length in pixels
    scale_bar(4) = 2; %scalebar linewidth
    plot([scale_bar(1) scale_bar(1)+scale_bar(3)], [scale_bar(2) scale_bar(2)], '-w', 'LineWidth', scale_bar(4));
    text(scale_bar(1)+12,scale_bar(2)+12,sprintf('100um'),'Color','white');

%% Plot the example neuron traces
    trial_traces = ROIs.trace_minusBG_new_DN_reshaped_scaled;
    avg_trace = ROIs.avg_trace_minusBG_new_scaled;
    cells = ROIs.goodIdx;
    
    figure;
    for n=1:numel(test)
        subplot(numel(test),1,n)
        offset = mean(mean(squeeze(trial_traces(cells(test(n)),1:5*Fs-1,:)),1));
        hold on
        plot(squeeze(trial_traces(cells(test(n)),:,:))-offset,'-','Color',[0.8 0.8 0.8])
        plot(avg_trace(cells(test(n)),:),'r-');
        xline(5*Fs,'Color','black','LineStyle','-'); 
        xline(10*Fs,'Color','black','LineStyle','-');
    end

end