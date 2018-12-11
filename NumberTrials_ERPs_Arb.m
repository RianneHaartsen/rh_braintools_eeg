function N_trials = NumberTrials_ERPs_Arb(Raw_trials)
% The function N_trials = NumberTrials_ERPs_Arb(Raw_trials) takes
% output from define trials and calculates the number of trials presented 
% for the fastERP tasks during the session and the number of valid ones. 
% Only for the braintools Arbaclofen paradigm.

% INPUT: 
% - Raw_trials; output from ft_define trial

% OUTPUT: 
% - N_trials variabe with the N presented and valid trials

% created by RH, dec-18 

%%

% Find the presented trials for each condition
    FaceUp = find(Raw_trials.trialinfo(:,1)==21 | Raw_trials.trialinfo(:,1)==23 | Raw_trials.trialinfo(:,1)==25);
    FaceInv = find(Raw_trials.trialinfo(:,1)==22 | Raw_trials.trialinfo(:,1)==24 | Raw_trials.trialinfo(:,1)==26);
    House = find(Raw_trials.trialinfo(:,1)==27 | Raw_trials.trialinfo(:,1)==28 | Raw_trials.trialinfo(:,1)==29); 

% Calculate the number of presented trials for each condition
    N_trials.Npres.FaceUp = length(FaceUp); 
    N_trials.Npres.FaceInv = length(FaceInv);
    N_trials.Npres.House = length(House);

end