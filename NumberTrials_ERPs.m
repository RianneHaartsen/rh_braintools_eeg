function N_trials = NumberTrials_ERPs(Raw_trials)
% The function N_trials = NumberTrials_ERPs(N_trials, Raw_trials) takes
% output from define trials and calculates the number of trials presented 
% for the fastERP tasks during the session and the number of valid ones. 
% Only for the braintools paradigm.

% INPUT: 
% - Raw_trials; output from ft_define trial

% OUTPUT: 
% - N_trials variabe with the N presented and valid trials

% created by RH, nov-18 

%%

% Find the presented trials for each condition
    FaceUp = find(Raw_trials.trl(:,4)==310 | Raw_trials.trl(:,4)==312 | Raw_trials.trl(:,4)==314 | Raw_trials.trl(:,4)==316);
    FaceInv = find(Raw_trials.trl(:,4)==311 | Raw_trials.trl(:,4)==313 | Raw_trials.trl(:,4)==315 | Raw_trials.trl(:,4)==317);
    ObjUp = find(Raw_trials.trl(:,4)==320); 
    ObjInv = find(Raw_trials.trl(:,4)==321); 
    Checkers = find(Raw_trials.trl(:,4)==330); 

% Calculate the number of presented trials for each condition
    N_trials.Npres.FaceUp = length(FaceUp); 
    N_trials.Npres.FaceInv = length(FaceInv);
    N_trials.Npres.ObjUp = length(ObjUp);
    N_trials.Npres.ObjInv = length(ObjInv);
    N_trials.Npres.Checker = length(Checkers);


% Find the number of valid trials for each condition
    N_trials.Nvalid.FaceUp = length(find(Raw_trials.trl(FaceUp,5)==1)); 
    N_trials.Nvalid.FaceInv = length(find(Raw_trials.trl(FaceInv,5)==1));
    N_trials.Nvalid.ObjUp = length(find(Raw_trials.trl(ObjUp,5)==1));
    N_trials.Nvalid.ObjInv = length(find(Raw_trials.trl(ObjInv,5)==1));
    N_trials.Nvalid.Checker = length(find(Raw_trials.trl(Checkers,5)==1));

end