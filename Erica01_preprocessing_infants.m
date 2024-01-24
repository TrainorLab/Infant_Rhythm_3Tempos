%Use this script to load raw .mff eeg files for each participant and run
%through the preprocessing function

cd D:/Erica/Infant_Rhythm_3tempos/Matlab_Analysis;
filepath = 'D:/Erica/Infant_Rhythm_3tempos/Matlab_Analysis';
addpath ('fieldtrip-20220228','preprocessed_MMN_infant_1-15Hz_CTR100','preprocessed_MMN_infant_1-15Hz_CTR100','preprocessed_freq_infant','AB_NONGUI','Video_Trigger_files','participants_infants') % SHOULD DOWNLOAD AND UPDATE FIELDTRIP

% SET ERP VARIABLE TO CHANGE WHICH PREPRO PIPELINE IS USED
% 0 = freq, 1 = ERP
ERP = 1;

% SET WHETHER WANT TO RUN WITH AB (0 = no -for checking noise, 1 = yes -normal)
AB = 1;

%% Participants
% NOTE: March 19, 2023, noticed after preprocessing that channel labels are
% not always the same across participants, e.g., participant 8 vs 10, 125
% vs 124 channels, and not in same order... realize I think it is the way
% it replaces the removed channels...

clearvars -except ERP AB
dataFile = 'participants_infants/01_no231_T.mff';
removeChan = [125:129];
% badChan = [17, 26, 32, 33, 38, 44, 56, 81, 88]; % manually label which channels we re really noisy.
badChan = [];
recodeTrig = {'TriWav_no231_IBI1.csv','TriWav_no231_IBI2.csv','TriWav_no231_IBI3.csv'}; % There were some extra DINs in between blocks, need to remove...
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub1.mat';
else
    saveName = 'preprocessed_freq_infant/sub1.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/02_no231_D.mff';
removeChan = [125:129];
badChan = [];
% badChan = []; % manually label which channels were really noisy.
recodeTrig = {'DupWav_no231_IBI1.csv','DupWav_no231_IBI2.csv','DupWav_no231_IBI3.csv'};
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub2.mat';
else
    saveName = 'preprocessed_freq_infant/sub2.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/03_no278_T.mff';
