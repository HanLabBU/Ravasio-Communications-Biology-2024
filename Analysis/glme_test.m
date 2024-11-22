% glme_test.m
% Date: 07/13/23
% Author: Cara
% Purpose: I tested a lot of different iterations of the generalized linear
% mixed effects model. Setting the table and equation up to answer the
% question you are specifically trying to answer is extremely important.
% Interpreting the results and their significance is difficult ( more
% difficult than a glm). Look at RSquared in model object for goodness of
% fit. As set up right now, glme_auc_1000 accounts for ~46% of variance,
% and the glme_auc+40 amd glme_auc_140 each only account for ~26% of
% variance. The rest of the variance of the data in the model is
% unexplained by the categories/variables I have provided. Use CoefTest to
% evaluate whether the difference between to conditions is significant
% (i.e. whether CA1 vs Cortex has a significant difference for the
% nonmodulated neuron population)
%
% 07/13/23: I have decided it is not worth all the effort to use a glme.
%
% 08/29/23: Xue has decided it is worth all the effort to use a glme.
%% Overall average trace box plots - Mixed Effect Model
% Calculate AUC and time-to-peak for every neuron's average trace and
% create a table with all of the necessary information for each neuron
% ('observation')
% 40Hz  = 1; 140Hz = 2; 1000Hz = 3;
% CA1 = 1; M1 = 2;
% non = 0; pos = 1; neg = 2;
% every single recording gets its own unique ID #
% neuron ('observation') order is non, pos,neg -> 40,140,1000 -> CA1, M1

%- Basic Setup -%
Fs = 20; %Hz
%useful for later on mouseID categorical variable
mouse_names= {'617428','617429','14133','14138','14139','607614','607631','23114','50354','50439','51546','31617','43484','47125'};

