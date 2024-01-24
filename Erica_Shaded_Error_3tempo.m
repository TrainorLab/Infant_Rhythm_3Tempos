%% Shaded error bars plot
% Select the data from the electrode groupings
% define channel sets
cfgEGI128chan

% FL electrodes configuration
cfg = [];
cfg.channel = FL;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

FL_ga_diff_dup_1 = ft_selectdata(cfg, ga_diff_dup_1);
FL_ga_diff_dup_2 = ft_selectdata(cfg, ga_diff_dup_2);
FL_ga_diff_trp_1 = ft_selectdata(cfg, ga_diff_trp_1);
FL_ga_diff_trp_2 = ft_selectdata(cfg, ga_diff_trp_2);

FL_data_dup_S1 = ft_selectdata(cfg, ga_dup_S1);
FL_data_dup_D1 = ft_selectdata(cfg, ga_dup_D1);
FL_data_dup_S2 = ft_selectdata(cfg, ga_dup_S2);
FL_data_dup_D2 = ft_selectdata(cfg, ga_dup_D2);

FL_data_trp_S1 = ft_selectdata(cfg, ga_trp_S1);
FL_data_trp_D1 = ft_selectdata(cfg, ga_trp_D1);
FL_data_trp_S2 = ft_selectdata(cfg, ga_trp_S2);
FL_data_trp_D2 = ft_selectdata(cfg, ga_trp_D2);

% FZ electrodes configuration
cfg = [];
cfg.channel = FZ;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

FZ_ga_diff_dup_1 = ft_selectdata(cfg, ga_diff_dup_1);
FZ_ga_diff_dup_2 = ft_selectdata(cfg, ga_diff_dup_2);
FZ_ga_diff_trp_1 = ft_selectdata(cfg, ga_diff_trp_1);
FZ_ga_diff_trp_2 = ft_selectdata(cfg, ga_diff_trp_2);

FZ_data_dup_S1 = ft_selectdata(cfg, ga_dup_S1);
FZ_data_dup_D1 = ft_selectdata(cfg, ga_dup_D1);
FZ_data_dup_S2 = ft_selectdata(cfg, ga_dup_S2);
FZ_data_dup_D2 = ft_selectdata(cfg, ga_dup_D2);

FZ_data_trp_S1 = ft_selectdata(cfg, ga_trp_S1);
FZ_data_trp_D1 = ft_selectdata(cfg, ga_trp_D1);
FZ_data_trp_S2 = ft_selectdata(cfg, ga_trp_S2);
FZ_data_trp_D2 = ft_selectdata(cfg, ga_trp_D2);

% FR electrodes configuration
cfg = [];
cfg.channel = FR;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

FR_ga_diff_dup_1 = ft_selectdata(cfg, ga_diff_dup_1);
FR_ga_diff_dup_2 = ft_selectdata(cfg, ga_diff_dup_2);
FR_ga_diff_trp_1 = ft_selectdata(cfg, ga_diff_trp_1);
FR_ga_diff_trp_2 = ft_selectdata(cfg, ga_diff_trp_2);

FR_data_dup_S1 = ft_selectdata(cfg, ga_dup_S1);
FR_data_dup_D1 = ft_selectdata(cfg, ga_dup_D1);
FR_data_dup_S2 = ft_selectdata(cfg, ga_dup_S2);
FR_data_dup_D2 = ft_selectdata(cfg, ga_dup_D2);

FR_data_trp_S1 = ft_selectdata(cfg, ga_trp_S1);
FR_data_trp_D1 = ft_selectdata(cfg, ga_trp_D1);
FR_data_trp_S2 = ft_selectdata(cfg, ga_trp_S2);
FR_data_trp_D2 = ft_selectdata(cfg, ga_trp_D2);


% CL electrodes configuration

cfg = [];
cfg.channel = CL;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

CL_ga_diff_dup_1 = ft_selectdata(cfg, ga_diff_dup_1);
CL_ga_diff_dup_2 = ft_selectdata(cfg, ga_diff_dup_2);
CL_ga_diff_trp_1 = ft_selectdata(cfg, ga_diff_trp_1);
CL_ga_diff_trp_2 = ft_selectdata(cfg, ga_diff_trp_2);

