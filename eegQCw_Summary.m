function eegQC = eegQCw_Summary(eeglab_file, channels)
% The function eegQC = eegQCw_Summary(eeglab_file, channels) checks the
% quality of the data across the whole session.

% Calls to other FieldTrip functions

% INPUT: eeg file in eeglab format

% OUTPUT: eegQC variable with 50Hz noise for each channel, variance across
% session for each channel (flat electrodes), correlations across channels (losing signal
% in REF)

% created by RH, nov-18

%% create eeg data quality summary struct
    eegQC = struct();
    eegQC.QC_date = date;

% QC with continous data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cfg = [];
    cfg.dataset = eeglab_file;
    cfg.channel = channels;
    RawContinuous = ft_preprocessing(cfg);
    eegQC.ChanLabels = RawContinuous.label;
    
% Amplitude for 50Hz noise %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    eegQC.Noise50Hz = zeros(size(eegQC.ChanLabels,1),1); 
% segment it into 1-second pieces with 50% overlap
    cfg = [];
    cfg.length      = 1;
    cfg.overlap     = .5;
    RawSegmented = ft_redefinetrial(cfg, RawContinuous);
% frequency analysis for 49 - 51 Hz
    cfg = [];
    cfg.method      = 'mtmfft';
    cfg.output      = 'pow';
    cfg.taper       = 'hanning';
    cfg.foilim      = [49 51];
    FreqDataS = ft_freqanalysis(cfg,RawSegmented);
    eegQC.Noise50Hz = log(mean(FreqDataS.powspctrm,2)); % calculate average natural log power across 49-51 Hz for each channel
    clear FreqDataS cfg RawSegmented
        
% Channel variance and correlations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% segment into 1-sec epochs without overlap
    cfg = [];
    cfg.length      = 1;
    cfg.overlap     = 0;
    cfg.channel     = channels;
    RawSeconds = ft_redefinetrial(cfg, RawContinuous);
    clear cfg
    
% calculate differences in amplitudes between samples
    eegQC.CorrDiff = zeros((size(RawSeconds.label,1)*(size(RawSeconds.label,1)-1))/2,size(RawSeconds.trial,2));
    eegQC.VarChan = zeros(size(RawSeconds.label,1),size(RawSeconds.trial,2));
    
    for ii = 1:size(RawSeconds.trial,2) % for each 1-sec segment:
        
        % calculate differences in amplitude between subsequent samples
        % within a 1-sec segment
            DiffAmpl = diff(RawSeconds.trial{1,ii},1,2);
        % calculate the correlation between electrodes
            x = corr(DiffAmpl'); 
            eegQC.CorrDiff(:,ii) = squareform(tril(x,-1));
            clear x 
        % calculate the variance for the differences in amplitudes across
        % the tsegment for each channel
            eegQC.VarChan(:,ii) = var(RawSeconds.trial{1,ii},0,2);
            clear DiffAmpl
    end
    clear ii
    clear RawContinuous RawSeconds 

end