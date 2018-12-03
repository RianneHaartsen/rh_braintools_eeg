function QCwhole = eegQCw_figure(eegQC, subj, session)
% The function QCwhole = eegQCw_figure(eegQC, subj, session)
% creates a summary figure with the 50Hz noise, variance for the channels
% accross the session, and correlations between signals from the different channels.

% INPUT: 
% - eegQC: structure with info on the data quality 
% - subj: subject ID in characters
% - session: test or retest in characters

% OUTPUT: 
% - figure with summary of data quality variables

% created by RH, nov-18

%% QC figure: whole session %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

QCwhole = figure;

% plot the 50Hz noise for each channel
    subplot(3,1,1) 
    plot(1:1:size(eegQC.ChanLabels,1),eegQC.Noise50Hz);
    ylabel('Log Power (Hz)', 'Fontsize', 12);
    ylim([0 20])
    xlim([0 (size(eegQC.ChanLabels,1)+1)])
    xticks(1:1:size(eegQC.ChanLabels,1))
    xticklabels(eegQC.ChanLabels)
    xlabel('Channels', 'Fontsize', 12);
    title({[subj ' ' session ' QC report'], ' ', ['50 Hz noise (mean: ' num2str(mean(eegQC.Noise50Hz,1)) ' Hz)']}, 'Fontsize', 14);
    
% plot the channel variance for each channel
    subplot(3,1,2) 
    x = ones(1,size(eegQC.VarChan,2));
    scatter(x,eegQC.VarChan(1,:)');
    hold on
    for ii = 2:size(eegQC.VarChan,1)
        scatter(x*ii, eegQC.VarChan(ii,:)')
    end
    ylabel('Variance (signal)', 'Fontsize', 12);
    set(gca, 'YScale', 'log')
    xlim([0 (size(eegQC.ChanLabels,1)+1)])
    xticks(1:1:size(eegQC.ChanLabels,1))
    xticklabels(eegQC.ChanLabels)
    xlabel('Channels', 'Fontsize', 12);
    title({'Variance for 1-sec segments (ampl diff)'}, 'Fontsize', 14);
    
% plot the channel correlations for differences in amplitudes between subsequent samples
    subplot(3,1,3)
    yyaxis left 
    plot(1:1:size(eegQC.CorrDiff,2),nanmean(eegQC.CorrDiff,1));
    ylabel('Mean', 'Fontsize', 12); ylim([0 1]);
    hold on
% plot the channel correlations for differences in amplitudes between subsequent samples
    yyaxis right
    plot(1:1:size(eegQC.CorrDiff,2),nanvar(eegQC.CorrDiff,0,1));
    ylabel('Variance', 'Fontsize', 12); ylim([0 1]);
    xlim([0 (size(eegQC.CorrDiff,2))])
    xlabel('Time (sec)', 'Fontsize', 12);
    title({'Correlations across all channels (ampl diff)'}, 'Fontsize', 14);

end