%% plot individuals script
% define channel sets
cfgEGI128chan
cfg = [];
cfg.channel = FL; %change as appropriate
% cfg.xlim = [-0.1 0.6];
cfg.ylim = [-6 9];

figure;
ft_singleplotER(cfg, data_dup_S1{:});
title('FL duple beat 4 std', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('2', '4','location', 'northwest','NumColumns', 4);

figure;
ft_singleplotER(cfg, data_dup_D1{:});
title('FL duple beat 4 dev', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('2', '4','location', 'northwest','NumColumns', 4);

figure;
ft_singleplotER(cfg,  data_dup_S2{:});
title('FL duple beat 5 std', 'fontsize', 15);
xlim()
set(gca,'Color',[0.9 0.9 0.9])
% legend('2', '4','location', 'northwest','NumColumns', 4);

figure;
ft_singleplotER(cfg, data_dup_D2{:})
title('FL duple beat 5 dev', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('2', '4','location', 'northwest','NumColumns', 4);

figure;
ft_singleplotER(cfg, data_trp_S1{:});
title('FL triple beat 4 std', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('1','3','location','northwest','NumColumns', 4);

figure;
ft_singleplotER(cfg, data_trp_D1{:});
title('FL triple beat 4 dev', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('1','3','location','northwest','NumColumns', 4);

figure;
ft_singleplotER(cfg, data_trp_S2{:});
title('FL triple beat 5 std', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('1','3','location','northwest','NumColumns', 4);

figure;
ft_singleplotER(cfg, data_trp_D2{:});
title('FL triple beat 5 dev', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('1','3','location','northwest','NumColumns', 4);

%% Plot difference waves
time1 = [-0.1:0.001:0.600];
time2 = [-0.1:0.001:0.599];

for n1 = 1:length(diff_dup_1)
    diff_dup_1{n1}.time = time1;
    diff_dup_2{n1}.time = time2;
end
for n1 = 1:length(diff_trp_1)
    diff_trp_1{n1}.time = time1;
    diff_trp_2{n1}.time = time2;
end

cfg.ylim = [-10 10];

figure;
ft_singleplotER(cfg, diff_dup_1{:});
title('FL duple individual diff beat 4', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('2','4','6','8','location','northwest','NumColumns', 4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure;
ft_singleplotER(cfg, diff_dup_2{:});
title('FL duple individual diff beat 5', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('2','4','6','8','location','northwest','NumColumns', 4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure;
% subplot(2,1,1);
ft_singleplotER(cfg, diff_trp_1{:});
title('FL triple individual diff beat 4', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('1','3','5','7','9','location','northwest','NumColumns', 4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';

figure;
ft_singleplotER(cfg, diff_trp_2{:});
title('FL triple individual diff beat 5', 'fontsize', 15);
set(gca,'Color',[0.9 0.9 0.9])
% legend('1','3','5','7','9','location','northwest','NumColumns', 4);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
