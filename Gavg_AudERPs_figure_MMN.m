function Gavg_AudERPs_fig_MMN = Gavg_AudERPs_figure_MMN(Gavg_S1, Gavg_D1, Gavg_D2)
% The function Gavg_AudERPs_fig_MMN = Gavg_AudERPs_figure_MMN(Gavg_S1, Gavg_D1, Gavg_D2)
% plots the grand averages for the first standard and 2 deviant tones.
% Data for the first standard are raw, data for the deviant tones are
% substractions to represent the MMN. 
% For braintools only

% Calls to: 
% - other FieldTrip functions

% INPUT: 
% - Grand average from the indiviudal Auditory preproc and timelock data
% for the first standard, deviant1 and deviant2.

% OUTPUT: 
% - Gavg_AudERPs_fig_MMN: figure with data for each of the 8 channels,
% displaying the raw wave for the standard in blue, and the difference MMN wave
% with the deviants in red (deviant1 - standard, and deviant2 - standard)

% created by RH, dec-18

%% Plot Grand averages  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create figure
Gavg_AudERPs_fig_MMN = figure;

% specify general parameters for all plots
    cfg = [];
    cfg.fontsize = 14;
    cfg.ylim = [-7 7];
    cfg.linewidth = 1;

% calculate the MMN
    MMN_Dev1 = Gavg_S1;
    MMN_Dev1.avg = Gavg_D1.avg - Gavg_S1.avg;
    MMN_Dev2 = Gavg_S1;
    MMN_Dev2.avg = Gavg_D2.avg - Gavg_S1.avg;

    
% create subplots
% channel Fpz
    subplot(3,3,1)
    cfg.channel = 'Fpz';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 0 0; 1 .6 0];
    ft_singleplotER(cfg, Gavg_S1, MMN_Dev1, MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-6 -3 0 3 6]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-6 -3 0 3 6];

    h = legend('Raw standard', 'MMN high', 'MMN low'); set(h,'FontSize',12, 'Location','best');

% channel Fz
    subplot(3,3,2)
    cfg.channel = 'Fz';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 0 0; 1 .6 0];
    ft_singleplotER(cfg, Gavg_S1, MMN_Dev1, MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-6 -3 0 3 6]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-6 -3 0 3 6];
    
% channel C3
    subplot(3,3,4)
    cfg.channel = 'C3';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 0 0; 1 .6 0];
    ft_singleplotER(cfg, Gavg_S1, MMN_Dev1, MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-6 -3 0 3 6]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-6 -3 0 3 6];
    
% channel Cz
    subplot(3,3,5)
    cfg.channel = 'Cz';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 0 0; 1 .6 0];
    ft_singleplotER(cfg, Gavg_S1, MMN_Dev1, MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-6 -3 0 3 6]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-6 -3 0 3 6];
    
% channel C4    
    subplot(3,3,6)
    cfg.channel = 'C4';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 0 0; 1 .6 0];
    ft_singleplotER(cfg, Gavg_S1, MMN_Dev1, MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-6 -3 0 3 6]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-6 -3 0 3 6];
    
% channel P7    
    subplot(3,3,7)
    cfg.channel = 'P7';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 0 0; 1 .6 0];
    ft_singleplotER(cfg, Gavg_S1, MMN_Dev1, MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-6 -3 0 3 6]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-6 -3 0 3 6];
    
% channel Oz    
    subplot(3,3,8)
    cfg.channel = 'Oz';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 0 0; 1 .6 0];
    ft_singleplotER(cfg, Gavg_S1, MMN_Dev1, MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-6 -3 0 3 6]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-6 -3 0 3 6];
    
% channel P8    
    subplot(3,3,9)
    cfg.channel = 'P8';
    cfg.title = cfg.channel;
    cfg.graphcolor = [0 0 1; 1 0 0; 1 .6 0];
    ft_singleplotER(cfg, Gavg_S1, MMN_Dev1, MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-6 -3 0 3 6]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-6 -3 0 3 6];
  
    
% global title for whole figure    
    suptitle({'Grand Average for AudERPs: MMN across 13 sessions'});
    
    
end