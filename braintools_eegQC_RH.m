%% Braintools ERP Quality check
% RH oct-2018
% after braintools_eeg_testprocess.m from LM
% bp filter: 1-30 Hz, and 100 ms baseline correction, no avg re-ref (not enough
% electrodes)
% own trialdef function

% INPUT: 
% - folderpath with session data (including an enobio folder with enobio
% data and tracker_X.mat file)

% OUTPUT: 
% - teData: file with a) session information, b) eegQC whole session, c) N
% of trials presented/ valid/ clean
% - figure with eegQC for the whole session
% - clean EEG data and individual ERPs


clear 
path_ses = strcat('/Users/riannehaartsen/Documents/02_Braintools/BrT_DATA_UK/Retest/BTA010/2018-11-24T123815');

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

%%
% Identifying paths and file information

% path to data
    %creating d variable containing all data information
    d = teData_enobio(path_ses); 
    % converting event codes to stimuli name codes
    fasterp_defineEvents(d.RegisteredEvents); 
    
% convert to eeglab
    % create a folder for eeglab data
    d.Path_EEGLab = fullfile(d.Path_Session, 'eeglab');
    mkdir(d.Path_EEGLab);
    % convert enobio data to eeglab data
    d.File_eegLab = eegEnobio2EEGLab(d.File_Enobio_Easy, d.File_Enobio_Info, d.Path_EEGLab);

% creat EEG preprocessing folder
    d.Path_FieldTrip = fullfile(d.Path_Session, 'FieldTrip');
    mkdir(d.Path_FieldTrip); 

disp('Ready for QC whole session')

%% Data quality check on EEG data across the whole session

    % Data quality check: 50Hz noise for each channel, variance across
    % session for each channel (flat electrodes), correlations across channels (losing signal
    % in REF), N presented and valid trials in the fastERP tasks
    
% define the channels to check
    channels = {'Fpz', 'Fz', 'Cz', 'Oz', 'C4', 'P8', 'C3', 'P7'};
    %'all'; % 
% check the quality of the data for those channels
    d.eegQC = eegQCw_Summary(d.File_eegLab, channels); 

% create figure with summary of the eegQC for the whole session
    QCwhole = eegQCw_figure(d.eegQC, d.ID, d.Session);

disp('Ready for QC whole session inspection and saving')

%% Save figure and d variable

% save the d variable with all QC and data information
    cd(path_ses);
    NameQC = strcat('teData_', d.Session,'_', d.Age, '_',d.ID, '.mat'); 
    save(NameQC, 'd')

% save the QC figureload
    NameFig = strcat('QCWholeSession_', d.Session,'_', d.Age, '_', d.ID, '.tif');
    saveas(QCwhole,NameFig)

% clean up and close figures
    clear NameFig ans Ns QCwhole NameQC
    close all

disp('Ready for Fast ERPs')

%% Fast ERPs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define the trials and clean the data for the Fast ERPs task
    % define the channels to check
    channels = {'Fpz', 'Fz', 'Cz', 'Oz', 'C4', 'P8', 'C3', 'P7'}; %'all';      
    
    % Threshold parameters:
    Tmin = -120; % minimum value for minmax threshold AR
    Tmax = 120; % maximum value for minmax threshold AR
    Trange = 150; % range value for range threshold AR 
    
    [CleanData, N_trials] = FastERPs_preproc(d.File_eegLab, channels, Tmin, Tmax, Trange);
    
% clean Visual AR on trial basis    
    cfg = [];
    cfg.method = 'trial';
    cfg.continuous = 'no';
    CleanData = ft_rejectvisual(cfg, CleanData);

% Timelock analyses 
    [ERPs, N_trials] = FastERPs_timelockavg (CleanData, N_trials);
    d.N_trials = N_trials; clear N_trials

% Plot individual ERPs 
    FastERPs_fig = FastERPs_figure(ERPs, d.N_trials, d.ID, d.Session);

disp('Ready for Fast ERPs inspection and saving')

%% Save figure and d variable
 
