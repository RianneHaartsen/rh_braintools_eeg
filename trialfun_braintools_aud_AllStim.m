function [trl, event] = trialfun_braintools_aud_AllStim(cfg)
% RH dec 2018
% defines the trial events for 1st, 2nd, 3rd standard tone
% and the high and low deviant tones
% recodes the eventvalue of the 2nd and 3rd standard tone
% for later convenience

% output: 
% trl file with trl = [begsample endsample offset task valid];
% event variable containing all the events in the raw data

%% read the header (needed for the samping rate) and the events
hdr        = ft_read_header(cfg.dataset);
event      = ft_read_event(cfg.dataset);

% for the events of interest, find the sample numbers (these are integers)
% for the events of interest, find the trigger values (these are strings in the case of BrainVision)
EVsample   = [event.sample]';
EVvalue    = {event.value}';

numEvents = length(EVvalue);

%% Selecting event specific for braintools

% select the target onset stimuli
StimCodes = [400 401 402]; % standard deviant1 deviant2
XOnset = zeros(numEvents,length(StimCodes));
for ii = 1:length(StimCodes)
    XOnset(:,ii) = strcmp(num2str(StimCodes(1,ii)), EVvalue);
end
XOnset = sum(XOnset,2); IndTStim = find(XOnset==1);
clear ii
           
validTStim = zeros(numEvents,1); 

% valid if
% a1) 400 and 3rd after that is dev1 or dev2
% a2) 400 and 2nd after that is dev1 or dev2, recode to 405
% a3) 400 and next after that is dev1 or dev2, recode to 406
% b) 401 dev1
% c) 401 dev2

    for e = 1:numEvents
        % if this is a relevant event
        if XOnset(e)
            
            if isequal(EVvalue{e},'401') || isequal(EVvalue{e},'402') %b and c
                validEvent = 1;
            elseif e+3 < numEvents && isequal(EVvalue{e},'400') && (isequal(EVvalue{e+3},'401') || isequal(EVvalue{e+3},'402')) %a1
                validEvent = 1;
            elseif e+2 < numEvents && isequal(EVvalue{e},'400') && (isequal(EVvalue{e+2},'401') || isequal(EVvalue{e+2},'402')) %a2
                EVvalue{e} = '405';
                validEvent = 1;
            elseif e+1 < numEvents && isequal(EVvalue{e},'400') && (isequal(EVvalue{e+1},'401') || isequal(EVvalue{e+1},'402')) %a3
                EVvalue{e} = '406';
                validEvent = 1;
            else
                validEvent = 0;
            end
            
            if validEvent == 1
                validTStim(e,1) = 1;
            end

        end
    end
    
    clear e

% define trials around onset stimuli
PreTrig  = round(cfg.trialdef.prestim  * hdr.Fs);
PostTrig =  round(cfg.trialdef.poststim * hdr.Fs);

begsample = EVsample(IndTStim) - PreTrig;
endsample = EVsample(IndTStim) + PostTrig;
offset = -PreTrig*ones(size(endsample));
task = str2double(EVvalue(IndTStim,1));
valid = validTStim(IndTStim,1);

trl = [begsample endsample offset task];
trl = trl(valid == 1,:);


end % function