function AudERPs_fig = AudERPs_figure(ERPs, N_trials, subj, session)
% The function AudERPs_fig = AudERPs_figure(ERPs, N_trials, subj, session)
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

%% Plot individual ERPs and eegQC summary %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create figure
AudERPs_fig = figure;

% specify general parameters for all plots
    cfg = [];
    cfg.fontsize = 14;
    cfg.ylim = [-15 15];
    cfg.linewidth = 1;

% create subplots
% channel Fpz
    subplot(3,3,1)
    cfg.channel = 'Fpz';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.Standard, ERPs.Deviant1, ERPs.Deviant2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

    h = legend('Stan', 'Dev high', 'Dev low'); set(h,'FontSize',12, 'Location','best');
    
% channel Fz
    subplot(3,3,2)
    cfg.channel = 'Fz';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.Standard, ERPs.Deviant1, ERPs.Deviant2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

% channel C3
    subplot(3,3,4)
    cfg.channel = 'C3';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.Standard, ERPs.Deviant1, ERPs.Deviant2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];
    
% channel Cz
    subplot(3,3,5)
    cfg.channel = 'Cz';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.Standard, ERPs.Deviant1, ERPs.Deviant2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

% channel C4    
    subplot(3,3,6)
    cfg.channel = 'C4';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.Standard, ERPs.Deviant1, ERPs.Deviant2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

% channel P7    
    subplot(3,3,7)
    cfg.channel = 'P7';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.Standard, ERPs.Deviant1, ERPs.Deviant2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

% channel Oz    
    subplot(3,3,8)
    cfg.channel = 'Oz';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.Standard, ERPs.Deviant1, ERPs.Deviant2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

% channel P8    
    subplot(3,3,9)
    cfg.channel = 'P8';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.Standard, ERPs.Deviant1, ERPs.Deviant2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

% N trials    
    subplot(3,3,3) 
    Ns = [N_trials.Npres.Standard N_trials.Nclean.Standard; ...
        N_trials.Npres.Deviant1  N_trials.Nclean.Deviant1; ...
        N_trials.Npres.Deviant2 N_trials.Nclean.Deviant2];
    bar(Ns)
    title({'Number of trials'}, 'Fontsize', 12);
    ylim([0 300])
    xticks(1:1:5);
    xticklabels({'Standard','Deviant high','Deviant low'});
    legend({'Presented', 'Clean'},'Fontsize', 12,'Location','best')   
    
% global title for whole figure    
    suptitle({['Auditory ERPs: ' subj ' ' session ]});
    
    
end