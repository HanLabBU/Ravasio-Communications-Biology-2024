% find_currents.m
% Author: Cara
% Date: 01/30/24
% Purpose: to extract all the current amplitudes from the file names' meta
% data. Also the associated mouse ID.

function [uA,ID] = find_currents(data)
    uA = [];
    ID = [];
    for i=1:numel(data)
        meta = strsplit(data(i).name,'_');
        uA = [uA, str2num(meta{1,7})];
        ID = [ID, {meta{1,3}}];
    end
end