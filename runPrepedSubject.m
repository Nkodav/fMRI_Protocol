function [ output_args ] = runPrepedSubject( subjID, j, input)
%% Load Everything




load(strcat('Run',num2str(j),'.mat')); % load the optseq output
% "cond" is the variable containing the trial order, given from optseq


%% Setting up the Run

trialOrder = zeros(1,length(condition));

for i = 1:length(trialOrder);
    if condition(i) == 0
            trialOrder(i) = 1;
    end
    if condition(i) == 1
            trialOrder(i) = controlConditionOrder(cIndex);
            cIndex = cIndex + 1;
    end
    if condition(i) == 2
            trialOrder(i) = scalingConditionOrder(sIndex);
            sIndex = sIndex + 1;
    end
    if condition(i) == 3
            trialOrder(i) = bundlingConditionOrder(bIndex);
            bIndex = bIndex + 1;
    end
end

%% Set up the screen
screenNumber = max(Screen('Screens'));
[width height] = Screen('WindowSize', screenNumber);

w = Screen('OpenWindow', screenNumber,[],[],[],[]);

% Display "Please wait. Do not touch anything"
drawStart(w);
Screen('Flip',w);
 
% James' code for scanner cue 
     key = 0;
while key ~= '5'
    [keyisdown, StartSecs, keycode] = KbCheck();
    if keyisdown
        key = KbName(keycode);  
    end
end 
UT = GetSecs;