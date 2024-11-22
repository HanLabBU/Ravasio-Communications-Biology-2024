% heatmap_Cara.m
% Date: 03/02/22
% Author: Cara
% Purpose: Generates a heatmap for the hippocampal GCaMP neural recordings

function heatmap_Cara(plot_data, num_recordings, Fs, colors, title_text, savename)

    %Setup
    [num_neurons, num_frames] = size(plot_data);
    
    %Plot figure
    figure('units','normalized','outerposition',[0 0 1 1])
    imagesc(plot_data);
    hold on
    plot([5*Fs,5*Fs],[0,num_neurons],'k','linewidth',1.5) %Stim onset
    plot([10*Fs,10*Fs],[0,num_neurons],'k','linewidth',1.5) %Stim offset
    ylabel('cell')
    set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:1:20]);
    xlabel('Time (s)')
    title([title_text,' (',...
        num2str(num_neurons), ' Neurons, ', ...
        num2str(num_recordings), ' Recordings)']);
    colormap(colors);
    colorbar
    caxis([-0.25 0.25]);
    
    %Save figure
    saveas(gcf, savename);
    
end
