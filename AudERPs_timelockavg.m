function [ERPs, N_trials] = AudERPs_timelockavg (data_AR2, N_trials)
% The function [ERPs, N_trials] = AudERPs_timelockavg (data_AR2, N_trials)
% calculates the event related potentials for the face up/ inverted, object
% up/ inverted, and checkers trials. 
% For braintools only

% Calls to: 
% - other FieldTrip functions

% INPUT: 
% - data_AR2: cleaned and preprocessed EEG data in FieldTrip format
% - N_trials: the number of presented and valid trials

% OUTPUT: 
% - ERPs: event related potentials for this individual participants
% - N_trials: number of trials presented, valid, and included in the ERP
% calculation

% created by RH, nov-18

%% averaging across trials for different conditions
% averaging across trials for different conditions
ERPs            = struct;

    cfg             = [];
    cfg.baseline    = [-0.1, 0];
% standard
    cfg.trials      = find(data_AR2.trialinfo == 400);
    Stan_NoBl    = ft_timelockanalysis(cfg, data_AR2);
    ERPs.Standard    = ft_timelockbaseline(cfg, Stan_NoBl);
    N_trials.Nclean.Standard = length(cfg.trials);
    cfg.trials = [];
% Dev1
    cfg.trials      = find(data_AR2.trialinfo == 401);
    Dev1_NoBl   = ft_timelockanalysis(cfg, data_AR2);
    ERPs.Deviant1   = ft_timelockbaseline(cfg, Dev1_NoBl);
    N_trials.Nclean.Deviant1 = length(cfg.trials);
    cfg.trials = [];
% Dev2
    cfg.trials      = find(data_AR2.trialinfo == 402);
    Dev2_NoBl   = ft_timelockanalysis(cfg, data_AR2);
    ERPs.Deviant2   = ft_timelockbaseline(cfg, Dev2_NoBl);
    N_trials.Nclean.Deviant2 = length(cfg.trials);
    clear cfg Stan_NoBl Dev1_NoBl Dev2_NoBl 

end