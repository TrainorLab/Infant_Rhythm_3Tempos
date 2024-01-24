%% Plotting data for original bar graphs manuscript Nov 2021
cd D:\Erica\Infant_Rhythm_3tempos\Matlab_Analysis;
addpath ('boxplot2','minmax')
ft_defaults
%
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

% read the .csv file with all the MMR amplitudes per participant.
% data = csv2struct("6mo6beat_3Tempo_DataExport_Aug2023.csv");
data = csv2struct("6mo6beat_3Tempo_DataExport_Nov2023_100ms.csv");
dup_index = find(ismember(data(:).GROUP,2));
trp_index = find(ismember(data(:).GROUP,3));
mus_class_ind = find(ismember(data(:).MUS_CLASS,1));
nmus_class_ind = find(ismember(data(:).MUS_CLASS,0));

%% Plot boplots for latencies in frontal sites separately for group

dp1 = (1.05-0.95).*rand(length(listDuple),1) + 0.95; % create some jitter on the x axis for plotting the scatter
dp2 = (2.05-1.95).*rand(length(listDuple),1) + 1.95;
dp3 = (3.05-2.95).*rand(length(listDuple),1) + 2.95;

tp1 = (1.05-0.95).*rand(length(listTriple),1) + 0.95; % create some jitter on the x axis for plotting the scatter
tp2 = (2.05-1.95).*rand(length(listTriple),1) + 1.95;
tp3 = (3.05-2.95).*rand(length(listTriple),1) + 2.95;

c_d = parula(length(listDuple));
c_d_all = cat(1,c_d,c_d,c_d);
c_t = parula(length(listTriple));
c_t_all = cat(1,c_t,c_t,c_t);

Y = [0.190 0.410];

