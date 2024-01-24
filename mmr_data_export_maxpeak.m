% Peak finding technique for getting the MMR... but use max peak instead of first peak

% MMR is usually slow, not 'peaky'... so should probably take wider window
% around the maximum... and instead of taking FIRST peak, should take
% largest peak

% Set the time vector
time_vectorD1 = -0.1:0.001:0.600; %Epoch time segment
time_vectorD2 = -0.1:0.001:0.599;

% time_vectorD2 = time_vectorD1; % in this case, don't have different time scales.

%% Find the peaks in the dup data for MMR in FL
% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
FL_diff_dup1_pks = zeros(1,length(FL_diff_dup_1));
FL_diff_dup1_lats = zeros(1,length(FL_diff_dup_1));
FL_diff_dup2_pks = zeros(1,length(FL_diff_dup_2)); % Create pk amplitude variable
FL_diff_dup2_lats = zeros(1,length(FL_diff_dup_2));% Create peak latency variable
peak_window = [];

for n = 1: length(FL_diff_dup_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(FL_diff_dup_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FL_diff_dup1_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FL_diff_dup1_lats(n) = 0;
    else
        FL_diff_dup1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FL_diff_dup1_lats));
for n = 1:length(FL_diff_dup1_lats)
    if FL_diff_dup1_lats(n) == 0
        FL_diff_dup1_lats(n) = meanlat;
        for j=1:length(FL_diff_dup_1{n}.time)
            if (round(FL_diff_dup_1{n}.time(j),4)) == round(FL_diff_dup1_lats(n),4)
                FL_diff_dup1_pks(n)= FL_diff_dup_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(FL_diff_dup_2)
    [pks,locs] = findpeaks(FL_diff_dup_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FL_diff_dup2_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FL_diff_dup2_lats(n) = 0;
    else
        FL_diff_dup2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FL_diff_dup2_lats));
for n = 1:length(FL_diff_dup2_lats)
    if FL_diff_dup2_lats(n) == 0
        FL_diff_dup2_lats(n) = meanlat;
        for j=1:length(FL_diff_dup_2{n}.time)
            if (round(FL_diff_dup_2{n}.time(j),4)) == round(FL_diff_dup2_lats(n),4)
                FL_diff_dup2_pks(n)= FL_diff_dup_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(FL_dup_D1,2)
    FL_dup_D1{1,Participant}.MMRPeakValue = FL_diff_dup1_pks(Participant);
    FL_dup_D1{1,Participant}.MMRPeakLatency = FL_diff_dup1_lats(Participant);
    FL_dup_D1{1,Participant}.MMRWindowStart = FL_diff_dup1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    FL_dup_D1{1,Participant}.MMRWindowEnd = FL_diff_dup1_lats(Participant)+0.050000;
    
    FL_dup_D2{1,Participant}.MMRPeakValue = FL_diff_dup2_pks(Participant);
    FL_dup_D2{1,Participant}.MMRPeakLatency = FL_diff_dup2_lats(Participant);
    FL_dup_D2{1,Participant}.MMRWindowStart = FL_diff_dup2_lats(Participant)-0.05000;
    FL_dup_D2{1,Participant}.MMRWindowEnd = FL_diff_dup2_lats(Participant)+0.050000;
    
    FL_dup_S1{1,Participant}.MMRPeakLatency = FL_diff_dup1_lats(Participant); %put window latency into the standard trial data
    FL_dup_S1{1,Participant}.MMRWindowStart = FL_diff_dup1_lats(Participant)-0.05000;
    FL_dup_S1{1,Participant}.MMRWindowEnd = FL_diff_dup1_lats(Participant)+0.050000;
    
    FL_dup_S2{1,Participant}.MMRPeakLatency = FL_diff_dup2_lats(Participant);
    FL_dup_S2{1,Participant}.MMRWindowStart = FL_diff_dup2_lats(Participant)-0.05000;
    FL_dup_S2{1,Participant}.MMRWindowEnd = FL_diff_dup2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FL_dup_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(FL_dup_D1{1,Participant}.MMRWindowStart,4))
            FL_dup_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(FL_dup_D1{1,Participant}.MMRWindowEnd,4))
            FL_dup_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FL_dup_D1{1,Participant}.avg(StartIndex:EndIndex));
    FL_dup_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FL_dup_S1{1,Participant}.avg(StartIndex:EndIndex));
    FL_dup_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FL_dup_D2,2) % D2/S2
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(FL_dup_D2{1,Participant}.MMRWindowStart,4))
            FL_dup_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(FL_dup_D2{1,Participant}.MMRWindowEnd,4))
            FL_dup_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FL_dup_D2{1,Participant}.avg(StartIndex:EndIndex));
    FL_dup_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FL_dup_S2{1,Participant}.avg(StartIndex:EndIndex));
    FL_dup_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end
%% Find the peaks in the trp data for MMR in FL
% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
FL_diff_trp1_pks = zeros(1,length(FL_diff_trp_1));
FL_diff_trp1_lats = zeros(1,length(FL_diff_trp_1));
FL_diff_trp2_pks = zeros(1,length(FL_diff_trp_2)); % Create pk amplitude variable
FL_diff_trp2_lats = zeros(1,length(FL_diff_trp_2));% Create peak latency variable
peak_window = [];

for n = 1: length(FL_diff_trp_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(FL_diff_trp_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FL_diff_trp1_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FL_diff_trp1_lats(n) = 0;
    else
        FL_diff_trp1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FL_diff_trp1_lats));
for n = 1:length(FL_diff_trp1_lats)
    if FL_diff_trp1_lats(n) == 0
        FL_diff_trp1_lats(n) = meanlat;
        for j=1:length(FL_diff_trp_1{n}.time)
            if (round(FL_diff_trp_1{n}.time(j),4)) == round(FL_diff_trp1_lats(n),4)
                FL_diff_trp1_pks(n)= FL_diff_trp_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(FL_diff_trp_2)
    [pks,locs] = findpeaks(FL_diff_trp_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FL_diff_trp2_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FL_diff_trp2_lats(n) = 0;
    else
        FL_diff_trp2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FL_diff_trp2_lats));
for n = 1:length(FL_diff_trp2_lats)
    if FL_diff_trp2_lats(n) == 0
        FL_diff_trp2_lats(n) = meanlat;
        for j=1:length(FL_diff_trp_2{n}.time)
            if (round(FL_diff_trp_2{n}.time(j),4)) == round(FL_diff_trp2_lats(n),4)
                FL_diff_trp2_pks(n)= FL_diff_trp_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(FL_trp_D1,2)
    FL_trp_D1{1,Participant}.MMRPeakValue = FL_diff_trp1_pks(Participant);
    FL_trp_D1{1,Participant}.MMRPeakLatency = FL_diff_trp1_lats(Participant);
    FL_trp_D1{1,Participant}.MMRWindowStart = FL_diff_trp1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    FL_trp_D1{1,Participant}.MMRWindowEnd = FL_diff_trp1_lats(Participant)+0.050000;
    
    FL_trp_D2{1,Participant}.MMRPeakValue = FL_diff_trp2_pks(Participant);
    FL_trp_D2{1,Participant}.MMRPeakLatency = FL_diff_trp2_lats(Participant);
    FL_trp_D2{1,Participant}.MMRWindowStart = FL_diff_trp2_lats(Participant)-0.05000;
    FL_trp_D2{1,Participant}.MMRWindowEnd = FL_diff_trp2_lats(Participant)+0.050000;
    
    FL_trp_S1{1,Participant}.MMRPeakLatency = FL_diff_trp1_lats(Participant); %put window latency into the standard trial data
    FL_trp_S1{1,Participant}.MMRWindowStart = FL_diff_trp1_lats(Participant)-0.05000;
    FL_trp_S1{1,Participant}.MMRWindowEnd = FL_diff_trp1_lats(Participant)+0.050000;
    
    FL_trp_S2{1,Participant}.MMRPeakLatency = FL_diff_trp2_lats(Participant);
    FL_trp_S2{1,Participant}.MMRWindowStart = FL_diff_trp2_lats(Participant)-0.05000;
    FL_trp_S2{1,Participant}.MMRWindowEnd = FL_diff_trp2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FL_trp_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(FL_trp_D1{1,Participant}.MMRWindowStart,4))
            FL_trp_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(FL_trp_D1{1,Participant}.MMRWindowEnd,4))
            FL_trp_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FL_trp_D1{1,Participant}.avg(StartIndex:EndIndex));
    FL_trp_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FL_trp_S1{1,Participant}.avg(StartIndex:EndIndex));
    FL_trp_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FL_trp_D2,2) % D2/S2
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(FL_trp_D2{1,Participant}.MMRWindowStart,4))
            FL_trp_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(FL_trp_D2{1,Participant}.MMRWindowEnd,4))
            FL_trp_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FL_trp_D2{1,Participant}.avg(StartIndex:EndIndex));
    FL_trp_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FL_trp_S2{1,Participant}.avg(StartIndex:EndIndex));
    FL_trp_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end


%% Find the peaks in the dup data for MMR in FZ
% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
FZ_diff_dup1_pks = zeros(1,length(FZ_diff_dup_1));
FZ_diff_dup1_lats = zeros(1,length(FZ_diff_dup_1));
FZ_diff_dup2_pks = zeros(1,length(FZ_diff_dup_2)); % Create pk amplitude variable
FZ_diff_dup2_lats = zeros(1,length(FZ_diff_dup_2));% Create peak latency variable
peak_window = [];

