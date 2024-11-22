% roiConvertCheck_Cara.m
% Author: Cara R adapted from roiConvertCheckjS.m VERSION 6.2.20
% Date: 01/26/22
% Purpose: After automatically selecting neuron ROIs with Hua-an's python
% neural net, clean up the data, remove bad ROIs, Add new ROIs, ouput an
% roiList to be used in postprocessing when extracting traces

function roiConvertCheck_Cara(main_path, mouse, saveName)
    maxmin_path = [main_path '/motion_corrected'];
    roi_path = [maxmin_path '/roi'];

%% ROI selection - Post projection analysis by Hua-an's U-net
    clear roiList
% Hua-an's automated - will change machine learning picked ROIs to the
% matlab format we use. 

    fprintf('\n Converting ROIs for %s \n',mouse);
    cd([roi_path])
    m = dir('*.tif');
    roiTiff = Tiff([roi_path '/' m.name],'r');
    roiData = roiTiff.read();
    roiTiff.close();

    num = max(roiData(:)); % number of rois
    for roi_idx=1:num
        roiList(roi_idx).pixel_idx = find(roiData==roi_idx);
    end

    cd(maxmin_path)
    m = dir('*.tif');
    maxmin = importdata(m.name);
    save([main_path,sprintf(['/maxmin_' saveName '.mat'])],'maxmin');
    save([main_path,sprintf(['/allRois_' saveName '.mat'])],'roiList');
    roiList = SemiSeg_Remove(maxmin,roiList);
    temporaryList = roiList;
    save([main_path,sprintf(['/roiAfterRemove_' saveName '.mat'])],'roiList');
    roiList = SemiSeg(maxmin,roiList);


    save([main_path,sprintf(['/roi_edited_' saveName '.mat'])],'roiList');
    clear 
    close all
end