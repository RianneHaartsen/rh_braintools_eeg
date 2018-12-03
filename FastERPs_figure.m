function FastERPs_fig = FastERPs_figure(ERPs, N_trials, subj, session)
% The function FastERPs_fig = FastERPs_figure(ERPs, N_trials)
% plots the ERPs for the faces in/up, objects inv/up, and checkerboards.
% It also displays the number of presented, valid, and clean trials for
% each condition.
% For braintools only

% Calls to: 
% - other FieldTrip functions

% INPUT: 
% - cleaned and preprocessed ERP data in FieldTrip format
% - N_trials with the number of presented, valid, and clean trials

% OUTPUT: 
% - FastERPs_fig: figure with ERPs and amount of data included

% created by RH, nov-18

%%

FastERPs_fig = figure;
    
    cfg = [];
    cfg.fontsize = 12;
    cfg.ylim = [-20 30];
    
% Faces for P7    
    subplot(2,3,1) 
    cfg.channel = 'P7';
    cfg.title = 'Faces up/inverted for P7';
    ft_singleplotER(cfg, ERPs.face_up, ERPs.face_inv);
    h = legend('Up', 'Inv'); set(h,'FontSize',cfg.fontsize);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20]; 
    
% Faces for P8    
    subplot(2,3,2) 
    cfg.channel = 'P8';
    cfg.title = 'Faces up/inverted for P8';
    ft_singleplotER(cfg, ERPs.face_up, ERPs.face_inv)
    h = legend('Up', 'Inv'); set(h,'FontSize',cfg.fontsize);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20]; 
    
% Objects    
    subplot(2,3,4) 
    cfg.ylim = [-20 40];
    cfg.channel = 'Oz'; %'Pz'; 
    cfg.title = 'Objects up/inverted for Oz';    
    ft_singleplotER(cfg, ERPs.obj_up, ERPs.obj_inv)
    h = legend('Up', 'Inv'); set(h,'FontSize',cfg.fontsize);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20]; 
    
% Checkers     
    subplot(2,3,5) 
    cfg.channel = 'Oz'; %'Pz'; 
    cfg.ylim = [-20 40];
    cfg.title = 'Checkerboards for Oz';
    ft_singleplotER(cfg, ERPs.checker)
    h = legend('Checkerboard'); set(h,'FontSize',cfg.fontsize);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20]; 
    
% N trials    
    subplot(2,3,3) 
    Ns = [N_trials.Npres.FaceUp N_trials.Nvalid.FaceUp N_trials.Nclean.FaceUp; ...
        N_trials.Npres.FaceInv  N_trials.Nvalid.FaceInv N_trials.Nclean.FaceInv; ...
        N_trials.Npres.ObjUp N_trials.Nvalid.ObjUp N_trials.Nclean.ObjUp; ...
        N_trials.Npres.ObjInv N_trials.Nvalid.ObjInv N_trials.Nclean.ObjInv; ...
        N_trials.Npres.Checker N_trials.Nvalid.Checker N_trials.Nclean.Checker];
    bar(Ns)
    title({'Number of trials'}, 'Fontsize', 12);
    ylim([0 72])
    xticks(1:1:5);
    xticklabels({'Face Up','Face Inv','Obj Up','Obj Inv','Checkers'});
    legend({'Presented','Valid','Clean'},'Fontsize', 12,'Location','best')   

% global title for whole figure   
    suptitle({['Fast ERPs: ' subj ' ' session ]});
    
end