function Gavg_AudERPs_fig_Hab = Gavg_AudERPs_figure_Hab(Gavg_S1, Gavg_S2, Gavg_S3)
% The function Gavg_AudERPs_fig_Hab = Gavg_AudERPs_figure_Hab(Gavg_S1, Gavg_S2, Gavg_S3)
% plots the grand averages for the first, second and third standard tone.
% For braintools only

% Calls to: 
% - other FieldTrip functions

% INPUT: 
% - Grand average from the indiviudal Auditory preproc and timelock data

% OUTPUT: 
% - Gavg_AudERPs_fig_habi: figure with data for each of the 8 channels,
% displaying 3 Grand averages for the first, second, and third standard.

% created by RH, dec-18

%% Plot Grand averages  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create figure
Gavg_AudERPs_fig_Hab = figure;

% specify general parameters for all plots
    cfg = [];
    cfg.fontsize = 14;
    cfg.ylim = [-5 5];
    cfg.linewidth = 1;
    
% create subplots
% channel Fpz
    subplot(3,3,1)
    cfg.channel = 'Fpz';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 .6 0; 1 0 0];
    ft_singleplotER(cfg, Gavg_S1, Gavg_S2, Gavg_S3);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-5 0 5]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-5 0 5];

    h = legend('Standard 1', 'Standard 2', 'Standard 3'); set(h,'FontSize',12, 'Location','best');

% channel Fz
    subplot(3,3,2)
    cfg.channel = 'Fz';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 .6 0; 1 0 0];
    ft_singleplotER(cfg, Gavg_S1, Gavg_S2, Gavg_S3);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-5 0 5]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-5 0 5];

% channel C3
    subplot(3,3,4)
    cfg.channel = 'C3';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 .6 0; 1 0 0];
    ft_singleplotER(cfg, Gavg_S1, Gavg_S2, Gavg_S3);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-5 0 5]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-5 0 5];
    
% channel Cz
    subplot(3,3,5)
    cfg.channel = 'Cz';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 .6 0; 1 0 0];
    ft_singleplotER(cfg, Gavg_S1, Gavg_S2, Gavg_S3);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-5 0 5]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-5 0 5];

% channel C4    
    subplot(3,3,6)
    cfg.channel = 'C4';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 .6 0; 1 0 0];
    ft_singleplotER(cfg, Gavg_S1, Gavg_S2, Gavg_S3);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-5 0 5]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-5 0 5];

% channel P7    
    subplot(3,3,7)
    cfg.channel = 'P7';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 .6 0; 1 0 0];
    ft_singleplotER(cfg, Gavg_S1, Gavg_S2, Gavg_S3);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-5 0 5]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-5 0 5];

% channel Oz    
    subplot(3,3,8)
    cfg.channel = 'Oz';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 .6 0; 1 0 0];
    ft_singleplotER(cfg, Gavg_S1, Gavg_S2, Gavg_S3);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-5 0 5]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-5 0 5];

% channel P8    
    subplot(3,3,9)
    cfg.channel = 'P8';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 .6 0; 1 0 0];
    ft_singleplotER(cfg, Gavg_S1, Gavg_S2, Gavg_S3);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-5 0 5]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-5 0 5];

  
    
% global title for whole figure    
    suptitle({'Grand Average for AudERPs: Habituation 13 sessions'});
    
    
end