CL_data_dup_S1 = ft_selectdata(cfg, ga_dup_S1);
CL_data_dup_D1 = ft_selectdata(cfg, ga_dup_D1);
CL_data_dup_S2 = ft_selectdata(cfg, ga_dup_S2);
CL_data_dup_D2 = ft_selectdata(cfg, ga_dup_D2);

CL_data_trp_S1 = ft_selectdata(cfg, ga_trp_S1);
CL_data_trp_D1 = ft_selectdata(cfg, ga_trp_D1);
CL_data_trp_S2 = ft_selectdata(cfg, ga_trp_S2);
CL_data_trp_D2 = ft_selectdata(cfg, ga_trp_D2);


% CZ electrodes configuration
cfg = [];
cfg.channel = CZ;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

CZ_ga_diff_dup_1 = ft_selectdata(cfg, ga_diff_dup_1);
CZ_ga_diff_dup_2 = ft_selectdata(cfg, ga_diff_dup_2);
CZ_ga_diff_trp_1 = ft_selectdata(cfg, ga_diff_trp_1);
CZ_ga_diff_trp_2 = ft_selectdata(cfg, ga_diff_trp_2);

CZ_data_dup_S1 = ft_selectdata(cfg, ga_dup_S1);
CZ_data_dup_D1 = ft_selectdata(cfg, ga_dup_D1);
CZ_data_dup_S2 = ft_selectdata(cfg, ga_dup_S2);
CZ_data_dup_D2 = ft_selectdata(cfg, ga_dup_D2);

CZ_data_trp_S1 = ft_selectdata(cfg, ga_trp_S1);
CZ_data_trp_D1 = ft_selectdata(cfg, ga_trp_D1);
CZ_data_trp_S2 = ft_selectdata(cfg, ga_trp_S2);
CZ_data_trp_D2 = ft_selectdata(cfg, ga_trp_D2);

% CR electrodes configuration
cfg = [];
cfg.channel = CR;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

CR_ga_diff_dup_1 = ft_selectdata(cfg, ga_diff_dup_1);
CR_ga_diff_dup_2 = ft_selectdata(cfg, ga_diff_dup_2);
CR_ga_diff_trp_1 = ft_selectdata(cfg, ga_diff_trp_1);
CR_ga_diff_trp_2 = ft_selectdata(cfg, ga_diff_trp_2);

CR_data_dup_S1 = ft_selectdata(cfg, ga_dup_S1);
CR_data_dup_D1 = ft_selectdata(cfg, ga_dup_D1);
CR_data_dup_S2 = ft_selectdata(cfg, ga_dup_S2);
CR_data_dup_D2 = ft_selectdata(cfg, ga_dup_D2);

CR_data_trp_S1 = ft_selectdata(cfg, ga_trp_S1);
CR_data_trp_D1 = ft_selectdata(cfg, ga_trp_D1);
CR_data_trp_S2 = ft_selectdata(cfg, ga_trp_S2);
CR_data_trp_D2 = ft_selectdata(cfg, ga_trp_D2);

% OL electrodes configuration

cfg = [];
cfg.channel = OL;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

OL_ga_diff_dup_1 = ft_selectdata(cfg, ga_diff_dup_1);
OL_ga_diff_dup_2 = ft_selectdata(cfg, ga_diff_dup_2);
OL_ga_diff_trp_1 = ft_selectdata(cfg, ga_diff_trp_1);
OL_ga_diff_trp_2 = ft_selectdata(cfg, ga_diff_trp_2);

OL_data_dup_S1 = ft_selectdata(cfg, ga_dup_S1);
OL_data_dup_D1 = ft_selectdata(cfg, ga_dup_D1);
OL_data_dup_S2 = ft_selectdata(cfg, ga_dup_S2);
OL_data_dup_D2 = ft_selectdata(cfg, ga_dup_D2);

OL_data_trp_S1 = ft_selectdata(cfg, ga_trp_S1);
OL_data_trp_D1 = ft_selectdata(cfg, ga_trp_D1);
OL_data_trp_S2 = ft_selectdata(cfg, ga_trp_S2);
OL_data_trp_D2 = ft_selectdata(cfg, ga_trp_D2);

% OZ electrodes configuration

cfg = [];
cfg.channel = OZ;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

