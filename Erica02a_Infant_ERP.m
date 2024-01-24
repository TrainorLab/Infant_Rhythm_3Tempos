%% This script averages and grand averages the ERPs for beats 4 and 5
% averaging data

cD = 0; %condition Duple
cT = 0; %condition Triple
cd D:\Erica\Infant_Rhythm_3tempos\Matlab_Analysis;
addpath ('preprocessed_MMN_infant_1-20Hz_AB75_CTR100_basedonallchan','fieldtrip-20220228','preprocessed_MMN_infant','preprocessed_MMN_infant_0.5-20Hz_AB75_CTR100_basedonallchan')

ft_defaults
%
subList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,...
    24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47];
listDuple = [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46];
listTriple = [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47];

listRemove = [2,4,10,12,19,31,33,35,43]; % based off no-ab participants
% with > 50% data removed, and the 7 month old, and hearing loss baby
%

% % remove flagged participants
subList = setdiff(subList,listRemove);
listDuple = setdiff(listDuple,listRemove);
listTriple = setdiff(listTriple,listRemove);

%%

for n1 = subList
    % load(['preprocessed_MMN_infant/sub',num2str(n1)])
    %     load(['preprocessed_MMN_infant_0.5-20Hz_AB75_CTR100_basedonallchan/sub',num2str(n1)])
%     load(['preprocessed_MMN_infant_1-20Hz_AB75_CTR100_basedonallchan/sub',num2str(n1)])
 load(['preprocessed_MMN_infant_1-20Hz_AB75_CTR100_basedonallchan/sub',num2str(n1)])

    if ismember(n1,listDuple) %Duple group time-lock analysis

        cD = cD + 1;

        % Average the standards
        cfg = [];
        cfg.trials = ismember(data.trialinfo, [1,41,81]);
        data_dup_S1{cD} = ft_timelockanalysis(cfg, data);
        data_dup_S2{cD} =  data_dup_S1{cD};

        cfg = [];
        cfg.toilim = [0.899 1.599]; %Create variable for the standard stimulus in beat 4 position
        data_dup_S1{cD} = ft_redefinetrial(cfg, data_dup_S1{cD});
        clear cfg.toilim
        cfg.toilim = [0.899 1.932]; %Create variable for the standard stimulus in beat 5 position, but take same pre-stimulus period as S1
        data_dup_S2{cD} = ft_redefinetrial(cfg, data_dup_S2{cD});

        % Average the beat 4 deviant
        cfg = [];
        cfg.trials = ismember(data.trialinfo, [4,44,84]);
        data_dup_D1{cD} = ft_timelockanalysis(cfg, data);
        cfg = [];
        cfg.toilim = [0.899,1.599]; %Create variable for the deviant stimulus in beat 4 position
        data_dup_D1{cD} = ft_redefinetrial(cfg, data_dup_D1{cD});

        % Average the beat 5 deviant
        cfg = [];
        cfg.trials = ismember(data.trialinfo, [5,45,85]); %Condition 5 is the stimulus with a beat 5 deviant
        data_dup_D2{cD} = ft_timelockanalysis(cfg, data);
        cfg = [];
        cfg.toilim = [0.899 1.932]; %Create variable for the deviant stimulus in beat 5 position
        data_dup_D2{cD} = ft_redefinetrial(cfg, data_dup_D2{cD});


    elseif ismember(n1,listTriple) %Do averaging for the triple group now. Note: Better to condense this part with previous, then section out the groupings after.

        cT = cT + 1;

        % Average the standards
        cfg = [];
        cfg.trials = ismember(data.trialinfo, [1,41,81]);
        data_trp_S1{cT} = ft_timelockanalysis(cfg, data);
        data_trp_S2{cT} =  data_trp_S1{cT};

        cfg = [];
        cfg.toilim = [0.899 1.599]; %Create variable for the standard stimulus in beat 5 position
        data_trp_S1{cT} = ft_redefinetrial(cfg, data_trp_S1{cT});
        clear cfg.toilim
        cfg.toilim = [0.899 1.932]; %Create variable for the standard stimulus in beat 4 position
        data_trp_S2{cT} = ft_redefinetrial(cfg, data_trp_S2{cT});

        % Average the beat 4 deviants
        cfg = [];
        cfg.trials = ismember(data.trialinfo, [4,44,84]);
        data_trp_D1{cT} = ft_timelockanalysis(cfg, data);
        cfg = [];
        cfg.toilim = [0.899,1.599];
        data_trp_D1{cT} = ft_redefinetrial(cfg, data_trp_D1{cT});

        % Average the beat 5 deviants
        cfg = [];
        cfg.trials = ismember(data.trialinfo, [5,45,85]);
        data_trp_D2{cT} = ft_timelockanalysis(cfg, data);
        cfg = [];
        cfg.toilim = [0.899 1.932];
        data_trp_D2{cT} = ft_redefinetrial(cfg, data_trp_D2{cT});
    end
end

