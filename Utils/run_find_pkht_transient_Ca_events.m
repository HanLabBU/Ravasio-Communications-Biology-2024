function pkht = run_find_pkht_transient_Ca_events(traces)
center = 101; %The index at which very event is centered for my event traces (201 indices total)

%Make pkht struct for baseline events
for i=1:size(traces.base,1)
    pkht.base(i) = find_pkht_Ca_events(traces.base(i,:), center);
end

%Make pkht struct for DBS events
for i = 1:size(traces.DBS,1)
    pkht.DBS(i) = find_pkht_Ca_events(traces.DBS(i,:), center);
end

%Make pkht struct for DBS events
for i = 1:size(traces.post_1,1)
    pkht.post_1(i) = find_pkht_Ca_events(traces.post_1(i,:), center);
end

%Make pkht struct for DBS events
for i = 1:size(traces.post_2,1)
    pkht.post_2(i) = find_pkht_Ca_events(traces.post_2(i,:), center);
end

end