removeChan = [125:129];
badChan = [];
% badChan = [56, 99, 100, 107, 114]; % manually label which channels were really noisy.
recodeTrig = {'TriWav_no278_IBI2.csv','TriWav_no278_IBI3.csv','TriWav_no278_IBI4.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub3.mat';
else
    saveName = 'preprocessed_freq_infant/sub3.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/04_no278_D.mff';
removeChan = [125:129];
badChan = [];
% badChan = [6, 17, 44, 113]; % manually label which channels were really noisy.
recodeTrig = {'DupWav_no278_IBI2.csv','DupWav_no278_IBI3.csv','DupWav_no278_IBI4.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub4.mat';
else
    saveName = 'preprocessed_freq_infant/sub4.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


% Lots of bad channels!
clearvars -except ERP AB
dataFile = 'participants_infants/05_no400_T.mff';
removeChan = [125:129];
badChan = [];
% badChan = [32, 33, 38, 39, 43, 44, 45, 48, 49, 56, 59, 63, 113, 114]; % manually label which channels were really noisy.
recodeTrig = {'TriWav_no400_IBI1.csv','TriWav_no400_IBI3.csv','TriWav_no400_IBI5.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub5.mat';
else
    saveName = 'preprocessed_freq_infant/sub5.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/06_no400_D.mff';
removeChan = [125:129];
badChan = [];
% badChan = [56]; % manually label which channels were really noisy.
recodeTrig = {'DupWav_no400_IBI1.csv','DupWav_no400_IBI3.csv','DupWav_no400_IBI5.csv'};
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub6.mat';
else
    saveName = 'preprocessed_freq_infant/sub6.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/07_no480_T.mff';
removeChan = [125:129];
badChan = [];
% badChan = [48 56]; % manually label which channels were really noisy.
recodeTrig = {'TriWav_no480_IBI2.csv','TriWav_no480_IBI4.csv','TriWav_no480_IBI1.csv'};
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub7.mat';
else
    saveName = 'preprocessed_freq_infant/sub7.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/08_no480_D.mff';
removeChan = [125:129];
badChan = [];
% badChan = [44 114]; % manually label which channels were really noisy.
recodeTrig = {'DupWav_no480_IBI2.csv','DupWav_no480_IBI4.csv','DupWav_no480_IBI1.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub8.mat';
else
    saveName = 'preprocessed_freq_infant/sub8.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


% SOME SUPER NOISY DATA BC BIG BLOCKS OF NOISE... maybe remove big blocks
% noise
clearvars -except ERP AB
dataFile = 'participants_infants/09_no231_T.mff';
removeChan = [125:129];
badChan = [];
% badChan = [44, 49, 56, 75, 107, 111, 112, 114, 120, 122]; % manually label which channels were really noisy.
% A LOT OF BAD CHANNELS ...
recodeTrig = {'TriWav_no231_IBI3.csv','TriWav_no231_IBI1.csv','TriWav_no231_IBI2.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub9.mat';
else
    saveName = 'preprocessed_freq_infant/sub9.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


% PROBABLY REMOVE PARTICIPANT 10
clearvars -except ERP AB
dataFile = 'participants_infants/10_no231_D.mff';
removeChan = [125:129]; 
badChan = [];
% badChan = [17, 44]; % manually label which channels were really noisy.
recodeTrig = {'DupWav_no231_IBI3.csv','DupWav_no231_IBI1.csv'}; % BABY FUSSED OUT
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub10.mat';
else
    saveName = 'preprocessed_freq_infant/sub10.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/11_no278_T.mff';
removeChan = [125:129];
% badChan = [1, 17, 75, 113, 114, 120, 121]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no278_IBI3.csv','TriWav_no278_IBI1.csv','TriWav_no278_IBI2.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub11.mat';
else
    saveName = 'preprocessed_freq_infant/sub11.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


% PROBABLY REMOVE PARTICIPANT 12
clearvars -except ERP AB
dataFile = 'participants_infants/12_no278_D.mff';
removeChan = [125:129];
% badChan = [17, 38, 43, 44, 48, 49, 56, 107, 114]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'DupWav_no278_IBI4.csv','DupWav_no278_IBI1.csv'}; % BABY FUSSED OUT
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub12.mat';
else
    saveName = 'preprocessed_freq_infant/sub12.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


% LOTS OF BAD CHANNELS
clearvars -except ERP AB
dataFile = 'participants_infants/13_no400_T.mff';
removeChan = [125:129];
% badChan = [1, 9, 43, 44, 49, 63, 68, 73, 81, 99, 100, 107, 108, 113, 114, 120, 121]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no400_IBI5.csv','TriWav_no400_IBI4.csv','TriWav_no400_IBI3.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub13.mat';
else
    saveName = 'preprocessed_freq_infant/sub13.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/14_no400_D.mff';
removeChan = [125:129];
% badChan = [17 44 49 56 107]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'DupWav_no400_IBI5.csv','DupWav_no400_IBI4.csv','DupWav_no400_IBI3.csv'};
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub14.mat';
else
    saveName = 'preprocessed_freq_infant/sub14.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/15_no480_T.mff';
removeChan = [125:129];
% badChan = [17 56]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no480_IBI3.csv','TriWav_no480_IBI5.csv','TriWav_no480_IBI1.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub15.mat';
else
    saveName = 'preprocessed_freq_infant/sub15.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/16_no480_D.mff';
removeChan = [125:129];
% badChan = [43, 56, 107, 113]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'DupWav_no480_IBI5.csv','DupWav_no480_IBI4.csv'}; % only did two blocks, but CLEAN
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub16.mat';
else
    saveName = 'preprocessed_freq_infant/sub16.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/17_no231_T.mff';
removeChan = [125:129];
% badChan = [17]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no231_IBI4.csv','TriWav_no231_IBI5.csv','TriWav_no231_IBI2.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub17.mat';
else
    saveName = 'preprocessed_freq_infant/sub17.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/18_no231_D.mff';
removeChan = [125:129];
% badChan = [100 114]; % manually label which channels were really noisy.
% Note, all channels seem high variance but probs bc of blocks of noise in
% end
badChan = [];
recodeTrig = {'DupWav_no231_IBI4.csv','DupWav_no231_IBI5.csv','DupWav_no231_IBI2.csv'}; % BIG BLOCKS OF NOISE IN END
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub18.mat';
else
    saveName = 'preprocessed_freq_infant/sub18.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB % THIS PARTICIPANT HAD MINOR HEARING LOSS
dataFile = 'participants_infants/19_no278_T.mff';
removeChan = [125:129];
% badChan = [44 56 107 111]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no278_IBI1.csv','TriWav_no278_IBI2.csv','TriWav_no278_IBI4.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub19.mat';
else
    saveName = 'preprocessed_freq_infant/sub19.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/20_no231_D.mff';
removeChan = [125:129];
% badChan = [56 114]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'DupWav_no231_IBI1.csv','DupWav_no231_IBI2.csv','DupWav_no231_IBI4.csv'}; % Was supposed to be no278 but did 231 instead
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub20.mat';
else
    saveName = 'preprocessed_freq_infant/sub20.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/21_no400_T.mff';
removeChan = [125:129];
% badChan = [17 44 63 114]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no400_IBI5.csv','TriWav_no400_IBI3.csv','TriWav_no400_IBI2.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub21.mat';
else
    saveName = 'preprocessed_freq_infant/sub21.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/22_no400_D.mff';
removeChan = [125:129];
% badChan = [17 44 107]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'DupWav_no400_IBI5.csv','DupWav_no400_IBI3.csv','DupWav_no400_IBI2.csv'};
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub22.mat';
else
    saveName = 'preprocessed_freq_infant/sub22.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/23_no480_T.mff';