%% Get only the standards that are followed by that specific deviant... Talking to Laurel, might not be necessary... but maybe should be for cluster analysis?
% 
% for n1 = subList
%     % load(['preprocessed_MMN_infant/sub',num2str(n1)])
%     %     load(['preprocessed_MMN_infant_0.5-20Hz_AB75_CTR100_basedonallchan/sub',num2str(n1)])
%     load(['preprocessed_MMN_infant_1-20Hz_AB75_CTR100_basedonallchan/sub',num2str(n1)])
% 
%     if ismember(n1,listDuple) %Duple group time-lock analysis NEED TO EDIT TO GET PROPER STANDARDS
% 
%         cD = cD + 1;
% 
%         % Average the standards
%         cfg = [];
%         data.trialinfo_use = data.trialinfo;
%         for trial = 1:length(data.trialinfo) - 1 % take only standards that are followed by a beat 4 deviant.
%             if ismember(data.trialinfo(trial), [1,41,81]) &&  ismember(data.trialinfo(trial +1), [4,44,84])
%                 data.trialinfo_use(trial) = 6; % Change the trial label to something new to make it unique
%             end
%         end
%         cfg.trials = ismember(data.trialinfo_use, 6);
%         data_dup_S1{cD} = ft_timelockanalysis(cfg, data);
% 
%         for trial = 1:length(data.trialinfo) - 1 % take only standards that are followed by a beat 5 deviant.
%             if ismember(data.trialinfo(trial), [1,41,81]) &&  ismember(data.trialinfo(trial +1), [5,45,85])
%                 data.trialinfo_use(trial) = 7; % Change the trial label to something new to make it unique
%             end
%         end
%         cfg.trials = ismember(data.trialinfo_use, 7);
%         data_dup_S2{cD} =  ft_timelockanalysis(cfg, data);
% 
%         cfg = [];
%         cfg.toilim = [0.899 1.599]; %Create variable for the standard stimulus in beat 4 position
%         data_dup_S1{cD} = ft_redefinetrial(cfg, data_dup_S1{cD});
%         clear cfg.toilim
%         cfg.toilim = [0.899 1.932]; %Create variable for the standard stimulus in beat 5 position, but take same pre-stimulus period as S1
%         data_dup_S2{cD} = ft_redefinetrial(cfg, data_dup_S2{cD});
% 
%         % Average the beat 4 deviant
%         cfg = [];
%         cfg.trials = ismember(data.trialinfo, [4,44,84]);
%         data_dup_D1{cD} = ft_timelockanalysis(cfg, data);
%         cfg = [];
%         cfg.toilim = [0.899,1.599]; %Create variable for the deviant stimulus in beat 4 position
%         data_dup_D1{cD} = ft_redefinetrial(cfg, data_dup_D1{cD});
% 
%         % Average the beat 5 deviant
%         cfg = [];
%         cfg.trials = ismember(data.trialinfo, [5,45,85]); %Condition 5 is the stimulus with a beat 5 deviant
%         data_dup_D2{cD} = ft_timelockanalysis(cfg, data);
%         cfg = [];
%         cfg.toilim = [0.899 1.932]; %Create variable for the deviant stimulus in beat 5 position
%         data_dup_D2{cD} = ft_redefinetrial(cfg, data_dup_D2{cD});
% 
% 
%     elseif ismember(n1,listTriple) %Do averaging for the triple group now. Note: Better to condense this part with previous, then section out the groupings after.
% 
%         cT = cT + 1;
% 
%         % Average the standards
%         cfg = [];
%         data.trialinfo_use = data.trialinfo;
%         for trial = 1:length(data.trialinfo) - 1 % take only standards that are followed by a beat 4 deviant.
%             if ismember(data.trialinfo(trial), [1,41,81]) &&  ismember(data.trialinfo(trial +1), [4,44,84])
%                 data.trialinfo_use(trial) = 6; % Change the trial label to something new to make it unique
%             end
%         end
%         cfg.trials = ismember(data.trialinfo_use, 6);
%         data_trp_S1{cT} = ft_timelockanalysis(cfg, data);
% 
%         for trial = 1:length(data.trialinfo) - 1 % take only standards that are followed by a beat 5 deviant.
%             if ismember(data.trialinfo(trial), [1,41,81]) &&  ismember(data.trialinfo(trial +1), [5,45,85])
%                 data.trialinfo_use(trial) = 7; % Change the trial label to something new to make it unique
%             end
%         end
%         cfg.trials = ismember(data.trialinfo_use, 7);
%         data_trp_S2{cT} =  ft_timelockanalysis(cfg, data);;
% 
%         cfg = [];
%         cfg.toilim = [0.899 1.599]; %Create variable for the standard stimulus in beat 5 position
%         data_trp_S1{cT} = ft_redefinetrial(cfg, data_trp_S1{cT});
%         clear cfg.toilim
%         cfg.toilim = [0.899 1.932]; %Create variable for the standard stimulus in beat 4 position
%         data_trp_S2{cT} = ft_redefinetrial(cfg, data_trp_S2{cT});
% 
%         % Average the beat 4 deviants
%         cfg = [];
%         cfg.trials = ismember(data.trialinfo, [4,44,84]);
%         data_trp_D1{cT} = ft_timelockanalysis(cfg, data);
%         cfg = [];
%         cfg.toilim = [0.899,1.599];
%         data_trp_D1{cT} = ft_redefinetrial(cfg, data_trp_D1{cT});
% 
%         % Average the beat 5 deviants
%         cfg = [];
%         cfg.trials = ismember(data.trialinfo, [5,45,85]);
%         data_trp_D2{cT} = ft_timelockanalysis(cfg, data);
%         cfg = [];
%         cfg.toilim = [0.899 1.932];
%         data_trp_D2{cT} = ft_redefinetrial(cfg, data_trp_D2{cT});
% 
%     end
% 
% end


%% baseline correction before changing time frame.

% try baselining on same period for beat 5 and see what it looks like.
% Will need to remove the beat 4 data (1.000 to 1.332)
time_remove_start = find(data_dup_D2{1, 1}.time == 1);
time_remove_end = find(data_dup_D2{1, 1}.time == 1.3320);

for n = 1 :length(data_dup_S1)
    data_dup_S2{1, n}.time(time_remove_start:time_remove_end) = [];
    data_dup_D2{1, n}.time(time_remove_start:time_remove_end) = [];

    data_dup_S2{1, n}.avg(:,time_remove_start:time_remove_end) = [];
    data_dup_D2{1, n}.avg(:,time_remove_start:time_remove_end) = [];
end

for n = 1 :length(data_trp_S1)
    data_trp_S2{1, n}.time(time_remove_start:time_remove_end) = [];
    data_trp_D2{1, n}.time(time_remove_start:time_remove_end) = [];

    data_trp_S2{1, n}.avg(:,time_remove_start:time_remove_end) = [];
    data_trp_D2{1, n}.avg(:,time_remove_start:time_remove_end) = [];
end

cfg1 = [];
cfg1.baseline = [0.899,0.999];

% cfg2 = [];
% cfg2.baseline = [1.232,1.332];


for n1 = 1:length(data_dup_S1)
    data_dup_S1{n1} = ft_timelockbaseline(cfg1, data_dup_S1{n1});
    data_dup_D1{n1} = ft_timelockbaseline(cfg1, data_dup_D1{n1});

    data_dup_S2{n1} = ft_timelockbaseline(cfg1, data_dup_S2{n1});
    data_dup_D2{n1} = ft_timelockbaseline(cfg1, data_dup_D2{n1});

