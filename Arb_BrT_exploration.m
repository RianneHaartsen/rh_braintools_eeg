%% Arbaclofen expl

clear 
path_ses = strcat('/Users/riannehaartsen/Documents/02_Braintools/BrT_Arbaclofen');

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
javaaddpath /Users/riannehaartsen/Documents/MATLAB/fieldtrip-20180925/external/egi_mff/java/MFF-1.2.jar

%%
% use complete directory as dataset input
eeg_file = '/Users/riannehaartsen/Documents/02_Braintools/BrT_Arbaclofen/arbaclofen_eeg_egi_kcl_20181206_120509.mff';

% preprocessing parameters
    Tmin = -120; % minimum value for minmax threshold AR
    Tmax = 120; % maximum value for minmax threshold AR
    Trange = 150; % range value for range threshold AR 
    Channels = 'all';
    
% preprocessing   
    [CleanData, N_trials] = Arb_FastERPs_preproc(eeg_file, Channels, Tmin, Tmax, Trange);
    

% view data in databrowser
    cfg = [];
    cfg.ylim                    = 'maxabs';
    cfg.continuous              = 'yes';
    cfg.ploteventlabels         = 'type=value';
    cfg.plotevents              = 'yes';
    cfg.viewmode                = 'vertical';
    cfg.colorgroups             = 'sequential';
    ft_databrowser(cfg, RawContinuous)
    
    cfg = [];
    cfg.ylim                    = 'maxabs';
    cfg.continuous              = 'no';
    cfg.ploteventlabels         = 'type=value';
    cfg.plotevents              = 'yes';
    cfg.viewmode                = 'vertical';
    cfg.colorgroups             = 'sequential';
    ft_databrowser(cfg, Raw_trials)
  
    
    %% clean Visual AR on trial basis    
    cfg = [];
    cfg.method = 'trial';
    cfg.continuous = 'no';
    CleanData = ft_rejectvisual(cfg, CleanData);
    
% re-ref to avg?

% Timelock analyses 
    [ERPs, N_trials] = FastERPs_timelockavg(CleanData, N_trials);
    d.N_trials = N_trials; clear N_trials

% Plot individual ERPs 
    FastERPs_fig = FastERPs_figure(ERPs, d.N_trials, d.ID, d.Session);

disp('Ready for Fast ERPs inspection and saving')