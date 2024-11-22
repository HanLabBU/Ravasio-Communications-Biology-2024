function [outputArg1,outputArg2] = display_cells_in_frame(frame, ROIs)%, scale_bar)
    % Display average image
    [rows, cols] = size(frame);
    figure('Renderer', 'painters', 'Position', [0 0 cols rows]);%2000 1500]);
    imagesc(frame,[median(median(frame))-2000, median(median(frame))+4000]);
    hold on;
    colormap(gray);
    
    % Show the ROIs on the average somArchon image
    %test=[204,178,31,161];
    for i=1:numel(ROIs.goodIdx)%4
        binmask = zeros(size(frame));
        roi_pixels = cell2mat(ROIs.pixel_idx(ROIs.goodIdx(i)));%cell2mat(ROIs.pixel_idx(ROIs.goodIdx(test(i))));
        binmask(roi_pixels) = 1;
        binmask = imfill(binmask, 'holes');
        B = bwboundaries(binmask);
        hold on;
        try
            if any(ROIs.posModID == ROIs.goodIdx(i)) 
                visboundaries(B, 'LineStyle', ':', 'EnhanceVisibility', false, 'Color', 'red');
            elseif any(ROIs.nonModID == ROIs.goodIdx(i)) 
                visboundaries(B, 'LineStyle', ':', 'EnhanceVisibility', false, 'Color', 'green');
            elseif any(ROIs.negModID == ROIs.goodIdx(i)) 
                visboundaries(B, 'LineStyle', ':', 'EnhanceVisibility', false, 'Color', 'blue');
            end
        catch
            visboundaries(B, 'LineStyle', ':', 'EnhanceVisibility', false, 'Color', 'yellow');
        end
        % Use the mid rectangle of area function to find a center point
        polyin = polyshape(B{1,1});
        [x,y] = centroid(polyin);
        text(y, x, num2str(i), 'Color', 'cyan', 'FontSize', 10);
    end
    
    % Plot the scale bar
    %plot([scale_bar(1) scale_bar(1)+scale_bar(3)], [scale_bar(2) scale_bar(2)], '-w', 'LineWidth', scale_bar(4));
end
