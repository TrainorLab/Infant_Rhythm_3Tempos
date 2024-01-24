function [ ] = preproEGI_3tempos( ERP, dataFile, removeChan, visCheck, badChan, AB, recodeTrig, saveName, removeEnd)
% Erica Feb 23,2022 - In process of updating for 3Tempo Study

% dataFile: load the raw .mff file
% removeChan: Remove face channels for infant data
% visCheck: whether do a visual inspection of the artifact channels. 1 for yes, 0 for skipping
% removeEnd: if there's a recording artifact in the end of the data, it will screw up the AB process, so it needs to be removed prior to filter. Unit in second.
% Need to comment in or out AB method/repair channels before or after epoching.**

ft_defaults % run this after every "clear all", it sets some general settings in the global variable
run(which('mff_setup'))

allChan = {'E1';'E2';'E3';'E4';'E5';'E6';'E7';'E8';'E9';'E10';'E11';'E12';'E13';'E14';'E15';'E16';'E17';'E18';'E19';'E20';'E21';'E22';'E23';'E24';'E25';'E26';'E27';'E28';'E29';'E30';'E31';'E32';'E33';'E34';'E35';'E36';'E37';'E38';'E39';'E40';'E41';'E42';'E43';'E44';'E45';'E46';'E47';'E48';'E49';'E50';'E51';'E52';'E53';'E54';'E55';'E56';'E57';'E58';'E59';'E60';'E61';'E62';'E63';'E64';'E65';'E66';'E67';'E68';'E69';'E70';'E71';'E72';'E73';'E74';'E75';'E76';'E77';'E78';'E79';'E80';'E81';'E82';'E83';'E84';'E85';'E86';'E87';'E88';'E89';'E90';'E91';'E92';'E93';'E94';'E95';'E96';'E97';'E98';'E99';'E100';'E101';'E102';'E103';'E104';'E105';'E106';'E107';'E108';'E109';'E110';'E111';'E112';'E113';'E114';'E115';'E116';'E117';'E118';'E119';'E120';'E121';'E122';'E123';'E124';'E125';'E126';'E127';'E128';'VREF'};
goodChan = allChan;
goodChan(removeChan)=[]; % only include the good channels
% %

if ERP == 1
    prestim = -0.899; %ERP Analysis beat 4 = .999 s, beat 5 = 1.332 s
    poststim = 1.998;
else
    prestim = 0.1; % FFT ANALYSIS (If segmenting from first trial of 16 test trials)
    poststim = 32;
end

%
cfgEGI128chan

%% read continous data

cfg = [];
cfg.dataset = dataFile;
cfg.dataformat              = 'egi_mff_v2';
cfg.headerformat            = 'egi_mff_v2';
cfg.eventformat             = 'egi_mff_v2';
cfg.continuous  = 'yes';
cfg.channel = goodChan;
data_org = ft_preprocessing(cfg);

% % select data
if removeEnd > 0
    cfg = [];
    cfg.latency = [0, length(data_org.time{1})/data_org.fsample-removeEnd];
    data_org = ft_selectdata(cfg, data_org);
end

% filter data
cfg = [];
cfg.continuous  = 'yes';
cfg.lpfilter = 'yes';
cfg.lpfilttype = 'but';
cfg.lpfreq = 20; % Original analysis
% cfg.lpfreq = 15; % Try this out Nov 2023
cfg.lpfiltord  = 3;
cfg.hpfilter = 'yes';
% cfg.hpfilttype = 'fir';
cfg.hpfiltord  = 3;
if ERP == 1
    cfg.hpfreq = 1;
elseif ERP == 0
    cfg.hpfreq = 0.5;
end

% cfg.plotfiltresp = 'yes';
% cfg.reref         = 'yes';
% cfg.refchannel      = 'all';

% preprocessing
data_org = ft_preprocessing(cfg, data_org);

