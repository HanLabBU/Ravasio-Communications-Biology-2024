% hip_gcamp_kmeans.m
% Author: Cara Ravasio
% Date: 03/15/22
% Purpose: To find the optimal k-means clustering for our data

function hip_gcamp_kmeans(data_struct,z)

%What pieces of data are most important for identifying clusters? Will
%probably need to try a few combinations.

%================ Setting up data struct for kmeans analysis =============%
cnt = 1;
for i=1:numel(data_struct) %iterate through recordings
    for j=1:numel(data_struct(i).roi_data.goodIdx) %iterate through good neurons
        % B=[recording,neuron_number,latency,act_max, act_max_frame, act_width, deact_min, deact_min_frame, deact_width];
        B(cnt,:) = [i, j , z{1,i}.lat(j), z{1,i}.max(j,1), z{1,i}.max(j,2), z{1,i}.act_width(j), z{1,i}.min(j,1), z{1,i}.min(j,2), z{1,i}.deact_width(j)]; 
        cnt = cnt+1; %increment the counter variable
    end
end
figure;
plotmatrix(B)

data = B(:,3:end); %exclude the recording and neuron numbers
% ========================= kmeans clustering ============================%
figure;
color=[[1 0 0];[0 1 0];[0 0 1];[0.25 0 0.75];[0 0.5 0.5];[0.75 0.25 0];...
       [0.5 0.5 0]; [1 0 1];[1 1 0]];
 for k=2:7
    legend_labels={};
    [IDX,C]=kmeans(data,k, 'Replicates',100);
    for cluster=1:k
        [Index,~,~]=find(IDX==cluster);
        subplot(2,6,k-1);
        plot(B(Index,1),B(Index,2),'.','MarkerFaceColor',color(cluster,:));
        hold on;
        legend_labels=horzcat(legend_labels, strcat('C',num2str(cluster),'=[',...
                      num2str(C(cluster,1)),',',num2str(C(cluster,2)),']'));
    end
    plot(C(:,1),C(:,2),'k.','MarkerSize',16);
     title(strcat('(k=',num2str(k),'), best of 100 replicates'));
     xlabel('Recording');
     ylabel('Cell Number');
     legend(legend_labels,'Location','northoutside');
    subplot(2,6,k+5);
    silhouette(data,IDX,'Euclidean');
    s=silhouette(data,IDX,'Euclidean');
    hold on;
    l=xline(mean(s,'omitnan'));
    set(l,'LineStyle','--','Color','r');
    title(strcat('Silhouette mean=',num2str(mean(s,'omitnan'))));
 end
 
end