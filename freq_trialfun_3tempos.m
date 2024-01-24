function [trl,event] = freq_trialfun_3tempos(cfg)
%% Segment the data for frequency analysis, after reading the csv trigger files
% First, separate the events by type
event = ft_read_event(cfg.dataset, 'eventformat', 'egi_mff_v2' ) % read events
trl = [];
hdr.Fs = 1000;

event_DIN1 = []; %create new indexes to separate out trigger labels
event_LOOK = [];
event_NOLO = [];

for i=1:length(event)
    if strcmp(event(i).type, 'DIN1')
        event_DIN1 = [event_DIN1,event(i)];
    elseif strcmp(event(i).type, 'LOOK')
        event_LOOK = [event_LOOK,event(i)];
    elseif strcmp(event(i).type, 'NOLO')
        event_NOLO = [event_NOLO,event(i)];
    end
end

%Then, replace the DIN1 codes with the csv trigger codes
% for i=1:length(event_DIN1)
%     event_DIN1(i).type = tempTrigger(i);
% end
%%Segment based on repetitions of the 16 test trials.
event_onset1 = event_DIN1(4:19:length(event_DIN1));
for i=1:length(event_onset1)
    begsample     = event_onset1(i).sample - cfg.trialdef.prestim*hdr.Fs;
    endsample     = event_onset1(i).sample + cfg.trialdef.poststim*hdr.Fs - 1;
    offset        = -cfg.trialdef.prestim*hdr.Fs;
    trigger       = 1;
    trl(end+1, :) = [round([begsample endsample offset])  trigger];
end

end