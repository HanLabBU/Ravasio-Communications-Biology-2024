% check_latency.m
% Author: Cara R
% Date: 11/15/23
% Purpose: see if there are significant differences in the latency (i.e.
% how long it takes to reach significance) for modulated neruons in CA1 vs
% M1

function lat_on = check_latency(CA1, M1, Fs, freq, mod,colors)

CA1_lat_on = []; M1_lat_on = [];
CA1_lat_off = []; M1_lat_off = [];
for i = 1:size(CA1.neurons,1)
    baseline = CA1.traces(i,1:5*Fs-1);
    baseline_avg = mean(baseline)*ones(size(CA1.traces(i,:)));
    CA1_z_score = (CA1.traces(i,:)-baseline_avg)/std(baseline);  
    if strcmp(mod, 'pos')
        I = find(diff(CA1_z_score(1,3*Fs:8.5*Fs) > 2) == 1, 1,'first') + 1 + 2*Fs;
        CA1_lat_on = vertcat(CA1_lat_on,I);
        I = find(diff(CA1_z_score(1,5*Fs:end) > 2) == -1, 1,'first') + 1 + 5*Fs;
        CA1_lat_off = vertcat(CA1_lat_off,I);
    elseif strcmp(mod, 'neg')
        I = find(diff(CA1_z_score(1,3*Fs:8.5*Fs) < -2) == 1, 1,'first') + 1 + 2*Fs;
        CA1_lat_on = vertcat(CA1_lat_on,I);
        I = find(diff(CA1_z_score(1,5*Fs:end) < -2) == -1, 1,'first') + 1 + 5*Fs;
        CA1_lat_off = vertcat(CA1_lat_off,I);
    end
end

for i = 1:size(M1.neurons,1)
    baseline = M1.traces(i,1:5*Fs-1);
    baseline_avg = mean(baseline)*ones(size(M1.traces(i,:)));
    M1_z_score = (M1.traces(i,:)-baseline_avg)/std(baseline);
    if strcmp(mod, 'pos')
        I = find(diff(M1_z_score(1,3*Fs:8.5*Fs) > 2) == 1, 1,'first') + 1 + 2*Fs;
        M1_lat_on = vertcat(M1_lat_on,I);
        I = find(diff(M1_z_score(1,5*Fs:end) > 2) == -1, 1,'first') + 1 + 5*Fs;
        M1_lat_off = vertcat(M1_lat_off,I);
    elseif strcmp(mod, 'neg')
        I = find(diff(M1_z_score(1,3*Fs:8.5*Fs) < -2) == 1, 1,'first') + 1 + 2*Fs;
        M1_lat_on = vertcat(M1_lat_on,I);
        I = find(diff(M1_z_score(1,5*Fs:end) < -2) == -1, 1,'first') + 1 + 5*Fs;
        M1_lat_off = vertcat(M1_lat_off,I);
    end
end

figure;
lat_on.CA1 = CA1_lat_on;
lat_on.M1 = M1_lat_on;
p = ranksum(CA1_lat_on, M1_lat_on);
violinplot(lat_on,{'CA1','M1'},'ShowData',false,'ViolinColor',[colors(1,:);colors(2,:)]);
title([freq 'Hz ' mod '-mod onset Latency (Z-score) [ p = ' num2str(p) ']']);
saveas(gcf,[freq 'Hz_' mod '_onsetLat.fig']);

figure;
lat_off.CA1 = CA1_lat_off;
lat_off.M1 = M1_lat_off;
p = ranksum(CA1_lat_off, M1_lat_off);
violinplot(lat_off,{'CA1','M1'},'ShowData',false,'ViolinColor',[colors(1,:);colors(2,:)]);
title([freq 'Hz ' mod '-mod offset Latency (Z-score) [ p = ' num2str(p) ']']);
saveas(gcf,[freq 'Hz_' mod '_offsetLat.fig']);

end