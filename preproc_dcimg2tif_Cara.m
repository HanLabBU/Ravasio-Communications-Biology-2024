% preprocess_dcimg2tif_Cara.m
% Author: Cara R adapted from Eric L
% Date: 11/11/21
% Purpose: Turn .dcimg into tiff files

clear

%% Setup
addpath(genpath('~/handata_server/EricLowet/Scripts'));
% base_path = '~/handata_server/Cara_Ravasio/Data/GCaMP_Data_Extraction/CA1';%/media/hanlabadmins/Elements/DBS/Hippocampus/GCaMP/'; %CHANGE IF NECESSARY
% cd(base_path);
% {'mouse', rec, fov, 'file save name', max_T}
% folder_names = {{'C00014133', 1, 1, 'fov1_10000_45_',1}};

%CA1 folder names
% {{'617428', 6, 1, 'fov1_40_150_',20},{'617428', 11, 1, 'fov1_40_90_',11},...
%     {'617428', 11, 1, 'fov1_140_70_',10},{'617428', 12, 1, 'fov1_40_80_',10},...
%     {'617428', 12, 1, 'fov1_140_70_',10},{'617429', 2, 1, 'fov1_40_25_',10},...
%     {'617429', 2, 1, 'fov1_140_25_',10},...
%     {'617429', 3, 1, 'fov1_40_35_',10},{'617429', 3, 1, 'fov1_140_25_',10},...
%     {'617429', 5, 1, 'fov1_140_15_',11},{'C00014138', 2, 1, 'fov1_40_30_',10},...
%     {'C00014138', 2, 1, 'fov1_140_20_',10},{'C00014138', 3, 1, 'fov1_40_30_',10},...
%     {'C00014138', 3, 1, 'fov1_140_25_',9},{'C00014138', 4, 1, 'fov1_40_30_',10},...
%     {'C00014138', 4, 1, 'fov1_140_25_',10},{'C00014138', 5, 1, 'fov1_40_30_',10},...
%     {'C00014138', 6, 1, 'fov1_40_30_',10},{'C00014138', 6, 1, 'fov1_140_25_',10},...
%     {'C00014138', 7, 1, 'fov1_40_30_',10},{'C00014138', 7, 1, 'fov1_140_25_',10},...
%     {'C00014138', 7, 2, 'fov2_140_25_',10},{'C00014138', 7, 2, 'fov2_40_30_',10},...
%     {'C00014138', 9, 1, 'fov1_1000_20_',20},{'C00014138', 10, 1, 'fov1_1000_20_',10},...
%     {'C00014138', 10, 2, 'fov2_1000_20_',10},{'C00014138', 10, 3, 'fov3_1000_20_',10},...
%     {'C00014138', 11, 1, 'fov1_1000_20_',10},{'C00014138', 12, 1, 'fov1_1000_15_',10},...
%     {'C00014138', 12, 1, 'fov1_1000_20_',9},{'C00014133', 1, 1, 'fov1_40_10_',20},...
%     {'C00014133', 2, 1, 'fov1_140_5_',15},{'C00014133', 3, 1, 'fov1_40_10_',20},...
%     {'C00014133', 4, 1, 'fov1_140_10_',20},...
%     {'C00014133', 5, 1, 'fov1_40_7_',20},{'C00014133', 5, 1, 'fov1_140_5_',20},...
%     {'C00014133', 6, 1, 'fov1_140_10_',10},{'C00014133', 8, 1, 'fov1_40_7_',10},...
%     {'C00014133', 8, 1, 'fov1_140_5_',9},{'C00014133', 9, 1, 'fov1_40_10_',10},...
%     {'C00014133', 9, 1, 'fov1_140_7_',10},{'C00014133', 10, 2, 'fov2_40_10_',10},...
%     {'C00014133', 10, 2, 'fov2_140_7_',10},{'C00014133', 11, 1, 'fov1_1000_5_',10},...
%     {'C00014133', 12, 1, 'fov1_1000_5_',10},{'C00014133', 13, 1, 'fov1_1000_7_',10},...
%     {'C00014139', 1, 1, 'fov1_40_17_',20},{'C00014139', 2, 1, 'fov1_140_10_',20},...
%     {'C00014139', 3, 1, 'fov1_40_15_',20},{'C00014139', 3, 1, 'fov1_140_10_',20},...
%     {'C00014139', 4, 1, 'fov1_40_15_',20},{'C00031617', 1, 1, 'fov1_1000_45_',15},...
%     {'C00031617', 1, 2, 'fov2_1000_45_',15},{'C00031617', 1, 3, 'fov3_1000_45_',15},...
%     {'C00031617', 2, 1, 'fov1_1000_45_',14},{'C00031617', 3, 1, 'fov1_1000_65_',15},...
%     {'C00031617', 4, 1, 'fov1_1000_45_',15},{'C00047125', 1, 1, 'fov1_1000_90_',15},...
%     {'C00047125', 2, 1, 'fov1_1000_75_',15},{'C00047125', 3, 1, 'fov1_1000_70_',15},...
%     {'C00043484', 1, 1, 'fov1_1000_60_',15},{'C00043484', 2, 1, 'fov1_1000_80_',15},...
%     {'C00043484', 3, 1, 'fov1_1000_80_',15}};