end
for n1 = 1:length(data_trp_S1)
    data_trp_S1{n1} = ft_timelockbaseline(cfg1, data_trp_S1{n1});
    data_trp_D1{n1} = ft_timelockbaseline(cfg1, data_trp_D1{n1});

    data_trp_S2{n1} = ft_timelockbaseline(cfg1, data_trp_S2{n1});
    data_trp_D2{n1} = ft_timelockbaseline(cfg1, data_trp_D2{n1});
end


%% calculate difference waves

cfg = [];
cfg.operation = 'subtract';
cfg.parameter = 'avg';

for n = 1:length(data_dup_D1)
    diff_dup_1{n} =  ft_math(cfg,data_dup_D1{n},data_dup_S1{n});
    diff_dup_2{n} =  ft_math(cfg,data_dup_D2{n},data_dup_S2{n});
end
for n = 1:length(data_trp_D1)
    diff_trp_1{n} =  ft_math(cfg,data_trp_D1{n},data_trp_S1{n});
    diff_trp_2{n} =  ft_math(cfg,data_trp_D2{n},data_trp_S2{n});
end


%% grand average
cfg = [];
cfg.keepindividual = 'no';

ga_dup_S1 = ft_timelockgrandaverage(cfg,data_dup_S1{:});
ga_dup_D1 = ft_timelockgrandaverage(cfg,data_dup_D1{:});

ga_dup_S2 = ft_timelockgrandaverage(cfg,data_dup_S2{:});
ga_dup_D2 = ft_timelockgrandaverage(cfg,data_dup_D2{:});

ga_trp_S1 = ft_timelockgrandaverage(cfg,data_trp_S1{:});
ga_trp_D1 = ft_timelockgrandaverage(cfg,data_trp_D1{:});

ga_trp_S2 = ft_timelockgrandaverage(cfg,data_trp_S2{:});
ga_trp_D2 = ft_timelockgrandaverage(cfg,data_trp_D2{:});

ga_diff_dup_1 = ft_timelockgrandaverage(cfg,diff_dup_1{:});
ga_diff_dup_2 = ft_timelockgrandaverage(cfg,diff_dup_2{:});

ga_diff_trp_1 = ft_timelockgrandaverage(cfg,diff_trp_1{:});
ga_diff_trp_2 = ft_timelockgrandaverage(cfg,diff_trp_2{:});
%
ga_diff_dup_1.time = [-0.1:0.001:0.600];
ga_diff_dup_2.time = [-0.1:0.001:0.599];
ga_diff_trp_1.time = [-0.1:0.001:0.600];
ga_diff_trp_2.time = [-0.1:0.001:0.599];

%% Try cluster Analysis

% Change time frame
for n = 1:length(listDuple)
    data_dup_S1{n}.time = [-0.1:0.001:0.600];
    data_dup_D1{n}.time = [-0.1:0.001:0.600];
%     data_dup_S2{n}.time = [-0.1:0.001:0.599];
%     data_dup_D2{n}.time = [-0.1:0.001:0.599];
    data_dup_S2{n}.time = [-0.1:0.001:0.600];
    data_dup_D2{n}.time = [-0.1:0.001:0.600];

    diff_dup_1{n}.time = [-0.1:0.001:0.600];
    diff_dup_2{n}.time = [-0.1:0.001:0.600];
end
for  n = 1:length(listTriple)
    data_trp_S1{n}.time = [-0.1:0.001:0.600];
    data_trp_D1{n}.time = [-0.1:0.001:0.600];
%     data_trp_S2{n}.time = [-0.1:0.001:0.599];
%     data_trp_D2{n}.time = [-0.1:0.001:0.599];
    data_trp_S2{n}.time = [-0.1:0.001:0.600];
    data_trp_D2{n}.time = [-0.1:0.001:0.600];

    diff_trp_1{n}.time = [-0.1:0.001:0.600];
    diff_trp_2{n}.time = [-0.1:0.001:0.600];
end

% Set up the data structure
data_all_S1 = cat(2,data_dup_S1,data_trp_S1);
data_all_D1 = cat(2,data_dup_D1,data_trp_D1);
data_all_S2 = cat(2,data_dup_S2,data_trp_S2);
data_all_D2 = cat(2,data_dup_D2,data_trp_D2);
data_all_strong = cat(2,diff_dup_2,diff_trp_1);
data_all_weak = cat(2,diff_dup_2,diff_trp_1);
subList_ordered = cat(2,listDuple,listTriple);

t1 = [-0.1:0.001:0.600];
t2 = [-0.1:0.001:0.599];

%%
load('layout_neighbours.mat');

cfg                  = [];
cfg.channel          = 'all';
cfg.neighbours       = neighbours; % based off 132 chans... might need to edit?
cfg.latency          = [0.150 0.450]; % originally did 100-500 ms
cfg.avgovertime      = 'no';
cfg.parameter        = 'avg';
cfg.method           = 'montecarlo';
% cfg.method           = 'analytic'; % this works though!
cfg.statistic        = 'ft_statfun_depsamplesT';
cfg.alpha            = 0.05;
cfg.clusteralpha     = 0.05;
cfg.clusterthreshold = 'nonparametric_individual';
% cfg.clustercritval   = 0.05; 
cfg.correctm         = 'cluster';
cfg.correcttail      = 'prob';
cfg.clustertail      = 0;
cfg.numrandomization = 5000;
cfg.minnbchan        = 2; % minimal neighbouring channels (originally 2)
cfg.tail             = 0; % try +1 for positive clusters only, -1 neg
%  
% Nsub = length(subList_ordered); % edit as needed
% Nsub = length(listDuple);
Nsub = length(listTriple);
cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
% cfg.design(2,1:2*Nsub)  = [subList_ordered subList_ordered];
cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number

% % Permute over std_dev:
% stat = ft_timelockstatistics(cfg,data_all_D1{:},data_all_S1{:}); 
% stat = ft_timelockstatistics(cfg,data_all_D2{:},data_all_S2{:}); 

% stat = ft_timelockstatistics(cfg,data_dup_D1{:},data_dup_S1{:}); 
% stat = ft_timelockstatistics(cfg,data_dup_D2{:},data_dup_S2{:}); 
% stat = ft_timelockstatistics(cfg,data_trp_D1{:},data_trp_S1{:}); 
stat = ft_timelockstatistics(cfg,data_trp_D2{:},data_trp_S2{:}); 