%% plot it
% figure;
% plot(data_org.trial{1}(:,:)');title('pre-AB')

%% Remove bad channels
if visCheck ==1
    cfg          = [];
    cfg.method   = 'summary';
    cfg.alim     = 1e-12;
    data_org = ft_rejectvisual(cfg,data_org);
end

%% read the excel files for trigger recoding
% Initialize variables.

delimiter = '';
startRow = 1;
endRow = inf;

formatSpec = '%f%[^\n\r]';
tempTrigger = NaN(length(recodeTrig)*171,1); % 171 total triggers per block

for nFile = 1:length(recodeTrig)
    % Open the text file.
    filename = recodeTrig{nFile};
    fileID = fopen(filename,'r');
    
    dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
    for block=2:length(startRow)
        frewind(fileID);
        dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
        dataArray{1} = [dataArray{1};dataArrayBlock{1}];
    end
    
    % Close the text file.
    fclose(fileID);
    
    
    % Allocate imported array to column variable names
    tempTrigger((1:171)+(nFile-1)*171) = dataArray{:, 1};
    
end


%% AB method BEFORE EPOCHING
data_AB = data_org;

if AB == 1
    Parameters = [];
    Parameters.Approach = 'Window';
    % Parameters.Threshold = 100;
    Parameters.Threshold = 75; % used 75 for previous infant studies
    Parameters.Fs = data_org.fsample;
    Parameters.WindowSize = 5; % unit in second, was set to 5 originally (EF June 27,2019)
    Parameters.InData = data_org.trial{1}; % may have to exclude the high-pass artifact before AB
    Parameters = Run_AB(Parameters);
    data_AB.trial{1} = Parameters.OutData;
    clear Parameters

    % plot it
    figure;
    subplot(2,1,1);plot(data_org.trial{1}(:,:)');title('pre-AB')
    subplot(2,1,2);plot(data_AB.trial{1}(:,:)');title('post-AB')

    % figure;plot(data_org.trial{1}(:,time)' - data_AB.trial{1}(:,time)')

    % averaged reference
    data_AB.trial{1} = ft_preproc_rereference(data_AB.trial{1},'all','avg');
end
%% read epoched data
cfg                         = [];
cfg.dataset                 = dataFile;
cfg.dataformat              = 'egi_mff_v2';
cfg.headerformat            = 'egi_mff_v2';
cfg.eventformat             = 'egi_mff_v2';

if ERP == 1
    % ERP Analysis Segmenting
    cfg.trialfun                = 'erica_trialfun';
    cfg.trialdef.eventvalue     = []; % the value of the stimulus trigger for fully incongruent (FIC). ???
    cfg.trialdef.prestim        = prestim; % in seconds
    cfg.trialdef.poststim       = poststim; % in seconds
    
else
    % Frequency Analysis Segmenting
    cfg.trialfun                = 'freq_trialfun_3tempos';
    cfg.trialdef.eventvalue     = [];
    cfg.trialdef.prestim        = prestim; % in seconds
    cfg.trialdef.poststim       = poststim; % in seconds
end
% Both
cfg         = ft_definetrial(cfg);
% dataEpoch_org  = ft_redefinetrial(cfg ,data_org); % check with no-AB data
dataEpoch_AB  = ft_redefinetrial(cfg, data_AB);

% replace the trigger code
% dataEpoch_org.trialinfo = tempTrigger;
dataEpoch_AB.trialinfo = tempTrigger(1:length(cfg.trl)); % FOR ERP ANALYSIS

%% artifact rejection % Only for ERPs
if ERP == 1
    % cfg = [];
    % cfg.baseline = [-0.1 0];
    % [dataEpoch_AB_baseline] = ft_timelockbaseline(cfg, dataEpoch_AB);
    
    cfg = [];
    cfg.trialdef.prestim        = prestim; % in seconds
    cfg.trialdef.poststim       = poststim; % in seconds
    cfg.dataset                 = dataFile;
    cfg.trl = erica_trialfun(cfg); %MMN/EP analysis
    % cfg.trl = freq_trialfun_3tempos(cfg);
    
    % cfg.artfctdef.threshold.range = 120;
    cfg.artfctdef.threshold.min       = -100;
    cfg.artfctdef.threshold.max       = 100;
    cfg.artfctdef.threshold.bpfilter  = 'no';

    if AB == 0
        cfg.artfctdef.threshold.channel = [FL FZ FR CL CZ CR]; % set if want
        % to specifically remove channels based on only these channels
    end

    cfg.continuous = 'no';
    [~, artifact2] = ft_artifact_threshold(cfg,dataEpoch_AB);
    % [~, artifact2] = ft_artifact_threshold(cfg,dataEpoch_org);
    
    % reject artifact trials
    cfg                         = [];
    % cfg.artfctdef.xxx.artifact = artifact1; % before AB
    % data_rej1 = ft_rejectartifact(cfg,dataEpoch_AB);
    cfg.artfctdef.xxx.artifact = artifact2; % after AB
    data_reject = ft_rejectartifact(cfg,dataEpoch_AB);
    % data = ft_rejectartifact(cfg,dataEpoch_org);
    if AB == 0
        pause
    end
    pause
else
    data_reject = dataEpoch_AB;
end

%% repair channels
load('layout_neighbours.mat');
cfg = [];
cfg.method = 'average';
cfg.neighbours = neighbours;
if isempty(badChan) == 1
    cfg.badchannel = allChan([find(~ismember(allChan(1:124),data_AB.label));129]); % skipped the face channels 125 - 128
else
    cfg.badchannel = allChan(badChan); % might want to edit this so that can do visual check AND manually label. This is just the latter.
end

cfg.elecfile = 'GSN-HydroCel-129.sfp';
data = ft_channelrepair(cfg, data_reject);

%% save data

% save(saveName,'data','-v7.3')   %use v7.3 for large data
save(saveName,'data')

end

