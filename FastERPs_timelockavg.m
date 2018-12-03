function [ERPs, N_trials] = FastERPs_timelockavg (data_AR2, N_trials)
% The function [ERPs, N_trials] = FastERPs_timelockavg (data_AR2, N_trials)
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
ERPs            = struct;

    cfg             = [];
    cfg.baseline    = [-0.1, 0];
    
% faces up
    cfg.trials      = find(data_AR2.trialinfo == 310 | data_AR2.trialinfo == 312 | data_AR2.trialinfo == 314 | data_AR2.trialinfo == 316);
    face_up_NoBl    = ft_timelockanalysis(cfg, data_AR2);
    ERPs.face_up    = ft_timelockbaseline(cfg, face_up_NoBl);
    N_trials.Nclean.FaceUp = length(cfg.trials);
    cfg.trials = [];
    
% faces inv
    cfg.trials      = find(data_AR2.trialinfo == 311 | data_AR2.trialinfo == 313 | data_AR2.trialinfo == 315 | data_AR2.trialinfo == 317);
    face_inv_NoBl   = ft_timelockanalysis(cfg, data_AR2);
    ERPs.face_inv   = ft_timelockbaseline(cfg, face_inv_NoBl);
    N_trials.Nclean.FaceInv = length(cfg.trials);
    cfg.trials = [];
    
% obj up
    cfg.trials      = find(data_AR2.trialinfo == 320);
    obj_up_NoBl     = ft_timelockanalysis(cfg, data_AR2);
    ERPs.obj_up     = ft_timelockbaseline(cfg, obj_up_NoBl);    
    N_trials.Nclean.ObjUp = length(cfg.trials);
    cfg.trials = [];
    
% obj inv
    cfg.trials      = find(data_AR2.trialinfo == 321);
    obj_inv_NoBl    = ft_timelockanalysis(cfg, data_AR2);
    ERPs.obj_inv    = ft_timelockbaseline(cfg, obj_inv_NoBl);    
    N_trials.Nclean.ObjInv = length(cfg.trials);
    cfg.trials = [];    
    
% checkers
    cfg.trials      = find(data_AR2.trialinfo == 330);
    checker_NoBl    = ft_timelockanalysis(cfg, data_AR2);
    ERPs.checker    = ft_timelockbaseline(cfg, checker_NoBl);   
    N_trials.Nclean.Checker = length(cfg.trials);
    
    clear cfg face_up_NoBl face_inv_NoBl obj_up_NoBl obj_inv_NoBl checker_NoBl
    
end