for n = 1: length(FZ_diff_dup_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(FZ_diff_dup_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FZ_diff_dup1_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FZ_diff_dup1_lats(n) = 0;
    else
        FZ_diff_dup1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FZ_diff_dup1_lats));
for n = 1:length(FZ_diff_dup1_lats)
    if FZ_diff_dup1_lats(n) == 0
        FZ_diff_dup1_lats(n) = meanlat;
        for j=1:length(FZ_diff_dup_1{n}.time)
            if (round(FZ_diff_dup_1{n}.time(j),4)) == round(FZ_diff_dup1_lats(n),4)
                FZ_diff_dup1_pks(n)= FZ_diff_dup_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(FZ_diff_dup_2)
    [pks,locs] = findpeaks(FZ_diff_dup_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FZ_diff_dup2_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FZ_diff_dup2_lats(n) = 0;
    else
        FZ_diff_dup2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FZ_diff_dup2_lats));
for n = 1:length(FZ_diff_dup2_lats)
    if FZ_diff_dup2_lats(n) == 0
        FZ_diff_dup2_lats(n) = meanlat;
        for j=1:length(FZ_diff_dup_2{n}.time)
            if (round(FZ_diff_dup_2{n}.time(j),4)) == round(FZ_diff_dup2_lats(n),4)
                FZ_diff_dup2_pks(n)= FZ_diff_dup_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(FZ_dup_D1,2)
    FZ_dup_D1{1,Participant}.MMRPeakValue = FZ_diff_dup1_pks(Participant);
    FZ_dup_D1{1,Participant}.MMRPeakLatency = FZ_diff_dup1_lats(Participant);
    FZ_dup_D1{1,Participant}.MMRWindowStart = FZ_diff_dup1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    FZ_dup_D1{1,Participant}.MMRWindowEnd = FZ_diff_dup1_lats(Participant)+0.050000;
    
    FZ_dup_D2{1,Participant}.MMRPeakValue = FZ_diff_dup2_pks(Participant);
    FZ_dup_D2{1,Participant}.MMRPeakLatency = FZ_diff_dup2_lats(Participant);
    FZ_dup_D2{1,Participant}.MMRWindowStart = FZ_diff_dup2_lats(Participant)-0.05000;
    FZ_dup_D2{1,Participant}.MMRWindowEnd = FZ_diff_dup2_lats(Participant)+0.050000;
    
    FZ_dup_S1{1,Participant}.MMRPeakLatency = FZ_diff_dup1_lats(Participant); %put window latency into the standard trial data
    FZ_dup_S1{1,Participant}.MMRWindowStart = FZ_diff_dup1_lats(Participant)-0.05000;
    FZ_dup_S1{1,Participant}.MMRWindowEnd = FZ_diff_dup1_lats(Participant)+0.050000;
    
    FZ_dup_S2{1,Participant}.MMRPeakLatency = FZ_diff_dup2_lats(Participant);
    FZ_dup_S2{1,Participant}.MMRWindowStart = FZ_diff_dup2_lats(Participant)-0.05000;
    FZ_dup_S2{1,Participant}.MMRWindowEnd = FZ_diff_dup2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FZ_dup_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(FZ_dup_D1{1,Participant}.MMRWindowStart,4))
            FZ_dup_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(FZ_dup_D1{1,Participant}.MMRWindowEnd,4))
            FZ_dup_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FZ_dup_D1{1,Participant}.avg(StartIndex:EndIndex));
    FZ_dup_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FZ_dup_S1{1,Participant}.avg(StartIndex:EndIndex));
    FZ_dup_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FZ_dup_D2,2) % D2/S11
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(FZ_dup_D2{1,Participant}.MMRWindowStart,4))
            FZ_dup_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(FZ_dup_D2{1,Participant}.MMRWindowEnd,4))
            FZ_dup_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FZ_dup_D2{1,Participant}.avg(StartIndex:EndIndex));
    FZ_dup_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FZ_dup_S2{1,Participant}.avg(StartIndex:EndIndex));
    FZ_dup_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

%% Find the peaks in the trp data for MMR in FZ
% Intilaize variables to score MMR peaks and latencies (change manually for different electrode groupings)
FZ_diff_trp1_pks = zeros(1,length(FZ_diff_trp_1));
FZ_diff_trp1_lats = zeros(1,length(FZ_diff_trp_1));
FZ_diff_trp2_pks = zeros(1,length(FZ_diff_trp_2)); % Create pk amplitude variable
FZ_diff_trp2_lats = zeros(1,length(FZ_diff_trp_2));% Create peak latency variable
peak_window = [];

for n = 1: length(FZ_diff_trp_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(FZ_diff_trp_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FZ_diff_trp1_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FZ_diff_trp1_lats(n) = 0;
    else
        FZ_diff_trp1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FZ_diff_trp1_lats));
for n = 1:length(FZ_diff_trp1_lats)
    if FZ_diff_trp1_lats(n) == 0
        FZ_diff_trp1_lats(n) = meanlat;
        for j=1:length(FZ_diff_trp_1{n}.time)
            if (round(FZ_diff_trp_1{n}.time(j),4)) == round(FZ_diff_trp1_lats(n),4)
                FZ_diff_trp1_pks(n)= FZ_diff_trp_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(FZ_diff_trp_2)
    [pks,locs] = findpeaks(FZ_diff_trp_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FZ_diff_trp2_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FZ_diff_trp2_lats(n) = 0;
    else
        FZ_diff_trp2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FZ_diff_trp2_lats));
for n = 1:length(FZ_diff_trp2_lats)
    if FZ_diff_trp2_lats(n) == 0
        FZ_diff_trp2_lats(n) = meanlat;
        for j=1:length(FZ_diff_trp_2{n}.time)
            if (round(FZ_diff_trp_2{n}.time(j),4)) == round(FZ_diff_trp2_lats(n),4)
                FZ_diff_trp2_pks(n)= FZ_diff_trp_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(FZ_trp_D1,2)
    FZ_trp_D1{1,Participant}.MMRPeakValue = FZ_diff_trp1_pks(Participant);
    FZ_trp_D1{1,Participant}.MMRPeakLatency = FZ_diff_trp1_lats(Participant);
    FZ_trp_D1{1,Participant}.MMRWindowStart = FZ_diff_trp1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    FZ_trp_D1{1,Participant}.MMRWindowEnd = FZ_diff_trp1_lats(Participant)+0.050000;
    
    FZ_trp_D2{1,Participant}.MMRPeakValue = FZ_diff_trp2_pks(Participant);
    FZ_trp_D2{1,Participant}.MMRPeakLatency = FZ_diff_trp2_lats(Participant);
    FZ_trp_D2{1,Participant}.MMRWindowStart = FZ_diff_trp2_lats(Participant)-0.05000;
    FZ_trp_D2{1,Participant}.MMRWindowEnd = FZ_diff_trp2_lats(Participant)+0.050000;
    
    FZ_trp_S1{1,Participant}.MMRPeakLatency = FZ_diff_trp1_lats(Participant); %put window latency into the standard trial data
    FZ_trp_S1{1,Participant}.MMRWindowStart = FZ_diff_trp1_lats(Participant)-0.05000;
    FZ_trp_S1{1,Participant}.MMRWindowEnd = FZ_diff_trp1_lats(Participant)+0.050000;
    
    FZ_trp_S2{1,Participant}.MMRPeakLatency = FZ_diff_trp2_lats(Participant);
    FZ_trp_S2{1,Participant}.MMRWindowStart = FZ_diff_trp2_lats(Participant)-0.05000;
    FZ_trp_S2{1,Participant}.MMRWindowEnd = FZ_diff_trp2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FZ_trp_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(FZ_trp_D1{1,Participant}.MMRWindowStart,4))
            FZ_trp_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(FZ_trp_D1{1,Participant}.MMRWindowEnd,4))
            FZ_trp_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FZ_trp_D1{1,Participant}.avg(StartIndex:EndIndex));
    FZ_trp_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FZ_trp_S1{1,Participant}.avg(StartIndex:EndIndex));
    FZ_trp_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FZ_trp_D2,2) % D2/S11
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(FZ_trp_D2{1,Participant}.MMRWindowStart,4))
            FZ_trp_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(FZ_trp_D2{1,Participant}.MMRWindowEnd,4))
            FZ_trp_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FZ_trp_D2{1,Participant}.avg(StartIndex:EndIndex));
    FZ_trp_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FZ_trp_S2{1,Participant}.avg(StartIndex:EndIndex));
    FZ_trp_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end


%% Find the peaks in the dup data for MMR FR

% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
FR_diff_dup1_pks = zeros(1,length(FR_diff_dup_1));
FR_diff_dup1_lats = zeros(1,length(FR_diff_dup_1));
FR_diff_dup2_pks = zeros(1,length(FR_diff_dup_2)); % Create pk amplitude variable
FR_diff_dup2_lats = zeros(1,length(FR_diff_dup_2));% Create peak latency variable
peak_window = [];

for n = 1: length(FR_diff_dup_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(FR_diff_dup_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FR_diff_dup1_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FR_diff_dup1_lats(n) = 0;
    else
        FR_diff_dup1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FR_diff_dup1_lats));
