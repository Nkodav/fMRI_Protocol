function [ output_args ] = RunGARPSubject( subjID, item1c, item2c, item3c,...
    item4c, item5c, item6c, item7c, item8c, item9c, item10c, item11c, item12c, ...
    item13c, item14c, item15c, item16c, item17c, item18c, item19c, item20c, ...
    item21c, item22c, item23c, item24c, item25c, item26c, item27c, item28c, ...
    item29c, item30c, item31c, input )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Settings
% Default for subjID is 1. This only kicks in iff no subject ID is given.
if exist('subjID','var') == 0;
    subjID = 1;
end
if exist('input','var') == 0;
    input = 'k';
end

%% Items

items = [item1c item2c item3c item4c item5c item6c item7c item8c item9c item10c ...
    item11c item12c item13c item14c item15c item16c item17c item18c item19c ...
    item20c item21c item22c item23c item24c item25c item26c item27c item28c ...
    item29c item30c item31c];

for i = 1:31;
    v = genvarname(strcat('item', num2str(i)));
    eval([v '= imread(strcat(''Image'', num2str(items(i)), ''.JPG''));']);
end

items = {item1 item2 item3 item4 item5 item6 item7 item8 item9 item10 ...
    item11 item12 item13 item14 item15 item16 item17 item18 item19 ...
    item20 item21 item22 item23 item24 item25 item26 item27 item28 ...
    item29 item30 item31};


%% Set up the screen
screenNumber = max(Screen('Screens'));
[width height] = Screen('WindowSize', screenNumber);
w = Screen('OpenWindow', screenNumber,[],[],[],[]);


%% Load all of the task lists
load('controlSet.mat');
load('scaling2Set.mat');
load('scaling3Set.mat'); 
load('scaling4Set.mat'); 
load('bundling2Set.mat'); 
load('bundling3Set.mat'); 
load('bundling4Set.mat'); 

%% **Design the task orders**
trialOrder = [1 2 4 2 5 3 4 6 5 1];
long = length(trialOrder); %The total number of trials that will be performed
 
controlConditionOrder = [];
i = 1;
while i < 4;
    controlConditionOrder = cat(2,controlConditionOrder,randperm(length(controlSet)));
    i = i + 1;
end

scalingConditionOrder2 = [];
i = 1;
while i < 3;
    scalingConditionOrder2 = cat(2,scalingConditionOrder2,randperm(length(scaling2Set)));
    i = i + 1;
end

scalingConditionOrder3 = [];
i = 1;
while i < 3;
    scalingConditionOrder3 = cat(2,scalingConditionOrder3,randperm(length(scaling3Set)));
    i = i + 1;
end

scalingConditionOrder4 = [];
i = 1;
while i < 3;
    scalingConditionOrder4 = cat(2,scalingConditionOrder4,randperm(length(scaling4Set)));
    i = i + 1;
end

bundlingConditionOrder2 = [];
i = 1;
while i < 3;
    bundlingConditionOrder2 = cat(2,bundlingConditionOrder2,randperm(length(bundling2Set)));
    i = i + 1;
end

bundlingConditionOrder3 = [];
i = 1;
while i < 3;
    bundlingConditionOrder3 = cat(2,bundlingConditionOrder3,randperm(length(bundling3Set)));
    i = i + 1;
end

bundlingConditionOrder4 = [];
i = 1;
while i < 3;
    bundlingConditionOrder4 = cat(2,bundlingConditionOrder4,randperm(length(bundling4Set)));
    i = i + 1;
end

%% Saving the settings