OZ_ga_diff_dup_1 = ft_selectdata(cfg, ga_diff_dup_1);
OZ_ga_diff_dup_2 = ft_selectdata(cfg, ga_diff_dup_2);
OZ_ga_diff_trp_1 = ft_selectdata(cfg, ga_diff_trp_1);
OZ_ga_diff_trp_2 = ft_selectdata(cfg, ga_diff_trp_2);

OZ_data_dup_S1 = ft_selectdata(cfg, ga_dup_S1);
OZ_data_dup_D1 = ft_selectdata(cfg, ga_dup_D1);
OZ_data_dup_S2 = ft_selectdata(cfg, ga_dup_S2);
OZ_data_dup_D2 = ft_selectdata(cfg, ga_dup_D2);

OZ_data_trp_S1 = ft_selectdata(cfg, ga_trp_S1);
OZ_data_trp_D1 = ft_selectdata(cfg, ga_trp_D1);
OZ_data_trp_S2 = ft_selectdata(cfg, ga_trp_S2);
OZ_data_trp_D2 = ft_selectdata(cfg, ga_trp_D2);

% OR electrodes configuration
cfg = [];
cfg.channel = OR;
cfg.keepindividual = 'yes';
cfg.avgoverchan = 'yes';

OR_ga_diff_dup_1 = ft_selectdata(cfg, ga_diff_dup_1);
OR_ga_diff_dup_2 = ft_selectdata(cfg, ga_diff_dup_2);
OR_ga_diff_trp_1 = ft_selectdata(cfg, ga_diff_trp_1);
OR_ga_diff_trp_2 = ft_selectdata(cfg, ga_diff_trp_2);

OR_data_dup_S1 = ft_selectdata(cfg, ga_dup_S1);
OR_data_dup_D1 = ft_selectdata(cfg, ga_dup_D1);
OR_data_dup_S2 = ft_selectdata(cfg, ga_dup_S2);
OR_data_dup_D2 = ft_selectdata(cfg, ga_dup_D2);

OR_data_trp_S1 = ft_selectdata(cfg, ga_trp_S1);
OR_data_trp_D1 = ft_selectdata(cfg, ga_trp_D1);
OR_data_trp_S2 = ft_selectdata(cfg, ga_trp_S2);
OR_data_trp_D2 = ft_selectdata(cfg, ga_trp_D2);

% Front - back config. 
dup_Left_diff_1 = FL_ga_diff_dup_1.avg-OL_ga_diff_dup_1.avg;
dup_Left_diff_2 = FL_ga_diff_dup_2.avg-OL_ga_diff_dup_2.avg;
dup_Right_diff_1 = FR_ga_diff_dup_1.avg-OR_ga_diff_dup_1.avg;
dup_Right_diff_2 = FR_ga_diff_dup_2.avg-OR_ga_diff_dup_2.avg;

trp_Left_diff_1 = FL_ga_diff_trp_1.avg-OL_ga_diff_trp_1.avg;
trp_Left_diff_2 = FL_ga_diff_trp_2.avg-OL_ga_diff_trp_2.avg;
trp_Right_diff_1 = FR_ga_diff_trp_1.avg-OR_ga_diff_trp_1.avg;
trp_Right_diff_2 = FR_ga_diff_trp_2.avg-OR_ga_diff_trp_2.avg;


%% plot FL/FZ/FR DIFF waves
time1 = (-0.1:0.001:0.600);
% time2 = (-0.1:0.001:0.599);
time2 = time1;
Xticks = (-0.1:0.1:0.600);
Y = [-3,3];
Y_ticks =  -3:1:3;