for n = 1:length(FR_diff_dup1_lats)
    if FR_diff_dup1_lats(n) == 0
        FR_diff_dup1_lats(n) = meanlat;
        for j=1:length(FR_diff_dup_1{n}.time)
            if (round(FR_diff_dup_1{n}.time(j),4)) == round(FR_diff_dup1_lats(n),4)
                FR_diff_dup1_pks(n)= FR_diff_dup_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(FR_diff_dup_2)
    [pks,locs] = findpeaks(FR_diff_dup_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FR_diff_dup2_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FR_diff_dup2_lats(n) = 0;
    else
        FR_diff_dup2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FR_diff_dup2_lats));
for n = 1:length(FR_diff_dup2_lats)
    if FR_diff_dup2_lats(n) == 0
        FR_diff_dup2_lats(n) = meanlat;
        for j=1:length(FR_diff_dup_2{n}.time)
            if (round(FR_diff_dup_2{n}.time(j),4)) == round(FR_diff_dup2_lats(n),4)
                FR_diff_dup2_pks(n)= FR_diff_dup_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(FR_dup_D1,2)
    FR_dup_D1{1,Participant}.MMRPeakValue = FR_diff_dup1_pks(Participant);
    FR_dup_D1{1,Participant}.MMRPeakLatency = FR_diff_dup1_lats(Participant);
    FR_dup_D1{1,Participant}.MMRWindowStart = FR_diff_dup1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    FR_dup_D1{1,Participant}.MMRWindowEnd = FR_diff_dup1_lats(Participant)+0.050000;
    
    FR_dup_D2{1,Participant}.MMRPeakValue = FR_diff_dup2_pks(Participant);
    FR_dup_D2{1,Participant}.MMRPeakLatency = FR_diff_dup2_lats(Participant);
    FR_dup_D2{1,Participant}.MMRWindowStart = FR_diff_dup2_lats(Participant)-0.05000;
    FR_dup_D2{1,Participant}.MMRWindowEnd = FR_diff_dup2_lats(Participant)+0.050000;
    
    FR_dup_S1{1,Participant}.MMRPeakLatency = FR_diff_dup1_lats(Participant); %put window latency into the standard trial data
    FR_dup_S1{1,Participant}.MMRWindowStart = FR_diff_dup1_lats(Participant)-0.05000;
    FR_dup_S1{1,Participant}.MMRWindowEnd = FR_diff_dup1_lats(Participant)+0.050000;
    
    FR_dup_S2{1,Participant}.MMRPeakLatency = FR_diff_dup2_lats(Participant);
    FR_dup_S2{1,Participant}.MMRWindowStart = FR_diff_dup2_lats(Participant)-0.05000;
    FR_dup_S2{1,Participant}.MMRWindowEnd = FR_diff_dup2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FR_dup_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(FR_dup_D1{1,Participant}.MMRWindowStart,4))
            FR_dup_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(FR_dup_D1{1,Participant}.MMRWindowEnd,4))
            FR_dup_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FR_dup_D1{1,Participant}.avg(StartIndex:EndIndex));
    FR_dup_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FR_dup_S1{1,Participant}.avg(StartIndex:EndIndex));
    FR_dup_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FR_dup_D2,2) % D2/S2
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(FR_dup_D2{1,Participant}.MMRWindowStart,4))
            FR_dup_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(FR_dup_D2{1,Participant}.MMRWindowEnd,4))
            FR_dup_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FR_dup_D2{1,Participant}.avg(StartIndex:EndIndex));
    FR_dup_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FR_dup_S2{1,Participant}.avg(StartIndex:EndIndex));
    FR_dup_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end
%% Find the peaks in the trp data for MMR FR

% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
FR_diff_trp1_pks = zeros(1,length(FR_diff_trp_1));
FR_diff_trp1_lats = zeros(1,length(FR_diff_trp_1));
FR_diff_trp2_pks = zeros(1,length(FR_diff_trp_2)); % Create pk amplitude variable
FR_diff_trp2_lats = zeros(1,length(FR_diff_trp_2));% Create peak latency variable
peak_window = [];

for n = 1: length(FR_diff_trp_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(FR_diff_trp_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FR_diff_trp1_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FR_diff_trp1_lats(n) = 0;
    else
        FR_diff_trp1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FR_diff_trp1_lats));
for n = 1:length(FR_diff_trp1_lats)
    if FR_diff_trp1_lats(n) == 0
        FR_diff_trp1_lats(n) = meanlat;
        for j=1:length(FR_diff_trp_1{n}.time)
            if (round(FR_diff_trp_1{n}.time(j),4)) == round(FR_diff_trp1_lats(n),4)
                FR_diff_trp1_pks(n)= FR_diff_trp_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(FR_diff_trp_2)
    [pks,locs] = findpeaks(FR_diff_trp_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [FR_diff_trp2_pks(n), max_index] = max(peak_window);
    if max(peak_window) == 0
        FR_diff_trp2_lats(n) = 0;
    else
        FR_diff_trp2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(FR_diff_trp2_lats));
for n = 1:length(FR_diff_trp2_lats)
    if FR_diff_trp2_lats(n) == 0
        FR_diff_trp2_lats(n) = meanlat;
        for j=1:length(FR_diff_trp_2{n}.time)
            if (round(FR_diff_trp_2{n}.time(j),4)) == round(FR_diff_trp2_lats(n),4)
                FR_diff_trp2_pks(n)= FR_diff_trp_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(FR_trp_D1,2)
    FR_trp_D1{1,Participant}.MMRPeakValue = FR_diff_trp1_pks(Participant);
    FR_trp_D1{1,Participant}.MMRPeakLatency = FR_diff_trp1_lats(Participant);
    FR_trp_D1{1,Participant}.MMRWindowStart = FR_diff_trp1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    FR_trp_D1{1,Participant}.MMRWindowEnd = FR_diff_trp1_lats(Participant)+0.050000;
    
    FR_trp_D2{1,Participant}.MMRPeakValue = FR_diff_trp2_pks(Participant);
    FR_trp_D2{1,Participant}.MMRPeakLatency = FR_diff_trp2_lats(Participant);
    FR_trp_D2{1,Participant}.MMRWindowStart = FR_diff_trp2_lats(Participant)-0.05000;
    FR_trp_D2{1,Participant}.MMRWindowEnd = FR_diff_trp2_lats(Participant)+0.050000;
    
    FR_trp_S1{1,Participant}.MMRPeakLatency = FR_diff_trp1_lats(Participant); %put window latency into the standard trial data
    FR_trp_S1{1,Participant}.MMRWindowStart = FR_diff_trp1_lats(Participant)-0.05000;
    FR_trp_S1{1,Participant}.MMRWindowEnd = FR_diff_trp1_lats(Participant)+0.050000;
    
    FR_trp_S2{1,Participant}.MMRPeakLatency = FR_diff_trp2_lats(Participant);
    FR_trp_S2{1,Participant}.MMRWindowStart = FR_diff_trp2_lats(Participant)-0.05000;
    FR_trp_S2{1,Participant}.MMRWindowEnd = FR_diff_trp2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FR_trp_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(FR_trp_D1{1,Participant}.MMRWindowStart,4))
            FR_trp_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(FR_trp_D1{1,Participant}.MMRWindowEnd,4))
            FR_trp_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FR_trp_D1{1,Participant}.avg(StartIndex:EndIndex));
    FR_trp_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FR_trp_S1{1,Participant}.avg(StartIndex:EndIndex));
    FR_trp_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(FR_trp_D2,2) % D2/S2
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(FR_trp_D2{1,Participant}.MMRWindowStart,4))
            FR_trp_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(FR_trp_D2{1,Participant}.MMRWindowEnd,4))
            FR_trp_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(FR_trp_D2{1,Participant}.avg(StartIndex:EndIndex));
    FR_trp_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(FR_trp_S2{1,Participant}.avg(StartIndex:EndIndex));
    FR_trp_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

%% Find the peaks in the dup data for MMR in OL
% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
OL_diff_dup1_pks = zeros(1,length(OL_diff_dup_1));
OL_diff_dup1_lats = zeros(1,length(OL_diff_dup_1));
OL_diff_dup2_pks = zeros(1,length(OL_diff_dup_2)); % Create pk amplitude variable
OL_diff_dup2_lats = zeros(1,length(OL_diff_dup_2));% Create peak latency variable
peak_window = [];

for n = 1: length(OL_diff_dup_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(-OL_diff_dup_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OL_diff_dup1_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OL_diff_dup1_lats(n) = 0;
    else
        OL_diff_dup1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OL_diff_dup1_lats));
for n = 1:length(OL_diff_dup1_lats)
    if OL_diff_dup1_lats(n) == 0
        OL_diff_dup1_lats(n) = meanlat;
        for j=1:length(OL_diff_dup_1{n}.time)
            if (round(OL_diff_dup_1{n}.time(j),4)) == round(OL_diff_dup1_lats(n),4)
                OL_diff_dup1_pks(n)= OL_diff_dup_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(OL_diff_dup_2)
    [pks,locs] = findpeaks(-OL_diff_dup_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OL_diff_dup2_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OL_diff_dup2_lats(n) = 0;
    else
        OL_diff_dup2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OL_diff_dup2_lats));