%- Table Setup -%
num_40_CA1_neurons = size(non_mod_40_CA1.neurons,1)+size(neg_mod_40_CA1.neurons,1)+size(pos_mod_40_CA1.neurons,1);
num_40_CA1_recs = max([non_mod_40_CA1.neurons(:,1)',neg_mod_40_CA1.neurons(:,1)',pos_mod_40_CA1.neurons(:,1)']);
num_140_CA1_neurons = size(non_mod_140_CA1.neurons,1)+size(neg_mod_140_CA1.neurons,1)+size(pos_mod_140_CA1.neurons,1);
num_140_CA1_recs = max([non_mod_140_CA1.neurons(:,1)',neg_mod_140_CA1.neurons(:,1)',pos_mod_140_CA1.neurons(:,1)']);
num_1000_CA1_neurons = size(non_mod_1000_CA1.neurons,1)+size(neg_mod_1000_CA1.neurons,1)+size(pos_mod_1000_CA1.neurons,1);
num_1000_CA1_recs = max([non_mod_1000_CA1.neurons(:,1)',neg_mod_1000_CA1.neurons(:,1)',pos_mod_1000_CA1.neurons(:,1)']);

num_40_M1_neurons = size(non_mod_40_M1.neurons,1)+size(neg_mod_40_M1.neurons,1)+size(pos_mod_40_M1.neurons,1);
num_40_M1_recs = max([non_mod_40_M1.neurons(:,1)',neg_mod_40_M1.neurons(:,1)',pos_mod_40_M1.neurons(:,1)']);
num_140_M1_neurons = size(non_mod_140_M1.neurons,1)+size(neg_mod_140_M1.neurons,1)+size(pos_mod_140_M1.neurons,1);
num_140_M1_recs = max([non_mod_140_M1.neurons(:,1)',neg_mod_140_M1.neurons(:,1)',pos_mod_140_M1.neurons(:,1)']);
num_1000_M1_neurons = size(non_mod_1000_M1.neurons,1)+size(neg_mod_1000_M1.neurons,1)+size(pos_mod_1000_M1.neurons,1);
num_1000_M1_recs = max([non_mod_1000_M1.neurons(:,1)',neg_mod_1000_M1.neurons(:,1)',pos_mod_1000_M1.neurons(:,1)']);

%- Table Setup for all neurons all together -%
% offset1 = num_40_CA1_recs;
% offset2 = num_40_CA1_recs + num_140_CA1_recs;
% offset3 = num_40_CA1_recs + num_140_CA1_recs + num_1000_CA1_recs;
% offset4 = num_40_CA1_recs + num_140_CA1_recs + num_1000_CA1_recs + num_40_M1_recs;
% offset5 = num_40_CA1_recs + num_140_CA1_recs + num_1000_CA1_recs + num_40_M1_recs + num_140_M1_recs;
% 
% frequency = num2str([1*ones(1,num_40_CA1_neurons),2*ones(1,num_140_CA1_neurons),3*ones(1,num_1000_CA1_neurons),...
%              1*ones(1,num_40_M1_neurons),2*ones(1,num_140_M1_neurons),3*ones(1,num_1000_M1_neurons)]');
%          
% region = num2str([1*ones(1,(num_40_CA1_neurons+num_140_CA1_neurons+num_1000_CA1_neurons)),...
%           2*ones(1,(num_40_M1_neurons+num_140_M1_neurons+num_1000_M1_neurons))]');
%       
% recording = num2str([non_mod_40_CA1.neurons(:,1)',pos_mod_40_CA1.neurons(:,1)',neg_mod_40_CA1.neurons(:,1)'...
%             non_mod_140_CA1.neurons(:,1)'+offset1,pos_mod_140_CA1.neurons(:,1)'+offset1,neg_mod_140_CA1.neurons(:,1)'+offset1,...
%             non_mod_1000_CA1.neurons(:,1)'+offset2,pos_mod_1000_CA1.neurons(:,1)'+offset2,neg_mod_1000_CA1.neurons(:,1)'+offset2,...
%             non_mod_40_M1.neurons(:,1)'+offset3,pos_mod_40_M1.neurons(:,1)'+offset3,neg_mod_40_M1.neurons(:,1)'+offset3...
%             non_mod_140_M1.neurons(:,1)'+offset4,pos_mod_140_M1.neurons(:,1)'+offset4,neg_mod_140_M1.neurons(:,1)'+offset4,...
%             non_mod_1000_M1.neurons(:,1)'+offset5,pos_mod_1000_M1.neurons(:,1)'+offset5,neg_mod_1000_M1.neurons(:,1)'+offset5]');
%  
% mod_ID = num2str([0*ones(1,size(non_mod_40_CA1.neurons,1)),1*ones(1,size(pos_mod_40_CA1.neurons,1)),2*ones(1,size(neg_mod_40_CA1.neurons,1)),...
%           0*ones(1,size(non_mod_140_CA1.neurons,1)),1*ones(1,size(pos_mod_140_CA1.neurons,1)),2*ones(1,size(neg_mod_140_CA1.neurons,1)),...
%           0*ones(1,size(non_mod_1000_CA1.neurons,1)),1*ones(1,size(pos_mod_1000_CA1.neurons,1)),2*ones(1,size(neg_mod_1000_CA1.neurons,1)),...
%           0*ones(1,size(non_mod_40_M1.neurons,1)),1*ones(1,size(pos_mod_40_M1.neurons,1)),2*ones(1,size(neg_mod_40_M1.neurons,1)),...
%           0*ones(1,size(non_mod_140_M1.neurons,1)),1*ones(1,size(pos_mod_140_M1.neurons,1)),2*ones(1,size(neg_mod_140_M1.neurons,1)),...
%           0*ones(1,size(non_mod_1000_M1.neurons,1)),1*ones(1,size(pos_mod_1000_M1.neurons,1)),2*ones(1,size(neg_mod_1000_M1.neurons,1))]');
%       
% all_traces = [non_mod_40_CA1.traces;pos_mod_40_CA1.traces;neg_mod_40_CA1.traces;...
%           non_mod_140_CA1.traces;pos_mod_140_CA1.traces;neg_mod_140_CA1.traces;...
%           non_mod_1000_CA1.traces;pos_mod_1000_CA1.traces;neg_mod_1000_CA1.traces;...
%           non_mod_40_M1.traces;pos_mod_40_M1.traces;neg_mod_40_M1.traces;...
%           non_mod_140_M1.traces;pos_mod_140_M1.traces;neg_mod_140_M1.traces;...
%           non_mod_1000_M1.traces;pos_mod_1000_M1.traces;neg_mod_1000_M1.traces];
% all_smooth_traces = smoothdata(all_traces,2);
% 
% auc = trapz(all_smooth_traces(:,5*Fs:end),2);
% tbl = table(auc,frequency,region,mod_ID,recording);

%- Table for 40Hz Alone-%
region_40 = [1*ones(1,num_40_CA1_neurons),2*ones(1,num_40_M1_neurons)]';
region_40 = discretize(region_40,[1:3],'categorical',{'CA1','M1'});
recording_40 = [non_mod_40_CA1.neurons(:,1)',pos_mod_40_CA1.neurons(:,1)',neg_mod_40_CA1.neurons(:,1)'...
                    non_mod_40_M1.neurons(:,1)'+num_40_CA1_recs,pos_mod_40_M1.neurons(:,1)'+num_40_CA1_recs,neg_mod_40_M1.neurons(:,1)'+num_40_CA1_recs]';
mod_ID_40 = [0*ones(1,size(non_mod_40_CA1.neurons,1)),1*ones(1,size(pos_mod_40_CA1.neurons,1)),2*ones(1,size(neg_mod_40_CA1.neurons,1)),...
                 0*ones(1,size(non_mod_40_M1.neurons,1)),1*ones(1,size(pos_mod_40_M1.neurons,1)),2*ones(1,size(neg_mod_40_M1.neurons,1))]';
mod_ID_40 = discretize(mod_ID_40, [0:3],'categorical',{'non','pos','neg'});

mask_1 = 1*((recording_40 == 1) + (recording_40 == 2) + (recording_40 == 3));
mask_2 = 2*((recording_40 == 4) + (recording_40 == 5));
mask_3 = 3*((recording_40 == 6) + (recording_40 == 7) + (recording_40 == 8) + (recording_40 == 9) + (recording_40 == 10) + (recording_40 == 11));
mask_4 = 4*((recording_40 == 12) + (recording_40 == 13) + (recording_40 == 14) + (recording_40 == 15) + (recording_40 == 16) + (recording_40 == 17) +(recording_40 == 18)); 
mask_5 = 5*((recording_40 == 19) + (recording_40 == 20) + (recording_40 == 21));
mask_6 = 6*((recording_40 == 22) + (recording_40 == 23) + (recording_40 == 24));
mask_7 = 7*((recording_40 == 25) + (recording_40 == 26) + (recording_40 == 27));
mask_8 = 8*((recording_40 == 28) + (recording_40 == 29));
mask_9 = 9*((recording_40 == 30) + (recording_40 == 31) + (recording_40 == 32));
mask_10 = 10*((recording_40 == 33));
mask_11 = 11*((recording_40 == 34) + (recording_40 == 35));
mouse_40 = sum([mask_1,mask_2,mask_3,mask_4,mask_5,mask_6,mask_7,mask_8,mask_9,mask_10,mask_11],2);
mouse_40 = discretize(mouse_40,[1:numel(mouse_names)+1],'categorical',mouse_names);

pre = 'rec';
names = {};
for k = min(recording_40):max(recording_40)
    names = [names;strcat(pre,num2str(k,'%02d'))];
end
recording_40 = discretize(recording_40,[min(recording_40):max(recording_40)+1],'categorical', names); %Note: discrteize defaults to left inclusive bin edges

traces_40 =  [non_mod_40_CA1.traces;pos_mod_40_CA1.traces;neg_mod_40_CA1.traces;... 
               non_mod_40_M1.traces;pos_mod_40_M1.traces;neg_mod_40_M1.traces];
smooth_traces_40 = smoothdata(traces_40,2);


%- Table for 140Hz Alone-%
region_140 = [1*ones(1,num_140_CA1_neurons),2*ones(1,num_140_M1_neurons)]';
region_140 = discretize(region_140,[1:3],'categorical',{'CA1','M1'});
recording_140 = [non_mod_140_CA1.neurons(:,1)',pos_mod_140_CA1.neurons(:,1)',neg_mod_140_CA1.neurons(:,1)'...
                    non_mod_140_M1.neurons(:,1)'+num_140_CA1_recs,pos_mod_140_M1.neurons(:,1)'+num_140_CA1_recs,neg_mod_140_M1.neurons(:,1)'+num_140_CA1_recs]';
mod_ID_140 = [0*ones(1,size(non_mod_140_CA1.neurons,1)),1*ones(1,size(pos_mod_140_CA1.neurons,1)),2*ones(1,size(neg_mod_140_CA1.neurons,1)),...
                 0*ones(1,size(non_mod_140_M1.neurons,1)),1*ones(1,size(pos_mod_140_M1.neurons,1)),2*ones(1,size(neg_mod_140_M1.neurons,1))]';
mod_ID_140 = discretize(mod_ID_140, [0:3],'categorical',{'non','pos','neg'});

mask_1 = 1*((recording_140 == 1) + (recording_140 == 2));
mask_2 = 2*((recording_140 == 3) + (recording_140 == 4) + (recording_140 == 5));
mask_3 = 3*((recording_140 == 6) + (recording_140 == 7) + (recording_140 == 8) + (recording_140 == 9) + (recording_140 == 10) + (recording_140 == 11) + (recording_140 == 12));
mask_4 = 4*((recording_140 == 13) + (recording_140 == 14) + (recording_140 == 15) + (recording_140 == 16) + (recording_140 == 17) +(recording_140 == 18) + (recording_140 == 19)); 
mask_5 = 5*((recording_140 == 20) + (recording_140 == 21));
mask_6 = 6*((recording_140 == 22) + (recording_140 == 23));
mask_7 = 7*((recording_140 == 24) + (recording_140 == 25) + (recording_140 == 26));
mask_8 = 8*((recording_140 == 27) + (recording_140 == 28) + (recording_140 == 29));
mask_9 = 9*((recording_140 == 30) + (recording_140 == 31));
mask_10 = 10*((recording_140 == 32) + (recording_140 == 33) + (recording_140 == 34));
mask_11 = 11*((recording_140 == 35) + (recording_140 == 36));
mouse_140 = sum([mask_1,mask_2,mask_3,mask_4,mask_5,mask_6,mask_7,mask_8,mask_9,mask_10,mask_11],2);
mouse_140 = discretize(mouse_140,[1:numel(mouse_names)+1],'categorical',mouse_names);

pre = 'rec';
names = {};
for k = min(recording_140):max(recording_140)
    names = [names;strcat(pre,num2str(k,'%02d'))];
end
recording_140 = discretize(recording_140,[min(recording_140):max(recording_140)+1],'categorical', names); %Note: discrteize defaults to left inclusive bin edges

traces_140 =  [non_mod_140_CA1.traces;pos_mod_140_CA1.traces;neg_mod_140_CA1.traces;... 
               non_mod_140_M1.traces;pos_mod_140_M1.traces;neg_mod_140_M1.traces];
smooth_traces_140 = smoothdata(traces_140,2);

    
%- Table for 1000Hz Alone-%
region_1000 = [1*ones(1,num_1000_CA1_neurons),2*ones(1,num_1000_M1_neurons)]';
region_1000 = discretize(region_1000,[1:3],'categorical',{'CA1','M1'});
recording_1000 = [non_mod_1000_CA1.neurons(:,1)',pos_mod_1000_CA1.neurons(:,1)',neg_mod_1000_CA1.neurons(:,1)'...
                    non_mod_1000_M1.neurons(:,1)'+num_1000_CA1_recs,pos_mod_1000_M1.neurons(:,1)'+num_1000_CA1_recs,neg_mod_1000_M1.neurons(:,1)'+num_1000_CA1_recs]';
mod_ID_1000 = [0*ones(1,size(non_mod_1000_CA1.neurons,1)),1*ones(1,size(pos_mod_1000_CA1.neurons,1)),2*ones(1,size(neg_mod_1000_CA1.neurons,1)),...
                 0*ones(1,size(non_mod_1000_M1.neurons,1)),1*ones(1,size(pos_mod_1000_M1.neurons,1)),2*ones(1,size(neg_mod_1000_M1.neurons,1))]';
mod_ID_1000 = discretize(mod_ID_1000, [0:3],'categorical',{'non','pos','neg'});

mask_1 = 3*((recording_1000 == 1) + (recording_1000 == 2) + (recording_1000 == 3));
mask_2 = 4*((recording_1000 == 4) + (recording_1000 == 5) + (recording_1000 == 6) + (recording_1000 == 7) + (recording_1000 == 8) + (recording_1000 == 9) + (recording_1000 == 10));
mask_3 = 12*((recording_1000 == 11) + (recording_1000 == 12) + (recording_1000 == 13) + (recording_1000 == 14) + (recording_1000 == 15) + (recording_1000 == 16));
mask_4 = 13*((recording_1000 == 17) + (recording_1000 == 18) + (recording_1000 == 19)); 
mask_5 = 14*((recording_1000 == 20) + (recording_1000 == 21) + (recording_1000 == 22));
mask_6 = 6*((recording_1000 == 23));
mask_7 = 8*((recording_1000 == 24) + (recording_1000 == 25) + (recording_1000 == 26));
mask_8 = 9*((recording_1000 == 27) + (recording_1000 == 28));
mask_9 = 10*((recording_1000 == 29) + (recording_1000 == 30));
mask_10 = 11*((recording_1000 == 31) + (recording_1000 == 32));
mouse_1000 = sum([mask_1,mask_2,mask_3,mask_4,mask_5,mask_6,mask_7,mask_8,mask_9,mask_10],2);
mouse_1000 = discretize(mouse_1000,[1:numel(mouse_names)+1],'categorical',mouse_names);

pre = 'rec';
names = {};
for k = min(recording_1000):max(recording_1000)
    names = [names;strcat(pre,num2str(k,'%02d'))];
end
recording_1000 = discretize(recording_1000,[min(recording_1000):max(recording_1000)+1],'categorical', names); %Note: discrteize defaults to left inclusive bin edges

traces_1000 =  [non_mod_1000_CA1.traces;pos_mod_1000_CA1.traces;neg_mod_1000_CA1.traces;... 
               non_mod_1000_M1.traces;pos_mod_1000_M1.traces;neg_mod_1000_M1.traces];
smooth_traces_1000 = smoothdata(traces_1000,2);

%% Evaluating GLMEs between regions with all neurons
%Generalized linear model fit (random and fixed intercept)
% Fixed effects: modulation ID and region (categorical)
% Random effects: recording and mouse (categorical)

%- 40Hz -%
auc = trapz(smooth_traces_40(:,5*Fs:end),2);
tbl_40 = table(region_40,mod_ID_40,recording_40,mouse_40,auc);
glme_auc_40 = fitglme(tbl_40, 'auc ~ mod_ID_40*region_40 + (1|recording_40)+ (1|mouse_40)',...
        'Distribution','Normal','Link','identity','FitMethod','Laplace',...
        'DummyVarCoding','effects')
    
%- 140Hz -%
auc = trapz(smooth_traces_140(:,5*Fs:end),2);
tbl_140 = table(region_140,mod_ID_140,recording_140,mouse_140,auc);
glme_auc_140 = fitglme(tbl_140, 'auc ~ mod_ID_140*region_140 + (1|recording_140) + (1|mouse_140)',...
        'Distribution','Normal','Link','identity','FitMethod','Laplace',...
        'DummyVarCoding','effects')

%- 1000Hz -%
auc = trapz(smooth_traces_1000(:,5*Fs:end),2);
tbl_1000 = table(region_1000,mod_ID_1000,recording_1000,mouse_1000,auc);
glme_auc_1000 = fitglme(tbl_1000, 'auc ~ mod_ID_1000*region_1000 + (1|recording_1000) + (1|mouse_1000)',...
        'Distribution','Normal','Link','identity','FitMethod','Laplace',...
        'DummyVarCoding','effects')   
anova(glme_auc_1000)

%% Evaluating GLMEs if there was a significant "interaction" term in full neuron analysis

%- 40Hz -%
% positive modulation *No signifcant differences across regions
glme_auc_40_pos = fitglme(tbl_40(ismember(tbl_40.mod_ID_40, {'pos'}),[1,3:end]),...
                        'auc ~ -1 + region_40 + (1|recording_40) + (1|mouse_40)',...
                        'Distribution','Normal','Link','identity','FitMethod','Laplace',...
                        'DummyVarCoding','reference')
% negative modulation *Came out as significant across regions
glme_auc_40_neg = fitglme(tbl_40(ismember(tbl_40.mod_ID_40, {'neg'}),[1,3:end]),...
                        'auc ~ -1 + region_40 + (1|recording_40) + (1|mouse_40)',...
                        'Distribution','Normal','Link','identity','FitMethod','Laplace',...
                        'DummyVarCoding','effects')

%- 140Hz -%
% positive modulation *No signifcant differences across regions
glme_auc_140_pos = fitglme(tbl_140(ismember(tbl_140.mod_ID_140, {'pos'}),[1,3:end]),...
                        'auc ~ -1 + region_140 + (1|recording_140) + (1|mouse_140)',...
                        'Distribution','Normal','Link','identity','FitMethod','Laplace',...
                        'DummyVarCoding','effects')
                    
% negative modulation *Came out as significant across regions (*WITH AN
% INTERCEPT BUT NOT WITHOUT)
glme_auc_140_neg = fitglme(tbl_140(ismember(tbl_140.mod_ID_140, {'neg'}),[1,3:end]),...
                        'auc ~ 1 + region_140 + (1|recording_140) + (1|mouse_140)',...
                        'Distribution','Normal','Link','identity','FitMethod','Laplace',...
                        'DummyVarCoding','reference')
                    
%- 1000Hz -%
% positive modulation *M1 has a significant effect but not CA1?? Is it a
% probability thing?
glme_auc_1000_pos = fitglme(tbl_1000(ismember(tbl_1000.mod_ID_1000, {'pos'}),[1,3:end]),...
                        'auc ~ -1 + region_1000 + (1|recording_1000) + (1|mouse_1000)',...
                        'Distribution','Normal','Link','identity','FitMethod','Laplace',...
                        'DummyVarCoding','reference')
                    
% negative modulation *No signifcant differences across regions
glme_auc_1000_neg = fitglme(tbl_1000(ismember(tbl_1000.mod_ID_1000, {'neg'}),[1,3:end]),...
                        'auc ~ -1 + region_1000 + (1|recording_1000) + (1|mouse_1000)',...
                        'Distribution','Normal','Link','identity','FitMethod','Laplace',...
                        'DummyVarCoding','reference')