%M1 folder names
% {{'C00023114', 2, 2, 'fov2_140_70_',15},{'C00023114', 3, 2, 'fov2_140_70_',10}...
% {'C00023114', 6, 1, 'fov1_1000_200_',15},{'C00023114', 8, 1, 'fov1_1000_340_',15},...
% {'C00050354', 1, 1, 'fov1_40_100_',15},{'C00050354', 2, 1, 'fov1_40_175_',15},...
% {'C00050354', 2, 1, 'fov1_140_175_',15},{'C00050354', 3, 1, 'fov1_1000_100_',15},...
% {'C00050354', 4, 1, 'fov1_40_175_',15},{'C00050354', 5, 1, 'fov1_140_75_',15},...
% {'C00050354', 6, 1, 'fov1_1000_80_',15},{'C00050439', 1, 1, 'fov1_40_70_',15},...
% {'C00050439', 1, 1, 'fov1_140_70_',15},{'C00050439', 2, 1, 'fov1_1000_70_',14},...
% {'C00050439', 5, 1, 'fov1_1000_95_',15},{'C00050439', 6, 1, 'fov1_140_80_',15},...
% {'C00051546', 1, 1, 'fov1_40_80_',15},{'C00051546', 2, 1, 'fov1_1000_105_',15},...
% {'C00051546', 3, 1, 'fov1_1000_105_',15},{'C00051546', 4, 1, 'fov1_140_85_',15},...
% {'C00051546', 5, 1, 'fov1_40_90_',15},{'C00051546', 6, 1, 'fov1_140_90_',15}};