for n = 1:length(OL_diff_dup2_lats)
    if OL_diff_dup2_lats(n) == 0
        OL_diff_dup2_lats(n) = meanlat;
        for j=1:length(OL_diff_dup_2{n}.time)
            if (round(OL_diff_dup_2{n}.time(j),4)) == round(OL_diff_dup2_lats(n),4)
                OL_diff_dup2_pks(n)= OL_diff_dup_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(OL_dup_D1,2)
    OL_dup_D1{1,Participant}.MMRPeakValue = OL_diff_dup1_pks(Participant);
    OL_dup_D1{1,Participant}.MMRPeakLatency = OL_diff_dup1_lats(Participant);
    OL_dup_D1{1,Participant}.MMRWindowStart = OL_diff_dup1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    OL_dup_D1{1,Participant}.MMRWindowEnd = OL_diff_dup1_lats(Participant)+0.050000;
    
    OL_dup_D2{1,Participant}.MMRPeakValue = OL_diff_dup2_pks(Participant);
    OL_dup_D2{1,Participant}.MMRPeakLatency = OL_diff_dup2_lats(Participant);
    OL_dup_D2{1,Participant}.MMRWindowStart = OL_diff_dup2_lats(Participant)-0.05000;
    OL_dup_D2{1,Participant}.MMRWindowEnd = OL_diff_dup2_lats(Participant)+0.050000;
    
    OL_dup_S1{1,Participant}.MMRPeakLatency = OL_diff_dup1_lats(Participant); %put window latency into the standard trial data
    OL_dup_S1{1,Participant}.MMRWindowStart = OL_diff_dup1_lats(Participant)-0.05000;
    OL_dup_S1{1,Participant}.MMRWindowEnd = OL_diff_dup1_lats(Participant)+0.050000;
    
    OL_dup_S2{1,Participant}.MMRPeakLatency = OL_diff_dup2_lats(Participant);
    OL_dup_S2{1,Participant}.MMRWindowStart = OL_diff_dup2_lats(Participant)-0.05000;
    OL_dup_S2{1,Participant}.MMRWindowEnd = OL_diff_dup2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OL_dup_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(OL_dup_D1{1,Participant}.MMRWindowStart,4))
            OL_dup_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(OL_dup_D1{1,Participant}.MMRWindowEnd,4))
            OL_dup_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OL_dup_D1{1,Participant}.avg(StartIndex:EndIndex));
    OL_dup_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OL_dup_S1{1,Participant}.avg(StartIndex:EndIndex));
    OL_dup_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OL_dup_D2,2) % D2/S2
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(OL_dup_D2{1,Participant}.MMRWindowStart,4))
            OL_dup_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(OL_dup_D2{1,Participant}.MMRWindowEnd,4))
            OL_dup_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OL_dup_D2{1,Participant}.avg(StartIndex:EndIndex));
    OL_dup_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OL_dup_S2{1,Participant}.avg(StartIndex:EndIndex));
    OL_dup_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

%% Find the peaks in the trp data for MMR in OL
% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
OL_diff_trp1_pks = zeros(1,length(OL_diff_trp_1));
OL_diff_trp1_lats = zeros(1,length(OL_diff_trp_1));
OL_diff_trp2_pks = zeros(1,length(OL_diff_trp_2)); % Create pk amplitude variable
OL_diff_trp2_lats = zeros(1,length(OL_diff_trp_2));% Create peak latency variable
peak_window = [];

for n = 1: length(OL_diff_trp_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(-OL_diff_trp_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OL_diff_trp1_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OL_diff_trp1_lats(n) = 0;
    else
        OL_diff_trp1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OL_diff_trp1_lats));
for n = 1:length(OL_diff_trp1_lats)
    if OL_diff_trp1_lats(n) == 0
        OL_diff_trp1_lats(n) = meanlat;
        for j=1:length(OL_diff_trp_1{n}.time)
            if (round(OL_diff_trp_1{n}.time(j),4)) == round(OL_diff_trp1_lats(n),4)
                OL_diff_trp1_pks(n)= OL_diff_trp_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(OL_diff_trp_2)
    [pks,locs] = findpeaks(-OL_diff_trp_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OL_diff_trp2_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OL_diff_trp2_lats(n) = 0;
    else
        OL_diff_trp2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OL_diff_trp2_lats));
for n = 1:length(OL_diff_trp2_lats)
    if OL_diff_trp2_lats(n) == 0
        OL_diff_trp2_lats(n) = meanlat;
        for j=1:length(OL_diff_trp_2{n}.time)
            if (round(OL_diff_trp_2{n}.time(j),4)) == round(OL_diff_trp2_lats(n),4)
                OL_diff_trp2_pks(n)= OL_diff_trp_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(OL_trp_D1,2)
    OL_trp_D1{1,Participant}.MMRPeakValue = OL_diff_trp1_pks(Participant);
    OL_trp_D1{1,Participant}.MMRPeakLatency = OL_diff_trp1_lats(Participant);
    OL_trp_D1{1,Participant}.MMRWindowStart = OL_diff_trp1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    OL_trp_D1{1,Participant}.MMRWindowEnd = OL_diff_trp1_lats(Participant)+0.050000;
    
    OL_trp_D2{1,Participant}.MMRPeakValue = OL_diff_trp2_pks(Participant);
    OL_trp_D2{1,Participant}.MMRPeakLatency = OL_diff_trp2_lats(Participant);
    OL_trp_D2{1,Participant}.MMRWindowStart = OL_diff_trp2_lats(Participant)-0.05000;
    OL_trp_D2{1,Participant}.MMRWindowEnd = OL_diff_trp2_lats(Participant)+0.050000;
    
    OL_trp_S1{1,Participant}.MMRPeakLatency = OL_diff_trp1_lats(Participant); %put window latency into the standard trial data
    OL_trp_S1{1,Participant}.MMRWindowStart = OL_diff_trp1_lats(Participant)-0.05000;
    OL_trp_S1{1,Participant}.MMRWindowEnd = OL_diff_trp1_lats(Participant)+0.050000;
    
    OL_trp_S2{1,Participant}.MMRPeakLatency = OL_diff_trp2_lats(Participant);
    OL_trp_S2{1,Participant}.MMRWindowStart = OL_diff_trp2_lats(Participant)-0.05000;
    OL_trp_S2{1,Participant}.MMRWindowEnd = OL_diff_trp2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OL_trp_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(OL_trp_D1{1,Participant}.MMRWindowStart,4))
            OL_trp_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(OL_trp_D1{1,Participant}.MMRWindowEnd,4))
            OL_trp_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OL_trp_D1{1,Participant}.avg(StartIndex:EndIndex));
    OL_trp_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OL_trp_S1{1,Participant}.avg(StartIndex:EndIndex));
    OL_trp_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OL_trp_D2,2) % D2/S2
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(OL_trp_D2{1,Participant}.MMRWindowStart,4))
            OL_trp_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(OL_trp_D2{1,Participant}.MMRWindowEnd,4))
            OL_trp_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OL_trp_D2{1,Participant}.avg(StartIndex:EndIndex));
    OL_trp_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OL_trp_S2{1,Participant}.avg(StartIndex:EndIndex));
    OL_trp_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

%% Find the peaks in the dup data for MMR in OZ
% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
OZ_diff_dup1_pks = zeros(1,length(OZ_diff_dup_1));
OZ_diff_dup1_lats = zeros(1,length(OZ_diff_dup_1));
OZ_diff_dup2_pks = zeros(1,length(OZ_diff_dup_2)); % Create pk amplitude variable
OZ_diff_dup2_lats = zeros(1,length(OZ_diff_dup_2));% Create peak latency variable
peak_window = [];

for n = 1: length(OZ_diff_dup_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(-OZ_diff_dup_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OZ_diff_dup1_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OZ_diff_dup1_lats(n) = 0;
    else
        OZ_diff_dup1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OZ_diff_dup1_lats));
for n = 1:length(OZ_diff_dup1_lats)
    if OZ_diff_dup1_lats(n) == 0
        OZ_diff_dup1_lats(n) = meanlat;
        for j=1:length(OZ_diff_dup_1{n}.time)
            if (round(OZ_diff_dup_1{n}.time(j),4)) == round(OZ_diff_dup1_lats(n),4)
                OZ_diff_dup1_pks(n)= OZ_diff_dup_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(OZ_diff_dup_2)
    [pks,locs] = findpeaks(-OZ_diff_dup_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OZ_diff_dup2_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OZ_diff_dup2_lats(n) = 0;
    else
        OZ_diff_dup2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OZ_diff_dup2_lats));
