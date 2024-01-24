% Use this to run the frequency analyses (SSEP/ITPC)
clear;
cd D:\Erica\Infant_Rhythm_3tempos\Matlab_Analysis; % set the directory
addpath ('fieldtrip-20220228','preprocessed_freq_infant')
ft_defaults

subList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,...
    24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47];
listDuple = [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46];
listTriple = [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47];

listRemove = [2,4,10,12,19,31,33,35,43]; % based off no-ab participants
% with > 50% data removed, and the 7 month old, and hearing loss baby

% % remove flagged participants
subList = setdiff(subList,listRemove);
listDuple = setdiff(listDuple,listRemove);
listTriple = setdiff(listTriple,listRemove);

ft_defaults
run(which('mff_setup'))

dup = cell(length(listDuple),1);
trp = cell(length(listTriple),1);
%% ITPC
% Remove the 100 ms prestimulus
cfg = [];
cfg.toilim = [0 31.999];
cD = 1; %condition Duple
cT = 1; %condition Triple

for n1 = subList
    load(['preprocessed_freq_infant/sub',num2str(n1)]) %load files
    if ismember(n1,listDuple)
        dup{cD} = ft_redefinetrial(cfg, data);
        cD = cD+ 1;
    elseif ismember(n1, listTriple)
        trp{cT} = ft_redefinetrial(cfg, data);
        cT = cT+ 1;

    end
    
    clear data
end

% FFT configuration
cfg = [];
cfg.output = 'fourier';
% cfg.output = 'FFT'; % can try this output and see how it differs?
cfg.channel = 'all';
cfg.method = 'mtmfft';
cfg.taper = 'hanning'; % not sure if best method, could also try boxcar
% cfg.taper = 'gausswin';
cfg.pad = 'maxperlen';
cfg.foi = 0:0.03125:4;

dup_itpc = cell(length(listDuple),1);
trp_itpc = cell(length(listTriple),1);
dup_itpc_mat = zeros(125,129,length(listDuple));
trp_itpc_mat = zeros(125,129,length(listTriple));

%% ITPC

% CALCULATE ITPC FOR DUPLE PARTICIPANTS
for n1=1:length(dup) %FFT
    data          = ft_freqanalysis(cfg, dup{n1});
    itc           = [];
    itc.label     = data.label;
    itc.freq      = data.freq;
    itc.dimord    = 'chan_freq';
    F             = data.fourierspctrm;
    N             = size(F,1);
    if sum(isnan(F),'all') > 0
        F(N,:,:) = []; % remove last trial if getting NaNs because incomplete.
    end
    itc.ntrials   = N;

    % compute inter-trial phase coherence (itpc)
    itc.itpc     = F./abs(F);         % divide by amplitude
    itc.itpc     = sum(itc.itpc,1);   % sum angles
    itc.itpc     = abs(itc.itpc)/N;   % take the absolute value and normalize
    itc.itpc     = squeeze(itc.itpc); % remove the first singleton dimension
    dup_itpc{n1} = itc;
    dup_itpc_mat(:,:,n1) = itc.itpc;
end
clear itc

%CALCULATE ITPC FOR TRIPLE PARTICIPANTS
for n1=1:length(trp)
    data = ft_freqanalysis(cfg, trp{n1});
    itc           = [];
    itc.label     = data.label;
    itc.freq      = data.freq;
    itc.dimord    = 'chan_freq';
    F             = data.fourierspctrm;
    N             = size(F,1);
    itc.ntrials   = N;

    % compute inter-trial phase coherence (itpc)
    itc.itpc      = F./abs(F);         % divide by amplitude
    itc.itpc      = sum(itc.itpc,1);   % sum angles
    itc.itpc      = abs(itc.itpc)/N;   % take the absolute value and normalize (wait what about this is normalizing?)
    itc.itpc      = squeeze(itc.itpc); % remove the first singleton dimension
    trp_itpc{n1}  = itc;
    trp_itpc_mat(:,:,n1) = itc.itpc;

end

