% mod_sig_fishertest.m
% Author: Cara Ravasio
% Date: 04/11/23
% Purpose: Perform fisher's exact test on the modulated and rebound
% populations of neurons in each condition to determine significance
%
% Edited 05/16/23: got rid of load section and added all mod structs as inputs
function [h_fisher,p_fisher,stats_fisher] = mod_sig_fishertest(pos_mod_40_CA1,neg_mod_40_CA1,non_mod_40_CA1,rebound_40_CA1,...
                                                    pos_mod_140_CA1,neg_mod_140_CA1,non_mod_140_CA1,rebound_140_CA1,...
                                                    pos_mod_1000_CA1,neg_mod_1000_CA1,non_mod_1000_CA1,rebound_1000_CA1,...
                                                    pos_mod_40_M1,neg_mod_40_M1,non_mod_40_M1,rebound_40_M1,...
                                                    pos_mod_140_M1,neg_mod_140_M1,non_mod_140_M1,rebound_140_M1,...
                                                    pos_mod_1000_M1,neg_mod_1000_M1,non_mod_1000_M1,rebound_1000_M1)
 
% %% Load in necessary structs
% save_path = ['/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Paper_Figures_Clean_Data'];
% %CA1
%     load([save_path,'/pos_40_hip.mat']);
%     load([save_path,'/pos_140_hip.mat']);
%     load([save_path,'/pos_1000_hip.mat']);
%     
%     load([save_path,'/neg_40_hip.mat']);
%     load([save_path,'/neg_140_hip.mat']);
%     load([save_path,'/neg_1000_hip.mat']);
%     
%     load([save_path,'/reb_40_hip.mat']);
%     load([save_path,'/reb_140_hip.mat']);
%     load([save_path,'/reb_1000_hip.mat']);
%     
%     base_hip_path = ['/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Hippocampus/Good_Recordings_Data_Files/'];
%     load([base_hip_path, 'non_mod_40_struct_s.mat']);
%     load([base_hip_path, 'non_mod_140_struct_s.mat']);
%     load([base_hip_path, 'non_mod_1000_struct_s.mat']);
%     non_40_hip = non_mod_40_s;
%     non_140_hip = non_mod_140_s;
%     non_1000_hip = non_mod_1000_s;
%     
%     %M1
%     load([save_path,'/pos_40_cort.mat']);
%     load([save_path,'/pos_140_cort.mat']);
%     load([save_path,'/pos_1000_cort.mat']);
%     
%     load([save_path,'/neg_40_cort.mat']);
%     load([save_path,'/neg_140_cort.mat']);
%     load([save_path,'/neg_1000_cort.mat']);
%     
%     load([save_path,'/reb_40_cort.mat']);
%     load([save_path,'/reb_140_cort.mat']);
%     load([save_path,'/reb_1000_cort.mat']);
%     
%     base_cort_path = ['/home/hanlabadmins/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/Neocortex/Good_Recordings_Data_Files/'];
%     load([base_cort_path, 'non_mod_40_struct_s.mat']);
%     load([base_cort_path, 'non_mod_140_struct_s.mat']);
%     load([base_cort_path, 'non_mod_1000_struct_s.mat']);
%     non_40_cort = non_mod_40_s;
%     non_140_cort = non_mod_140_s;
%     non_1000_cort = non_mod_1000_s;
%     
    %% Construct the tables for fisher tests

    %======================== Within Hippocampus =========================%
    total_40_hip = numel(neg_mod_40_CA1.neurons(:,1))+numel(pos_mod_40_CA1.neurons(:,1))+numel(non_mod_40_CA1.neurons(:,1));
    total_140_hip = numel(neg_mod_140_CA1.neurons(:,1))+numel(pos_mod_140_CA1.neurons(:,1))+numel(non_mod_140_CA1.neurons(:,1));
    total_1000_hip = numel(neg_mod_1000_CA1.neurons(:,1))+numel(pos_mod_1000_CA1.neurons(:,1))+numel(non_mod_1000_CA1.neurons(:,1));
    
    %All modulated vs nonmodulated
    fisher_table.hip.mod(:,:,1) = [numel(neg_mod_40_CA1.neurons(:,1))+numel(pos_mod_40_CA1.neurons(:,1)), numel(non_mod_40_CA1.neurons(:,1));...
                                numel(neg_mod_140_CA1.neurons(:,1))+numel(pos_mod_140_CA1.neurons(:,1)),  numel(non_mod_140_CA1.neurons(:,1))];
    fisher_table.hip.mod(:,:,2) = [numel(neg_mod_40_CA1.neurons(:,1))+numel(pos_mod_40_CA1.neurons(:,1)), numel(non_mod_40_CA1.neurons(:,1));...
                                numel(neg_mod_1000_CA1.neurons(:,1))+numel(pos_mod_1000_CA1.neurons(:,1)),  numel(non_mod_1000_CA1.neurons(:,1))];
    fisher_table.hip.mod(:,:,3) = [numel(neg_mod_140_CA1.neurons(:,1))+numel(pos_mod_140_CA1.neurons(:,1)), numel(non_mod_140_CA1.neurons(:,1));...
                                numel(neg_mod_1000_CA1.neurons(:,1))+numel(pos_mod_1000_CA1.neurons(:,1)),  numel(non_mod_1000_CA1.neurons(:,1))];
                            
    %Positive vs not positively modulated
    fisher_table.hip.pos(:,:,1) = [numel(pos_mod_40_CA1.neurons(:,1)), numel(neg_mod_40_CA1.neurons(:,1))+numel(non_mod_40_CA1.neurons(:,1));...
                                numel(pos_mod_140_CA1.neurons(:,1)), numel(neg_mod_140_CA1.neurons(:,1))+numel(non_mod_140_CA1.neurons(:,1))];
    fisher_table.hip.pos(:,:,2) = [numel(pos_mod_40_CA1.neurons(:,1)), numel(neg_mod_40_CA1.neurons(:,1))+numel(non_mod_40_CA1.neurons(:,1));...
                                numel(pos_mod_1000_CA1.neurons(:,1)), numel(neg_mod_1000_CA1.neurons(:,1))+numel(non_mod_1000_CA1.neurons(:,1))];
    fisher_table.hip.pos(:,:,3) = [numel(pos_mod_140_CA1.neurons(:,1)), numel(neg_mod_140_CA1.neurons(:,1))+numel(non_mod_140_CA1.neurons(:,1));...
                                numel(pos_mod_1000_CA1.neurons(:,1)), numel(neg_mod_1000_CA1.neurons(:,1))+numel(non_mod_1000_CA1.neurons(:,1))];
                            
    %Negative vs not negatively modulated
    fisher_table.hip.neg(:,:,1) = [numel(neg_mod_40_CA1.neurons(:,1)), numel(pos_mod_40_CA1.neurons(:,1))+numel(non_mod_40_CA1.neurons(:,1));...
                                numel(neg_mod_140_CA1.neurons(:,1)), numel(pos_mod_140_CA1.neurons(:,1))+numel(non_mod_140_CA1.neurons(:,1))];
    fisher_table.hip.neg(:,:,2) = [numel(neg_mod_40_CA1.neurons(:,1)), numel(pos_mod_40_CA1.neurons(:,1))+numel(non_mod_40_CA1.neurons(:,1));...
                                numel(neg_mod_1000_CA1.neurons(:,1)), numel(pos_mod_1000_CA1.neurons(:,1))+numel(non_mod_1000_CA1.neurons(:,1))];
    fisher_table.hip.neg(:,:,3) = [numel(neg_mod_140_CA1.neurons(:,1)), numel(pos_mod_140_CA1.neurons(:,1))+numel(non_mod_140_CA1.neurons(:,1));...
                                numel(neg_mod_1000_CA1.neurons(:,1)), numel(pos_mod_1000_CA1.neurons(:,1))+numel(non_mod_1000_CA1.neurons(:,1))];

    %Rebound vs no rebound
    fisher_table.hip.reb(:,:,1) = [numel(rebound_40_CA1.neurons(1,:)), total_40_hip-numel(rebound_40_CA1.neurons(1,:)); ...
                               numel(rebound_140_CA1.neurons(1,:)), total_140_hip-numel(rebound_140_CA1.neurons(1,:))];
    fisher_table.hip.reb(:,:,2) = [numel(rebound_40_CA1.neurons(1,:)), total_40_hip-numel(rebound_40_CA1.neurons(1,:)); ...
                               numel(rebound_1000_CA1.neurons(1,:)), total_1000_hip-numel(rebound_1000_CA1.neurons(1,:))];
    fisher_table.hip.reb(:,:,3) = [numel(rebound_140_CA1.neurons(1,:)), total_140_hip-numel(rebound_140_CA1.neurons(1,:)); ...
                               numel(rebound_1000_CA1.neurons(1,:)), total_1000_hip-numel(rebound_1000_CA1.neurons(1,:))];
    
    %============================ Within Cortex ==========================%
    total_40_cort = numel(neg_mod_40_M1.neurons(:,1))+numel(pos_mod_40_M1.neurons(:,1))+numel(non_mod_40_M1.neurons(:,1));
    total_140_cort = numel(neg_mod_140_M1.neurons(:,1))+numel(pos_mod_140_M1.neurons(:,1))+numel(non_mod_140_M1.neurons(:,1));
    total_1000_cort = numel(neg_mod_1000_M1.neurons(:,1))+numel(pos_mod_1000_M1.neurons(:,1))+numel(non_mod_1000_M1.neurons(:,1));
    
    %All modulated vs nonmodulated
    fisher_table.cort.mod(:,:,1) = [numel(neg_mod_40_M1.neurons(:,1))+numel(pos_mod_40_M1.neurons(:,1)), numel(non_mod_40_M1.neurons(:,1));...
                                numel(neg_mod_140_M1.neurons(:,1))+numel(pos_mod_140_M1.neurons(:,1)),  numel(non_mod_140_M1.neurons(:,1))];
    fisher_table.cort.mod(:,:,2) = [numel(neg_mod_40_M1.neurons(:,1))+numel(pos_mod_40_M1.neurons(:,1)), numel(non_mod_40_M1.neurons(:,1));...
                                numel(neg_mod_1000_M1.neurons(:,1))+numel(pos_mod_1000_M1.neurons(:,1)),  numel(non_mod_1000_M1.neurons(:,1))];
    fisher_table.cort.mod(:,:,3) = [numel(neg_mod_140_M1.neurons(:,1))+numel(pos_mod_140_M1.neurons(:,1)), numel(non_mod_140_M1.neurons(:,1));...
                                numel(neg_mod_1000_M1.neurons(:,1))+numel(pos_mod_1000_M1.neurons(:,1)),  numel(non_mod_1000_M1.neurons(:,1))];
                            
    %Positive vs not positively modulated
    fisher_table.cort.pos(:,:,1) = [numel(pos_mod_40_M1.neurons(:,1)), numel(neg_mod_40_M1.neurons(:,1))+numel(non_mod_40_M1.neurons(:,1));...
                                numel(pos_mod_140_M1.neurons(:,1)), numel(neg_mod_140_M1.neurons(:,1))+numel(non_mod_140_M1.neurons(:,1))];
    fisher_table.cort.pos(:,:,2) = [numel(pos_mod_40_M1.neurons(:,1)), numel(neg_mod_40_M1.neurons(:,1))+numel(non_mod_40_M1.neurons(:,1));...
                                numel(pos_mod_1000_M1.neurons(:,1)), numel(neg_mod_1000_M1.neurons(:,1))+numel(non_mod_1000_M1.neurons(:,1))];
    fisher_table.cort.pos(:,:,3) = [numel(pos_mod_140_M1.neurons(:,1)), numel(neg_mod_140_M1.neurons(:,1))+numel(non_mod_140_M1.neurons(:,1));...
                                numel(pos_mod_1000_M1.neurons(:,1)), numel(neg_mod_1000_M1.neurons(:,1))+numel(non_mod_1000_M1.neurons(:,1))];
                            
    %Negative vs not negatively modulated
    fisher_table.cort.neg(:,:,1) = [numel(neg_mod_40_M1.neurons(:,1)), numel(pos_mod_40_M1.neurons(:,1))+numel(non_mod_40_M1.neurons(:,1));...
                                numel(neg_mod_140_M1.neurons(:,1)), numel(pos_mod_140_M1.neurons(:,1))+numel(non_mod_140_M1.neurons(:,1))];
    fisher_table.cort.neg(:,:,2) = [numel(neg_mod_40_M1.neurons(:,1)), numel(pos_mod_40_M1.neurons(:,1))+numel(non_mod_40_M1.neurons(:,1));...
                                numel(neg_mod_1000_M1.neurons(:,1)), numel(pos_mod_1000_M1.neurons(:,1))+numel(non_mod_1000_M1.neurons(:,1))];
    fisher_table.cort.neg(:,:,3) = [numel(neg_mod_140_M1.neurons(:,1)), numel(pos_mod_140_M1.neurons(:,1))+numel(non_mod_140_M1.neurons(:,1));...
                                numel(neg_mod_1000_M1.neurons(:,1)), numel(pos_mod_1000_M1.neurons(:,1))+numel(non_mod_1000_M1.neurons(:,1))];

    %Rebound vs no rebound
    fisher_table.cort.reb(:,:,1) = [numel(rebound_40_M1.neurons(1,:)), total_40_cort-numel(rebound_40_M1.neurons(1,:)); ...
                               numel(rebound_140_M1.neurons(1,:)), total_140_cort-numel(rebound_140_M1.neurons(1,:))];
    fisher_table.cort.reb(:,:,2) = [numel(rebound_40_M1.neurons(1,:)), total_40_cort-numel(rebound_40_M1.neurons(1,:)); ...
                               numel(rebound_1000_M1.neurons(1,:)), total_1000_cort-numel(rebound_1000_M1.neurons(1,:))];
    fisher_table.cort.reb(:,:,3) = [numel(rebound_140_M1.neurons(1,:)), total_140_cort-numel(rebound_140_M1.neurons(1,:)); ...
                               numel(rebound_1000_M1.neurons(1,:)), total_1000_cort-numel(rebound_1000_M1.neurons(1,:))];
    
    %======================= 40Hz Across Regions =========================%
     fisher_table.hz40.mod(:,:,1) = [numel(neg_mod_40_CA1.neurons(:,1))+numel(pos_mod_40_CA1.neurons(:,1)), numel(non_mod_40_CA1.neurons(:,1));...
                                numel(neg_mod_40_M1.neurons(:,1))+numel(pos_mod_40_M1.neurons(:,1)),  numel(non_mod_40_M1.neurons(:,1))];
     
    fisher_table.hz40.pos(:,:,1) = [numel(pos_mod_40_CA1.neurons(:,1)), numel(neg_mod_40_CA1.neurons(:,1))+numel(non_mod_40_CA1.neurons(:,1));...
                                numel(pos_mod_40_M1.neurons(:,1)), numel(neg_mod_40_M1.neurons(:,1))+numel(non_mod_40_M1.neurons(:,1))];
                            
    fisher_table.hz40.neg(:,:,1) = [numel(neg_mod_40_CA1.neurons(:,1)), numel(pos_mod_40_CA1.neurons(:,1))+numel(non_mod_40_CA1.neurons(:,1));...
                            numel(neg_mod_40_M1.neurons(:,1)), numel(pos_mod_40_M1.neurons(:,1))+numel(non_mod_40_M1.neurons(:,1))];
    
    fisher_table.hz40.reb(:,:,1) = [numel(rebound_40_CA1.neurons(1,:)), total_40_hip-numel(rebound_40_CA1.neurons(1,:)); ...
                            numel(rebound_40_M1.neurons(1,:)), total_40_cort-numel(rebound_40_M1.neurons(1,:))];

    %====================== 140Hz Across Regions =========================%
     fisher_table.hz140.mod(:,:,1) = [numel(neg_mod_140_CA1.neurons(:,1))+numel(pos_mod_140_CA1.neurons(:,1)), numel(non_mod_140_CA1.neurons(:,1));...
                                numel(neg_mod_140_M1.neurons(:,1))+numel(pos_mod_140_M1.neurons(:,1)),  numel(non_mod_140_M1.neurons(:,1))];
     
    fisher_table.hz140.pos(:,:,1) = [numel(pos_mod_140_CA1.neurons(:,1)), numel(neg_mod_140_CA1.neurons(:,1))+numel(non_mod_140_CA1.neurons(:,1));...
                                numel(pos_mod_140_M1.neurons(:,1)), numel(neg_mod_140_M1.neurons(:,1))+numel(non_mod_140_M1.neurons(:,1))];
                            
    fisher_table.hz140.neg(:,:,1) = [numel(neg_mod_140_CA1.neurons(:,1)), numel(pos_mod_140_CA1.neurons(:,1))+numel(non_mod_140_CA1.neurons(:,1));...
                            numel(neg_mod_140_M1.neurons(:,1)), numel(pos_mod_140_M1.neurons(:,1))+numel(non_mod_140_M1.neurons(:,1))];
    
    fisher_table.hz140.reb(:,:,1) = [numel(rebound_140_CA1.neurons(1,:)), total_140_hip-numel(rebound_140_CA1.neurons(1,:)); ...
                            numel(rebound_140_M1.neurons(1,:)), total_140_cort-numel(rebound_140_M1.neurons(1,:))];
    %======================= 1000Hz Across Regions =======================% 
    fisher_table.hz1000.mod(:,:,1) = [numel(neg_mod_1000_CA1.neurons(:,1))+numel(pos_mod_1000_CA1.neurons(:,1)), numel(non_mod_1000_CA1.neurons(:,1));...
                                numel(neg_mod_1000_M1.neurons(:,1))+numel(pos_mod_1000_M1.neurons(:,1)),  numel(non_mod_140_M1.neurons(:,1))];
     
    fisher_table.hz1000.pos(:,:,1) = [numel(pos_mod_1000_CA1.neurons(:,1)), numel(neg_mod_1000_CA1.neurons(:,1))+numel(non_mod_1000_CA1.neurons(:,1));...
                                numel(pos_mod_1000_M1.neurons(:,1)), numel(neg_mod_1000_M1.neurons(:,1))+numel(non_mod_1000_M1.neurons(:,1))];
                            
    fisher_table.hz1000.neg(:,:,1) = [numel(neg_mod_1000_CA1.neurons(:,1)), numel(pos_mod_1000_CA1.neurons(:,1))+numel(non_mod_1000_CA1.neurons(:,1));...
                            numel(neg_mod_1000_M1.neurons(:,1)), numel(pos_mod_1000_M1.neurons(:,1))+numel(non_mod_1000_M1.neurons(:,1))];
    
    fisher_table.hz1000.reb(:,:,1) = [numel(rebound_1000_CA1.neurons(1,:)), total_1000_hip-numel(rebound_1000_CA1.neurons(1,:)); ...
                            numel(rebound_1000_M1.neurons(1,:)), total_1000_cort-numel(rebound_1000_M1.neurons(1,:))];
    %% Fisher Test
    for i=1:3
        %CA1
        [h_fisher.hip.mod(i),p_fisher.hip.mod(i),stats_fisher.hip.mod(i)] = fishertest(fisher_table.hip.mod(:,:,i));
        [h_fisher.hip.pos(i),p_fisher.hip.pos(i),stats_fisher.hip.pos(i)] = fishertest(fisher_table.hip.pos(:,:,i));
        [h_fisher.hip.neg(i),p_fisher.hip.neg(i),stats_fisher.hip.neg(i)] = fishertest(fisher_table.hip.neg(:,:,i));
        [h_fisher.hip.reb(i),p_fisher.hip.reb(i),stats_fisher.hip.reb(i)] = fishertest(fisher_table.hip.reb(:,:,i));
        
        %M1
        [h_fisher.cort.mod(i),p_fisher.cort.mod(i),stats_fisher.cort.mod(i)] = fishertest(fisher_table.cort.mod(:,:,i));
        [h_fisher.cort.pos(i),p_fisher.cort.pos(i),stats_fisher.cort.pos(i)] = fishertest(fisher_table.cort.pos(:,:,i));
        [h_fisher.cort.neg(i),p_fisher.cort.neg(i),stats_fisher.cort.neg(i)] = fishertest(fisher_table.cort.neg(:,:,i));
        [h_fisher.cort.reb(i),p_fisher.cort.reb(i),stats_fisher.cort.reb(i)] = fishertest(fisher_table.cort.reb(:,:,i));

    end
    %40Hz
        [h_fisher.hz40.mod(1),p_fisher.hz40.mod(1),stats_fisher.hz40.mod(1)] = fishertest(fisher_table.hz40.mod(:,:,1));
        [h_fisher.hz40.pos(1),p_fisher.hz40.pos(1),stats_fisher.hz40.pos(1)] = fishertest(fisher_table.hz40.pos(:,:,1));
        [h_fisher.hz40.neg(1),p_fisher.hz40.neg(1),stats_fisher.hz40.neg(1)] = fishertest(fisher_table.hz40.neg(:,:,1));
        [h_fisher.hz40.reb(1),p_fisher.hz40.reb(1),stats_fisher.hz40.reb(1)] = fishertest(fisher_table.hz40.reb(:,:,1));
        
        %140Hz
        [h_fisher.hz140.mod(1),p_fisher.hz140.mod(1),stats_fisher.hz140.mod(1)] = fishertest(fisher_table.hz140.mod(:,:,1));
        [h_fisher.hz140.pos(1),p_fisher.hz140.pos(1),stats_fisher.hz140.pos(1)] = fishertest(fisher_table.hz140.pos(:,:,1));
        [h_fisher.hz140.neg(1),p_fisher.hz140.neg(1),stats_fisher.hz140.neg(1)] = fishertest(fisher_table.hz140.neg(:,:,1));
        [h_fisher.hz140.reb(1),p_fisher.hz140.reb(1),stats_fisher.hz140.reb(1)] = fishertest(fisher_table.hz140.reb(:,:,1));
        
        %1000Hz
        [h_fisher.hz1000.mod(1),p_fisher.hz1000.mod(1),stats_fisher.hz1000.mod(1)] = fishertest(fisher_table.hz1000.mod(:,:,1));
        [h_fisher.hz1000.pos(1),p_fisher.hz1000.pos(1),stats_fisher.hz1000.pos(1)] = fishertest(fisher_table.hz1000.pos(:,:,1));
        [h_fisher.hz1000.neg(1),p_fisher.hz1000.neg(1),stats_fisher.hz1000.neg(1)] = fishertest(fisher_table.hz1000.neg(:,:,1));
        [h_fisher.hz1000.reb(1),p_fisher.hz1000.reb(1),stats_fisher.hz1000.reb(1)] = fishertest(fisher_table.hz1000.reb(:,:,1));
end