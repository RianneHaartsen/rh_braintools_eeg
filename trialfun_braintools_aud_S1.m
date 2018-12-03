function [trl, event] = trialfun_braintools_aud_S1(cfg)
% RH nov 2018
% defines the trial events for first standard tone
% checks whether trials are valid (correct length, or skipped)

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

            % % check validity of the stimuli
            % StimOffset = [318 322 331]; % faces up/inv, obj up/inv, checkerboards offset
            % XOffset = zeros(numEvents,length(StimOffset));
            % for ii = 1:length(StimOffset)
            %     XOffset(:,ii) = strcmp(num2str(StimOffset(1,ii)), EVvalue);
            % end
            % XOffset = sum(XOffset,2); %IndOffStim = find(XOffset==1);
            % 
            % StimSkipped = 248; % skipped
            % XSkipped = zeros(numEvents,length(StimSkipped));
            % for ii = 1:length(StimSkipped)
            %     XSkipped(:,ii) = strcmp(num2str(StimSkipped(1,ii)), EVvalue);
            % end
            % XSkipped = sum(XSkipped,2); %IndSkipped = find(XSkipped==1);

            
            
            
validTStim = zeros(numEvents,1); 
% valid if
% a) 400 and 3rd after that is dev1 or dev2
% b) dev1
% c) dev2

    for e = 1:numEvents
        % if this is a relevant event
        if XOnset(e)
            
            if isequal(EVvalue{e},'401') || isequal(EVvalue{e},'402')
                validEvent = 1;
            elseif e+3 < numEvents && isequal(EVvalue{e},'400') && isequal(EVvalue{e+3},'401')
                validEvent = 1;
            elseif e+3 < numEvents && isequal(EVvalue{e},'400') && isequal(EVvalue{e+3},'402')
                validEvent = 1;
            else
                validEvent = 0;
            end
 
            %             % find the offset
            %             nextOffset = e - 1 + find(XOffset(e:end), 1);
            %             if isempty(nextOffset)
            %                 error('Cannot pair offsets with onsets.')
            %             end
            %             % calculate the time between the onset and offset
            %             delta = event(nextOffset).latency_ms - event(e).latency_ms;
            %             % time between must be within 40ms of 500ms
            %             validEvent = abs(delta - 500) < 40;
            %             % and no skipped events
            %             validEvent = validEvent & ~any(XSkipped(e:nextOffset));
            
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