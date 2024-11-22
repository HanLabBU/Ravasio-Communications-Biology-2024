% sess_variation_bar.m
% Author: Cara
% Date; 05/17/23
% Purpose: Cleanup and automate the session variation code in
% post-processing

function session_variation_bar(non_mod, neg_mod, pos_mod, freq, region, colors)
% freq is a number (i.e. 40, 140, 1000)
% region is a string (i.e. 'CA1','M1)

grey = colors(1,:);
dark_blue = colors(2,:);
red = colors(3,:);
for i = 1:max(non_mod.neurons(:,1)) %Iterate through all sessions
    non_mod_count(i) = sum(non_mod.neurons(:,1)==i);
    neg_mod_count(i) = sum(neg_mod.neurons(:,1)==i); 
    pos_mod_count(i) = sum(pos_mod.neurons(:,1)==i);
    total_count(i) = non_mod_count(i) + neg_mod_count(i) + pos_mod_count(i);
end

bs = [(non_mod_count./total_count)',(neg_mod_count./total_count)',(pos_mod_count./total_count)'];
figure;
b=bar([1:max(non_mod.neurons(:,1))],bs,'stacked');
b(1).FaceColor = colors(1,:);
b(2).FaceColor = colors(2,:);
b(3).FaceColor = colors(3,:);
title(['Session-wise ' num2str(freq) 'Hz ' region ' breakdown']);
xlabel('Session'); ylabel('Percentage of total neurons');
legend({'Non-modulated neruons','Neg-Mod neurons','Pos-mod neurons'});
saveas(gcf, [num2str(freq) '_' region '_sess_bar_normalized.fig']);

bs2 = [(non_mod_count)',(neg_mod_count)',(pos_mod_count)'];
figure;
b=bar([1:max(non_mod.neurons(:,1))],bs2,'stacked');
b(1).FaceColor = colors(1,:);
b(2).FaceColor = colors(2,:);
b(3).FaceColor = colors(3,:);
title(['Session-wise ' num2str(freq) 'Hz ' region ' breakdown']);
xlabel('Session'); ylabel('# Neurons');
legend({'Non-modulated neruons','Neg-Mod neurons','Pos-mod neurons'});
saveas(gcf, [num2str(freq) '_' region '_sess_bar.fig']);
end