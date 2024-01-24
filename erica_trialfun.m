% function [trl,event] = erica_trialfun(cfg)
function trl = erica_trialfun(cfg) % 


event = ft_read_event(cfg.dataset, 'eventformat', 'egi_mff_v2' ); % read out the events and select them
    
% for EGI, the trigger is in the "eventtype", rather than "eventvalue"    

    trl = [];
    hdr.Fs = 1000;
    
    for i=1:length(event)
       
        if strcmp(event(i).type, 'DIN1') % standard duration (first tone)
%                 % the first tone of standard duration, for modeling the preceding ERP
%                 begsample     = event(i).sample - cfg.trialdef.prestim*hdr.Fs;
%                 endsample     = event(i).sample + cfg.trialdef.poststim*hdr.Fs - 1;
%                 offset        = -cfg.trialdef.prestim*hdr.Fs;  
%                 trigger       = 0; % remember the trigger (=condition) for each trial
%                 trl(end+1, :) = [round([begsample endsample offset])  trigger];
                
                % CONTROL: 500 ms post the onset of the second tone of a gap, for modeling the preceding ERP
                begsample     = event(i).sample - cfg.trialdef.prestim*hdr.Fs;
                endsample     = event(i).sample + cfg.trialdef.poststim*hdr.Fs - 1;
                offset        = -cfg.trialdef.prestim*hdr.Fs;  
                trigger       = 1; 
                trl(end+1, :) = [round([begsample endsample offset])  trigger];
            
        end
    end
       
end