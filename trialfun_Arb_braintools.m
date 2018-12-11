function [trl, event] = trialfun_Arb_braintools(cfg)
% RH dec 2018
% defines the trial events for faces and houses in Arbaclofen trial
% assumed no trials are invalid/ skipped

% output: 
% trl file with trl = [begsample endsample offset task];
% event variable containing all the events in the raw data

%% read the header (needed for the samping rate) and the events
hdr        = ft_read_header(cfg.trialdef.dataset);
event      = ft_read_event(cfg.trialdef.dataset);

% for the events of interest, find the sample numbers (these are integers)
% for the events of interest, find the trigger values (these are strings in the case of BrainVision)
EVsample   = [event.sample]';
EVvalue    = {event.value}';
numEvents = length(EVvalue);

%% Selecting event specific for braintools Arbaclofen trial

% select the target onset stimuli
StimCodes = {'21  ', '22  ', '23  ', '24  ', '25  ', '26  ', '27  ', '28  ', '29  '}; % faces up/inv, houses
XOnset = zeros(numEvents,length(StimCodes));
for ii = 1:length(StimCodes)
    XOnset(:,ii) = strcmp(StimCodes{1,ii}, EVvalue);
end
XOnset = sum(XOnset,2); IndTStim = find(XOnset==1);

%assume for now that they are all valid and nothing is skipped

% define trials around onset stimuli
PreTrig  = round(cfg.trialdef.prestim  * hdr.Fs);
PostTrig =  round(cfg.trialdef.poststim * hdr.Fs);

begsample = EVsample(IndTStim) - PreTrig;
endsample = EVsample(IndTStim) + PostTrig;
offset = -PreTrig*ones(size(endsample));
task = str2double(EVvalue(IndTStim,1));

trl = [begsample endsample offset task];



end % function