%for curr_file = 1:numel(folder_names)
%     clearvars -except base_path folder_names curr_file
%     curr_file %report where we are
%     mouse = folder_names{1,curr_file}{1,1};
%     rec = folder_names{1,curr_file}{1,2};
%     fov_id = folder_names{1,curr_file}{1,3};
%     ses = folder_names{1,curr_file}{1,4};
%     max_T = folder_names{1,curr_file}{1,5};
    %%%%%%%%%%%%%% CHANGE PER RUN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    mouse='607614';
    rec=8;
    fov_id=1;
    ses= ['fov' num2str(fov_id) '_1000_80_' ];
    cond_id={ses};  %Metadata for later in pipeline
    max_T= 15;   %Number of trials
    
    camera_config = 1; % 0 for old config, 1 for new config
    
    base_path = '/media/hanlabadmins/Elements/DBS/Transient_DBS_Project/GCaMP/Neocortex/Raw_Videos/'; %CHANGE IF NECESSARY
    cd(base_path)
    main_path = [base_path '/' mouse '/' 'rec'  num2str(rec)];
    save_name = [mouse '_rec'  num2str(rec)  '_' ses 'trials_' num2str(max_T)];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    all_vall=[];trial_vec=[]; %cond_vec=[];
    
    %% Read in .dcimg
    trialn=0;
    
    for trialT=[1:max_T]
        trialn=trialn+1;
        trialT
        
        if trialT<10
            filname=  [main_path '/' ses '' '0000' num2str(trialT) '.dcimg'];
            tifname = [save_name '_0000' num2str(trialT) '.tif'];
        elseif trialT>=10  && trialT< 100
            filname=  [main_path '/' ses '' '000' num2str(trialT) '.dcimg'];
            tifname = [save_name '_000' num2str(trialT) '.tif'];
        elseif trialT>99
            filname=  [main_path '/' ses '' '00' num2str(trialT) '.dcimg'];
            tifname = [save_name '_00' num2str(trialT) '.tif'];
        end
        %% Load .dcimg based on camera configuration (old or new)
        
        try
            try        %if camera_config
                % New camera config parameters
                header_end=2821;
                betI=257; %points in between image aqu
                
                fid = fopen(filname,'rb');
                % read the entire stack into memory
                mystack = fread(fid,inf,'uint16=>uint16'); % 16-bit images
                % read just the first bit of the file (the header plus a bit more)
                fid2 = fopen(filname,'rb');
                metadata = fread(fid2,29450,'uint32=>uint32'); % 32-bit header information
                fclose(fid2);
                
                Height = double(metadata(148));
                Width = ceil(double(metadata(147))/64).*64; % 32=for old voltage scope %64=for new scope
                TotalFrames = double(metadata(10));
                %      %else
                %         % Old camera config parameters
                %         header_end=489;
                %         betI=17; %points in between image aqu
                %
                %         fid = fopen(filname,'rb');
                %         % read the entire stack into memory
                %         mystack = fread(fid,inf,'uint16=>uint16'); % 16-bit images
                %         % read just the first bit of the file (the header plus a bit more)
                %         fid2 = fopen(filname,'rb');
                %         metadata = fread(fid2,29450,'uint32=>uint32'); % 32-bit header information
                %         fclose(fid2);
                %
                %         Height = double(metadata(48));
                %         Width = ceil(double(metadata(47))/64).*64; % 32=for old voltage scope %64=for new scope
                %         TotalFrames = double(metadata(44));
                %     end
                
                %% Eric's Code
                % "The part I don't understand" - Cara 02/04/22
                vall=(zeros(Width, Height, TotalFrames,'uint16' )); % allocation
                
                for trial= 1:TotalFrames
                    if trial==1
                        vv=mystack(header_end:header_end-1+  (Height*Width)  ) ;
                        vv(end-4:end)=median(vv);
                        vv=reshape(vv(1:end),[Width Height]);
                        vv1= [ vv(end-3:end,1:end); vv(1:end-4,1:end)];
                        vall(:,:,trial)= vv1;
                        lastid= header_end-1+  (Height*Width)  ;
                    else
                        vv=mystack(lastid+betI:lastid+(Height*Width)-1+betI );
                        vv(end-4:end)=median(vv);
                        vv=reshape(vv(1:end),[Width Height]);
                        vv1= [ vv(end-3:end,1:end); vv(1:end-4,1:end)];
                        vall(:,:,trial)= vv1;
                        lastid= lastid+(Height*Width)-1+betI   ;
                    end
                end
                vall(vall==0)=NaN;
                vall=vall(:,:,1:end);
                

                all_vall=[]; %Reset all_va;l variable for every trial %added - Cara 03/28/22
                all_vall=[all_vall; permute(vall, [ 3 1 2])];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                trial_vec=[trial_vec,ones(1,size(vall,3) ).*(trialT)];
            catch
                % Old camera config parameters
                header_end=489;
                betI=17; %points in between image aqu
                
                fid = fopen(filname,'rb');
                % read the entire stack into memory
                mystack = fread(fid,inf,'uint16=>uint16'); % 16-bit images
                % read just the first bit of the file (the header plus a bit more)
                fid2 = fopen(filname,'rb');
                metadata = fread(fid2,29450,'uint32=>uint32'); % 32-bit header information
                fclose(fid2);
                
                Height = double(metadata(48));
                Width = ceil(double(metadata(47))/64).*64; % 32=for old voltage scope %64=for new scope
                TotalFrames = double(metadata(44));
                %% Eric's Code
                % "The part I don't understand" - Cara 02/04/22
                vall=(zeros(Width, Height, TotalFrames,'uint16' )); % allocation
                
                for trial= 1:TotalFrames
                    if trial==1
                        vv=mystack(header_end:header_end-1+  (Height*Width)  ) ;
                        vv(end-4:end)=median(vv);
                        vv=reshape(vv(1:end),[Width Height]);
                        vv1= [ vv(end-3:end,1:end); vv(1:end-4,1:end)];
                        vall(:,:,trial)= vv1;
                        lastid= header_end-1+  (Height*Width)  ;
                    else
                        vv=mystack(lastid+betI:lastid+(Height*Width)-1+betI );
                        vv(end-4:end)=median(vv);
                        vv=reshape(vv(1:end),[Width Height]);
                        vv1= [ vv(end-3:end,1:end); vv(1:end-4,1:end)];
                        vall(:,:,trial)= vv1;
                        lastid= lastid+(Height*Width)-1+betI   ;
                    end
                end
                vall(vall==0)=NaN;
                vall=vall(:,:,1:end);

                all_vall=[all_vall; permute(vall, [ 3 1 2])];
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                trial_vec=[trial_vec,ones(1,size(vall,3) ).*(trialT)];
            end
        catch
            fprintf(['Skip: ' ses 'session, trial ' trialT ' (does not exist)']);
            continue %Skips rest of commands to try next iteration of the for loop
        end
        %% Save as .tif
        %Reorder the all_vall variable and save as tiff
        all_vall=permute(all_vall,[2 3 1]);
        tif_path=[main_path '/' tifname];
        res = saveastiff(all_vall(:,:,1:end), tif_path);
    end
    %% Save as .tif
% Changed by Cara 03/28/22
% %Reorder the all_vall variable and save as tiff
% all_vall=permute(all_vall,[2 3 1]);
% tif_path=[ main_path '/' save_name '.tif' ]
% res = saveastiff(all_vall(:,:,1:2:end), tif_path);


% saves trial and cond vectors
vec_path=[ main_path '/' save_name ]
save(vec_path, 'trial_vec', 'cond_id') % ,'cond_vec')
%end