for n = 1:length(OZ_diff_dup2_lats)
    if OZ_diff_dup2_lats(n) == 0
        OZ_diff_dup2_lats(n) = meanlat;
        for j=1:length(OZ_diff_dup_2{n}.time)
            if (round(OZ_diff_dup_2{n}.time(j),4)) == round(OZ_diff_dup2_lats(n),4)
                OZ_diff_dup2_pks(n)= OZ_diff_dup_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(OZ_dup_D1,2)
    OZ_dup_D1{1,Participant}.MMRPeakValue = OZ_diff_dup1_pks(Participant);
    OZ_dup_D1{1,Participant}.MMRPeakLatency = OZ_diff_dup1_lats(Participant);
    OZ_dup_D1{1,Participant}.MMRWindowStart = OZ_diff_dup1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    OZ_dup_D1{1,Participant}.MMRWindowEnd = OZ_diff_dup1_lats(Participant)+0.050000;
    
    OZ_dup_D2{1,Participant}.MMRPeakValue = OZ_diff_dup2_pks(Participant);
    OZ_dup_D2{1,Participant}.MMRPeakLatency = OZ_diff_dup2_lats(Participant);
    OZ_dup_D2{1,Participant}.MMRWindowStart = OZ_diff_dup2_lats(Participant)-0.05000;
    OZ_dup_D2{1,Participant}.MMRWindowEnd = OZ_diff_dup2_lats(Participant)+0.050000;
    
    OZ_dup_S1{1,Participant}.MMRPeakLatency = OZ_diff_dup1_lats(Participant); %put window latency into the standard trial data
    OZ_dup_S1{1,Participant}.MMRWindowStart = OZ_diff_dup1_lats(Participant)-0.05000;
    OZ_dup_S1{1,Participant}.MMRWindowEnd = OZ_diff_dup1_lats(Participant)+0.050000;
    
    OZ_dup_S2{1,Participant}.MMRPeakLatency = OZ_diff_dup2_lats(Participant);
    OZ_dup_S2{1,Participant}.MMRWindowStart = OZ_diff_dup2_lats(Participant)-0.05000;
    OZ_dup_S2{1,Participant}.MMRWindowEnd = OZ_diff_dup2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OZ_dup_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(OZ_dup_D1{1,Participant}.MMRWindowStart,4))
            OZ_dup_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(OZ_dup_D1{1,Participant}.MMRWindowEnd,4))
            OZ_dup_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OZ_dup_D1{1,Participant}.avg(StartIndex:EndIndex));
    OZ_dup_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OZ_dup_S1{1,Participant}.avg(StartIndex:EndIndex));
    OZ_dup_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OZ_dup_D2,2) % D2/S2
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(OZ_dup_D2{1,Participant}.MMRWindowStart,4))
            OZ_dup_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(OZ_dup_D2{1,Participant}.MMRWindowEnd,4))
            OZ_dup_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OZ_dup_D2{1,Participant}.avg(StartIndex:EndIndex));
    OZ_dup_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OZ_dup_S2{1,Participant}.avg(StartIndex:EndIndex));
    OZ_dup_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

%% Find the peaks in the trp data for MMR in OZ
% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
OZ_diff_trp1_pks = zeros(1,length(OZ_diff_trp_1));
OZ_diff_trp1_lats = zeros(1,length(OZ_diff_trp_1));
OZ_diff_trp2_pks = zeros(1,length(OZ_diff_trp_2)); % Create pk amplitude variable
OZ_diff_trp2_lats = zeros(1,length(OZ_diff_trp_2));% Create peak latency variable
peak_window = [];

for n = 1: length(OZ_diff_trp_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(-OZ_diff_trp_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OZ_diff_trp1_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OZ_diff_trp1_lats(n) = 0;
    else
        OZ_diff_trp1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OZ_diff_trp1_lats));
for n = 1:length(OZ_diff_trp1_lats)
    if OZ_diff_trp1_lats(n) == 0
        OZ_diff_trp1_lats(n) = meanlat;
        for j=1:length(OZ_diff_trp_1{n}.time)
            if (round(OZ_diff_trp_1{n}.time(j),4)) == round(OZ_diff_trp1_lats(n),4)
                OZ_diff_trp1_pks(n)= OZ_diff_trp_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(OZ_diff_trp_2)
    [pks,locs] = findpeaks(-OZ_diff_trp_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OZ_diff_trp2_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OZ_diff_trp2_lats(n) = 0;
    else
        OZ_diff_trp2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OZ_diff_trp2_lats));
for n = 1:length(OZ_diff_trp2_lats)
    if OZ_diff_trp2_lats(n) == 0
        OZ_diff_trp2_lats(n) = meanlat;
        for j=1:length(OZ_diff_trp_2{n}.time)
            if (round(OZ_diff_trp_2{n}.time(j),4)) == round(OZ_diff_trp2_lats(n),4)
                OZ_diff_trp2_pks(n)= OZ_diff_trp_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(OZ_trp_D1,2)
    OZ_trp_D1{1,Participant}.MMRPeakValue = OZ_diff_trp1_pks(Participant);
    OZ_trp_D1{1,Participant}.MMRPeakLatency = OZ_diff_trp1_lats(Participant);
    OZ_trp_D1{1,Participant}.MMRWindowStart = OZ_diff_trp1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    OZ_trp_D1{1,Participant}.MMRWindowEnd = OZ_diff_trp1_lats(Participant)+0.050000;
    
    OZ_trp_D2{1,Participant}.MMRPeakValue = OZ_diff_trp2_pks(Participant);
    OZ_trp_D2{1,Participant}.MMRPeakLatency = OZ_diff_trp2_lats(Participant);
    OZ_trp_D2{1,Participant}.MMRWindowStart = OZ_diff_trp2_lats(Participant)-0.05000;
    OZ_trp_D2{1,Participant}.MMRWindowEnd = OZ_diff_trp2_lats(Participant)+0.050000;
    
    OZ_trp_S1{1,Participant}.MMRPeakLatency = OZ_diff_trp1_lats(Participant); %put window latency into the standard trial data
    OZ_trp_S1{1,Participant}.MMRWindowStart = OZ_diff_trp1_lats(Participant)-0.05000;
    OZ_trp_S1{1,Participant}.MMRWindowEnd = OZ_diff_trp1_lats(Participant)+0.050000;
    
    OZ_trp_S2{1,Participant}.MMRPeakLatency = OZ_diff_trp2_lats(Participant);
    OZ_trp_S2{1,Participant}.MMRWindowStart = OZ_diff_trp2_lats(Participant)-0.05000;
    OZ_trp_S2{1,Participant}.MMRWindowEnd = OZ_diff_trp2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OZ_trp_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(OZ_trp_D1{1,Participant}.MMRWindowStart,4))
            OZ_trp_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(OZ_trp_D1{1,Participant}.MMRWindowEnd,4))
            OZ_trp_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OZ_trp_D1{1,Participant}.avg(StartIndex:EndIndex));
    OZ_trp_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OZ_trp_S1{1,Participant}.avg(StartIndex:EndIndex));
    OZ_trp_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OZ_trp_D2,2) % D2/S2
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(OZ_trp_D2{1,Participant}.MMRWindowStart,4))
            OZ_trp_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(OZ_trp_D2{1,Participant}.MMRWindowEnd,4))
            OZ_trp_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OZ_trp_D2{1,Participant}.avg(StartIndex:EndIndex));
    OZ_trp_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OZ_trp_S2{1,Participant}.avg(StartIndex:EndIndex));
    OZ_trp_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end
%% Find the peaks in the dup data for MMR in OR
% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
OR_diff_dup1_pks = zeros(1,length(OR_diff_dup_1));
OR_diff_dup1_lats = zeros(1,length(OR_diff_dup_1));
OR_diff_dup2_pks = zeros(1,length(OR_diff_dup_2)); % Create pk amplitude variable
OR_diff_dup2_lats = zeros(1,length(OR_diff_dup_2));% Create peak latency variable
peak_window = [];

for n = 1: length(OR_diff_dup_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(-OR_diff_dup_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OR_diff_dup1_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OR_diff_dup1_lats(n) = 0;
    else
        OR_diff_dup1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OR_diff_dup1_lats));
for n = 1:length(OR_diff_dup1_lats)
    if OR_diff_dup1_lats(n) == 0
        OR_diff_dup1_lats(n) = meanlat;
        for j=1:length(OR_diff_dup_1{n}.time)
            if (round(OR_diff_dup_1{n}.time(j),4)) == round(OR_diff_dup1_lats(n),4)
                OR_diff_dup1_pks(n)= OR_diff_dup_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(OR_diff_dup_2)
    [pks,locs] = findpeaks(-OR_diff_dup_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OR_diff_dup2_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OR_diff_dup2_lats(n) = 0;
    else
        OR_diff_dup2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OR_diff_dup2_lats));
for n = 1:length(OR_diff_dup2_lats)
    if OR_diff_dup2_lats(n) == 0
        OR_diff_dup2_lats(n) = meanlat;
        for j=1:length(OR_diff_dup_2{n}.time)
            if (round(OR_diff_dup_2{n}.time(j),4)) == round(OR_diff_dup2_lats(n),4)
                OR_diff_dup2_pks(n)= OR_diff_dup_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(OR_dup_D1,2)
    OR_dup_D1{1,Participant}.MMRPeakValue = OR_diff_dup1_pks(Participant);
    OR_dup_D1{1,Participant}.MMRPeakLatency = OR_diff_dup1_lats(Participant);
    OR_dup_D1{1,Participant}.MMRWindowStart = OR_diff_dup1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    OR_dup_D1{1,Participant}.MMRWindowEnd = OR_diff_dup1_lats(Participant)+0.050000;
    
    OR_dup_D2{1,Participant}.MMRPeakValue = OR_diff_dup2_pks(Participant);
    OR_dup_D2{1,Participant}.MMRPeakLatency = OR_diff_dup2_lats(Participant);
    OR_dup_D2{1,Participant}.MMRWindowStart = OR_diff_dup2_lats(Participant)-0.05000;
    OR_dup_D2{1,Participant}.MMRWindowEnd = OR_diff_dup2_lats(Participant)+0.050000;
    
    OR_dup_S1{1,Participant}.MMRPeakLatency = OR_diff_dup1_lats(Participant); %put window latency into the standard trial data
    OR_dup_S1{1,Participant}.MMRWindowStart = OR_diff_dup1_lats(Participant)-0.05000;
    OR_dup_S1{1,Participant}.MMRWindowEnd = OR_diff_dup1_lats(Participant)+0.050000;
    
    OR_dup_S2{1,Participant}.MMRPeakLatency = OR_diff_dup2_lats(Participant);
    OR_dup_S2{1,Participant}.MMRWindowStart = OR_diff_dup2_lats(Participant)-0.05000;
    OR_dup_S2{1,Participant}.MMRWindowEnd = OR_diff_dup2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OR_dup_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(OR_dup_D1{1,Participant}.MMRWindowStart,4))
            OR_dup_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(OR_dup_D1{1,Participant}.MMRWindowEnd,4))
            OR_dup_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OR_dup_D1{1,Participant}.avg(StartIndex:EndIndex));
    OR_dup_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OR_dup_S1{1,Participant}.avg(StartIndex:EndIndex));
    OR_dup_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OR_dup_D2,2) % D2/S2
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(OR_dup_D2{1,Participant}.MMRWindowStart,4))
            OR_dup_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(OR_dup_D2{1,Participant}.MMRWindowEnd,4))
            OR_dup_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OR_dup_D2{1,Participant}.avg(StartIndex:EndIndex));
    OR_dup_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OR_dup_S2{1,Participant}.avg(StartIndex:EndIndex));
    OR_dup_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

