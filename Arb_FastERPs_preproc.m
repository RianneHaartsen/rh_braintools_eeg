function [CleanData, N_trials] = Arb_FastERPs_preproc(eeg_file, channels, Tmin, Tmax, Trange)
% The function [CleanData, N_trials] = Arb_FastERPs_preproc(eeg_file, channels, Tmin, Tmax, Trange)
% extracts the number of trials presented for the fastERP tasks during the
% session from the eeglab file.
% For braintools Arbaclofen only

% Calls to: 
% - other FieldTrip functions
% - trialfun_braintools: trialfunction for braintools FastERPs task
% - NumberTrials_ERPs.m
% - eegAR_Detect.m

% INPUT: 
% - eeglab_file: eeg file in eeglab format
% - Tmin: minimum value for threshold AR
% - Tmax: maximum value for threshold AR
% - Trange: range value for threshold AR

% OUTPUT: 
% - CleanData: preprocessed data
% - N_trials: number of trials presented and valid

% created by RH, dec-18


%% QC and prep for FastERP data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read in data inf FT format
    cfg = [];
    cfg.dataset             = eeg_file;
    cfg.continuous          = 'yes';
    RawContinuous = ft_preprocessing(cfg);
    
    disp('EGI data read into FieldTrip')

% define trials: trl with [beginsample endsample offset task] information
    cfg = [];
    cfg.trialfun            = 'trialfun_Arb_braintools'; %trials -100 ms - 600 ms stimulus onset for different stimuli
    cfg.trialdef.dataset    = eeg_file;
    cfg.trialdef.prestim    = .1; % s before the stimulus onset
	cfg.trialdef.poststim   = .6; % s after the stimulus onset
    [BrT_Faces_trl, ~] = trialfun_Arb_braintools(cfg);
    
    disp('Trial info defined')
    
% redefine trial using trl definition    
    cfg = [];
    cfg.trl = BrT_Faces_trl;
    Raw_trials = ft_redefinetrial(cfg, RawContinuous);
    clear RawContinuous 
    
    disp('EEG data cut into trials')

% calculate N presented and valid trials
    N_trials = NumberTrials_ERPs_Arb(Raw_trials);
    
    disp('Number of trials presented found')

% read and preprocess
    % params for all conditions
    cfg.padding         = 3;
    cfg.bpfilter        = 'yes';
    cfg.bpfreq          = [1, 30];
    cfg.dftfilter       = 'yes';
    cfg.demean          = 'yes';
    cfg.baselinewindow  = [-0.1, 0.0];
    cfg.channel         = channels;
    data_preproc = ft_preprocessing(cfg, Raw_trials);
    clear Raw_trials
    
    disp('Trials defined, now on to artefact detection')
    
% Artefact rejection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% AR step 1) Thesholds
    data_preproc = eegAR_Detect(data_preproc, 'method', 'minmax', 'threshold', [Tmin, Tmax]); 
% AR step 2) range 
    data_preproc = eegAR_Detect(data_preproc, 'method', 'range', 'threshold', Trange); 
% AR step 3) Flat channels 
    data_preproc = eegAR_Detect(data_preproc, 'method', 'flat'); 
% AR step 4) Blinks  
%     data = eegAR_Detect(data, 'method', 'eogstat');
% AR step 5) Alpha oscillations
%     data = eegAR_Detect(data, 'method', 'alpha');

disp('Artefacts identified')
        
% update
    summary.ar = eegAR_Summarise(data_preproc);
        
% drop trials with artefacts
    cfg = [];
    badTrials = any(any(data_preproc.art, 3), 1);
    if sum(badTrials) == length(data_preproc.trial)
        summary.success = false;
        summary.outcome = 'No good trials';
        return
    end
    cfg.trials = ~badTrials;
    if any(badTrials), CleanData = ft_selectdata(cfg, data_preproc); 
    else
        CleanData = data_preproc;
    end
    
end