% % Permute between beat positions for MMR:
% stat = ft_timelockstatistics(cfg,diff_dup_2{:},diff_dup_1{:}); 
% stat = ft_timelockstatistics(cfg,diff_trp_1{:},diff_trp_2{:}); 
% stat =  ft_timelockstatistics(cfg,data_all_strong{:},data_all_weak{:}); 
%% plot it - CHANGE CODE TO PLOT SIG MASKS OVER THE ORIGINAL DIFF WAVES.
cfgEGI128chan

% layout
cfg = [];
data = [];
data.elec = ft_read_sens('GSN-HydroCel-129.sfp');
layout = ft_prepare_layout(cfg,data); % use the sfp to creat the layout file!
layout.label{strcmp(layout.label,'Cz')} = 'VREF';
stat.dimord = 'chan_time';

% ch = stat.label(stat.prob<.05);
cfg = [];
% cfg.xlim = [];
cfg.channel = 'all';
cfg.layout = layout;
cfg.colorbar = 'yes';
cfg.renderer = 'painters';
cfg.parameter = 'stat';
cfg.maskparameter = 'mask'; % posclusterslabelmat    mask   negclusterslabelmat
cfg.maskalpha = 1;
cfg.maskstyle = 'box';
cfg.colorbartext = 'Power (dB)';
cfg.showlabels = 'yes';
cfg.showoutline = 'yes';
cfg.colormap = 'jet';
cfg.masknans = 'yes';
% cfg.zlim = 'maxabs';
figure
ft_multiplotER(cfg,stat);

%%
stat.avg = stat.prob;
% stat.avg = stat.stat;
sig_samples = stat;
ind = isnan(sum(sig_samples.stat,2));
sig_samples.prob(ind,:) = [];
sum(sum(sig_samples.prob<.05))
figure;
ft_multiplotER(cfg,stat)

%% plot (optional... better to use shaded error plot script)

% define channel sets
cfgEGI128chan

% layout
cfg = [];
data = [];
data.elec = ft_read_sens('GSN-HydroCel-129.sfp');
layout = ft_prepare_layout(cfg,data); % use the sfp to creat the layout file!
layout.label{strcmp(layout.label,'Cz')} = 'VREF';

% % % topography plot

cfg = [];
cfg.xlim = [0.200 0.400];
cfg.zlim = [-3 3];
cfg.layout = layout;
cfg.channel = 'all';
cfg.colorbar = 'yes';
figure;
ft_topoplotER(cfg, ga_diff_dup_1)
figure;
ft_topoplotER(cfg, ga_diff_dup_2)
figure;
ft_topoplotER(cfg, ga_diff_trp_1)
figure;
ft_topoplotER(cfg, ga_diff_trp_2)

% % multiple single plot
% TL={'E39','E40','E44','E45','E46','E49','E50','E56','E57'};
% TR ={'E100','E101','E102','E107','E108','E109','E113','E114','E115'};
% figure
% for n = 1:9 %originally had 1:6 for FL, FR, CL, CR, FZ, CZ)
%     chan_sel = {FL,FZ,FR,CL,CZ,CR};
%     chan_sel_labels = {'FL','FZ','FR','CL','CZ','CR'};
% %     chan_sel = {FL,FR,CL,CR,PL,PR,OL,OR,TL,TR};%use ten groupings: FL,FR,CL,CR,PL,PR,OL,OR,TL,TR
%     % single plot
% %     subplot(2,5,n) %for original 6 groupings it was subplot(2,3,m)...
% %     this isn't working anymore...
%     cfg = [];
%     cfg.parameter  = 'avg';
%     cfg.channel = chan_sel{n};
% %     cfg.baseline = baseline;
%     cfg.renderer = 'painters';
%     cfg.graphcolor = 'brk';
%     cfg.linewidth = 1;
%
%     figure;
% %     ft_singleplotER(cfg, ga_dup_S1, ga_dup_D1); %These plots not working anymore...might need to update matlab.
% %     ft_singleplotER(cfg, ga_dup_S2, ga_dup_D2);
% %     ft_singleplotER(cfg, ga_trp_S1, ga_trp_D1);
% %     ft_singleplotER(cfg, ga_trp_S2, ga_trp_D2);
%     ft_singleplotER(cfg, ga_diff_dup_2, ga_diff_dup_1)
% %     ft_singleplotER(cfg, ga_diff_trp_1, ga_diff_trp_2)
%
% %     legend('std','dev','location','southeast')
%     legend('strong beat','weak beat','location','southeast')
%
% %     ylim([-3,3]);
%     set(gca, 'Color', 'None');
%     ax = gca;
%     ax.XAxisLocation = 'origin';
%     ax.YAxisLocation = 'origin';
% %     set(gca,'YTickLabel',[]); %remove tick labels
%     set(gca,'XTickLabel',[]);
%     title(chan_sel_labels(n),'fontsize',15)
%
% %
% %     if n==1
% %         title('FL','fontsize',15) %these were also different before obviously, to match the proper electrode groupings
% %     elseif n==2
% %         title('FR','fontsize',15)
% %     elseif n==3
% %         title('CL','fontsize',15)
% %     elseif n==4
% %         title('CR','fontsize',15)
% %     elseif n==5
% %         title('PL','fontsize',15)
% %     elseif n==6
% %         title('PR','fontsize',15)
% %     elseif n==7
% %         title('OL','fontsize',15)
% %     elseif n==8
% %         title('OR','fontsize',15)
% %     elseif n==9
% %         title('TL','fontsize',15)
% %     elseif n==10
% %         title('TR','fontsize',15)
% %     end
% end
%% Select FL data for finding peaks
% define channel sets
cfgEGI128chan
cfg = [];
cfg.channel = FL;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

