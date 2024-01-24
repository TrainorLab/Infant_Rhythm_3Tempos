%% Plot Non-binned signal

% Average across all electrodes for each participant
% define channel sets
cfgEGI128chan
cfg = [];
cfg.channel = 'all';
cfg.frequency = 'all';
cfg.avgoverchan = 'yes';
cfg.keepindividual = 'yes';

for n = 1:length(dup_freq)
    dup_freq_allchan{n} = ft_selectdata(cfg, dup_freq{n});
end
for n = 1:length(trp_freq)
    trp_freq_allchan{n} = ft_selectdata(cfg, trp_freq{n});
end


%% Grand average
cfgEGI128chan

cfg = [];
cfg.keepindividual = 'no';
cfg.foilim = 'all'; %frequencies of interest, default = all.
cfg.channel = 'all';
cfg.parameter = 'powspctrm';

dup_ga_freq = ft_freqgrandaverage(cfg,dup_freq{:});
trp_ga_freq = ft_freqgrandaverage(cfg,trp_freq{:});
ALL_dup_ga_freq = mean(dup_ga_freq.powspctrm);
ALL_trp_ga_freq = mean(trp_ga_freq.powspctrm);

%% plot individuals for All channels
x_limit = ([0.5 4]);
Y = ([-0.15, 1]);

figure;
for n = 1:length(dup_freq_allchan)
    hold on;
    plot(dup_freq_allchan{n}.freq,dup_freq_allchan{n}.powspctrm);
    title('Dup Freq Spectra All Channels')
    xlim(x_limit)
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
end
plot(dup_freq_allchan{1}.freq,ALL_dup_ga_freq,'k','LineWidth',2);

figure;
for n = 1:length(trp_freq_allchan)
    hold on;
    plot(trp_freq_allchan{n}.freq,trp_freq_allchan{n}.powspctrm);
    title('Trp Freq Spectra All Channels')
    xlim(x_limit)
    %     xlabel('Frequency (Hz)')
    %     ylabel('absolute power (uV^2)')
    ylim(Y)
end
plot(trp_freq_allchan{1}.freq,ALL_trp_ga_freq,'k','LineWidth',2); % something weird with the powspectrum.


