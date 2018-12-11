%% Grand averages for AudERPs
% Calculates and visualised auditory ERP data

clear 
path_gavg = strcat('/Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/001_GrandAvgs_UK');

% Set up local paths to scripts

%add eeglab path
addpath(genpath('/Users/riannehaartsen/Documents/MATLAB/eeglab14_1_2b')); 
%add fieldtrip path and set to defaults
addpath('/Users/riannehaartsen/Documents/MATLAB/fieldtrip-20180925'); 
ft_defaults
%add LM code TaskEngine2
addpath(genpath('/Users/riannehaartsen/Documents/02_Braintools/BrT_Scripts/TaskEngine2'));  
addpath(genpath('/Users/riannehaartsen/Documents/02_Braintools/BrT_Scripts/braintools_code_LM'));  
%add RH code
addpath('/Users/riannehaartsen/Documents/02_Braintools/BrT_Scripts/braintools_code_RH/');

%% Load Clean ERPs and give new name

% BTA004 retest
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Retest/BTA004/2018-11-15T104014/FieldTrip/AudERPsMMN_AllStim_retest_36_BTA004.mat AudERPs
erps0042 = AudERPs; 
clear AudERPs

% BTA006 test
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Test/BTA006/2018-11-06T103547/FieldTrip/AudERPsMMN_AllStim_test_36_BTA006.mat AudERPs
erps0061 = AudERPs; 
clear AudERPs

% BTA006 retest
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Retest/BTA006/2018-11-13T102331/FieldTrip/AudERPsMMN_AllStim_retest_36_BTA006.mat AudERPs
erps0062 = AudERPs; 
clear AudERPs

% BTA007 test
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Test/BTA007/2018-11-08T135257/FieldTrip/AudERPsMMN_AllStim_test_36_BTA007.mat AudERPs
erps0071 = AudERPs; 
clear AudERPs

% BTA007 retest
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Retest/BTA007/2018-11-15T141928/FieldTrip/AudERPsMMN_AllStim_retest_36_BTA004.mat AudERPs
erps0072 = AudERPs; 
clear AudERPs

% BTA009 test
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Test/BTA009/2018-11-14T105416/FieldTrip/AudERPsMMN_AllStim_test_36_BTA009.mat AudERPs
erps0091 = AudERPs; 
clear AudERPs

% BTA009 retest
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Retest/BTA009/2018-11-21T113727/FieldTrip/AudERPsMMN_AllStim_retest_36_BTA009.mat AudERPs
erps0092 = AudERPs; 
clear AudERPs

% BTA010 retest
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Retest/BTA010/2018-11-24T123815/FieldTrip/AudERPsMMN_AllStim_retest_36_BTA010.mat AudERPs
erps0102 = AudERPs; 
clear AudERPs

% BTA011 retest
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Retest/BTA011/2018-11-24T143330/FieldTrip/AudERPsMMN_AllStim_retest_36_BTA011.mat AudERPs
erps0112 = AudERPs; 
clear AudERPs

% BTA012 test
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Test/BTA012/2018-11-27T144149/FieldTrip/AudERPsMMN_AllStim_test_36_BTA012.mat AudERPs
erps0121 = AudERPs; 
clear AudERPs

% BTA012 retest
load //Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Retest/BTA012/2018-12-04T141931/FieldTrip/AudERPsMMN_AllStim_retest_36_BTA012.mat AudERPs
erps0122 = AudERPs; 
clear AudERPs

% BTA013 test
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Test/BTA013/2018-11-28T144936/FieldTrip/AudERPsMMN_AllStim_test_36_BTA013.mat AudERPs
erps0131 = AudERPs; 
clear AudERPs

% BTA013 retest
load /Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Retest/BTA013/2018-12-05T140833/FieldTrip/AudERPsMMN_AllStim_retest_36_BTA013.mat AudERPs
erps0132 = AudERPs; 
clear AudERPs

disp('Individual ERP data loaded')

%% Calculate timelock averages

cfg = [];
cfg.method = 'across';

Aud_avg_S1 = ft_timelockgrandaverage(cfg, erps0042.Standard1, erps0061.Standard1, erps0062.Standard1, erps0071.Standard1, erps0072.Standard1, ...
    erps0091.Standard1, erps0092.Standard1, erps0102.Standard1, erps0112.Standard1, erps0121.Standard1, erps0122.Standard1, erps0131.Standard1, ...
    erps0132.Standard1);
Aud_avg_S2 = ft_timelockgrandaverage(cfg, erps0042.Standard2, erps0061.Standard2, erps0062.Standard2, erps0071.Standard2, erps0072.Standard2, ...
    erps0091.Standard2, erps0092.Standard2, erps0102.Standard2, erps0112.Standard2, erps0121.Standard2, erps0122.Standard2, erps0131.Standard2, ...
    erps0132.Standard2);
Aud_avg_S3 = ft_timelockgrandaverage(cfg, erps0042.Standard3, erps0061.Standard3, erps0062.Standard3, erps0071.Standard3, erps0072.Standard3, ...
    erps0091.Standard3, erps0092.Standard3, erps0102.Standard3, erps0112.Standard3, erps0121.Standard3, erps0122.Standard3, erps0131.Standard3, ...
    erps0132.Standard3);
Aud_avg_D1 = ft_timelockgrandaverage(cfg, erps0042.Deviant1, erps0061.Deviant1, erps0062.Deviant1, erps0071.Deviant1, erps0072.Deviant1, ...
    erps0091.Deviant1, erps0092.Deviant1, erps0102.Deviant1, erps0112.Deviant1, erps0121.Deviant1, erps0122.Deviant1, erps0131.Deviant1, ...
    erps0132.Deviant1);
Aud_avg_D2 = ft_timelockgrandaverage(cfg, erps0042.Deviant2, erps0061.Deviant2, erps0062.Deviant2, erps0071.Deviant2, erps0072.Deviant2, ...
    erps0091.Deviant2, erps0092.Deviant2, erps0102.Deviant2, erps0112.Deviant2, erps0121.Deviant2, erps0122.Deviant2, erps0131.Deviant2, ...
    erps0132.Deviant2);

%% Create figures
% For standards 1/2/3
Gavg_AudERPs_fig_Hab = Gavg_AudERPs_figure_Hab(Aud_avg_S1, Aud_avg_S2, Aud_avg_S3);

% MMN: S1 vs. MMN for Dev1 and Dev2
Gavg_AudERPs_fig_MMN = Gavg_AudERPs_figure_MMN(Aud_avg_S1, Aud_avg_D1, Aud_avg_D2);

% save figures
cd(path_gavg)
saveas(Gavg_AudERPs_fig_Hab,'GrandAverage_AudERPs_3Standards.png')
saveas(Gavg_AudERPs_fig_MMN,'GrandAverage_AudERPs_MMN_S1_D12.png')