% Select the data to find the peaks in (electrode grouping avg's)
for n = 1:length(data_dup_D1)
    FL_dup_S1{n} = ft_selectdata(cfg, data_dup_S1{n}); %Standards
    FL_dup_S2{n} = ft_selectdata(cfg, data_dup_S2{n});

    FL_dup_D1{n} = ft_selectdata(cfg, data_dup_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    FL_dup_D2{n} = ft_selectdata(cfg, data_dup_D2{n});

end
for n = 1:length(data_trp_D1)
    FL_trp_S1{n} = ft_selectdata(cfg, data_trp_S1{n}); %Standards
    FL_trp_S2{n} = ft_selectdata(cfg, data_trp_S2{n});

    FL_trp_D1{n} = ft_selectdata(cfg, data_trp_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    FL_trp_D2{n} = ft_selectdata(cfg, data_trp_D2{n});
end
for n = 1:length(diff_dup_1)
    FL_diff_dup_1{n} = ft_selectdata(cfg, diff_dup_1{n});
    FL_diff_dup_2{n} = ft_selectdata(cfg, diff_dup_2{n});
end
for n = 1:length(diff_trp_1)
    FL_diff_trp_1{n} = ft_selectdata(cfg, diff_trp_1{n});
    FL_diff_trp_2{n} = ft_selectdata(cfg, diff_trp_2{n});
end

% Select FZ data for finding peaks
cfg = [];
cfg.channel = FZ;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

for n = 1:length(data_dup_D1)
    FZ_dup_S1{n} = ft_selectdata(cfg, data_dup_S1{n}); %Standards
    FZ_dup_S2{n} = ft_selectdata(cfg, data_dup_S2{n});

    FZ_dup_D1{n} = ft_selectdata(cfg, data_dup_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    FZ_dup_D2{n} = ft_selectdata(cfg, data_dup_D2{n});

end
for n = 1:length(data_trp_D1)
    FZ_trp_S1{n} = ft_selectdata(cfg, data_trp_S1{n}); %Standards
    FZ_trp_S2{n} = ft_selectdata(cfg, data_trp_S2{n});

    FZ_trp_D1{n} = ft_selectdata(cfg, data_trp_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    FZ_trp_D2{n} = ft_selectdata(cfg, data_trp_D2{n});
end
for n = 1:length(diff_dup_1)
    FZ_diff_dup_1{n} = ft_selectdata(cfg, diff_dup_1{n});
    FZ_diff_dup_2{n} = ft_selectdata(cfg, diff_dup_2{n});
end
for n = 1:length(diff_trp_1)
    FZ_diff_trp_1{n} = ft_selectdata(cfg, diff_trp_1{n});
    FZ_diff_trp_2{n} = ft_selectdata(cfg, diff_trp_2{n});
end

% Select FR data for finding peaks
cfg = [];
cfg.channel = FR;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

for n = 1:length(data_dup_D1)
    FR_dup_S1{n} = ft_selectdata(cfg, data_dup_S1{n}); %Standards
    FR_dup_S2{n} = ft_selectdata(cfg, data_dup_S2{n});

    FR_dup_D1{n} = ft_selectdata(cfg, data_dup_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    FR_dup_D2{n} = ft_selectdata(cfg, data_dup_D2{n});

end
for n = 1:length(data_trp_D1)
    FR_trp_S1{n} = ft_selectdata(cfg, data_trp_S1{n}); %Standards
    FR_trp_S2{n} = ft_selectdata(cfg, data_trp_S2{n});

    FR_trp_D1{n} = ft_selectdata(cfg, data_trp_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    FR_trp_D2{n} = ft_selectdata(cfg, data_trp_D2{n});
end
for n = 1:length(diff_dup_1)
    FR_diff_dup_1{n} = ft_selectdata(cfg, diff_dup_1{n});
    FR_diff_dup_2{n} = ft_selectdata(cfg, diff_dup_2{n});
end
for n = 1:length(diff_trp_1)
    FR_diff_trp_1{n} = ft_selectdata(cfg, diff_trp_1{n});
    FR_diff_trp_2{n} = ft_selectdata(cfg, diff_trp_2{n});
end

% Select CL data for finding peaks
cfg = [];
cfg.channel = CL;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

for n = 1:length(data_dup_D1)
    CL_dup_S1{n} = ft_selectdata(cfg, data_dup_S1{n}); %Standards
    CL_dup_S2{n} = ft_selectdata(cfg, data_dup_S2{n});

    CL_dup_D1{n} = ft_selectdata(cfg, data_dup_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    CL_dup_D2{n} = ft_selectdata(cfg, data_dup_D2{n});

end
for n = 1:length(data_trp_D1)
    CL_trp_S1{n} = ft_selectdata(cfg, data_trp_S1{n}); %Standards
    CL_trp_S2{n} = ft_selectdata(cfg, data_trp_S2{n});

    CL_trp_D1{n} = ft_selectdata(cfg, data_trp_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    CL_trp_D2{n} = ft_selectdata(cfg, data_trp_D2{n});
end
for n = 1:length(diff_dup_1)
    CL_diff_dup_1{n} = ft_selectdata(cfg, diff_dup_1{n});
    CL_diff_dup_2{n} = ft_selectdata(cfg, diff_dup_2{n});
end
for n = 1:length(diff_trp_1)
    CL_diff_trp_1{n} = ft_selectdata(cfg, diff_trp_1{n});
    CL_diff_trp_2{n} = ft_selectdata(cfg, diff_trp_2{n});
end

% Select CZ data for finding peaks
cfg = [];
cfg.channel = CZ;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

for n = 1:length(data_dup_D1)
    CZ_dup_S1{n} = ft_selectdata(cfg, data_dup_S1{n}); %Standards
    CZ_dup_S2{n} = ft_selectdata(cfg, data_dup_S2{n});

    CZ_dup_D1{n} = ft_selectdata(cfg, data_dup_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    CZ_dup_D2{n} = ft_selectdata(cfg, data_dup_D2{n});

end
for n = 1:length(data_trp_D1)
    CZ_trp_S1{n} = ft_selectdata(cfg, data_trp_S1{n}); %Standards
    CZ_trp_S2{n} = ft_selectdata(cfg, data_trp_S2{n});

    CZ_trp_D1{n} = ft_selectdata(cfg, data_trp_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    CZ_trp_D2{n} = ft_selectdata(cfg, data_trp_D2{n});
end
for n = 1:length(diff_dup_1)
    CZ_diff_dup_1{n} = ft_selectdata(cfg, diff_dup_1{n});
    CZ_diff_dup_2{n} = ft_selectdata(cfg, diff_dup_2{n});
end
for n = 1:length(diff_trp_1)
    CZ_diff_trp_1{n} = ft_selectdata(cfg, diff_trp_1{n});
    CZ_diff_trp_2{n} = ft_selectdata(cfg, diff_trp_2{n});
end

% Select CR data for finding peaks
cfg = [];
cfg.channel = CR;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

for n = 1:length(data_dup_D1)
    CR_dup_S1{n} = ft_selectdata(cfg, data_dup_S1{n}); %Standards
    CR_dup_S2{n} = ft_selectdata(cfg, data_dup_S2{n});

    CR_dup_D1{n} = ft_selectdata(cfg, data_dup_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    CR_dup_D2{n} = ft_selectdata(cfg, data_dup_D2{n});

end
for n = 1:length(data_trp_D1)
    CR_trp_S1{n} = ft_selectdata(cfg, data_trp_S1{n}); %Standards
    CR_trp_S2{n} = ft_selectdata(cfg, data_trp_S2{n});

    CR_trp_D1{n} = ft_selectdata(cfg, data_trp_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    CR_trp_D2{n} = ft_selectdata(cfg, data_trp_D2{n});
end
for n = 1:length(diff_dup_1)
    CR_diff_dup_1{n} = ft_selectdata(cfg, diff_dup_1{n});
    CR_diff_dup_2{n} = ft_selectdata(cfg, diff_dup_2{n});
end
for n = 1:length(diff_trp_1)
    CR_diff_trp_1{n} = ft_selectdata(cfg, diff_trp_1{n});
    CR_diff_trp_2{n} = ft_selectdata(cfg, diff_trp_2{n});
end


% Select OL data for finding peaks
cfg = [];
cfg.channel = OL;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

for n = 1:length(data_dup_D1)
    OL_dup_S1{n} = ft_selectdata(cfg, data_dup_S1{n}); %Standards
    OL_dup_S2{n} = ft_selectdata(cfg, data_dup_S2{n});

    OL_dup_D1{n} = ft_selectdata(cfg, data_dup_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    OL_dup_D2{n} = ft_selectdata(cfg, data_dup_D2{n});

end
for n = 1:length(data_trp_D1)
    OL_trp_S1{n} = ft_selectdata(cfg, data_trp_S1{n}); %Standards
    OL_trp_S2{n} = ft_selectdata(cfg, data_trp_S2{n});

    OL_trp_D1{n} = ft_selectdata(cfg, data_trp_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    OL_trp_D2{n} = ft_selectdata(cfg, data_trp_D2{n});
end
for n = 1:length(diff_dup_1)
    OL_diff_dup_1{n} = ft_selectdata(cfg, diff_dup_1{n});
    OL_diff_dup_2{n} = ft_selectdata(cfg, diff_dup_2{n});
end
for n = 1:length(diff_trp_1)
    OL_diff_trp_1{n} = ft_selectdata(cfg, diff_trp_1{n});
    OL_diff_trp_2{n} = ft_selectdata(cfg, diff_trp_2{n});
end

% Select OZ data for finding peaks
cfg = [];
cfg.channel = OZ;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

for n = 1:length(data_dup_D1)
    OZ_dup_S1{n} = ft_selectdata(cfg, data_dup_S1{n}); %Standards
    OZ_dup_S2{n} = ft_selectdata(cfg, data_dup_S2{n});

    OZ_dup_D1{n} = ft_selectdata(cfg, data_dup_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    OZ_dup_D2{n} = ft_selectdata(cfg, data_dup_D2{n});

end
for n = 1:length(data_trp_D1)
    OZ_trp_S1{n} = ft_selectdata(cfg, data_trp_S1{n}); %Standards
    OZ_trp_S2{n} = ft_selectdata(cfg, data_trp_S2{n});

    OZ_trp_D1{n} = ft_selectdata(cfg, data_trp_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    OZ_trp_D2{n} = ft_selectdata(cfg, data_trp_D2{n});
end
for n = 1:length(diff_dup_1)
    OZ_diff_dup_1{n} = ft_selectdata(cfg, diff_dup_1{n});
    OZ_diff_dup_2{n} = ft_selectdata(cfg, diff_dup_2{n});
end
for n = 1:length(diff_trp_1)
    OZ_diff_trp_1{n} = ft_selectdata(cfg, diff_trp_1{n});
    OZ_diff_trp_2{n} = ft_selectdata(cfg, diff_trp_2{n});
end

% Select OR data for finding peaks
cfg = [];
cfg.channel = OR;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

for n = 1:length(data_dup_D1)
    OR_dup_S1{n} = ft_selectdata(cfg, data_dup_S1{n}); %Standards
    OR_dup_S2{n} = ft_selectdata(cfg, data_dup_S2{n});

    OR_dup_D1{n} = ft_selectdata(cfg, data_dup_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    OR_dup_D2{n} = ft_selectdata(cfg, data_dup_D2{n});

end
for n = 1:length(data_trp_D1)
    OR_trp_S1{n} = ft_selectdata(cfg, data_trp_S1{n}); %Standards
    OR_trp_S2{n} = ft_selectdata(cfg, data_trp_S2{n});

    OR_trp_D1{n} = ft_selectdata(cfg, data_trp_D1{n}); %Deviants - used to find peaks, then use the latency for standards too
    OR_trp_D2{n} = ft_selectdata(cfg, data_trp_D2{n});
end
for n = 1:length(diff_dup_1)
    OR_diff_dup_1{n} = ft_selectdata(cfg, diff_dup_1{n});
    OR_diff_dup_2{n} = ft_selectdata(cfg, diff_dup_2{n});
end
for n = 1:length(diff_trp_1)
    OR_diff_trp_1{n} = ft_selectdata(cfg, diff_trp_1{n});
    OR_diff_trp_2{n} = ft_selectdata(cfg, diff_trp_2{n});
end

%% Change time frame - Dont need???
for n = 1 :length(CL_dup_D1)
    CL_dup_S1{n}.time = [-0.1:0.001:0.600];
    CL_dup_D1{n}.time = [-0.1:0.001:0.600];
    CL_dup_S2{n}.time = [-0.1:0.001:0.599];
    CL_dup_D2{n}.time = [-0.1:0.001:0.599];
    CL_diff_dup_1{n}.time = [-0.1:0.001:0.600];
    CL_diff_dup_2{n}.time = [-0.1:0.001:0.599];

    CZ_dup_S1{n}.time = [-0.1:0.001:0.600];
    CZ_dup_D1{n}.time = [-0.1:0.001:0.600];
    CZ_dup_S2{n}.time = [-0.1:0.001:0.599];
    CZ_dup_D2{n}.time = [-0.1:0.001:0.599];
    CZ_diff_dup_1{n}.time = [-0.1:0.001:0.600];
    CZ_diff_dup_2{n}.time = [-0.1:0.001:0.599];

    CR_dup_S1{n}.time = [-0.1:0.001:0.600];
    CR_dup_D1{n}.time = [-0.1:0.001:0.600];
    CR_dup_S2{n}.time = [-0.1:0.001:0.599];
    CR_dup_D2{n}.time = [-0.1:0.001:0.599];
    CR_diff_dup_1{n}.time = [-0.1:0.001:0.600];
    CR_diff_dup_2{n}.time = [-0.1:0.001:0.599];
end
for n = 1 :length(CL_trp_D1)
    CL_trp_S1{n}.time = [-0.1:0.001:0.600];
    CL_trp_D1{n}.time = [-0.1:0.001:0.600];
    CL_trp_S2{n}.time = [-0.1:0.001:0.599];
    CL_trp_D2{n}.time = [-0.1:0.001:0.599];
    CL_diff_trp_1{n}.time = [-0.1:0.001:0.600];
    CL_diff_trp_2{n}.time = [-0.1:0.001:0.599];

    CZ_trp_S1{n}.time = [-0.1:0.001:0.600];
    CZ_trp_D1{n}.time = [-0.1:0.001:0.600];
    CZ_trp_S2{n}.time = [-0.1:0.001:0.599];
    CZ_trp_D2{n}.time = [-0.1:0.001:0.599];
    CZ_diff_trp_1{n}.time = [-0.1:0.001:0.600];
    CZ_diff_trp_2{n}.time = [-0.1:0.001:0.599];

    CR_trp_S1{n}.time = [-0.1:0.001:0.600];
    CR_trp_D1{n}.time = [-0.1:0.001:0.600];
    CR_trp_S2{n}.time = [-0.1:0.001:0.599];
    CR_trp_D2{n}.time = [-0.1:0.001:0.599];
    CR_diff_trp_1{n}.time = [-0.1:0.001:0.600];
    CR_diff_trp_2{n}.time = [-0.1:0.001:0.599];
end

for n = 1 :length(FL_dup_D1)
    FL_dup_S1{n}.time = [-0.1:0.001:0.600];
    FL_dup_D1{n}.time = [-0.1:0.001:0.600];
    FL_dup_S2{n}.time = [-0.1:0.001:0.599];
    FL_dup_D2{n}.time = [-0.1:0.001:0.599];
    FL_diff_dup_1{n}.time = [-0.1:0.001:0.600];
    FL_diff_dup_2{n}.time = [-0.1:0.001:0.599];

    FZ_dup_S1{n}.time = [-0.1:0.001:0.600];
    FZ_dup_D1{n}.time = [-0.1:0.001:0.600];
    FZ_dup_S2{n}.time = [-0.1:0.001:0.599];
    FZ_dup_D2{n}.time = [-0.1:0.001:0.599];
    FZ_diff_dup_1{n}.time = [-0.1:0.001:0.600];
    FZ_diff_dup_2{n}.time = [-0.1:0.001:0.599];

    FR_dup_S1{n}.time = [-0.1:0.001:0.600];
    FR_dup_D1{n}.time = [-0.1:0.001:0.600];
    FR_dup_S2{n}.time = [-0.1:0.001:0.599];
    FR_dup_D2{n}.time = [-0.1:0.001:0.599];
    FR_diff_dup_1{n}.time = [-0.1:0.001:0.600];
    FR_diff_dup_2{n}.time = [-0.1:0.001:0.599];
end
for n = 1 :length(FL_trp_D1)
    FL_trp_S1{n}.time = [-0.1:0.001:0.600];
    FL_trp_D1{n}.time = [-0.1:0.001:0.600];
    FL_trp_S2{n}.time = [-0.1:0.001:0.599];
    FL_trp_D2{n}.time = [-0.1:0.001:0.599];
    FL_diff_trp_1{n}.time = [-0.1:0.001:0.600];
    FL_diff_trp_2{n}.time = [-0.1:0.001:0.599];

    FZ_trp_S1{n}.time = [-0.1:0.001:0.600];
    FZ_trp_D1{n}.time = [-0.1:0.001:0.600];
    FZ_trp_S2{n}.time = [-0.1:0.001:0.599];
    FZ_trp_D2{n}.time = [-0.1:0.001:0.599];
    FZ_diff_trp_1{n}.time = [-0.1:0.001:0.600];
    FZ_diff_trp_2{n}.time = [-0.1:0.001:0.599];

    FR_trp_S1{n}.time = [-0.1:0.001:0.600];
    FR_trp_D1{n}.time = [-0.1:0.001:0.600];
    FR_trp_S2{n}.time = [-0.1:0.001:0.599];
    FR_trp_D2{n}.time = [-0.1:0.001:0.599];
    FR_diff_trp_1{n}.time = [-0.1:0.001:0.600];
    FR_diff_trp_2{n}.time = [-0.1:0.001:0.599];
end

for n = 1 :length(OL_dup_D1)
    OL_dup_S1{n}.time = [-0.1:0.001:0.600];
    OL_dup_D1{n}.time = [-0.1:0.001:0.600];
    OL_dup_S2{n}.time = [-0.1:0.001:0.599];
    OL_dup_D2{n}.time = [-0.1:0.001:0.599];
    OL_diff_dup_1{n}.time = [-0.1:0.001:0.600];
    OL_diff_dup_2{n}.time = [-0.1:0.001:0.599];

    OZ_dup_S1{n}.time = [-0.1:0.001:0.600];
    OZ_dup_D1{n}.time = [-0.1:0.001:0.600];
    OZ_dup_S2{n}.time = [-0.1:0.001:0.599];
    OZ_dup_D2{n}.time = [-0.1:0.001:0.599];
    OZ_diff_dup_1{n}.time = [-0.1:0.001:0.600];
    OZ_diff_dup_2{n}.time = [-0.1:0.001:0.599];

    OR_dup_S1{n}.time = [-0.1:0.001:0.600];
    OR_dup_D1{n}.time = [-0.1:0.001:0.600];
    OR_dup_S2{n}.time = [-0.1:0.001:0.599];
    OR_dup_D2{n}.time = [-0.1:0.001:0.599];
    OR_diff_dup_1{n}.time = [-0.1:0.001:0.600];
    OR_diff_dup_2{n}.time = [-0.1:0.001:0.599];
end
for n = 1 :length(OL_trp_D1)
    OL_trp_S1{n}.time = [-0.1:0.001:0.600];
    OL_trp_D1{n}.time = [-0.1:0.001:0.600];
    OL_trp_S2{n}.time = [-0.1:0.001:0.599];
    OL_trp_D2{n}.time = [-0.1:0.001:0.599];
    OL_diff_trp_1{n}.time = [-0.1:0.001:0.600];
    OL_diff_trp_2{n}.time = [-0.1:0.001:0.599];

    OZ_trp_S1{n}.time = [-0.1:0.001:0.600];
    OZ_trp_D1{n}.time = [-0.1:0.001:0.600];
    OZ_trp_S2{n}.time = [-0.1:0.001:0.599];
    OZ_trp_D2{n}.time = [-0.1:0.001:0.599];
    OZ_diff_trp_1{n}.time = [-0.1:0.001:0.600];
    OZ_diff_trp_2{n}.time = [-0.1:0.001:0.599];

    OR_trp_S1{n}.time = [-0.1:0.001:0.600];
    OR_trp_D1{n}.time = [-0.1:0.001:0.600];
    OR_trp_S2{n}.time = [-0.1:0.001:0.599];
    OR_trp_D2{n}.time = [-0.1:0.001:0.599];
    OR_diff_trp_1{n}.time = [-0.1:0.001:0.600];
    OR_diff_trp_2{n}.time = [-0.1:0.001:0.599];
end
%% create data structure that will have all the variables in it
data = [];

data.dup.FL.diff1 = FL_diff_dup_1;
data.dup.FL.diff2 = FL_diff_dup_2;
data.dup.FL.S1 = FL_dup_S1;
data.dup.FL.D1 = FL_dup_D1;
data.dup.FL.S2 = FL_dup_S2;
data.dup.FL.D2 = FL_dup_D2;

data.dup.FZ.diff1 = FZ_diff_dup_1;
data.dup.FZ.diff2 = FZ_diff_dup_2;
data.dup.FZ.S1 = FZ_dup_S1;
data.dup.FZ.D1 = FZ_dup_D1;
data.dup.FZ.S2 = FZ_dup_S2;
data.dup.FZ.D2 = FZ_dup_D2;

data.dup.FR.diff1 = FR_diff_dup_1;
data.dup.FR.diff2 = FR_diff_dup_2;
data.dup.FR.S1 = FR_dup_S1;
data.dup.FR.D1 = FR_dup_D1;
data.dup.FR.S2 = FR_dup_S2;
data.dup.FR.D2 = FR_dup_D2;

data.dup.CL.diff1 = CL_diff_dup_1;
data.dup.CL.diff2 = CL_diff_dup_2;
data.dup.CL.S1 = CL_dup_S1;
data.dup.CL.D1 = CL_dup_D1;
data.dup.CL.S2 = CL_dup_S2;
data.dup.CL.D2 = CL_dup_D2;

data.dup.CZ.diff1 = CZ_diff_dup_1;
data.dup.CZ.diff2 = CZ_diff_dup_2;
data.dup.CZ.S1 = CZ_dup_S1;
data.dup.CZ.D1 = CZ_dup_D1;
data.dup.CZ.S2 = CZ_dup_S2;
data.dup.CZ.D2 = CZ_dup_D2;

data.dup.CR.diff1 = CR_diff_dup_1;
data.dup.CR.diff2 = CR_diff_dup_2;
data.dup.CR.S1 = CR_dup_S1;
data.dup.CR.D1 = CR_dup_D1;
data.dup.CR.S2 = CR_dup_S2;
data.dup.CR.D2 = CR_dup_D2;

data.trp.FL.diff1 = FL_diff_trp_1;
data.trp.FL.diff2 = FL_diff_trp_2;
data.trp.FL.S1 = FL_trp_S1;
data.trp.FL.D1 = FL_trp_D1;
data.trp.FL.S2 = FL_trp_S2;
data.trp.FL.D2 = FL_trp_D2;

data.trp.FZ.diff1 = FZ_diff_trp_1;
data.trp.FZ.diff2 = FZ_diff_trp_2;
data.trp.FZ.S1 = FZ_trp_S1;
data.trp.FZ.D1 = FZ_trp_D1;
data.trp.FZ.S2 = FZ_trp_S2;
data.trp.FZ.D2 = FZ_trp_D2;

data.trp.FR.diff1 = FR_diff_trp_1;
data.trp.FR.diff2 = FR_diff_trp_2;
data.trp.FR.S1 = FR_trp_S1;
data.trp.FR.D1 = FR_trp_D1;
data.trp.FR.S2 = FR_trp_S2;
data.trp.FR.D2 = FR_trp_D2;

data.trp.CL.diff1 = CL_diff_trp_1;
data.trp.CL.diff2 = CL_diff_trp_2;
data.trp.CL.S1 = CL_trp_S1;
data.trp.CL.D1 = CL_trp_D1;
data.trp.CL.S2 = CL_trp_S2;
data.trp.CL.D2 = CL_trp_D2;

data.trp.CZ.diff1 = CZ_diff_trp_1;
data.trp.CZ.diff2 = CZ_diff_trp_2;
data.trp.CZ.S1 = CZ_trp_S1;
data.trp.CZ.D1 = CZ_trp_D1;
data.trp.CZ.S2 = CZ_trp_S2;
data.trp.CZ.D2 = CZ_trp_D2;

data.trp.CR.diff1 = CR_diff_trp_1;
data.trp.CR.diff2 = CR_diff_trp_2;
data.trp.CR.S1 = CR_trp_S1;
data.trp.CR.D1 = CR_trp_D1;
data.trp.CR.S2 = CR_trp_S2;
data.trp.CR.D2 = CR_trp_D2;

save('D:\Erica\Infant_Rhythm_3tempos\Matlab_Analysis\preprocessed_MMN_infant\mmr_data.mat','data')

%% GO TO DATA EXPORT