%% Find the peaks in the trp data for MMR in OR
% Intilaize variables to store MMR peaks and latencies (change manually for different electrode groupings)
OR_diff_trp1_pks = zeros(1,length(OR_diff_trp_1));
OR_diff_trp1_lats = zeros(1,length(OR_diff_trp_1));
OR_diff_trp2_pks = zeros(1,length(OR_diff_trp_2)); % Create pk amplitude variable
OR_diff_trp2_lats = zeros(1,length(OR_diff_trp_2));% Create peak latency variable
peak_window = [];

for n = 1: length(OR_diff_trp_1) %Find the peaks and locations in the Deviant 1 data.
    [pks,locs] = findpeaks(-OR_diff_trp_1{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OR_diff_trp1_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OR_diff_trp1_lats(n) = 0;
    else
        OR_diff_trp1_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OR_diff_trp1_lats));
for n = 1:length(OR_diff_trp1_lats)
    if OR_diff_trp1_lats(n) == 0
        OR_diff_trp1_lats(n) = meanlat;
        for j=1:length(OR_diff_trp_1{n}.time)
            if (round(OR_diff_trp_1{n}.time(j),4)) == round(OR_diff_trp1_lats(n),4)
                OR_diff_trp1_pks(n)= OR_diff_trp_1{n}.avg(j);
            end
        end
    end
end
clear meanlat

%D2
for n = 1: length(OR_diff_trp_2)
    [pks,locs] = findpeaks(-OR_diff_trp_2{n}.avg, time_vectorD1);
    for i=1:length(pks)
        if locs(i) > 0.200 && locs(i) < 0.400 %
            peak_window(i) = -pks(i);
            locs_window(i) = locs(i);
        end
    end
    if isempty(peak_window)
        peak_window = 0;
    end
    [OR_diff_trp2_pks(n), max_index] = min(peak_window);
    if min(peak_window) == 0
        OR_diff_trp2_lats(n) = 0;
    else
        OR_diff_trp2_lats(n) = locs(max_index);
    end
    peak_window = [];
    clear max_index pks locs locs_window
end
%deal with peaks with 0 value
meanlat = mean(nonzeros(OR_diff_trp2_lats));
for n = 1:length(OR_diff_trp2_lats)
    if OR_diff_trp2_lats(n) == 0
        OR_diff_trp2_lats(n) = meanlat;
        for j=1:length(OR_diff_trp_2{n}.time)
            if (round(OR_diff_trp_2{n}.time(j),4)) == round(OR_diff_trp2_lats(n),4)
                OR_diff_trp2_pks(n)= OR_diff_trp_2{n}.avg(j);
            end
        end
    end
end
clear meanlat


for Participant = 1:size(OR_trp_D1,2)
    OR_trp_D1{1,Participant}.MMRPeakValue = OR_diff_trp1_pks(Participant);
    OR_trp_D1{1,Participant}.MMRPeakLatency = OR_diff_trp1_lats(Participant);
    OR_trp_D1{1,Participant}.MMRWindowStart = OR_diff_trp1_lats(Participant)-0.05000; %note, this used to be 0.04 (changed Jan 2020)
    OR_trp_D1{1,Participant}.MMRWindowEnd = OR_diff_trp1_lats(Participant)+0.050000;
    
    OR_trp_D2{1,Participant}.MMRPeakValue = OR_diff_trp2_pks(Participant);
    OR_trp_D2{1,Participant}.MMRPeakLatency = OR_diff_trp2_lats(Participant);
    OR_trp_D2{1,Participant}.MMRWindowStart = OR_diff_trp2_lats(Participant)-0.05000;
    OR_trp_D2{1,Participant}.MMRWindowEnd = OR_diff_trp2_lats(Participant)+0.050000;
    
    OR_trp_S1{1,Participant}.MMRPeakLatency = OR_diff_trp1_lats(Participant); %put window latency into the standard trial data
    OR_trp_S1{1,Participant}.MMRWindowStart = OR_diff_trp1_lats(Participant)-0.05000;
    OR_trp_S1{1,Participant}.MMRWindowEnd = OR_diff_trp1_lats(Participant)+0.050000;
    
    OR_trp_S2{1,Participant}.MMRPeakLatency = OR_diff_trp2_lats(Participant);
    OR_trp_S2{1,Participant}.MMRWindowStart = OR_diff_trp2_lats(Participant)-0.05000;
    OR_trp_S2{1,Participant}.MMRWindowEnd = OR_diff_trp2_lats(Participant)+0.050000;
end

%Intialize Indexes
StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OR_trp_D1,2) % D1/S1
    for j=1:length(time_vectorD1)
        if (round(time_vectorD1(j),4) == round(OR_trp_D1{1,Participant}.MMRWindowStart,4))
            OR_trp_D1{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD1(j),4) == round(OR_trp_D1{1,Participant}.MMRWindowEnd,4))
            OR_trp_D1{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OR_trp_D1{1,Participant}.avg(StartIndex:EndIndex));
    OR_trp_D1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OR_trp_S1{1,Participant}.avg(StartIndex:EndIndex));
    OR_trp_S1{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end

StartIndex = 1;
EndIndex = 1;

for Participant = 1:size(OR_trp_D2,2) % D2/S2
    for j=1:length(time_vectorD2)
        if (round(time_vectorD2(j),4) == round(OR_trp_D2{1,Participant}.MMRWindowStart,4))
            OR_trp_D2{1,Participant}.StartIndex = j;
            StartIndex = j;
        end
        
        if (round(time_vectorD2(j),4) == round(OR_trp_D2{1,Participant}.MMRWindowEnd,4))
            OR_trp_D2{1,Participant}.EndIndex = j;
            EndIndex = j;
        end
    end
    AvgAmpMMRWind_D = mean(OR_trp_D2{1,Participant}.avg(StartIndex:EndIndex));
    OR_trp_D2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_D;
    
    AvgAmpMMRWind_S = mean(OR_trp_S2{1,Participant}.avg(StartIndex:EndIndex));
    OR_trp_S2{1,Participant}.AvgAmpMMRWind = AvgAmpMMRWind_S;
end


%% create amps for frontals
%FL S1
FL_S1_Amps = zeros((length(FL_dup_S1)+length(FL_trp_S1)),1);
for n = 1:length(FL_dup_S1)
    FL_S1_Amps(n,1) = FL_dup_S1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FL_trp_S1)
    FL_S1_Amps((n+length(FL_dup_S1)),1) = FL_trp_S1{1,n}.AvgAmpMMRWind;
end

%FL D1
FL_D1_Amps = zeros((length(FL_dup_D1)+length(FL_trp_D1)),1);
for n = 1:length(FL_dup_D1)
    FL_D1_Amps(n,1) = FL_dup_D1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FL_trp_D1)
    FL_D1_Amps((n+length(FL_dup_D1)),1) = FL_trp_D1{1,n}.AvgAmpMMRWind;
end

%FL S2
FL_S2_Amps = zeros((length(FL_dup_S2)+length(FL_trp_S2)),1);
for n = 1:length(FL_dup_S2)
    FL_S2_Amps(n,1) = FL_dup_S2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FL_trp_S2)
    FL_S2_Amps((n+length(FL_dup_S2)),1) = FL_trp_S2{1,n}.AvgAmpMMRWind;
end

%FL D2
FL_D2_Amps = zeros((length(FL_dup_D2)+length(FL_trp_D2)),1);
for n = 1:length(FL_dup_D2)
    FL_D2_Amps(n,1) = FL_dup_D2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FL_trp_D2)
    FL_D2_Amps((n+length(FL_dup_D2)),1) = FL_trp_D2{1,n}.AvgAmpMMRWind;
end

%FZ S1
FZ_S1_Amps = zeros((length(FZ_dup_S1)+length(FZ_trp_S1)),1);
for n = 1:length(FZ_dup_S1)
    FZ_S1_Amps(n,1) = FZ_dup_S1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FZ_trp_S1)
    FZ_S1_Amps((n+length(FZ_dup_S1)),1) = FZ_trp_S1{1,n}.AvgAmpMMRWind;