figure;
subplot(2,3,1);
shadedErrorBar(time2,FL_ga_diff_dup_2.avg, (sqrt(FL_ga_diff_dup_2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,FL_ga_diff_dup_1.avg, (sqrt(FL_ga_diff_dup_1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('FL Duple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,3,2);
shadedErrorBar(time2,FZ_ga_diff_dup_2.avg, (sqrt(FZ_ga_diff_dup_2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,FZ_ga_diff_dup_1.avg, (sqrt(FZ_ga_diff_dup_1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('FZ Duple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,3,3);
shadedErrorBar(time2,FR_ga_diff_dup_2.avg, (sqrt(FR_ga_diff_dup_2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,FR_ga_diff_dup_1.avg, (sqrt(FR_ga_diff_dup_1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('FR Duple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,3,4);
shadedErrorBar(time1,FL_ga_diff_trp_1.avg, (sqrt(FL_ga_diff_trp_1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,FL_ga_diff_trp_2.avg, (sqrt(FL_ga_diff_trp_2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('strong','weak','location','southeast')
title('FL Triple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,3,5);
shadedErrorBar(time1,FZ_ga_diff_trp_1.avg, (sqrt(FZ_ga_diff_trp_1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,FZ_ga_diff_trp_2.avg, (sqrt(FZ_ga_diff_trp_2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('strong','weak','location','southeast')
title('FZ Triple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,3,6);
shadedErrorBar(time1,FR_ga_diff_trp_1.avg, (sqrt(FR_ga_diff_trp_1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,FR_ga_diff_trp_2.avg, (sqrt(FR_ga_diff_trp_2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('strong','weak','location','southeast')
title('FR Triple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

%% Plot FL Stds/devs
Y = [-3,6];
Y_ticks =  -3:1:6;

figure;
subplot(2,2,1);
shadedErrorBar(time1,FL_data_dup_S1.avg, (sqrt(FL_data_dup_S1.var))/sqrt(length(data_dup_S1)),{'--','color',[0.3, 0, 0]},1);
hold on
shadedErrorBar(time1,FL_data_dup_D1.avg, (sqrt(FL_data_dup_D1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('FL Duple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,2);
shadedErrorBar(time2,FL_data_dup_S2.avg, (sqrt(FL_data_dup_S2.var))/sqrt(length(data_dup_S2)),{'--','color',[0.1, 0.2, 0.5]},1);
hold on
shadedErrorBar(time2,FL_data_dup_D2.avg, (sqrt(FL_data_dup_D2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
title('FL Duple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,3);
shadedErrorBar(time1,FL_data_trp_S1.avg, (sqrt(FL_data_trp_S1.var))/sqrt(length(data_trp_S1)),{'--','color',[0.3, 0, 0]},1);
hold on
shadedErrorBar(time1,FL_data_trp_D1.avg, (sqrt(FL_data_trp_D1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
title('FL Triple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,4);
shadedErrorBar(time2,FL_data_trp_S2.avg, (sqrt(FL_data_trp_S2.var))/sqrt(length(data_trp_S2)),{'--','color',[0.1, 0.2, 0.5]},1);
hold on
shadedErrorBar(time2,FL_data_trp_D2.avg, (sqrt(FL_data_trp_D2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
title('FL Triple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'
%% Plot FZ Stds/devs

figure;
subplot(2,2,1);
shadedErrorBar(time1,FZ_data_dup_S1.avg, (sqrt(FZ_data_dup_S1.var))/sqrt(length(data_dup_S1)),{'--','color',[0.3, 0, 0]},1);
hold on
shadedErrorBar(time1,FZ_data_dup_D1.avg, (sqrt(FZ_data_dup_D1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('FZ Duple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,2);
shadedErrorBar(time2,FZ_data_dup_S2.avg, (sqrt(FZ_data_dup_S2.var))/sqrt(length(data_dup_S2)),{'--','color',[0.1, 0.2, 0.5]},1);
hold on
shadedErrorBar(time2,FZ_data_dup_D2.avg, (sqrt(FZ_data_dup_D2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
title('FZ Duple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,3);
shadedErrorBar(time1,FZ_data_trp_S1.avg, (sqrt(FZ_data_trp_S1.var))/sqrt(length(data_trp_S1)),{'--','color',[0.3, 0, 0]},1);
hold on
shadedErrorBar(time1,FZ_data_trp_D1.avg, (sqrt(FZ_data_trp_D1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
title('FZ Triple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,4);
shadedErrorBar(time2,FZ_data_trp_S2.avg, (sqrt(FZ_data_trp_S2.var))/sqrt(length(data_trp_S2)),{'--','color',[0.1, 0.2, 0.5]},1);
hold on
shadedErrorBar(time2,FZ_data_trp_D2.avg, (sqrt(FZ_data_trp_D2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
title('FZ Triple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'
%% Plot FR Stds/devs
figure;
subplot(2,2,1);
shadedErrorBar(time1,FR_data_dup_S1.avg, (sqrt(FR_data_dup_S1.var))/sqrt(length(data_dup_S1)),{'--','color',[0.3, 0, 0]},1);
hold on
shadedErrorBar(time1,FR_data_dup_D1.avg, (sqrt(FR_data_dup_D1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('FR Duple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,2);
shadedErrorBar(time2,FR_data_dup_S2.avg, (sqrt(FR_data_dup_S2.var))/sqrt(length(data_dup_S2)),{'--','color',[0.1, 0.2, 0.5]},1);
hold on
shadedErrorBar(time2,FR_data_dup_D2.avg, (sqrt(FR_data_dup_D2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
title('FR Duple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,3);
shadedErrorBar(time1,FR_data_trp_S1.avg, (sqrt(FR_data_trp_S1.var))/sqrt(length(data_trp_S1)),{'--','color',[0.3, 0, 0]},1);
hold on
shadedErrorBar(time1,FR_data_trp_D1.avg, (sqrt(FR_data_trp_D1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
title('FR Triple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,4);
shadedErrorBar(time2,FR_data_trp_S2.avg, (sqrt(FR_data_trp_S2.var))/sqrt(length(data_trp_S2)),{'--','color',[0.1, 0.2, 0.5]},1);
hold on
shadedErrorBar(time2,FR_data_trp_D2.avg, (sqrt(FR_data_trp_D2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
title('FR Triple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'


%% Plot CL/CZ/CR DIFF waves
Y = [-3,3];
Y_ticks =  -3:1:3;

figure;
subplot(2,3,1);
shadedErrorBar(time2,CL_ga_diff_dup_2.avg, (sqrt(CL_ga_diff_dup_2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,CL_ga_diff_dup_1.avg, (sqrt(CL_ga_diff_dup_1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('CL Duple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

subplot(2,3,2);
shadedErrorBar(time2,CZ_ga_diff_dup_2.avg, (sqrt(CZ_ga_diff_dup_2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,CZ_ga_diff_dup_1.avg, (sqrt(CZ_ga_diff_dup_1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
% legend('dup1','dup2','location','southeast')
title('CZ Duple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

subplot(2,3,3);
shadedErrorBar(time2,CR_ga_diff_dup_2.avg, (sqrt(CR_ga_diff_dup_2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,CR_ga_diff_dup_1.avg, (sqrt(CR_ga_diff_dup_1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
% legend('dup1','dup2','location','southeast')
title('CR Duple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'


subplot(2,3,4);
shadedErrorBar(time1,CL_ga_diff_trp_1.avg, (sqrt(CL_ga_diff_trp_1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,CL_ga_diff_trp_2.avg, (sqrt(CL_ga_diff_trp_2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('trp1','trp2','location','southeast')
title('CL Triple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

subplot(2,3,5);
shadedErrorBar(time1,CZ_ga_diff_trp_1.avg, (sqrt(CZ_ga_diff_trp_1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,CZ_ga_diff_trp_2.avg, (sqrt(CZ_ga_diff_trp_2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('trp1','trp2','location','southeast')
title('CZ Triple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

subplot(2,3,6);
shadedErrorBar(time1,CR_ga_diff_trp_1.avg, (sqrt(CR_ga_diff_trp_1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,CR_ga_diff_trp_2.avg, (sqrt(CR_ga_diff_trp_2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('trp1','trp2','location','southeast')
title('CR Triple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'
%% Plot CL Stds/devs

figure;
subplot(2,2,1);
shadedErrorBar(time1,CL_data_dup_S1.avg, (sqrt(CL_data_dup_S1.var))/sqrt(length(data_dup_S1)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time1,CL_data_dup_D1.avg, (sqrt(CL_data_dup_D1.var))/sqrt(length(data_dup_D1)),{'color',[0 0 0]},1);
title('CL Duple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,2);
shadedErrorBar(time2,CL_data_dup_S2.avg, (sqrt(CL_data_dup_S2.var))/sqrt(length(data_dup_S2)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time2,CL_data_dup_D2.avg, (sqrt(CL_data_dup_D2.var))/sqrt(length(data_dup_D2)),{'color',[0 0 0]},1);
title('CL Duple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,3);
shadedErrorBar(time1,CL_data_trp_S1.avg, (sqrt(CL_data_trp_S1.var))/sqrt(length(data_trp_S1)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time1,CL_data_trp_D1.avg, (sqrt(CL_data_trp_D1.var))/sqrt(length(data_trp_D1)),{'color',[0 0 0]},1);
title('CL Triple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,4);
shadedErrorBar(time2,CL_data_trp_S2.avg, (sqrt(CL_data_trp_S2.var))/sqrt(length(data_trp_S2)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time2,CL_data_trp_D2.avg, (sqrt(CL_data_trp_D2.var))/sqrt(length(data_trp_D2)),{'color',[0 0 0]},1);
title('CL Triple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'
%% Plot CZ Stds/devs

figure;
subplot(2,2,1);
shadedErrorBar(time1,CZ_data_dup_S1.avg, (sqrt(CZ_data_dup_S1.var))/sqrt(length(data_dup_S1)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time1,CZ_data_dup_D1.avg, (sqrt(CZ_data_dup_D1.var))/sqrt(length(data_dup_D1)),{'color',[0 0 0]},1);
title('CZ Duple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,2);
shadedErrorBar(time2,CZ_data_dup_S2.avg, (sqrt(CZ_data_dup_S2.var))/sqrt(length(data_dup_S2)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time2,CZ_data_dup_D2.avg, (sqrt(CZ_data_dup_D2.var))/sqrt(length(data_dup_D2)),{'color',[0 0 0]},1);
title('CZ Duple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,3);
shadedErrorBar(time1,CZ_data_trp_S1.avg, (sqrt(CZ_data_trp_S1.var))/sqrt(length(data_trp_S1)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time1,CZ_data_trp_D1.avg, (sqrt(CZ_data_trp_D1.var))/sqrt(length(data_trp_D1)),{'color',[0 0 0]},1);
title('CZ Triple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,4);
shadedErrorBar(time2,CZ_data_trp_S2.avg, (sqrt(CZ_data_trp_S2.var))/sqrt(length(data_trp_S2)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time2,CZ_data_trp_D2.avg, (sqrt(CZ_data_trp_D2.var))/sqrt(length(data_trp_D2)),{'color',[0 0 0]},1);
title('CZ Triple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'
%% Plot CR Stds/devs

figure;
subplot(2,2,1);
shadedErrorBar(time1,CR_data_dup_S1.avg, (sqrt(CR_data_dup_S1.var))/sqrt(length(data_dup_S1)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time1,CR_data_dup_D1.avg, (sqrt(CR_data_dup_D1.var))/sqrt(length(data_dup_D1)),{'color',[0 0 0]},1);
title('CR Duple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,2);
shadedErrorBar(time2,CR_data_dup_S2.avg, (sqrt(CR_data_dup_S2.var))/sqrt(length(data_dup_S2)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time2,CR_data_dup_D2.avg, (sqrt(CR_data_dup_D2.var))/sqrt(length(data_dup_D2)),{'color',[0 0 0]},1);
title('CR Duple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,3);
shadedErrorBar(time1,CR_data_trp_S1.avg, (sqrt(CR_data_trp_S1.var))/sqrt(length(data_trp_S1)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time1,CR_data_trp_D1.avg, (sqrt(CR_data_trp_D1.var))/sqrt(length(data_trp_D1)),{'color',[0 0 0]},1);
title('CR Triple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,4);
shadedErrorBar(time2,CR_data_trp_S2.avg, (sqrt(CR_data_trp_S2.var))/sqrt(length(data_trp_S2)),{'color',[0.5, 0.5, 0.5]},1);
hold on
shadedErrorBar(time2,CR_data_trp_D2.avg, (sqrt(CR_data_trp_D2.var))/sqrt(length(data_trp_D2)),{'color',[0 0 0]},1);
title('CR Triple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

%% Plot OL/OZ/OR DIFF waves

figure;
subplot(2,3,1);
shadedErrorBar(time2,OL_ga_diff_dup_2.avg, (sqrt(OL_ga_diff_dup_2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,OL_ga_diff_dup_1.avg, (sqrt(OL_ga_diff_dup_1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('OL Duple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

subplot(2,3,2);
shadedErrorBar(time2,OZ_ga_diff_dup_2.avg, (sqrt(OZ_ga_diff_dup_2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,OZ_ga_diff_dup_1.avg, (sqrt(OZ_ga_diff_dup_1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('OZ Duple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

subplot(2,3,3);
shadedErrorBar(time2,OR_ga_diff_dup_2.avg, (sqrt(OR_ga_diff_dup_2.var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,OR_ga_diff_dup_1.avg, (sqrt(OR_ga_diff_dup_1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
% legend('dup1','dup2','location','southeast')
title('OR Duple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'


subplot(2,3,4);
shadedErrorBar(time1,OL_ga_diff_trp_1.avg, (sqrt(OL_ga_diff_trp_1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,OL_ga_diff_trp_2.avg, (sqrt(OL_ga_diff_trp_2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('trp1','trp2','location','southeast')
title('OL Triple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

subplot(2,3,5);
shadedErrorBar(time1,OZ_ga_diff_trp_1.avg, (sqrt(OZ_ga_diff_trp_1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,OZ_ga_diff_trp_2.avg, (sqrt(OZ_ga_diff_trp_2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('trp1','trp2','location','southeast')
title('OZ Triple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

subplot(2,3,6);
shadedErrorBar(time1,OR_ga_diff_trp_1.avg, (sqrt(OR_ga_diff_trp_1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,OR_ga_diff_trp_2.avg, (sqrt(OR_ga_diff_trp_2.var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('trp1','trp2','location','southeast')
title('OR Triple')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'
%% Plot OL Stds/devs

figure;
subplot(2,2,1);
shadedErrorBar(time1,OL_data_dup_S1.avg, (sqrt(OL_data_dup_S1.var))/sqrt(length(data_dup_S1)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,OL_data_dup_D1.avg, (sqrt(OL_data_dup_D1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('OL Duple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,2);
shadedErrorBar(time2,OL_data_dup_S2.avg, (sqrt(OL_data_dup_S2.var))/sqrt(length(data_dup_S2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time2,OL_data_dup_D2.avg, (sqrt(OL_data_dup_D2.var))/sqrt(length(data_dup_D2)),{'color',[0.7 0 0]},1);
title('OL Duple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,3);
shadedErrorBar(time1,OL_data_trp_S1.avg, (sqrt(OL_data_trp_S1.var))/sqrt(length(data_trp_S1)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,OL_data_trp_D1.avg, (sqrt(OL_data_trp_D1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
title('OL Triple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,4);
shadedErrorBar(time2,OL_data_trp_S2.avg, (sqrt(OL_data_trp_S2.var))/sqrt(length(data_trp_S2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time2,OL_data_trp_D2.avg, (sqrt(OL_data_trp_D2.var))/sqrt(length(data_trp_D2)),{'color',[0.7 0 0]},1);
title('OL Triple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'
%% Plot OZ Stds/devs

figure;
subplot(2,2,1);
shadedErrorBar(time1,OZ_data_dup_S1.avg, (sqrt(OZ_data_dup_S1.var))/sqrt(length(data_dup_S1)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,OZ_data_dup_D1.avg, (sqrt(OZ_data_dup_D1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('OZ Duple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,2);
shadedErrorBar(time2,OZ_data_dup_S2.avg, (sqrt(OZ_data_dup_S2.var))/sqrt(length(data_dup_S2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time2,OZ_data_dup_D2.avg, (sqrt(OZ_data_dup_D2.var))/sqrt(length(data_dup_D2)),{'color',[0.7 0 0]},1);
title('OZ Duple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,3);
shadedErrorBar(time1,OZ_data_trp_S1.avg, (sqrt(OZ_data_trp_S1.var))/sqrt(length(data_trp_S1)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,OZ_data_trp_D1.avg, (sqrt(OZ_data_trp_D1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
title('OZ Triple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,4);
shadedErrorBar(time2,OZ_data_trp_S2.avg, (sqrt(OZ_data_trp_S2.var))/sqrt(length(data_trp_S2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time2,OZ_data_trp_D2.avg, (sqrt(OZ_data_trp_D2.var))/sqrt(length(data_trp_D2)),{'color',[0.7 0 0]},1);
title('OZ Triple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'
%% Plot OR Stds/devs

figure;
subplot(2,2,1);
shadedErrorBar(time1,OR_data_dup_S1.avg, (sqrt(OR_data_dup_S1.var))/sqrt(length(data_dup_S1)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,OR_data_dup_D1.avg, (sqrt(OR_data_dup_D1.var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
title('OR Duple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,2);
shadedErrorBar(time2,OR_data_dup_S2.avg, (sqrt(OR_data_dup_S2.var))/sqrt(length(data_dup_S2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time2,OR_data_dup_D2.avg, (sqrt(OR_data_dup_D2.var))/sqrt(length(data_dup_D2)),{'color',[0.7 0 0]},1);
title('OR Duple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,3);
shadedErrorBar(time1,OR_data_trp_S1.avg, (sqrt(OR_data_trp_S1.var))/sqrt(length(data_trp_S1)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,OR_data_trp_D1.avg, (sqrt(OR_data_trp_D1.var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
title('OR Triple Beat 4')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

subplot(2,2,4);
shadedErrorBar(time2,OR_data_trp_S2.avg, (sqrt(OR_data_trp_S2.var))/sqrt(length(data_trp_S2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time2,OR_data_trp_D2.avg, (sqrt(OR_data_trp_D2.var))/sqrt(length(data_trp_D2)),{'color',[0.7 0 0]},1);
title('OR Triple Beat 5')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
yticks([Y_ticks])
box 'off'

%% Plot Front-back
% trp_Left_diff_1, trp_Left_diff_2, trp_Right_diff_1, trp_Right_diff_2

DupL2_var = FL_ga_diff_dup_2.var-OL_ga_diff_dup_2.var;
DupL1_var = FL_ga_diff_dup_1.var-OL_ga_diff_dup_1.var;
figure;
subplot(2,2,1);                       
shadedErrorBar(time2,dup_Left_diff_2, abs(sqrt(DupL2_var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,dup_Left_diff_1, abs(sqrt(DupL1_var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
% legend('strong beat','weak beat','location','southeast')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

DupR2_var = abs(FR_ga_diff_dup_2.var-OR_ga_diff_dup_2.var);
DupR1_var = abs(FR_ga_diff_dup_1.var-OR_ga_diff_dup_1.var);
subplot(2,2,2);                       
shadedErrorBar(time2,dup_Right_diff_2, (sqrt(DupR2_var))/sqrt(length(data_dup_D2)),{'color',[0.3 0.6 1]},1);
hold on
shadedErrorBar(time1,dup_Right_diff_1, (sqrt(DupR1_var))/sqrt(length(data_dup_D1)),{'color',[0.7 0 0]},1);
% legend('strong beat','weak beat','location','southeast')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

TrpL1_var = abs(FL_ga_diff_trp_1.var-OL_ga_diff_trp_1.var);
TrpL2_var = abs(FL_ga_diff_trp_2.var-OL_ga_diff_trp_2.var);
subplot(2,2,3);                       
shadedErrorBar(time1,trp_Left_diff_1, (sqrt(TrpL1_var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,trp_Left_diff_2, (sqrt(TrpL2_var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('strong beat','weak beat','location','southeast')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'

TrpR1_var = abs(FR_ga_diff_trp_1.var-OR_ga_diff_trp_1.var);
TrpR2_var = abs(FR_ga_diff_trp_2.var-OR_ga_diff_trp_2.var);
subplot(2,2,4);                       
shadedErrorBar(time1,trp_Right_diff_1, (sqrt(TrpR1_var))/sqrt(length(data_trp_D1)),{'color',[0.7 0 0]},1);
hold on
shadedErrorBar(time2,trp_Right_diff_2, (sqrt(TrpR2_var))/sqrt(length(data_trp_D2)),{'color',[0.3 0.6 1]},1);
% legend('strong beat','weak beat','location','southeast')
ylim([Y]);
set(gca, 'Color', 'None');
ax = gca;
ax.XAxisLocation = 'origin'; 
ax.YAxisLocation = 'origin';
set(gca,'YTickLabel',[]); %remove tick labels
set(gca,'XTickLabel',[]);
xticks(Xticks)
box 'off'