%% ITPC plot
cfgEGI128chan
% addpath('C:\Users\LabUser\Downloads\raacampbell-shadedErrorBar-0dc4de5\')
freqs = dup_itpc{1,1}.freq;
[~,trp_freq]  = min(abs(freqs-1));
[~,dup_freq]  = min(abs(freqs-1.5));
[~,beat_freq] = min(abs(freqs-3));

% FL = {'E18','E22','E23','E24','E26','E27'}; % NOT SURE THIS IS NECESSARY SINCE THE GROUPINGS SHOULD BE AUTOMATIC?
% FR = {'E2','E3','E9','E10','E123','E124'};
% CL = {'E13','E20','E28','E29','E30','E24','E35','E36','E41'};
% CR = {'E103','E104','E105','E110','E111','E112','E116','E117','E118'};

frontocentral = [FL';FZ';FR';CL';CZ';CR'];
% regions = {FL,FZ,FR,CL,CZ,CR,frontocentral};
regions = {frontocentral};

% if want average of all electrodes, set ALL to 1, if not, set to 0
ALL = 0;
% region_labels = {'FL','FZ','FR','CL','CZ','CR','frontocentral'};
region_labels = {'frontocentral'};

% for groups

for r = 1:length(regions)
    if ALL == 0
        chan_ind = contains(data.label,regions{r});
    else
        chan_ind = ones(125,1);% if want all electrodes
    end
    dup_itpc_avg  = mean(mean(dup_itpc_mat(chan_ind,:,:),3),1);
    dup_sem  = mean(std(dup_itpc_mat(chan_ind,:,:),[],3),1);

    figure();
    subplot(2,1,1)
    shadedErrorBar(freqs,dup_itpc_avg,dup_sem);
    ylim([0 0.8])
    xlabel('Frequency(Hz)')
    ylabel('ITPC')
    if ALL == 0
        title (['ITPC for Duple group in ',region_labels{r}, ' region'])
    else
        title (['ITPC for Duple group in all electrodes'])
    end

    trp_itpc_avg  = mean(mean(trp_itpc_mat(chan_ind,:,:),3),1);
    trp_sem  = mean(std(trp_itpc_mat(chan_ind,:,:),[],3),1);
    subplot(2,1,2)
    shadedErrorBar(freqs,trp_itpc_avg,trp_sem);
    ylim([0 0.8])
    xlabel('Frequency(Hz)')
    ylabel('ITPC')
    if ALL == 0
        title (['ITPC for Triple group in ',region_labels{r}, ' region'])
    else
        title (['ITPC for Triple group in all electrodes'])
    end
    if ALL == 1
        break
    end
end

%% Topoplot
% Get grand average, but call it powspctrm to trick FT into plotting it...
dup_ga_itpc.powspctrm = mean(dup_itpc_mat,3);
trp_ga_itpc.powspctrm = mean(trp_itpc_mat,3);
dup_ga_itpc.freq = freqs;
trp_ga_itpc.freq = freqs;
dup_ga_itpc.dimord    = 'chan_freq';
trp_ga_itpc.dimord    = 'chan_freq';
dup_ga_itpc.label   = labels;
trp_ga_itpc.label    = labels;

% define channel sets
cfgEGI128chan
% DOUBLE CHECK THIS CODE WITH ADULT CODE!!!
% Topoplot
% layout
cfg = [];
layout_data = [];
layout_data.elec = ft_read_sens('GSN-HydroCel-129.sfp');
layout = ft_prepare_layout(cfg,layout_data); % use the sfp to creat the layout file!
layout.label{strcmp(layout.label,'Cz')} = 'VREF';
index = contains(layout.label,'Fid');
layout.label(index) = [];
layout.pos(index,:) = [];
cfg.layout = layout;
cfg.box = 'no';
ft_layoutplot(cfg, layout_data)

figure;
cfg = [];
% cfg.xlim = [2.96875, 3.03125];
% cfg.xlim = [1.46875, 1.53125];
cfg.xlim = [0.96875,1.03125];
cfg.zlim = [0.1 0.3];
cfg.layout = layout;
cfg.channel = 'all';
cfg.colorbar = 'yes';
ft_topoplotER(cfg, dup_ga_itpc)

figure;
ft_topoplotER(cfg, trp_ga_itpc)
%% Critical ITPC value calculation (based off ANTD ch 34):
p = .05; % set alpha
n = 54; % number of trials... so will differ for participants with less trials

% for now calculate ITPC critical assuming all have 30 trials.
ITPCcrit = sqrt(-log(p)/n);

%% Export the ITPC peaks at the channel groupings of interest
trp_index = find(round(freqs,3) == 1);
dup_index = find(round(freqs,3) == 1.5);
beat_index = find(round(freqs,3) == 3);

% create 3d matrix for itpc (participant,freq,region)
dup_itpc_reg = zeros(length(listDuple),3,length(regions));
trp_itpc_reg = zeros(length(listTriple),3,length(regions));

for r = 1:length(regions)
    chan_ind = contains(data.label,regions{r});
    for d = 1:length(listDuple)
        dup_itpc_reg(d,1,r)=mean(dup_itpc_mat(chan_ind,trp_index,d));
        dup_itpc_reg(d,2,r)=mean(dup_itpc_mat(chan_ind,dup_index,d));
        dup_itpc_reg(d,3,r)=mean(dup_itpc_mat(chan_ind,beat_index,d));
    end
    for t = 1:length(listTriple)
        trp_itpc_reg(t,1,r)=mean(trp_itpc_mat(chan_ind,trp_index,t));
        trp_itpc_reg(t,2,r)=mean(trp_itpc_mat(chan_ind,dup_index,t));
        trp_itpc_reg(t,3,r)=mean(trp_itpc_mat(chan_ind,beat_index,t));
    end
end
%% SSEPs
% Average the up to 27 trials for each subject in time domain.
cD = 0; %condition Duple
cT = 0; %condition Triple
for n1 = subList
    load(['preprocessed_freq_infant/sub',num2str(n1)]) %load files

    if ismember(n1,listDuple) %Duple group time-lock analysis

        cD = cD + 1;

        cfg = [];
        dup_avg{cD} = ft_timelockanalysis(cfg, data);

    elseif ismember(n1,listTriple)

        cT = cT + 1;

        cfg = [];
        trp_avg{cT} = ft_timelockanalysis(cfg, data);
    end
end

% Baseline correction after time-average
cfg = [];
cfg.baseline = [-0.1,0];
for n1 = 1:length(dup_avg)
    dup_avg{n1} = ft_timelockbaseline(cfg, dup_avg{n1});
end
for n1 = 1:length(trp_avg)
    trp_avg{n1} = ft_timelockbaseline(cfg, trp_avg{n1});
end

% Remove the 100 ms prestimulus
cfg = [];
cfg.toilim = [0 dup_avg{1}.time(end)];
for n = 1:length(dup_avg)
    dup_avg{n} = ft_redefinetrial(cfg, dup_avg{n});
end
for n = 1:length(trp_avg)
    trp_avg{n} = ft_redefinetrial(cfg, trp_avg{n});
end

%% SSEPs: FFT To Time-Averaged waveforms at each electrode

cfg = [];
cfg.output = 'pow';
% cfg.output = 'FFT'; % can try this output and see how it differs?
cfg.channel = 'all';
cfg.method = 'mtmfft'; % multitaper method
cfg.taper = 'hanning'; % not sure if best method, could also try boxcar
% cfg.taper = 'gausswin';
cfg.pad = 'maxperlen';
cfg.foi = 0:0.03125:4;  % play around with this %NOTE The highest freq resolution I can have is 0.03125 based on nyquist and N, without 0-padding
% 0.034725*16 = 0.5556 (lowest foi)

for n1=1:length(dup_avg) %FFT
    dup_freq{n1} = ft_freqanalysis(cfg, dup_avg{n1});
end
for n1=1:length(trp_avg)
    trp_freq{n1} = ft_freqanalysis(cfg, trp_avg{n1});
    %     save(['freq_result/trp' num2str(n1) '_mtfft'])
end

%% SSEPs: Frequency-binning
dup_freq_binned = dup_freq;
for n1=1:length(dup_freq)
    for n = 6:length(dup_freq{1,n1}.freq)-5
        meanmatrix = zeros(length(dup_freq{1,n1}.label),6);
        meanmatrix(:,1:3) = [dup_freq{1,n1}.powspctrm(:,n-3),dup_freq{1,n1}.powspctrm(:,n-4),dup_freq{1,n1}.powspctrm(:,n-5)];
        meanmatrix(:,4:6) = [dup_freq{1,n1}.powspctrm(:,n+3),dup_freq{1,n1}.powspctrm(:,n+4),dup_freq{1,n1}.powspctrm(:,n+5)];
        meanbins = mean(meanmatrix,2);
        dup_freq_binned{1,n1}.powspctrm(:,n)= dup_freq{1,n1}.powspctrm(:,n)-meanbins;
    end
end
trp_freq_binned = trp_freq;
for n1=1:length(trp_freq)
    for n = 6:length(trp_freq{1,n1}.freq)-5
        meanmatrix = zeros(length(trp_freq{1,n1}.label),6);
        meanmatrix(:,1:3) = [trp_freq{1,n1}.powspctrm(:,n-3),trp_freq{1,n1}.powspctrm(:,n-4),trp_freq{1,n1}.powspctrm(:,n-5)];
        meanmatrix(:,4:6) = [trp_freq{1,n1}.powspctrm(:,n+3),trp_freq{1,n1}.powspctrm(:,n+4),trp_freq{1,n1}.powspctrm(:,n+5)];
        meanbins = mean(meanmatrix,2);
        trp_freq_binned{1,n1}.powspctrm(:,n)= trp_freq{1,n1}.powspctrm(:,n)-meanbins;
    end
end

%% Z-score the data
% dup_freq_zscored = dup_freq_binned;
% trp_freq_zscored = trp_freq_binned;
%
% for n = 1:length(dup_freq_binned)
%     dup_freq_zscored{1,n}.powspctrm = zscore(dup_freq_binned{1,n}.powspctrm, 0, 2);
% end
% for n = 1:length(trp_freq_binned)
%     trp_freq_zscored{1,n}.powspctrm = zscore(trp_freq_binned{1,n}.powspctrm, 0, 2);
% end

%% Average across all electrodes for each participant
% define channel sets
cfgEGI128chan
cfg = [];
cfg.channel = 'all';
cfg.frequency = 'all';
cfg.avgoverchan = 'yes';
cfg.keepindividual = 'yes';

for n = 1:length(dup_freq)
    ALL_dup_freq{n} = ft_selectdata(cfg, dup_freq_binned{n});
end
for n = 1:length(trp_freq)
    ALL_trp_freq{n} = ft_selectdata(cfg, trp_freq_binned{n});
end


%% Average across fronto-central electrodes for each participant
frontocentral = [FL';FZ';FR';CL';CZ';CR'];
cfg = [];
cfg.channel = frontocentral;
cfg.frequency = 'all';
cfg.avgoverchan = 'yes';
cfg.keepindividual = 'yes';

for n = 1:length(dup_freq)
    fronto_dup_freq{n} = ft_selectdata(cfg, dup_freq_binned{n});
end
for n = 1:length(trp_freq)
    fronto_trp_freq{n} = ft_selectdata(cfg, trp_freq_binned{n});
end

%% Export FOI for ALL channels
FOI = [1,1.5,2,2.5,3];
ALL_dup_freq_export = zeros(length(dup_freq_binned),4);
ALL_trp_freq_export = zeros(length(trp_freq_binned),4);

for n = 1:length(ALL_dup_freq)
    for f = 1:length(FOI)
        for x = 1:length(ALL_dup_freq{n}.freq)
            if  round(ALL_dup_freq{n}.freq(x),4) == FOI(f)
                ALL_dup_freq_export(n,f)=ALL_dup_freq{n}.powspctrm(x);
            end
        end
    end
end
for n = 1:length(ALL_trp_freq)
    for f = 1:length(FOI)
        for x = 1:length(ALL_trp_freq{n}.freq)
            if  round(ALL_trp_freq{n}.freq(x),4) == FOI(f)
                ALL_trp_freq_export(n,f)=ALL_trp_freq{n}.powspctrm(x);
            end
        end
    end
end

%% Export NFOI for ALL channels
FNOI = [0.75, 1.25, 1.75, 2.25, 2.75];
ALL_dup_fnoi_export = zeros(length(dup_freq_binned),length(FNOI));
ALL_trp_fnoi_export = zeros(length(trp_freq_binned),length(FNOI));

for n = 1:length(ALL_dup_freq)
    for f = 1:length(FNOI)
        for x = 1:length(ALL_dup_freq{n}.freq)
            if  round(ALL_dup_freq{n}.freq(x),4) == FNOI(f)
                ALL_dup_fnoi_export(n,f)=ALL_dup_freq{n}.powspctrm(x);
            end
        end
    end
end
for n = 1:length(ALL_trp_freq)
    for f = 1:length(FNOI)
        for x = 1:length(ALL_trp_freq{n}.freq)
            if  round(ALL_trp_freq{n}.freq(x),4) == FNOI(f)
                ALL_trp_fnoi_export(n,f)=ALL_trp_freq{n}.powspctrm(x);
            end
        end
    end
end
%% Export FOI for fronto-central channels
fronto_dup_freq_export = zeros(length(dup_freq_binned),4);
fronto_trp_freq_export = zeros(length(trp_freq_binned),4);

for n = 1:length(fronto_dup_freq)
    for f = 1:length(FOI)
        for x = 1:length(fronto_dup_freq{n}.freq)
            if  round(fronto_dup_freq{n}.freq(x),4) == FOI(f)
                fronto_dup_freq_export(n,f)=fronto_dup_freq{n}.powspctrm(x);
            end
        end
    end
end
for n = 1:length(fronto_trp_freq)
    for f = 1:length(FOI)
        for x = 1:length(fronto_trp_freq{n}.freq)
            if  round(fronto_trp_freq{n}.freq(x),4) == FOI(f)
                fronto_trp_freq_export(n,f)=fronto_trp_freq{n}.powspctrm(x);
            end
        end
    end
end

%% Export NFOI for fronto-central channels
FNOI = [0.75, 1.25, 1.75, 2.25, 2.75];
fronto_dup_fnoi_export = zeros(length(dup_freq_binned),length(FNOI));
fronto_trp_fnoi_export = zeros(length(trp_freq_binned),length(FNOI));

for n = 1:length(fronto_dup_freq)
    for f = 1:length(FNOI)
        for x = 1:length(fronto_dup_freq{n}.freq)
            if  round(fronto_dup_freq{n}.freq(x),4) == FNOI(f)
                fronto_dup_fnoi_export(n,f)=fronto_dup_freq{n}.powspctrm(x);
            end
        end
    end
end
for n = 1:length(fronto_trp_freq)
    for f = 1:length(FNOI)
        for x = 1:length(fronto_trp_freq{n}.freq)
            if  round(fronto_trp_freq{n}.freq(x),4) == FNOI(f)
                fronto_trp_fnoi_export(n,f)=fronto_trp_freq{n}.powspctrm(x);
            end
        end
    end
end


%% Average across groupings for each participant
% define channel sets
cfgEGI128chan
cfg = [];
cfg.channel = FL;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

%select the data
for n = 1:length(dup_freq_binned)
    FL_dup_freq_binned{n} = ft_selectdata(cfg, dup_freq_binned{n});
end

for n = 1:length(trp_freq_binned)
    FL_trp_freq_binned{n} = ft_selectdata(cfg, trp_freq_binned{n});
end

cfg = [];
cfg.channel = FZ;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

%select the data
for n = 1:length(dup_freq_binned)
    FZ_dup_freq_binned{n} = ft_selectdata(cfg, dup_freq_binned{n});
end

for n = 1:length(trp_freq_binned)
    FZ_trp_freq_binned{n} = ft_selectdata(cfg, trp_freq_binned{n});
end

cfg = [];
cfg.channel = FR;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

%select the data
for n = 1:length(dup_freq_binned)
    FR_dup_freq_binned{n} = ft_selectdata(cfg, dup_freq_binned{n});
end

for n = 1:length(trp_freq_binned)
    FR_trp_freq_binned{n} = ft_selectdata(cfg, trp_freq_binned{n});
end

cfg = [];
cfg.channel = CL;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

%select the data
for n = 1:length(dup_freq_binned)
    CL_dup_freq_binned{n} = ft_selectdata(cfg, dup_freq_binned{n});
end

for n = 1:length(trp_freq_binned)
    CL_trp_freq_binned{n} = ft_selectdata(cfg, trp_freq_binned{n});
end

cfg = [];
cfg.channel = CZ;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

%select the data
for n = 1:length(dup_freq_binned)
    CZ_dup_freq_binned{n} = ft_selectdata(cfg, dup_freq_binned{n});
end

for n = 1:length(trp_freq_binned)
    CZ_trp_freq_binned{n} = ft_selectdata(cfg, trp_freq_binned{n});
end

cfg = [];
cfg.channel = CR;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

%select the data
for n = 1:length(dup_freq_binned)
    CR_dup_freq_binned{n} = ft_selectdata(cfg, dup_freq_binned{n});
end

for n = 1:length(trp_freq_binned)
    CR_trp_freq_binned{n} = ft_selectdata(cfg, trp_freq_binned{n});
end

%% Export power at frequencies of interest and harmonics for FL -NEED TO EDIT FOR Z and CENTRALS
FL_dup_freq_export = zeros(length(dup_freq_binned),length(FOI));
FL_trp_freq_export = zeros(length(trp_freq_binned),length(FOI));

for n = 1:length(FL_dup_freq_binned)
    for f = 1:length(FOI)
        for x = 1:length(FL_dup_freq_binned{n}.freq)
            if  round(FL_dup_freq_binned{n}.freq(x),4) == FOI(f)
                FL_dup_freq_export(n,f)=FL_dup_freq_binned{n}.powspctrm(x);
            end
        end
    end
end
for n = 1:length(FL_trp_freq_binned)
    for f = 1:length(FOI)
        for x = 1:length(FL_trp_freq_binned{n}.freq)
            if  round(FL_trp_freq_binned{n}.freq(x),4) == FOI(f)
                FL_trp_freq_export(n,f)=FL_trp_freq_binned{n}.powspctrm(x);
            end
        end
    end
end

%% Export power at frequencies of interest and harmonics for FR
FR_dup_freq_export = zeros(length(dup_freq_binned),length(FOI));
FR_trp_freq_export = zeros(length(trp_freq_binned),length(FOI));

for n = 1:length(FR_dup_freq_binned)
    for f = 1:length(FOI)
        for x = 1:length(FR_dup_freq_binned{n}.freq)
            if  round(FR_dup_freq_binned{n}.freq(x),4) == FOI(f)
                FR_dup_freq_export(n,f)=FR_dup_freq_binned{n}.powspctrm(x);
            end
        end
    end
end
for n = 1:length(FR_trp_freq_binned)
    for f = 1:length(FOI)
        for x = 1:length(FR_trp_freq_binned{n}.freq)
            if  round(FR_trp_freq_binned{n}.freq(x),4) == FOI(f)
                FR_trp_freq_export(n,f)=FR_trp_freq_binned{n}.powspctrm(x);
            end
        end
    end
end

%% Export power at frequencies NOT of interest for FL
FL_dup_fnoi_export = zeros(length(dup_freq_binned),length(FNOI));
FL_trp_fnoi_export = zeros(length(trp_freq_binned),length(FNOI));

for n = 1:length(FL_dup_freq_binned)
    for f = 1:length(FNOI)
        for x = 1:length(FL_dup_freq_binned{n}.freq)
            if  round(FL_dup_freq_binned{n}.freq(x),4) == FNOI(f)
                FL_dup_fnoi_export(n,f)=FL_dup_freq_binned{n}.powspctrm(x);
            end
        end
    end
end
for n = 1:length(FL_trp_freq_binned)
    for f = 1:length(FNOI)
        for x = 1:length(FL_trp_freq_binned{n}.freq)
            if  round(FL_trp_freq_binned{n}.freq(x),4) == FNOI(f)
                FL_trp_fnoi_export(n,f)=FL_trp_freq_binned{n}.powspctrm(x);
            end
        end
    end
end

%% Export power at frequencies NOT of interest for FR
FR_dup_fnoi_export = zeros(length(dup_freq_binned),length(FNOI));
FR_trp_fnoi_export = zeros(length(trp_freq_binned),length(FNOI));

for n = 1:length(FR_dup_freq_binned)
    for f = 1:length(FNOI)
        for x = 1:length(FR_dup_freq_binned{n}.freq)
            if  round(FR_dup_freq_binned{n}.freq(x),4) == FNOI(f)
                FR_dup_fnoi_export(n,f)=FR_dup_freq_binned{n}.powspctrm(x);
            end
        end
    end
end
for n = 1:length(FR_trp_freq_binned)
    for f = 1:length(FNOI)
        for x = 1:length(FR_trp_freq_binned{n}.freq)
            if  round(FR_trp_freq_binned{n}.freq(x),4) == FNOI(f)
                FR_trp_fnoi_export(n,f)=FR_trp_freq_binned{n}.powspctrm(x);
            end
        end
    end
end

%% Average for the groups
% define channel sets
cfgEGI128chan

cfg = [];
cfg.keepindividual = 'no';
cfg.foilim = 'all'; %frequencies of interest, default = all.
cfg.channel = 'all';
cfg.parameter = 'powspctrm';
% dup_ga_freq = ft_freqgrandaverage(cfg,Sub_Dup_FFT{:});
% trp_ga_freq = ft_freqgrandaverage(cfg,Sub_Trp_FFT{:});
dup_ga_freq = ft_freqgrandaverage(cfg,dup_freq_binned{:});
trp_ga_freq = ft_freqgrandaverage(cfg,trp_freq_binned{:});
% FL_dup_ga_freq = ft_freqgrandaverage(cfg,FL_dup_freq_binned{:});
% FL_trp_ga_freq = ft_freqgrandaverage(cfg,FL_trp_freq_binned{:});
% FZ_dup_ga_freq = ft_freqgrandaverage(cfg,FZ_dup_freq_binned{:});
% FZ_trp_ga_freq = ft_freqgrandaverage(cfg,FZ_trp_freq_binned{:});
% FR_dup_ga_freq = ft_freqgrandaverage(cfg,FR_dup_freq_binned{:});
% FR_trp_ga_freq = ft_freqgrandaverage(cfg,FR_trp_freq_binned{:});
%
% CL_dup_ga_freq = ft_freqgrandaverage(cfg,CL_dup_freq_binned{:});
% CL_trp_ga_freq = ft_freqgrandaverage(cfg,CL_trp_freq_binned{:});
% CZ_dup_ga_freq = ft_freqgrandaverage(cfg,CZ_dup_freq_binned{:});
% CZ_trp_ga_freq = ft_freqgrandaverage(cfg,CZ_trp_freq_binned{:});
% CR_dup_ga_freq = ft_freqgrandaverage(cfg,CR_dup_freq_binned{:});
% CR_trp_ga_freq = ft_freqgrandaverage(cfg,CR_trp_freq_binned{:});

ALL_dup_ga_freq = mean(dup_ga_freq.powspctrm);
ALL_trp_ga_freq = mean(trp_ga_freq.powspctrm);
fronto_dup_ga_freq = ft_freqgrandaverage(cfg,fronto_dup_freq{:});
fronto_trp_ga_freq = ft_freqgrandaverage(cfg,fronto_dup_freq{:});

%% Topoplot
cfgEGI128chan

% layout
cfg = [];
data = [];
data.elec = ft_read_sens('GSN-HydroCel-129.sfp');
layout = ft_prepare_layout(cfg,data); % use the sfp to creat the layout file!
layout.label{strcmp(layout.label,'Cz')} = 'VREF';
cfg = [];
cfg.xlim = [2.96875, 3.03125];
% cfg.xlim = [1.46875, 1.53125];
% cfg.xlim = [0.96875,1.03125];
cfg.zlim = [-0.1 1.1];
cfg.layout = layout;
cfg.channel = 'all';
cfg.colorbar = 'yes';
figure;
ft_topoplotER(cfg, dup_ga_freq)
figure;
ft_topoplotER(cfg, trp_ga_freq)
%% plot individuals for All channels
% define channel sets
cfgEGI128chan

% create variable with all the data in it
dup_sseps_all = zeros(129,length(listDuple));
trp_sseps_all = zeros(129,length(listTriple));
freqs = dup_freq_binned{1, 1}.freq;

for n = 1:length(listDuple)
    dup_sseps_all(:,n) = ALL_dup_freq{1, n}.powspctrm  ;
end
for n = 1:length(listTriple)
    trp_sseps_all(:,n) = ALL_trp_freq{1, n}.powspctrm;
end

dup_avg  = mean(dup_sseps_all(:,:),2);
dup_sem  = std(dup_sseps_all(:,:),[],2);

figure();
subplot(2,1,1)
shadedErrorBar(freqs,dup_avg,dup_sem);
xlim([0.75 3.5])
ylim([-0.3 2])
xlabel('Frequency(Hz)')
ylabel('Power (uV^2)')
title (['SSEP for Duple group across all channels'])

trp_avg  = mean(trp_sseps_all(:,:),2);
trp_sem  = std(trp_sseps_all(:,:),[],2);

subplot(2,1,2)
shadedErrorBar(freqs,trp_avg,trp_sem);
xlim([0.75 3.5])
xlabel('Frequency(Hz)')
ylabel('Power (uV^2)')
ylim([-0.3 2])
title (['SSEP for Triple group across all channels'])

%%
% OLD CODE

% x_limit = ([0.5 4]);
% Y = ([-0.15, 2]);
%
% figure;
% for n = 1:length(ALL_dup_freq)
%     hold on;
%     plot(ALL_dup_freq{n}.freq,ALL_dup_freq{n}.powspctrm);
%     title('Dup Freq Spectra All Channels')
%     xlim(x_limit)
%     %     xlabel('Frequency (Hz)')
%     %     ylabel('absolute power (uV^2)')
%     ylim(Y)
% end
% plot(ALL_dup_freq{1}.freq,ALL_dup_ga_freq,'k','LineWidth',2);
%
% figure;
% for n = 1:length(ALL_trp_freq)
%     hold on;
%     plot(ALL_trp_freq{n}.freq,ALL_trp_freq{n}.powspctrm);
%     title('Trp Freq Spectra All Channels')
%     xlim(x_limit)
%     %     xlabel('Frequency (Hz)')
%     %     ylabel('absolute power (uV^2)')
%     ylim(Y)
% end
% plot(ALL_trp_freq{1}.freq,ALL_trp_ga_freq,'k','LineWidth',2); % something weird with the powspectrum.
%
% % set(gca,'YTickLabel',[]); %remove tick labels
% % set(gca,'XTickLabel',[]);
%% plot individuals for frontocentral channels
% define channel sets
cfgEGI128chan

% create variable with all the data in it
dup_sseps_FC = zeros(129,length(listDuple));
trp_sseps_FC = zeros(129,length(listTriple));
freqs = dup_freq_binned{1, 1}.freq;

for n = 1:length(listDuple)
    dup_sseps_FC(:,n) = fronto_dup_freq{1, n}.powspctrm  ;
end
for n = 1:length(listTriple)
    trp_sseps_FC(:,n) = fronto_trp_freq{1, n}.powspctrm;
end

dup_avg  = mean(dup_sseps_FC(:,:),2);
dup_sem  = std(dup_sseps_FC(:,:),[],2);

figure();
subplot(2,1,1)
shadedErrorBar(freqs,dup_avg,dup_sem);
xlim([0.75 3.5])
ylim([-0.3 2])
xlabel('Frequency(Hz)')
ylabel('Power (uV^2)')
title (['SSEP for Duple group across FC channels'])

trp_avg  = mean(trp_sseps_all(:,:),2);
trp_sem  = std(trp_sseps_all(:,:),[],2);

subplot(2,1,2)
shadedErrorBar(freqs,trp_avg,trp_sem);
xlim([0.75 3.5])
xlabel('Frequency(Hz)')
ylabel('Power (uV^2)')
ylim([-0.3 2])
title (['SSEP for Triple group across FC channels'])

%% OLD
figure;
for n = 1:length(fronto_dup_freq)
    hold on;
    plot(fronto_dup_freq{n}.freq,fronto_dup_freq{n}.powspctrm);
    title('Dup Freq Spectra FC Channels')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim([-0.2,1.7])
end
plot(fronto_dup_freq{1}.freq,fronto_dup_ga_freq.powspctrm,'k','LineWidth',2);

figure;
for n = 1:length(fronto_trp_freq)
    hold on;
    plot(fronto_trp_freq{n}.freq,fronto_trp_freq{n}.powspctrm);
    title('Trp Freq Spectra FC Channels')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim([-0.2,1.7])
end
plot(fronto_trp_freq{1}.freq,fronto_trp_ga_freq.powspctrm,'k','LineWidth',2); % something weird with the powspectrum.

% set(gca,'YTickLabel',[]); %remove tick labels
% set(gca,'XTickLabel',[]);

%% plot individuals for Frontals - OG SIGNAL WITH BINNING
Y = [-0.1, 1.3];
X = [0.5, 3.5];

figure;
for n = 1:length(FL_dup_freq_binned)
    hold on;
    plot(FL_dup_freq_binned{n}.freq,FL_dup_freq_binned{n}.powspctrm);
    title('FL Dup Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(FL_dup_ga_freq.freq,FL_dup_ga_freq.powspctrm,'k','LineWidth',2);

figure;
for n = 1:length(FL_trp_freq_binned)
    hold on;
    plot(FL_trp_freq_binned{n}.freq,FL_trp_freq_binned{n}.powspctrm);
    title('FL Trp Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(FL_trp_ga_freq.freq,FL_trp_ga_freq.powspctrm,'k','LineWidth',2);


figure;
for n = 1:length(FZ_dup_freq_binned)
    hold on;
    plot(FZ_dup_freq_binned{n}.freq,FZ_dup_freq_binned{n}.powspctrm);
    title('FZ Dup Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(FZ_dup_ga_freq.freq,FZ_dup_ga_freq.powspctrm,'k','LineWidth',2);

figure;
for n = 1:length(FZ_trp_freq_binned)
    hold on;
    plot(FZ_trp_freq_binned{n}.freq,FZ_trp_freq_binned{n}.powspctrm);
    title('FZ Trp Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(FZ_trp_ga_freq.freq,FZ_trp_ga_freq.powspctrm,'k','LineWidth',2);

figure;
for n = 1:length(FR_dup_freq_binned)
    hold on;
    plot(FR_dup_freq_binned{n}.freq,FR_dup_freq_binned{n}.powspctrm);
    title('FR Dup Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(FR_dup_ga_freq.freq,FR_dup_ga_freq.powspctrm,'k','LineWidth',2);
% set(gca,'YTickLabel',[]); %remove tick labels
% set(gca,'XTickLabel',[]);

figure;
for n = 1:length(FR_trp_freq_binned)
    hold on;
    plot(FR_trp_freq_binned{n}.freq,FR_trp_freq_binned{n}.powspctrm);
    title('FR Trp Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(FR_trp_ga_freq.freq,FR_trp_ga_freq.powspctrm,'k','LineWidth',2);
% set(gca,'YTickLabel',[]); %remove tick labels
% set(gca,'XTickLabel',[]);
%% plot individuals for Centrals - OG SIGNAL WITH BINNING

figure;
for n = 1:length(CL_dup_freq_binned)
    hold on;
    plot(CL_dup_freq_binned{n}.freq,CL_dup_freq_binned{n}.powspctrm);
    title('CL Dup Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(CL_dup_ga_freq.freq,CL_dup_ga_freq.powspctrm,'k','LineWidth',2);

figure;
for n = 1:length(CL_trp_freq_binned)
    hold on;
    plot(CL_trp_freq_binned{n}.freq,CL_trp_freq_binned{n}.powspctrm);
    title('CL Trp Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(CL_trp_ga_freq.freq,CL_trp_ga_freq.powspctrm,'k','LineWidth',2);


figure;
for n = 1:length(CZ_dup_freq_binned)
    hold on;
    plot(CZ_dup_freq_binned{n}.freq,CZ_dup_freq_binned{n}.powspctrm);
    title('CZ Dup Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(CZ_dup_ga_freq.freq,CZ_dup_ga_freq.powspctrm,'k','LineWidth',2);

figure;
for n = 1:length(CZ_trp_freq_binned)
    hold on;
    plot(CZ_trp_freq_binned{n}.freq,CZ_trp_freq_binned{n}.powspctrm);
    title('CZ Trp Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(CZ_trp_ga_freq.freq,CZ_trp_ga_freq.powspctrm,'k','LineWidth',2);

figure;
for n = 1:length(CR_dup_freq_binned)
    hold on;
    plot(CR_dup_freq_binned{n}.freq,CR_dup_freq_binned{n}.powspctrm);
    title('CR Dup Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(CR_dup_ga_freq.freq,CR_dup_ga_freq.powspctrm,'k','LineWidth',2);
% set(gca,'YTickLabel',[]); %remove tick labels
% set(gca,'XTickLabel',[]);

figure;
for n = 1:length(CR_trp_freq_binned)
    hold on;
    plot(CR_trp_freq_binned{n}.freq,CR_trp_freq_binned{n}.powspctrm);
    title('CR Trp Freq Spectra')
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
    xlim(X)
end
plot(CR_trp_ga_freq.freq,CR_trp_ga_freq.powspctrm,'k','LineWidth',2);
% set(gca,'YTickLabel',[]); %remove tick labels
% set(gca,'XTickLabel',[]);