end

%FZ D1
FZ_D1_Amps = zeros((length(FZ_dup_D1)+length(FZ_trp_D1)),1);
for n = 1:length(FZ_dup_D1)
    FZ_D1_Amps(n,1) = FZ_dup_D1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FZ_trp_D1)
    FZ_D1_Amps((n+length(FZ_dup_D1)),1) = FZ_trp_D1{1,n}.AvgAmpMMRWind;
end

%FZ S2
FZ_S2_Amps = zeros((length(FZ_dup_S2)+length(FZ_trp_S2)),1);
for n = 1:length(FZ_dup_S2)
    FZ_S2_Amps(n,1) = FZ_dup_S2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FZ_trp_S2)
    FZ_S2_Amps((n+length(FZ_dup_S2)),1) = FZ_trp_S2{1,n}.AvgAmpMMRWind;
end

%FZ D2
FZ_D2_Amps = zeros((length(FZ_dup_D2)+length(FZ_trp_D2)),1);
for n = 1:length(FZ_dup_D2)
    FZ_D2_Amps(n,1) = FZ_dup_D2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FZ_trp_D2)
    FZ_D2_Amps((n+length(FZ_dup_D2)),1) = FZ_trp_D2{1,n}.AvgAmpMMRWind;
end

%FR S1
FR_S1_Amps = zeros((length(FR_dup_S1)+length(FR_trp_S1)),1);
for n = 1:length(FR_dup_S1)
    FR_S1_Amps(n,1) = FR_dup_S1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FR_trp_S1)
    FR_S1_Amps((n+length(FR_dup_S1)),1) = FR_trp_S1{1,n}.AvgAmpMMRWind;
end

%FR D1
FR_D1_Amps = zeros((length(FR_dup_D1)+length(FR_trp_D1)),1);
for n = 1:length(FR_dup_D1)
    FR_D1_Amps(n,1) = FR_dup_D1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FR_trp_D1)
    FR_D1_Amps((n+length(FR_dup_D1)),1) = FR_trp_D1{1,n}.AvgAmpMMRWind;
end

%FR S2
FR_S2_Amps = zeros((length(FR_dup_S2)+length(FR_trp_S2)),1);
for n = 1:length(FR_dup_S2)
    FR_S2_Amps(n,1) = FR_dup_S2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FR_trp_S2)
    FR_S2_Amps((n+length(FR_dup_S2)),1) = FR_trp_S2{1,n}.AvgAmpMMRWind;
end

%FR D2
FR_D2_Amps = zeros((length(FR_dup_D2)+length(FR_trp_D2)),1);
for n = 1:length(FR_dup_D2)
    FR_D2_Amps(n,1) = FR_dup_D2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(FR_trp_D2)
    FR_D2_Amps((n+length(FR_dup_D2)),1) = FR_trp_D2{1,n}.AvgAmpMMRWind;
end

%% Occipitals
%OL S1
OL_S1_Amps = zeros((length(OL_dup_S1)+length(OL_trp_S1)),1);
for n = 1:length(OL_dup_S1)
    OL_S1_Amps(n,1) = OL_dup_S1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OL_trp_S1)
    OL_S1_Amps((n+length(OL_dup_S1)),1) = OL_trp_S1{1,n}.AvgAmpMMRWind;
end

%OL D1
OL_D1_Amps = zeros((length(OL_dup_D1)+length(OL_trp_D1)),1);
for n = 1:length(OL_dup_D1)
    OL_D1_Amps(n,1) = OL_dup_D1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OL_trp_D1)
    OL_D1_Amps((n+length(OL_dup_D1)),1) = OL_trp_D1{1,n}.AvgAmpMMRWind;
end

%OL S2
OL_S2_Amps = zeros((length(OL_dup_S2)+length(OL_trp_S2)),1);
for n = 1:length(OL_dup_S2)
    OL_S2_Amps(n,1) = OL_dup_S2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OL_trp_S2)
    OL_S2_Amps((n+length(OL_dup_S2)),1) = OL_trp_S2{1,n}.AvgAmpMMRWind;
end

%OL D2
OL_D2_Amps = zeros((length(OL_dup_D2)+length(OL_trp_D2)),1);
for n = 1:length(OL_dup_D2)
    OL_D2_Amps(n,1) = OL_dup_D2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OL_trp_D2)
    OL_D2_Amps((n+length(OL_dup_D2)),1) = OL_trp_D2{1,n}.AvgAmpMMRWind;
end

%OZ S1
OZ_S1_Amps = zeros((length(OZ_dup_S1)+length(OZ_trp_S1)),1);
for n = 1:length(OZ_dup_S1)
    OZ_S1_Amps(n,1) = OZ_dup_S1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OZ_trp_S1)
    OZ_S1_Amps((n+length(OZ_dup_S1)),1) = OZ_trp_S1{1,n}.AvgAmpMMRWind;
end

%OZ D1
OZ_D1_Amps = zeros((length(OZ_dup_D1)+length(OZ_trp_D1)),1);
for n = 1:length(OZ_dup_D1)
    OZ_D1_Amps(n,1) = OZ_dup_D1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OZ_trp_D1)
    OZ_D1_Amps((n+length(OZ_dup_D1)),1) = OZ_trp_D1{1,n}.AvgAmpMMRWind;
end

%OZ S2
OZ_S2_Amps = zeros((length(OZ_dup_S2)+length(OZ_trp_S2)),1);
for n = 1:length(OZ_dup_S2)
    OZ_S2_Amps(n,1) = OZ_dup_S2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OZ_trp_S2)
    OZ_S2_Amps((n+length(OZ_dup_S2)),1) = OZ_trp_S2{1,n}.AvgAmpMMRWind;
end

%OZ D2
OZ_D2_Amps = zeros((length(OZ_dup_D2)+length(OZ_trp_D2)),1);
for n = 1:length(OZ_dup_D2)
    OZ_D2_Amps(n,1) = OZ_dup_D2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OZ_trp_D2)
    OZ_D2_Amps((n+length(OZ_dup_D2)),1) = OZ_trp_D2{1,n}.AvgAmpMMRWind;
end

%OR S1
OR_S1_Amps = zeros((length(OR_dup_S1)+length(OR_trp_S1)),1);
for n = 1:length(OR_dup_S1)
    OR_S1_Amps(n,1) = OR_dup_S1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OR_trp_S1)
    OR_S1_Amps((n+length(OR_dup_S1)),1) = OR_trp_S1{1,n}.AvgAmpMMRWind;
end

%OR D1
OR_D1_Amps = zeros((length(OR_dup_D1)+length(OR_trp_D1)),1);
for n = 1:length(OR_dup_D1)
    OR_D1_Amps(n,1) = OR_dup_D1{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OR_trp_D1)
    OR_D1_Amps((n+length(OR_dup_D1)),1) = OR_trp_D1{1,n}.AvgAmpMMRWind;
end

%OR S2
OR_S2_Amps = zeros((length(OR_dup_S2)+length(OR_trp_S2)),1);
for n = 1:length(OR_dup_S2)
    OR_S2_Amps(n,1) = OR_dup_S2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OR_trp_S2)
    OR_S2_Amps((n+length(OR_dup_S2)),1) = OR_trp_S2{1,n}.AvgAmpMMRWind;
end

%OR D2
OR_D2_Amps = zeros((length(OR_dup_D2)+length(OR_trp_D2)),1);
for n = 1:length(OR_dup_D2)
    OR_D2_Amps(n,1) = OR_dup_D2{1,n}.AvgAmpMMRWind;
end
for n = 1:length(OR_trp_D2)
    OR_D2_Amps((n+length(OR_dup_D2)),1) = OR_trp_D2{1,n}.AvgAmpMMRWind;
end
%% Export the latencies for frontals

%FL S1
FL_S1_Lats = zeros((length(FL_dup_S1)+length(FL_trp_S1)),1);
for n = 1:length(FL_dup_S1)
    FL_S1_Lats(n,1) = FL_dup_S1{1,n}.MMRPeakLatency;
end
for n = 1:length(FL_trp_S1)
    FL_S1_Lats((n+length(FL_dup_S1)),1) = FL_trp_S1{1,n}.MMRPeakLatency;
end

%FL D1
FL_D1_Lats = zeros((length(FL_dup_D1)+length(FL_trp_D1)),1);
for n = 1:length(FL_dup_D1)
    FL_D1_Lats(n,1) = FL_dup_D1{1,n}.MMRPeakLatency;
end
for n = 1:length(FL_trp_D1)
    FL_D1_Lats((n+length(FL_dup_D1)),1) = FL_trp_D1{1,n}.MMRPeakLatency;
end

%FL S2
FL_S2_Lats = zeros((length(FL_dup_S2)+length(FL_trp_S2)),1);
for n = 1:length(FL_dup_S2)
    FL_S2_Lats(n,1) = FL_dup_S2{1,n}.MMRPeakLatency;
end
for n = 1:length(FL_trp_S2)
    FL_S2_Lats((n+length(FL_dup_S2)),1) = FL_trp_S2{1,n}.MMRPeakLatency;
end

%FL D2
FL_D2_Lats = zeros((length(FL_dup_D2)+length(FL_trp_D2)),1);
for n = 1:length(FL_dup_D2)
    FL_D2_Lats(n,1) = FL_dup_D2{1,n}.MMRPeakLatency;