% dup beat 4
figure
b = boxplot([data.FL_MMR_LAT1(dup_index),data.FZ_MMR_LAT1(dup_index),data.FR_MMR_LAT1(dup_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,dp1,dp2,dp3); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.FL_MMR_LAT1(dup_index),data.FZ_MMR_LAT1(dup_index),data.FR_MMR_LAT1(dup_index));
scatter(x_plot,y_data,20,c_d_all,'o','filled');
l = line([dp1 dp2 dp3]',[data.FL_MMR_LAT1(dup_index),data.FZ_MMR_LAT1(dup_index),data.FR_MMR_LAT1(dup_index)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(c_d, 2));
ylim(Y) % create a bit of space at the top for drawing in significance

% dup beat 5
figure
b = boxplot([data.FL_MMR_LAT2(dup_index),data.FZ_MMR_LAT2(dup_index),data.FR_MMR_LAT2(dup_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,dp1,dp2,dp3); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.FL_MMR_LAT2(dup_index),data.FZ_MMR_LAT2(dup_index),data.FR_MMR_LAT2(dup_index));
scatter(x_plot,y_data,20,c_d_all,'o','filled');
l = line([dp1 dp2 dp3]',[data.FL_MMR_LAT2(dup_index),data.FZ_MMR_LAT2(dup_index),data.FR_MMR_LAT2(dup_index)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(c_d, 2));
ylim(Y) % create a bit of space at the top for drawing in significance

% trp beat 4
figure
b = boxplot([data.FL_MMR_LAT1(trp_index),data.FZ_MMR_LAT1(trp_index),data.FR_MMR_LAT1(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,tp1,tp2,tp3); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.FL_MMR_LAT1(trp_index),data.FZ_MMR_LAT1(trp_index),data.FR_MMR_LAT1(trp_index));
scatter(x_plot,y_data,20,c_t_all,'o','filled');
l = line([tp1 tp2 tp3]',[data.FL_MMR_LAT1(trp_index),data.FZ_MMR_LAT1(trp_index),data.FR_MMR_LAT1(trp_index)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(c_t, 2));
ylim(Y)

% trp beat 5
figure
b = boxplot([data.FL_MMR_LAT2(trp_index),data.FZ_MMR_LAT2(trp_index),data.FR_MMR_LAT2(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,tp1,tp2,tp3); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.FL_MMR_LAT2(trp_index),data.FZ_MMR_LAT2(trp_index),data.FR_MMR_LAT2(trp_index));
scatter(x_plot,y_data,20,c_t_all,'o','filled');
l = line([tp1 tp2 tp3]',[data.FL_MMR_LAT2(trp_index),data.FZ_MMR_LAT2(trp_index),data.FR_MMR_LAT2(trp_index)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(c_t, 2));
ylim(Y)

%% Plot boplots for amplitudes for beat 4 vs 5 in FL for music vs. non-music group

mus1 = (1.05-0.95).*rand(length(mus_class_ind),1) + 0.95; % create some jitter on the x axis for plotting the scatter
mus2 = (2.05-1.95).*rand(length(mus_class_ind),1) + 1.95;

nmus1 = (1.05-0.95).*rand(length(nmus_class_ind),1) + 0.95; % create some jitter on the x axis for plotting the scatter
nmus2 = (2.05-1.95).*rand(length(nmus_class_ind),1) + 1.95;

mus = parula(length(mus_class_ind));
mus_all = cat(1,mus,mus);
nmus = parula(length(nmus_class_ind));
nmus_all = cat(1,nmus,nmus);

Y = [-5 9];

% musical class group beat 4 vs 5
figure
b = boxplot([data.FL_MMR_DIFF1(mus_class_ind),data.FL_MMR_DIFF2(mus_class_ind)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,mus1,mus2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.FL_MMR_DIFF1(mus_class_ind),data.FL_MMR_DIFF2(mus_class_ind));
scatter(x_plot,y_data,20,mus_all,'o','filled');
l = line([mus1,mus2]',[data.FL_MMR_DIFF1(mus_class_ind),data.FL_MMR_DIFF2(mus_class_ind)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(mus, 2));
ylim(Y) % create a bit of space at the top for drawing in significance

% non-musical class group beat 4 vs 5
figure
b = boxplot([data.FL_MMR_DIFF1(nmus_class_ind),data.FL_MMR_DIFF2(nmus_class_ind)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,nmus1,nmus2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.FL_MMR_DIFF1(nmus_class_ind),data.FL_MMR_DIFF2(nmus_class_ind));
scatter(x_plot,y_data,20,nmus_all,'o','filled');
l = line([nmus1,nmus2]',[data.FL_MMR_DIFF1(nmus_class_ind),data.FL_MMR_DIFF2(nmus_class_ind)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(nmus, 2));
ylim(Y) % create a bit of space at the top for drawing in significance


%% OLDER 
% Plot FL & FR MMR for beats 4 and 5
r1 = (1.05-0.95).*rand(44,1) + 0.95; % create some jitter on the x axis for plotting the scatter
r2 = (2.05-1.95).*rand(44,1) + 1.95;

% now separate by group for clarity
dp1 = (1.05-0.95).*rand(length(listDuple),1) + 0.95; % create some jitter on the x axis for plotting the scatter
dp2 = (2.05-1.95).*rand(length(listDuple),1) + 1.95;

tp1 = (1.05-0.95).*rand(length(listTriple),1) + 0.95; % create some jitter on the x axis for plotting the scatter
tp2 = (2.05-1.95).*rand(length(listTriple),1) + 1.95;

c_d = parula(length(listDuple));
c_d_all = cat(1,c_d,c_d);
c_t = parula(length(listTriple));
c_t_all = cat(1,c_t,c_t);

Y = [-6 8];

% dup
figure
b = boxplot([data.FL_MMR_DIFF1(dup_index),data.FL_MMR_DIFF2(dup_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,dp1,dp2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.FL_MMR_DIFF1(dup_index),data.FL_MMR_DIFF2(dup_index));
scatter(x_plot,y_data,20,c_d_all,'o','filled');
l = line([dp1 dp2]',[data.FL_MMR_DIFF1(dup_index),data.FL_MMR_DIFF2(dup_index)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(c_d, 2));
ylim(Y) % create a bit of space at the top for drawing in significance

% trp
figure
b = boxplot([data.FL_MMR_DIFF1(trp_index),data.FL_MMR_DIFF2(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,tp1,tp2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.FL_MMR_DIFF1(trp_index),data.FL_MMR_DIFF2(trp_index));
scatter(x_plot,y_data,20,c_t_all,'o','filled');
l = line([tp1 tp2]',[data.FL_MMR_DIFF1(trp_index),data.FL_MMR_DIFF2(trp_index)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(c_t, 2));
ylim(Y)

% FR
% dup
figure
b = boxplot([data.FR_MMR_DIFF1(dup_index),data.FR_MMR_DIFF2(dup_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,dp1,dp2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.FR_MMR_DIFF1(dup_index),data.FR_MMR_DIFF2(dup_index));
scatter(x_plot,y_data,20,c_d_all,'o','filled');
l = line([dp1 dp2]',[data.FR_MMR_DIFF1(dup_index),data.FR_MMR_DIFF2(dup_index)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(c_d, 2));
ylim(Y)

% trp
figure
b = boxplot([data.FR_MMR_DIFF1(trp_index),data.FR_MMR_DIFF2(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,tp1,tp2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.FR_MMR_DIFF1(trp_index),data.FR_MMR_DIFF2(trp_index));
scatter(x_plot,y_data,20,c_t_all,'o','filled');
l = line([tp1 tp2]',[data.FR_MMR_DIFF1(trp_index),data.FR_MMR_DIFF2(trp_index)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(c_t, 2));
ylim(Y)

%% Plot Beat position x group effect
Y = [0.25 0.36];

% dup
figure
b = boxplot([data.MMR_LAT1(dup_index),data.MMR_LAT2(dup_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,dp1,dp2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.MMR_LAT1(dup_index),data.MMR_LAT2(dup_index));
scatter(x_plot,y_data,20,c_d_all,'o','filled');
l = line([dp1 dp2]',[data.MMR_LAT1(dup_index),data.MMR_LAT2(dup_index)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(c_d, 2));
ylim(Y)

% trp
figure
b = boxplot([data.MMR_LAT1(trp_index),data.MMR_LAT2(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,tp1,tp2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.MMR_LAT1(trp_index),data.MMR_LAT2(trp_index));
scatter(x_plot,y_data,20,c_t_all,'o','filled');
l = line([tp1 tp2]',[data.MMR_LAT1(trp_index),data.MMR_LAT2(trp_index)]','LineWidth',0.5,'Color',0.7*[1 1 1]);
set(l, {'color'}, num2cell(c_t, 2));
ylim(Y)


%% Plot SSEP boxplots for each frequency
r1 = (1.05-0.95).*rand(19,1) + 0.95; % create some jitter on the x axis for plotting the scatter
r2 = (2.05-1.95).*rand(19,1) + 1.95;

figure
b = boxplot([data.SSEP_TRP_FC(dup_index),data.SSEP_TRP_FC(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,r1,r2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.SSEP_TRP_FC(dup_index),data.SSEP_TRP_FC(trp_index));
scatter(x_plot,y_data,20,0.7*[1 1 1],'o','filled');
% set(l, {'color'}, num2cell(c_d, 2));
ylim([-0.1 0.9]) % create a bit of space at the top for drawing in significance

figure
b = boxplot([data.SSEP_DUP_FC(dup_index),data.SSEP_DUP_FC(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,r1,r2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.SSEP_DUP_FC(dup_index),data.SSEP_DUP_FC(trp_index));
scatter(x_plot,y_data,20,0.7*[1 1 1],'o','filled');
% set(l, {'color'}, num2cell(c_d, 2));
ylim([-0.1 0.36]) % create a bit of space at the top for drawing in significance

figure
b = boxplot([data.SSEP_BEAT_FC(dup_index),data.SSEP_BEAT_FC(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,r1,r2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.SSEP_BEAT_FC(dup_index),data.SSEP_BEAT_FC(trp_index));
scatter(x_plot,y_data,20,0.7*[1 1 1],'o','filled');
% set(l, {'color'}, num2cell(c_d, 2));
ylim([0 3]) % create a bit of space at the top for drawing in significance

%% Plot ITPC boxplots for each frequency
r1 = (1.05-0.95).*rand(19,1) + 0.95; % create some jitter on the x axis for plotting the scatter
r2 = (2.05-1.95).*rand(19,1) + 1.95;

figure
b = boxplot([data.ITPC_TRP(dup_index),data.ITPC_TRP(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,r1,r2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.ITPC_TRP(dup_index),data.ITPC_TRP(trp_index));
scatter(x_plot,y_data,20,0.7*[1 1 1],'o','filled');
% set(l, {'color'}, num2cell(c_d, 2));
ylim([0.1 0.4]) % create a bit of space at the top for drawing in significance

figure
b = boxplot([data.ITPC_DUP(dup_index),data.ITPC_DUP(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,r1,r2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.ITPC_DUP(dup_index),data.ITPC_DUP(trp_index));
scatter(x_plot,y_data,20,0.7*[1 1 1],'o','filled');
% set(l, {'color'}, num2cell(c_d, 2));
ylim([0.1 0.4]) % create a bit of space at the top for drawing in significance

figure
b = boxplot([data.ITPC_BEAT(dup_index),data.ITPC_BEAT(trp_index)],'Symbol','','Colors',[0 0 0]);hold on
set(b,{'linew'},{1.5})
x_plot = cat(1,r1,r2); % create variable Of 1s, 2s and 3s for plotting...
y_data = cat(1,data.ITPC_BEAT(dup_index),data.ITPC_BEAT(trp_index));
scatter(x_plot,y_data,20,0.7*[1 1 1],'o','filled');
% set(l, {'color'}, num2cell(c_d, 2));
ylim([0.25 0.85]) % create a bit of space at the top for drawing in significance