% save the FastERPs data
    cd(d.Path_FieldTrip) %go to FieldTrip folder
    NameData = strcat('FastERPs_', d.Session,'_', d.Age, '_', d.ID, '.mat');
    save(NameData,'ERPs','CleanData')
    d.Path_FastERPdata = strcat(d.Path_FieldTrip, '/', NameData);
    clear NameData
    
% save the FastERPs figure
    cd(path_ses); % go to session folder
    NameFig = strcat('FastERPs_', d.Session,'_', d.Age, '_', d.ID, '.tif');
    saveas(FastERPs_fig,NameFig)
    clear NameFig ans Ns QCwhole FastERPs_fig
    
% save the d variable
    NameQC = strcat('teData_', d.Session,'_', d.Age, '_',d.ID, '.mat'); % interim saving eegQC data
    save(NameQC,'d')
    clear NameQC	
    
% clear up data and close figures
    clear CleanData ERPs Tmax Tmin Trange    
    close all
 
disp('Ready for Aud ERPs')   

%% Aud ERPs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define the trials and clean the data for the auditory ERPs task
    % define the channels to check
    channels = {'Fpz', 'Fz', 'Cz', 'Oz', 'C4', 'P8', 'C3', 'P7'}; %'all';      
    
    % Threshold parameters:
    Tmin = -80; % minimum value for minmax threshold AR
    Tmax = 80; % maximum value for minmax threshold AR
    Trange = 150; % range value for range threshold AR 
    
    [AudCleanData, AudN_trials] = AudERPs_preproc(d.File_eegLab, channels, Tmin, Tmax, Trange);
    
% clean Visual AR on trial basis    
    cfg = [];
    cfg.method = 'trial';
    cfg.continuous = 'no';
    AudCleanData = ft_rejectvisual(cfg, AudCleanData);

% Timelock analyses 
    [AudERPs, AudN_trials] = AudERPs_timelockavg(AudCleanData, AudN_trials);
    d.AudN_trials = AudN_trials; clear AudN_trials

% Plot individual ERPs 
%     AudERPs_fig = AudERPs_figure(AudERPs, d.AudN_trials, d.ID, d.Session);
    
    % ERPs with raw standard and deviant substractions
    AudERPs_fig_MMN = AudERPs_figure_MMN(AudERPs, d.AudN_trials, d.ID, d.Session);

disp('Ready for Aud ERPs inspection and saving')

%% Saving data for Auditory ERP task

% % save the AudERPs data
%     cd(d.Path_FieldTrip) %go to FieldTrip folder
%     NameData = strcat('AudERPs_', d.Session,'_', d.Age, '_', d.ID, '.mat');
%     save(NameData,'AudERPs','AudCleanData')
%     d.Path_AudERPdata = strcat(d.Path_FieldTrip, '/', NameData);
%     clear NameData AudERPs AudCleanData
%        
% % save the FastERPs figure
%     cd(path_ses); % go to session folder
%     NameFig = strcat('AudERPs_', d.Session,'_', d.Age, '_', d.ID, '.tif');
%     saveas(AudERPs_fig,NameFig)
%     clear NameFig AudERPs_fig
    
    
    
% save the AudERPs_MMN_S1 data
    cd(d.Path_FieldTrip) %go to FieldTrip folder
    NameData = strcat('AudERPsMMN_S1sp_', d.Session,'_', d.Age, '_', d.ID, '.mat');
    save(NameData,'AudERPs','AudCleanData')
    d.Path_AudERPdata = strcat(d.Path_FieldTrip, '/', NameData);
    clear NameData AudERPs AudCleanData    
    
% save the AudERPs_MMN_S1 figure
    cd(path_ses); % go to session folder
    NameFig = strcat('AudERPs_MMN_S1sp_', d.Session,'_', d.Age, '_', d.ID, '.tif');
    saveas(AudERPs_fig_MMN,NameFig)
    clear NameFig AudERPs_fig    
    
    
    
% save the d variable
    NameQC = strcat('teData_', d.Session,'_', d.Age, '_',d.ID, '.mat'); % interim saving eegQC data
    save(NameQC,'d')
    clear NameQC	
    
% clear up data
    clear CleanData ERPs Tmax Tmin Trange    
    clear d channels path_ses cfg
    close all
    
disp('Data saved')
