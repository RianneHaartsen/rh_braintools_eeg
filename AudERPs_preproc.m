function [CleanData, N_trials] = AudERPs_preproc(eeglab_file, channels, Tmin, Tmax, Trange)
% The function [Raw_trials, N_trials] = eegQC_Trialnumbers(eeglab_file)
% extracts the number of trials presented for the fastERP tasks during the
% session from the eeglab file. 
% For braintools only

% Calls to: 
% - other FieldTrip functions
% - trialfun_braintools_aud: trialfunction for braintools auditory task
% - eegAR_Detect.m

% INPUT: 
% - eeglab_file: eeg file in eeglab format
% - Tmin: minimum value for threshold AR
% - Tmax: maximum value for threshold AR
% - Trange: range value for threshold AR

% OUTPUT: 
% - CleanData: preprocessed data
% - N_trials: number of trials presented

% created by RH, nov-18

%% QC and prep for AudERP data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define all trials 
    cfg = [];
    cfg.trialfun            = 'trialfun_braintools_aud_AllStim'; %trials -100 ms - 450 ms stimulus onset for different stimuli
    cfg.dataset             = eeglab_file;
    cfg.trialdef.prestim    = .1; % s before the stimulus onset
	cfg.trialdef.poststim   = .45; % s after the stimulus onset
    Raw_trials = ft_definetrial(cfg);

% calculate N presented trials
Stan1 = find(Raw_trials.trl(:,4)==400); % standard tone 1
Stan2 = find(Raw_trials.trl(:,4)==405); % standard tone 1
Stan3 = find(Raw_trials.trl(:,4)==406); % standard tone 1
Dev1 = find(Raw_trials.trl(:,4)==401); % high tone
Dev2 = find(Raw_trials.trl(:,4)==402); % low tone

N_trials.Npres.Standard1 = length(Stan1); 
N_trials.Npres.Standard2 = length(Stan2); 
N_trials.Npres.Standard3 = length(Stan3); 
N_trials.Npres.Deviant1 = length(Dev1);
N_trials.Npres.Deviant2 = length(Dev2);
clear Stan Dev1 Dev2


% read and preprocess %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % params for all conditions
    cfg.padding         = 3;
    cfg.bpfilter        = 'yes';
    cfg.bpfreq          = [1, 30];
    cfg.dftfilter       = 'yes';
    cfg.demean          = 'yes';
    cfg.baselinewindow  = [-0.1, 0.0];
    cfg.channel         = channels; 
    cfg.trl             = Raw_trials.trl;
    data = ft_preprocessing(cfg);
    clear Raw_trials
    

% Artefact rejection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% AR step 1) Thesholds
    data = eegAR_Detect(data, 'method', 'minmax', 'threshold', [Tmin, Tmax]); 
% AR step 2) range 
    data = eegAR_Detect(data, 'method', 'range', 'threshold', Trange); 
% AR step 3) Flat channels 
    data = eegAR_Detect(data, 'method', 'flat'); 
% AR step 4) Blinks  
%     data = eegAR_Detect(data, 'method', 'eogstat');
% AR step 5) Alpha oscillations
%     data = eegAR_Detect(data, 'method', 'alpha');

disp('Artefacts identified')
        
% update
    summary.ar = eegAR_Summarise(data);
        
% drop trials with artefacts
    cfg = [];
    badTrials = any(any(data.art, 3), 1);
    if sum(badTrials) == length(data.trial)
        summary.success = false;
        summary.outcome = 'No good trials';
        return
    end
    cfg.trials = ~badTrials;
    if any(badTrials), CleanData = ft_selectdata(cfg, data); 
    else
        CleanData = data;
    end


end