%% MMN figures


ERPs.MMN_Dev1 = ERPs.Standard;
ERPs.MMN_Dev1.avg = ERPs.Deviant1.avg - ERPs.Standard.avg;
ERPs.MMN_Dev2 = ERPs.Standard;
ERPs.MMN_Dev2.avg = ERPs.Deviant2.avg - ERPs.Standard.avg;

Fig = figure;
    cfg = [];
    cfg.fontsize = 14;
    cfg.ylim = [-15 15];
    cfg.linewidth = 1;
    
    subplot(2,4,1)
    cfg.channel = 'Fpz';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.MMN_Dev1, ERPs.MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

    subplot(2,4,2)
    cfg.channel = 'Fz';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.MMN_Dev1, ERPs.MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

    subplot(2,4,3)
    cfg.channel = 'Cz';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.MMN_Dev1, ERPs.MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

    subplot(2,4,4)
    cfg.channel = 'C3';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.MMN_Dev1, ERPs.MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];
    
    subplot(2,4,5)
    cfg.channel = 'C4';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.MMN_Dev1, ERPs.MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

    subplot(2,4,6)
    cfg.channel = 'P7';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.MMN_Dev1, ERPs.MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

    subplot(2,4,7)
    cfg.channel = 'P8';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.MMN_Dev1, ERPs.MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];

    subplot(2,4,8)
    cfg.channel = 'Oz';
    cfg.title = cfg.channel;
    ft_singleplotER(cfg, ERPs.MMN_Dev1, ERPs.MMN_Dev2);
    ax = gca; ax.XAxisLocation = 'origin'; ax.YAxisLocation = 'origin';
    ax.XTick = [.1 .2 .3 .4 .5]; ax.YTick = [-10 10 20]; 
    ax.XTickLabel = {' ', '200', ' ', '400', ' '}; ax.YTickLabel = [-10 10 20];
    
    h = legend('Diff Dev high - Standard', 'Diff Dev low - Standard'); set(h,'FontSize',14, 'Location','best');