settings.recordfolder = 'records';
settings.subjID = subjID;
settings.trialOrder = trialOrder;
settings.controlSet = controlSet;
settings.controlConditionOrder = controlConditionOrder;
settings.items.item1 = items{1};
settings.items.item2 = items{2};
settings.scaling2Set = scaling2Set;
settings.scalingConditionOrder2 = scalingConditionOrder2;
settings.scaling3Set = scaling3Set;
settings.scalingConditionOrder3 = scalingConditionOrder3;
settings.scaling4Set = scaling4Set;
settings.scalingConditionOrder4 = scalingConditionOrder4;
settings.bundling2Set = bundling2Set;
settings.bundlingConditionOrder2 = bundlingConditionOrder2;
settings.bundling3Set = bundling3Set; 
settings.bundlingConditionOrder3 = bundlingConditionOrder3;
settings.bundling4Set = bundling4Set;
settings.bundlingConditionOrder4 = bundlingConditionOrder4;
settings.screenNumber = screenNumber;
settings.width = width;
settings.height = height;
% if the records folder doesn't exist, create it. 
mkdir(settings.recordfolder);
% create the file name for this run of this subject
recordname = [settings.recordfolder '/' num2str(subjID) '_' datestr(now,'yyyymmddTHHMMSS') '.mat'];
% Save the settings (the results are saved later)
save (recordname, 'settings')


% Display "Please wait. Do not touch anything"
drawStart(w);
Screen('Flip',w);
 while input == 'k';
    [settings.startTime, keyCode, ~] = KbWait(-1, 3);
    if strcmp(KbName(keyCode),'5%');
        break
    end
 end
save (recordname, 'settings');

%%

% Set all of the indeces equal to 1
i = 1;
controlIndex = 1;
scalingIndex2 = 1;
scalingIndex3 = 1;
scalingIndex4 = 1;
bundlingIndex2 = 1;
bundlingIndex3 = 1;
bundlingIndex4 = 1;

while i <= long;
    switch(trialOrder(i));
        case 1 %is for the CONTROL condition
            sprintf('This is case 1')
            itemCode = controlSet(controlConditionOrder(controlIndex));
            v1 = items{itemCode};
            v2 = items{itemCode};
            v3 = items{itemCode};
            v4 = items{itemCode};
            numberItems = 1; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            controlIndex = controlIndex  + 1;
            
        case 2 %is for the SCALING by 2 condition
            sprintf('This is case 2')
            itemCode = scaling2Set(scalingConditionOrder2(scalingIndex2));
            v1 = items{itemCode};
            v2 = items{itemCode};
            v3 = items{itemCode};
            v4 = items{itemCode};
            numberItems = 2; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            scalingIndex2 = scalingIndex2  + 1;
            
        case 3 %is for the SCALING by 3 condition
            sprintf('This is case 3')
            itemCode = scaling3Set(scalingConditionOrder3(scalingIndex3));
            v1 = items{itemCode};
            v2 = items{itemCode};
            v3 = items{itemCode};
            v4 = items{itemCode};
            numberItems = 3; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            scalingIndex3 = scalingIndex3 + 1;
            
        case 4 %is for the SCALING by 4 condition
            sprintf('This is case 4')
            itemCode = scaling4Set(scalingConditionOrder4(scalingIndex4));
            v1 = items{itemCode};
            v2 = items{itemCode};
            v3 = items{itemCode};
            v4 = items{itemCode};
            numberItems = 4; r = 0; s = 0;
            [r,s] =fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            scalingIndex4 = scalingIndex4  + 1;
            
        case 5 %is for the BUNDLING by 2 condition
            sprintf('This is case 5')
            itemCode1 = bundling2Set(bundlingConditionOrder2(bundlingIndex2));
            itemCode2 = bundling2Set(bundlingConditionOrder2(bundlingIndex2),2);
            v1 = items{itemCode1};
            v2 = items{itemCode2};
            v3 = items{itemCode1};
            v4 = items{itemCode2};
            numberItems = 2; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            bundlingIndex2 = bundlingIndex2 + 1;
            
        case 6 %is for the BUNDLING by 3 condition
            sprintf('This is case 6')
            itemCode1 = bundling3Set(bundlingConditionOrder3(bundlingIndex3));
            itemCode2 = bundling3Set(bundlingConditionOrder3(bundlingIndex3),2);
            itemCode3 = bundling3Set(bundlingConditionOrder3(bundlingIndex3),3);
            v1 = items{itemCode1};
            v2 = items{itemCode2};
            v3 = items{itemCode3};
            v4 = items{itemCode1};
            numberItems = 3; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            bundlingIndex3 = bundlingIndex3 + 1;
            
        case 7 %is for the BUNDLING by 4 condition
            itemCode1 = bundling4Set(bundlingConditionOrder4(bundlingIndex4));
            itemCode2 = bundling4Set(bundlingConditionOrder4(bundlingIndex4),2);
            itemCode3 = bundling4Set(bundlingConditionOrder4(bundlingIndex4),3);
            itemCode4 = bundling4Set(bundlingConditionOrder4(bundlingIndex4),4);
            v1 = items{itemCode1};
            v2 = items{itemCode2};
            v3 = items{itemCode3};
            v4 = items{itemCode4};
            numberItems = 4; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            bundlingIndex4 = bundlingIndex4 + 1;         
    end
    