end
for n = 1:length(FL_trp_D2)
    FL_D2_Lats((n+length(FL_dup_D2)),1) = FL_trp_D2{1,n}.MMRPeakLatency;
end

%FZ S1
FZ_S1_Lats = zeros((length(FZ_dup_S1)+length(FZ_trp_S1)),1);
for n = 1:length(FZ_dup_S1)
    FZ_S1_Lats(n,1) = FZ_dup_S1{1,n}.MMRPeakLatency;
end
for n = 1:length(FZ_trp_S1)
    FZ_S1_Lats((n+length(FZ_dup_S1)),1) = FZ_trp_S1{1,n}.MMRPeakLatency;
end

%FZ D1
FZ_D1_Lats = zeros((length(FZ_dup_D1)+length(FZ_trp_D1)),1);
for n = 1:length(FZ_dup_D1)
    FZ_D1_Lats(n,1) = FZ_dup_D1{1,n}.MMRPeakLatency;
end
for n = 1:length(FZ_trp_D1)
    FZ_D1_Lats((n+length(FZ_dup_D1)),1) = FZ_trp_D1{1,n}.MMRPeakLatency;
end

%FZ S2
FZ_S2_Lats = zeros((length(FZ_dup_S2)+length(FZ_trp_S2)),1);
for n = 1:length(FZ_dup_S2)
    FZ_S2_Lats(n,1) = FZ_dup_S2{1,n}.MMRPeakLatency;
end
for n = 1:length(FZ_trp_S2)
    FZ_S2_Lats((n+length(FZ_dup_S2)),1) = FZ_trp_S2{1,n}.MMRPeakLatency;
end

%FZ D2
FZ_D2_Lats = zeros((length(FZ_dup_D2)+length(FZ_trp_D2)),1);
for n = 1:length(FZ_dup_D2)
    FZ_D2_Lats(n,1) = FZ_dup_D2{1,n}.MMRPeakLatency;
end
for n = 1:length(FZ_trp_D2)
    FZ_D2_Lats((n+length(FZ_dup_D2)),1) = FZ_trp_D2{1,n}.MMRPeakLatency;
end

%FR S1
FR_S1_Lats = zeros((length(FR_dup_S1)+length(FR_trp_S1)),1);
for n = 1:length(FR_dup_S1)
    FR_S1_Lats(n,1) = FR_dup_S1{1,n}.MMRPeakLatency;
end
for n = 1:length(FR_trp_S1)
    FR_S1_Lats((n+length(FR_dup_S1)),1) = FR_trp_S1{1,n}.MMRPeakLatency;
end

%FR D1
FR_D1_Lats = zeros((length(FR_dup_D1)+length(FR_trp_D1)),1);
for n = 1:length(FR_dup_D1)
    FR_D1_Lats(n,1) = FR_dup_D1{1,n}.MMRPeakLatency;
end
for n = 1:length(FR_trp_D1)
    FR_D1_Lats((n+length(FR_dup_D1)),1) = FR_trp_D1{1,n}.MMRPeakLatency;
end

%FR S2
FR_S2_Lats = zeros((length(FR_dup_S2)+length(FR_trp_S2)),1);
for n = 1:length(FR_dup_S2)
    FR_S2_Lats(n,1) = FR_dup_S2{1,n}.MMRPeakLatency;
end
for n = 1:length(FR_trp_S2)
    FR_S2_Lats((n+length(FR_dup_S2)),1) = FR_trp_S2{1,n}.MMRPeakLatency;
end

%FR D2
FR_D2_Lats = zeros((length(FR_dup_D2)+length(FR_trp_D2)),1);
for n = 1:length(FR_dup_D2)
    FR_D2_Lats(n,1) = FR_dup_D2{1,n}.MMRPeakLatency;
end
for n = 1:length(FR_trp_D2)
    FR_D2_Lats((n+length(FR_dup_D2)),1) = FR_trp_D2{1,n}.MMRPeakLatency;
end

%% Export the latencies for occipitals

%OL S1
OL_S1_Lats = zeros((length(OL_dup_S1)+length(OL_trp_S1)),1);
for n = 1:length(OL_dup_S1)
    OL_S1_Lats(n,1) = OL_dup_S1{1,n}.MMRPeakLatency;
end
for n = 1:length(OL_trp_S1)
    OL_S1_Lats((n+length(OL_dup_S1)),1) = OL_trp_S1{1,n}.MMRPeakLatency;
end

%OL D1
OL_D1_Lats = zeros((length(OL_dup_D1)+length(OL_trp_D1)),1);
for n = 1:length(OL_dup_D1)
    OL_D1_Lats(n,1) = OL_dup_D1{1,n}.MMRPeakLatency;
end
for n = 1:length(OL_trp_D1)
    OL_D1_Lats((n+length(OL_dup_D1)),1) = OL_trp_D1{1,n}.MMRPeakLatency;
end

%OL S2
OL_S2_Lats = zeros((length(OL_dup_S2)+length(OL_trp_S2)),1);
for n = 1:length(OL_dup_S2)
    OL_S2_Lats(n,1) = OL_dup_S2{1,n}.MMRPeakLatency;
end
for n = 1:length(OL_trp_S2)
    OL_S2_Lats((n+length(OL_dup_S2)),1) = OL_trp_S2{1,n}.MMRPeakLatency;
end

%OL D2
OL_D2_Lats = zeros((length(OL_dup_D2)+length(OL_trp_D2)),1);
for n = 1:length(OL_dup_D2)
    OL_D2_Lats(n,1) = OL_dup_D2{1,n}.MMRPeakLatency;
end
for n = 1:length(OL_trp_D2)
    OL_D2_Lats((n+length(OL_dup_D2)),1) = OL_trp_D2{1,n}.MMRPeakLatency;
end

%OZ S1
OZ_S1_Lats = zeros((length(OZ_dup_S1)+length(OZ_trp_S1)),1);
for n = 1:length(OZ_dup_S1)
    OZ_S1_Lats(n,1) = OZ_dup_S1{1,n}.MMRPeakLatency;
end
for n = 1:length(OZ_trp_S1)
    OZ_S1_Lats((n+length(OZ_dup_S1)),1) = OZ_trp_S1{1,n}.MMRPeakLatency;
end

%OZ D1
OZ_D1_Lats = zeros((length(OZ_dup_D1)+length(OZ_trp_D1)),1);
for n = 1:length(OZ_dup_D1)
    OZ_D1_Lats(n,1) = OZ_dup_D1{1,n}.MMRPeakLatency;
end
for n = 1:length(OZ_trp_D1)
    OZ_D1_Lats((n+length(OZ_dup_D1)),1) = OZ_trp_D1{1,n}.MMRPeakLatency;
end

%OZ S2
OZ_S2_Lats = zeros((length(OZ_dup_S2)+length(OZ_trp_S2)),1);
for n = 1:length(OZ_dup_S2)
    OZ_S2_Lats(n,1) = OZ_dup_S2{1,n}.MMRPeakLatency;
end
for n = 1:length(OZ_trp_S2)
    OZ_S2_Lats((n+length(OZ_dup_S2)),1) = OZ_trp_S2{1,n}.MMRPeakLatency;
end

%OZ D2
OZ_D2_Lats = zeros((length(OZ_dup_D2)+length(OZ_trp_D2)),1);
for n = 1:length(OZ_dup_D2)
    OZ_D2_Lats(n,1) = OZ_dup_D2{1,n}.MMRPeakLatency;
end
for n = 1:length(OZ_trp_D2)
    OZ_D2_Lats((n+length(OZ_dup_D2)),1) = OZ_trp_D2{1,n}.MMRPeakLatency;
end

%OR S1
OR_S1_Lats = zeros((length(OR_dup_S1)+length(OR_trp_S1)),1);
for n = 1:length(OR_dup_S1)
    OR_S1_Lats(n,1) = OR_dup_S1{1,n}.MMRPeakLatency;
end
for n = 1:length(OR_trp_S1)
    OR_S1_Lats((n+length(OR_dup_S1)),1) = OR_trp_S1{1,n}.MMRPeakLatency;
end

%OR D1
OR_D1_Lats = zeros((length(OR_dup_D1)+length(OR_trp_D1)),1);
for n = 1:length(OR_dup_D1)
    OR_D1_Lats(n,1) = OR_dup_D1{1,n}.MMRPeakLatency;
end
for n = 1:length(OR_trp_D1)
    OR_D1_Lats((n+length(OR_dup_D1)),1) = OR_trp_D1{1,n}.MMRPeakLatency;
end

%OR S2
OR_S2_Lats = zeros((length(OR_dup_S2)+length(OR_trp_S2)),1);
for n = 1:length(OR_dup_S2)
    OR_S2_Lats(n,1) = OR_dup_S2{1,n}.MMRPeakLatency;
end
for n = 1:length(OR_trp_S2)
    OR_S2_Lats((n+length(OR_dup_S2)),1) = OR_trp_S2{1,n}.MMRPeakLatency;
end

%OR D2
OR_D2_Lats = zeros((length(OR_dup_D2)+length(OR_trp_D2)),1);
for n = 1:length(OR_dup_D2)
    OR_D2_Lats(n,1) = OR_dup_D2{1,n}.MMRPeakLatency;
end
for n = 1:length(OR_trp_D2)
    OR_D2_Lats((n+length(OR_dup_D2)),1) = OR_trp_D2{1,n}.MMRPeakLatency;
end
