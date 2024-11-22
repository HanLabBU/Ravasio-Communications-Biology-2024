nrec = pos_mod_140.stim.neurons(:,1);
id = pos_mod_140.stim.neurons(:,2);
figure;
hold on;
temp_trace = zeros(length(nrec),200);
for i = 1:length(nrec)
    temp_trace(i,:) = data140(nrec(i)).roi_data.avg_trace_minusBG_new_scaled(...
                        data140(nrec(i)).roi_data.goodIdx(id(i)),:);
   plot([1:200], temp_trace(i,:), 'Color',[0.8 0.8 0.8]);
end
plot(mean(temp_trace,1), 'r-');
set(gca,'XTick',[0:Fs:num_frames],'XTickLabel',[0:20]);
xlabel('Time (s)'); ylabel('dF/F');
title('Pos Mod 140Hz Traces');
saveas(gcf,['PosMod140HzTraces.fig']);

avg_pos_mod_140 = mean(temp_trace,1);
save('avg_pos_mod_140_trace.mat', 'avg_pos_mod_140')

%% Subplot of averages
figure;
%Negatively modulated subplot
subplot(1,3,1);
%plot([0.2:0.1:20],avg_neg_mod_1000(2:end),'r-');
hold on;
plot([0.2:0.1:20],avg_neg_mod_40(2:end),'g-');
plot([0.2:0.1:20],avg_neg_mod_140(2:end),'b-');
xlabel('Time(s)');ylabel('dF/F');
title('Average Negatively Modulated');
%Non-modulated subplot
subplot(1,3,2);
%plot([0.2:0.1:20],avg_non_mod_1000(2:end),'r-');
hold on;
plot([0.2:0.1:20],avg_non_mod_40(2:end),'g-');
plot([0.2:0.1:20],avg_non_mod_140(2:end),'b-');
xlabel('Time(s)');ylabel('dF/F');
title('Average Non-Modulated')
%Positively modulated subplot
subplot(1,3,3);
%plot([0.2:0.1:20],avg_pos_mod_1000(2:end),'r-');
hold on;
plot([0.2:0.1:20],avg_pos_mod_40(2:end),'g-');
plot([0.2:0.1:20],avg_pos_mod_140(2:end),'b-');
xlabel('Time(s)');ylabel('dF/F');
title('Average Positively Modulated')
legend({'40Hz','140Hz'}); %'1000Hz','40Hz','140Hz'});