%     if i > 1; % So don't wait on the first lap through
% % first wait .2 seconds so that they have time to stop pressing the button.
% % Then wait until the next cycle of the experiment (2 second interval)
%     oldTime = GetSecs;
%     waitTime = (exprnd(1)*(2-.5))+.5;
%     currentTime = GetSecs;
%     while currentTime < oldTime + waitTime; 
%         currentTime = GetSecs;
%     end
% end

[VBLTimestamp StimulusOnsetTime FlipTimestamp] = Screen('Flip', w);
flipTime = GetSecs;
settings.VBLTimestamp(i) = VBLTimestamp;
settings.StimulusOnsetTime(i) = StimulusOnsetTime;
settings.FlipTimestamp(i) = FlipTimestamp;
save(recordname,'settings');

untilTime = flipTime + 4;

while input == 'k' && GetSecs <= untilTime
    [behavioral.secs(i), keyCode, behavioral.deltaSecs(i)] = KbPressWait(-1,GetSecs>=untilTime);
    if (strcmp(KbName(keyCode),'1!') || strcmp(KbName(keyCode),'2@')) && (s(1)==1);
        behavioral.key(i,1) = '1';
        behavioral.choice(i,1) = 'r';
        break
    elseif (strcmp(KbName(keyCode),'3#') || strcmp(KbName(keyCode),'4$')) && (s(1)==1);
        behavioral.key(i,1) = '3';
        behavioral.choice(i,1) = 'v';
        break
    elseif (strcmp(KbName(keyCode),'1!') || strcmp(KbName(keyCode),'2@')) && (s(1)==2);
        behavioral.key(i,1) = '1';
        behavioral.choice(i,1) = 'v';
        break
    elseif (strcmp(KbName(keyCode),'3#') || strcmp(KbName(keyCode),'4$')) && (s(1)==2);
        behavioral.key(i,1) = '3';
        behavioral.choice(i,1) = 'r';
        break
    end
end

if behavioral.key(i,1) == '1'
    feedbackLogic('1',numberItems,r,s,v1,v2,v3,v4,w);
    Screen('Flip',w);
    WaitSecs(0.5);
elseif behavioral.key(i,1) == '3'
    feedbackLogic('3',numberItems,r,s,v1,v2,v3,v4,w);
    Screen('Flip',w);
    WaitSecs(0.5);
end

%drawFixation
drawFixation(w);
Screen('Flip',w);
WaitSecs(0.5); % here we will plug in pre-specified times from optseq plus
% the time they didn't use from the 4 seconds given to them

i = i + 1;
end

%% at the end
% up at the end of settings we created a file to hold all of our important data
% Now we will save all of the behavioural data in the same -.mat file

save (recordname, 'behavioral', '-append')
drawStop(w);
Screen('Flip',w);
WaitSecs(2);
Screen('CloseAll');
end
