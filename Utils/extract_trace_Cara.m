% extract_trace_Cara.m
% Author: Cara R
% Date: 01/27/22
% Purpose: take the roiList from Hua-an's python U-net, extract traces from
% ROIs, and perform background subtraction on the data using Doughnut
% subtraction code from Athif M

function r_out=extract_trace_Cara(r_in, GUIpick)
%GUI pick is a logical (0 or 1).  1 if you'd like to select files via
%GUI, or 0 if it should autoselect *.hdf5 files with m_. as a prefix in
%the pwd as the tifs to use.
%%
    if GUIpick
        [selected_files,selected_dir] = uigetfile('*.hdf5','MultiSelect','on'); % changed to .hdf5
    else
        selected_dir = pwd;
        selected_struct = dir('m_*.hdf5');
        temp_cell = struct2cell(selected_struct);
        selected_files = temp_cell(1,:);
    end


    whole_tic = tic;

    if class(selected_files)=='char'
        file_list(1).name = fullfile(selected_dir,selected_files);
    else
        file_list = cell2struct(fullfile(selected_dir,selected_files),'name',1);
    end

    % I is a vector of all indices of rois this is used to remove other
    % ROIS from the background ring

    I= [];
    for i=1:numel(r_in)
        I = [I;r_in(i).pixel_idx];
    end


    for file_idx=1:length(file_list)


        filename = [file_list(file_idx).name];
        disp(filename)
        fprintf(['Processing ', filename,'....\n']);

        suffix = strsplit(filename,'.');
        suffix = suffix{end};
        
        if suffix == ".tif"
            InfoImage = imfinfo(filename);
            NumberImages=length(InfoImage);
            
            f_matrix = zeros(InfoImage(1).Height,InfoImage(1).Width,NumberImages,'uint16');
            for i=1:NumberImages
                f_matrix(:,:,i) = imread(filename,'Index',i,'Info',InfoImage);
            end
        else
            f_matrix = h5read(filename,'/image_data');
            f_matrix = permute(f_matrix,[2,1,3]);
            InfoImage = struct('Height',size(f_matrix,1),'Width',size(f_matrix,2));
            NumberImages = size(f_matrix,3);   
        end

        f_matrix = double(reshape(f_matrix,InfoImage(1).Height*InfoImage(1).Width,NumberImages));
        %f_matrix = (reshape(f_matrix,InfoImage(1).Height*InfoImage(1).Width,NumberImages));

        for roi_idx=1:numel(r_in)
            current_mask = zeros(1,InfoImage(1).Height*InfoImage(1).Width);
            try
                current_mask(r_in(roi_idx).pixel_idx) = true;
                %r_out(roi_idx).pixel_idx = r_in(roi_idx).pixel_idx;
                r_out.pixel_idx{roi_idx} = r_in(roi_idx).pixel_idx;
            catch
                current_mask(r_in(roi_idx).PixelIdxList) = true;
                %r_out(roi_idx).pixel_idx = r_in(roi_idx).PixelIdxList;
                r_out.pixel_idx{roi_idx} = r_in(roi_idx).PixelIdxList;
            end
            %             parfor frame = 1:size(f_matrix,3)
            %                 mat = f_matrix(:,:,frame);
            %                 current_trace(frame) = sum(sum(mat(current_mask)))/sum(sum(current_mask));
            %             end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            image_mask = reshape(current_mask,InfoImage(1).Height,InfoImage(1).Width);
            %Find Centroid code from
            %(https://www.mathworks.com/matlabcentral/answers/322369-find-centroid-of-binary-image)
            [y, x] = ndgrid(1:InfoImage(1).Height, 1:InfoImage(1).Width);
            centroid = mean([x(logical(image_mask)), y(logical(image_mask))]);
            xcent = centroid(1);
            ycent = centroid(2);
            BG_radius = 50; %Number of Pixels for Local Background Radius.  Assume 1 neuron about 10 pixels in diameter
            BG_radius_in = 15;

            BG_mask_new = (y - ycent).^2 + (x-xcent).^2 <= BG_radius.^2 &...
                (y - ycent).^2 + (x-xcent).^2 > BG_radius_in .^2;
            BG_mask = (y - ycent).^2 + (x-xcent).^2 <= BG_radius.^2 ;
%%            Use this to visualize the ring background
%             figure
%             imshowpair(image_mask,BG_mask,'falsecolor')
%             rectangle('Position',r_in(roi_idx).stats.BoundingBox,'EdgeColor','r','LineWidth',3)
%%
            % Full image is 1 all rois are 0
            I_mask = ones(InfoImage(1).Height,InfoImage(1).Width);
            I_mask(I) = 0;
            I_mask([1:25,end-25:end],:) = 0; % Do not consider the outermost 25 edge pixels as background
            I_mask(:,[1:25,end-25:end]) = 0;

            onlyBG_mask_new = (BG_mask_new - image_mask).*I_mask;
            onlyBG_mask = (BG_mask - image_mask);

%%             Use this to visualize the ring background and other ROIs
%             figure
%             imshowpair(image_mask,onlyBG_mask,'falsecolor')
% %             rectangle('Position',r_in(roi_idx).stats.BoundingBox,'EdgeColor','r','LineWidth',3)
%
%             figure
%             imshowpair(image_mask,onlyBG_mask_new,'falsecolor')
% %             rectangle('Position',r_in(roi_idx).stats.BoundingBox,'EdgeColor','r','LineWidth',3)

%%
            BG_vect_new = reshape(onlyBG_mask_new, 1,InfoImage(1).Height*InfoImage(1).Width);
            BG_vect = reshape(onlyBG_mask, 1,InfoImage(1).Height*InfoImage(1).Width);

            %r_out(roi_idx).BG_idx_new = find(BG_vect_new == 1);
            %r_out(roi_idx).BG_idx = find(BG_vect == 1);
             r_out.BG_idx_new{roi_idx} = find(BG_vect_new == 1);
             r_out.BG_idx{roi_idx} = find(BG_vect == 1);

            %Take Out Trace Values & Update r_out
            current_trace = (current_mask*f_matrix)/sum(current_mask);
            current_BG = (BG_vect*f_matrix)/sum(BG_vect);
            current_BG_new = (BG_vect_new*f_matrix)/sum(BG_vect_new);

            %r_out(roi_idx).file(file_idx).filename = filename;
            %r_out(roi_idx).file(file_idx).trace = current_trace;
            %r_out(roi_idx).file(file_idx).BGtrace = current_BG;
            %r_out(roi_idx).file(file_idx).BGtrace_new = current_BG_new;
            r_out.file(roi_idx,file_idx).filename = filename;
            r_out.file(roi_idx,file_idx).trace = current_trace;
            r_out.file(roi_idx,file_idx).BGtrace = current_BG;
            r_out.file(roi_idx,file_idx).BGtrace_new = current_BG_new;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %             r_out(roi_idx).file(file_idx).filename = filename;
            %             r_out(roi_idx).file(file_idx).trace = current_trace;

            %             if file_idx==1
            %                 r_out(roi_idx).trace = current_trace;
            %             else
            %                 r_out(roi_idx).trace = cat(2,r_out(roi_idx).trace,current_trace);
            %             end
            if file_idx==1
                %r_out(roi_idx).trace = current_trace;
                %r_out(roi_idx).BGtrace = current_BG;
                %r_out(roi_idx).BGtrace_new = current_BG_new;
                r_out.trace(roi_idx,:) = current_trace;
                r_out.BGtrace(roi_idx,:) = current_BG;
                r_out.BGtrace_new(roi_idx,:) = current_BG_new;
            else
                %r_out(roi_idx).trace = cat(2,r_out(roi_idx).trace,current_trace);
                %r_out(roi_idx).BGtrace = cat(2,r_out(roi_idx).BGtrace,current_BG);
                %r_out(roi_idx).BGtrace_new = cat(2,r_out(roi_idx).BGtrace_new,current_BG_new);
%                 r_out.trace(roi_idx,:) = cat(2,r_out.trace(roi_idx,:),current_trace);
%                 r_out.BGtrace(roi_idx,:) = cat(2,r_out.BGtrace(roi_idx,:),current_BG);
%                 r_out.BGtrace_new(roi_idx,:) = cat(2,r_out.BGtrace_new(roi_idx,:),current_BG_new);
                temp_trace_patch(roi_idx,:) = current_trace;
                temp_BGtrace_patch(roi_idx,:) = current_BG;
                temp_BGtrace_new_patch(roi_idx,:) = current_BG_new;
            end

        end
        
        if file_idx~=1
             r_out.trace = cat(2,r_out.trace,temp_trace_patch);
             r_out.BGtrace = cat(2,r_out.BGtrace,temp_BGtrace_patch);
             r_out.BGtrace_new = cat(2,r_out.BGtrace_new,temp_BGtrace_new_patch);
        % else do nothing
        end
    end

    for roi_idx=1:numel(r_in)
        r_out.color(roi_idx,:) = rand(1,3);
    end
    
    fprintf(['Total loading time: ',num2str(round(toc(whole_tic),2)),' seconds.\n']);

end