removeChan = [125:129];
% badChan = [2 9 17 49 56 114 115]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no480_IBI2.csv','TriWav_no480_IBI4.csv','TriWav_no480_IBI5.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub23.mat';
else
    saveName = 'preprocessed_freq_infant/sub23.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/24_no480_D.mff';
removeChan = [125:129];
% badChan = [9, 33, 63, 75, 107, 114]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'DupWav_no480_IBI2.csv','DupWav_no480_IBI4.csv','DupWav_no480_IBI5.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub24.mat';
else
    saveName = 'preprocessed_freq_infant/sub24.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/25_no231_T.mff';
removeChan = [125:129];
% badChan = [17 48]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no231_IBI2.csv','TriWav_no231_IBI1.csv','TriWav_no231_IBI3.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub25.mat';
else
    saveName = 'preprocessed_freq_infant/sub25.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/26_no231_D.mff';
removeChan = [125:129];
% badChan = [17 107 114]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'DupWav_no231_IBI2.csv','DupWav_no231_IBI1.csv','DupWav_no231_IBI3.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub26.mat';
else
    saveName = 'preprocessed_freq_infant/sub26.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/27_no278_T.mff';
removeChan = [125:129];
% badChan = [9, 17, 44, 49, 56, 63, 75, 81, 99, 100, 101, 107, 114]; % manually label which channels were really noisy. % LOTS
badChan = [];
recodeTrig = {'TriWav_no278_IBI3.csv','TriWav_no278_IBI4.csv','TriWav_no278_IBI5.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub27.mat';
else
    saveName = 'preprocessed_freq_infant/sub27.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/28_no278_D.mff';
removeChan = [125:129];
% badChan = [17 56 107 114]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'DupWav_no278_IBI3.csv','DupWav_no278_IBI4.csv','DupWav_no278_IBI5.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub28.mat';
else
    saveName = 'preprocessed_freq_infant/sub28.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/29_no400_T.mff';
removeChan = [125:129];
% badChan = [1, 12, 17, 101, 107, 113, 114, 115, 120, 121]; % manually label which channels were really noisy. % LOTS
badChan = [];
recodeTrig = {'TriWav_no400_IBI5.csv','TriWav_no400_IBI2.csv','TriWav_no400_IBI4.csv'}; % block 3 was incomplete
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub29.mat';
else
    saveName = 'preprocessed_freq_infant/sub29.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/30_no400_D.mff';
removeChan = [125:129];
% badChan = [17 91 97 107 114]; % manually label which channels were really noisy. 
badChan = [];
recodeTrig = {'DupWav_no400_IBI5.csv','DupWav_no400_IBI2.csv','DupWav_no400_IBI4.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub30.mat';
else
    saveName = 'preprocessed_freq_infant/sub30.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/31_no480_T.mff';
removeChan = [125:129];
% badChan = [1 17 44 49 56 63 107 114]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no480_IBI3.csv','TriWav_no480_IBI5.csv','TriWav_no480_IBI1.csv'};
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub31.mat';
else
    saveName = 'preprocessed_freq_infant/sub31.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/32_no480_D.mff';
removeChan = [125:129];
% badChan = [17 107 114]; % manually label which channels were really noisy. 
badChan = [];
recodeTrig = {'DupWav_no480_IBI3.csv','DupWav_no480_IBI5.csv','DupWav_no480_IBI1.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub32.mat';
else
    saveName = 'preprocessed_freq_infant/sub32.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/33_no231_T.mff';
removeChan = [125:129];
% badChan = [1 17 44 49 56 75 76 114]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no231_IBI3.csv','TriWav_no231_IBI4.csv','TriWav_no231_IBI1.csv'};
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub33.mat';
else
    saveName = 'preprocessed_freq_infant/sub33.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/34_no231_D.mff';
removeChan = [125:129];
% badChan = [1 17 40 44 81 107 114]; % manually label which channels were really noisy. 
badChan = [];
recodeTrig = {'DupWav_no231_IBI3.csv','DupWav_no231_IBI4.csv','DupWav_no231_IBI1.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub34.mat';
else
    saveName = 'preprocessed_freq_infant/sub34.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


% participant 35 only completed 1 block - don't bother analyzing


clearvars -except ERP AB
dataFile = 'participants_infants/36_no278_D.mff';
removeChan = [125:129];
% badChan = [32 56 101 107]; % manually label which channels were really noisy. 
badChan = [];
recodeTrig = {'DupWav_no278_IBI4.csv','DupWav_no278_IBI1.csv','DupWav_no278_IBI2.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub36.mat';
else
    saveName = 'preprocessed_freq_infant/sub36.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/37_no400_T.mff';
removeChan = [125:129];
% badChan = [44 49 56 107 113]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no400_IBI1.csv','TriWav_no400_IBI5.csv','TriWav_no400_IBI3.csv'};
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub37.mat';
else
    saveName = 'preprocessed_freq_infant/sub37.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/38_no400_D.mff';
removeChan = [125:129];
% badChan = [44 52 60 63 72 77 85]; % manually label which channels were really noisy. 
badChan = [];
recodeTrig = {'DupWav_no400_IBI1.csv','DupWav_no400_IBI5.csv','DupWav_no400_IBI3.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub38.mat';
else
    saveName = 'preprocessed_freq_infant/sub38.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/39_no480_T.mff';
removeChan = [125:129];
% badChan = [17]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no480_IBI2.csv','TriWav_no480_IBI3.csv','TriWav_no480_IBI4.csv'};
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub39.mat';
else
    saveName = 'preprocessed_freq_infant/sub39.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


clearvars -except ERP AB
dataFile = 'participants_infants/40_no480_D.mff';
removeChan = [125:129];
% badChan = [44 49 56 99 100 113 114]; % manually label which channels were really noisy. 
badChan = [];
recodeTrig = {'DupWav_no480_IBI2.csv','DupWav_no480_IBI3.csv','DupWav_no480_IBI4.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub40.mat';
else
    saveName = 'preprocessed_freq_infant/sub40.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/41_no231_T.mff';
removeChan = [125:129];
% badChan = [17 44 56 99 101]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no231_IBI5.csv','TriWav_no231_IBI3.csv','TriWav_no231_IBI4.csv'};
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub41.mat';
else
    saveName = 'preprocessed_freq_infant/sub41.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/42_no231_D.mff';
removeChan = [125:129];
% badChan = [99 100 114]; % manually label which channels were really noisy. 
badChan = [];
recodeTrig = {'DupWav_no231_IBI5.csv','DupWav_no231_IBI3.csv','DupWav_no231_IBI4.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub42.mat';
else
    saveName = 'preprocessed_freq_infant/sub42.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)


% participant 43 only completed 1 block - don't bother analyzing


clearvars -except ERP AB
dataFile = 'participants_infants/44_no278_D.mff';
removeChan = [125:129];
% badChan = [56 63 113]; % manually label which channels were really noisy. 
badChan = [];
recodeTrig = {'DupWav_no278_IBI5.csv','DupWav_no278_IBI2.csv','DupWav_no278_IBI3.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub44.mat';
else
    saveName = 'preprocessed_freq_infant/sub44.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/45_no400_T.mff';
removeChan = [125:129];
% badChan = [56 57 101]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no400_IBI2.csv','TriWav_no400_IBI1.csv','TriWav_no400_IBI5.csv'}; % incomplete 3rd block
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub45.mat';
else
    saveName = 'preprocessed_freq_infant/sub45.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



clearvars -except ERP AB
dataFile = 'participants_infants/46_no400_D.mff';
removeChan = [125:129];
% badChan = [56 113]; % manually label which channels were really noisy. 
badChan = [];
recodeTrig = {'DupWav_no400_IBI2.csv','DupWav_no400_IBI1.csv','DupWav_no400_IBI5.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub46.mat';
else
    saveName = 'preprocessed_freq_infant/sub46.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 0)



% BAD NET - LOTS OF BAD CHANNELS
clearvars -except ERP AB
dataFile = 'participants_infants/47_no480_T.mff';
removeChan = [125:129];
% badChan = [1, 8, 9, 17, 25, 26, 27, 38, 40, 44, 49, 73, 75, 82, 113, 114]; % manually label which channels were really noisy.
badChan = [];
recodeTrig = {'TriWav_no480_IBI4.csv','TriWav_no480_IBI2.csv','TriWav_no480_IBI3.csv'}; 
if ERP == 1
    saveName = 'preprocessed_MMN_infant_1-15Hz_CTR100/sub47.mat';
else
    saveName = 'preprocessed_freq_infant/sub47.mat';
end
preproEGI_3tempos( ERP, dataFile, removeChan, 1, badChan, AB, recodeTrig, saveName, 251) % forgot to take net off for last 4:11, so 251 s

