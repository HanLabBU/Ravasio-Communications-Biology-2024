function fwhm = run_find_fwhm_transient_Ca_events(traces)
center = 101; %The index at which very event is centered for my event traces (201 indices total)

%Make FWHM struct for baseline events
for i=1:size(traces.base,1)
    fwhm.base(i) = find_fwhm_Ca_events(traces.base(i,:), center);
end

%Make FWHM struct for DBS events
for i = 1:size(traces.DBS,1)
    fwhm.DBS(i) = find_fwhm_Ca_events(traces.DBS(i,:), center);
end

end