function [ output_args ] = NRunGARPSubject( subjID, j, item1c, item2c, item3c,...
    item4c, item5c, item6c, item7c, item8c, item9c, item10c, item11c, item12c, ...
    item13c, item14c, item15c, item16c, item17c, item18c, item19c, item20c, ...
    item21c,input)
%% This is for 21 goods and 5 fMRI runs

%% If not running on actual subject, use the following to test out script
% item1c = 1; item2c = 2; item3c = 3;
% item4c = 4; item5c = 5; item6c = 6;
% item7c = 7; item8c = 8; item9c = 9;
% item10c = 10; item11c = 11; item12c = 12;
% item13c = 13; item14c = 14; item15c= 15;
% item16c = 16; item17c= 17; item18c = 18;
% item19c = 19; item20c = 20; item21c = 21;
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
    item20c item21c];

for i = 1:21;
    v = genvarname(strcat('item', num2str(i)));
    eval([v '= imread(strcat(''Image'', num2str(items(i)), ''.jpg''));']);
end

items = {item1 item2 item3 item4 item5 item6 item7 item8 item9 item10 ...
    item11 item12 item13 item14 item15 item16 item17 item18 item19 ...
    item20 item21};


%% Set up the screen
screenNumber = max(Screen('Screens'));
[width height] = Screen('WindowSize', screenNumber);


%% Load all of the task lists
load('Ncontrol1Set.mat');
load('Ncontrol2Set.mat');
load('Nscaling2Set.mat');
load('Nscaling3Set.mat'); 
load('Nscaling4Set.mat'); 
load('Nbundling2Set.mat'); 
load('Nbundling3Set.mat'); 
load('Nbundling4Set.mat'); 

%% **Design the task orders**
% numberRuns = 5; %we will be doing 5 unique runs, totalling 270 trials of three different conditions: CONTROL, SCALING, and BUNDLING (as well as NULL)
cIndex = 1;
sIndex = 1;
bIndex = 1;
% Hangover = 0;

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
%%
control1 = 2*(ones(1,50));  % later referred to as "case 2"
control2 = 3*(ones(1,40));  % later referred to as "case 3"
control1and2 = cat(2,control1, control2); 
controlConditionOrder = Shuffle(control1and2); 

scaling2 = 4*(ones(1,30));  % later referred to as "case 4"
scaling3 = 5*(ones(1,30));  % later referred to as "case 5"
scaling4 = 6*(ones(1,30));  % later referred to as "case 6"
scaling2and3and4 = cat(2,scaling2,scaling3,scaling4);
scalingConditionOrder = Shuffle(scaling2and3and4);

bundling2 = 7*ones(1,30);   % later referred to as "case 7"
bundling3 = 8*(ones(1,30)); % later referred to as "case 8"
bundling4 = 9*(ones(1,30)); % later referred to as "case 9"
bundling2and3and4 = cat(2,bundling2,bundling3,bundling4);
bundlingConditionOrder = Shuffle(bundling2and3and4);

load(strcat('Run',num2str(j),'.mat')); % load the optseq output
% "cond" is the variable containing the trial order, given from optseq

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

controlConditionOrder1 = [];
i = 1;
while i < 6;
    controlConditionOrder1 = cat(2,controlConditionOrder1,randperm(length(Ncontrol1Set)));
    i = i + 1;
end

controlConditionOrder2 = [];
i = 1;
while i < 5; 
    controlConditionOrder2 = cat(2,controlConditionOrder2,randperm(length(Ncontrol2Set)));
    i = i + 1;
end

scalingConditionOrder2 = [];
i = 1;
while i < 4;
    scalingConditionOrder2 = cat(2,scalingConditionOrder2,randperm(length(Nscaling2Set)));
    i = i + 1;
end

scalingConditionOrder3 = [];
i = 1;
while i < 4;
    scalingConditionOrder3 = cat(2,scalingConditionOrder3,randperm(length(Nscaling3Set)));
    i = i + 1;
end

scalingConditionOrder4 = [];
i = 1;
while i < 4;
    scalingConditionOrder4 = cat(2,scalingConditionOrder4,randperm(length(Nscaling4Set)));
    i = i + 1;
end

bundlingConditionOrder2 = [];
i = 1;
while i < 4;
    bundlingConditionOrder2 = cat(2,bundlingConditionOrder2,randperm(length(Nbundling2Set)));
    i = i + 1;
end

bundlingConditionOrder3 = [];
i = 1;
while i < 4;
    bundlingConditionOrder3 = cat(2,bundlingConditionOrder3,randperm(length(Nbundling3Set)));
    i = i + 1;
end

bundlingConditionOrder4 = [];
i = 1;
while i < 4;
    bundlingConditionOrder4 = cat(2,bundlingConditionOrder4,randperm(length(Nbundling4Set)));
    i = i + 1;
end

%% Saving the settings

% these are the same across all runs, so no need to save them under that run's name in the settings file
settings.recordfolder = 'records';
settings.subjID = subjID;
settings.items.item1 = items{1}; settings.items.item2 = items{2};
settings.items.item3 = items{3}; settings.items.item4 = items{4};
settings.items.item5 = items{5}; settings.items.item6 = items{6};
settings.items.item7 = items{7}; settings.items.item8 = items{8};
settings.items.item9 = items{9}; settings.items.item10 = items{10};
settings.items.item11 = items{11}; settings.items.item12 = items{12};
settings.items.item13 = items{13}; settings.items.item14 = items{14};
settings.items.item15 = items{15}; settings.items.item16 = items{16};
settings.items.item17 = items{17}; settings.items.item18 = items{18};
settings.items.item19 = items{19}; settings.items.item20 = items{20};
settings.items.item21 = items{21};
settings.controlConditionOrder1 = controlConditionOrder1;
settings.controlConditionOrder2 = controlConditionOrder2;
settings.scalingConditionOrder2 = scalingConditionOrder2;
settings.scalingConditionOrder3 = scalingConditionOrder3;
settings.scalingConditionOrder4 = scalingConditionOrder4;
settings.bundlingConditionOrder2 = bundlingConditionOrder2;
settings.bundlingConditionOrder3 = bundlingConditionOrder3;
settings.bundlingConditionOrder4 = bundlingConditionOrder4;
settings.UT = UT;
settings.controlSet = Ncontrol1Set;
settings.control2Set = Ncontrol2Set;
settings.scaling2Set = Nscaling2Set;
settings.scaling3Set = Nscaling3Set;
settings.scaling4Set = Nscaling4Set;
settings.bundling2Set = Nbundling2Set;
settings.bundling3Set = Nbundling3Set; 
settings.bundling4Set = Nbundling4Set;
settings.trialOrder   = trialOrder;
settings.screenNumber = screenNumber;
settings.width = width;
settings.height = height;


% if the records folder doesn't exist, create it. 
mkdir(settings.recordfolder);
% create the file name for this run of this subject
recordname = [settings.recordfolder '/' num2str(subjID) '_' num2str(j) '_' datestr(now,'yyyymmddTHHMMSS') '.mat'];
textFileName = [settings.recordfolder '/' num2str(subjID) '_' num2str(j) '_' datestr(now,'yyyymmddTHHMMSS') '.txt'];
% Save the settings (the results are saved later)
save (recordname, 'settings')
fileID = fopen(textFileName, 'w');


%%
long = length(trialOrder);

% Set all of the indeces equal to 1
i = 1;
controlIndex1 = 1;
controlIndex2 = 1;
scalingIndex2 = 1;
scalingIndex3 = 1;
scalingIndex4 = 1;
bundlingIndex2 = 1;
bundlingIndex3 = 1;
bundlingIndex4 = 1;

feedbackTime = 0.25;

whenTime = zeros(length(time),1);
for k = 1:(length(time))
    whenTime(k,1) = UT + 10 + time(k);
end

% whenTime(length(time)+1,1) = UT + j*10 + 324 + time(k);

RestrictKeysForKbCheck([30, 31, 32, 33]); % these are the keycodes for 1,2,3,4 on a Mac

while i <= long;
    switch trialOrder(i);
        case 1 %is for the NULL condition
            caseNumber = 1;
            setNumber = 0;
            drawFixation(w);
            
        case 2 %is for the CONTROL condition (1st half: 5 reps)
            caseNumber = 2;
            setNumber = controlConditionOrder1(controlIndex1);
            itemCode = Ncontrol1Set(controlConditionOrder1(controlIndex1));
            v1 = items{itemCode};
            v2 = items{itemCode};
            v3 = items{itemCode};
            v4 = items{itemCode};
            numberItems = 1; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            controlIndex1 = controlIndex1  + 1;
            
        
        case 3 %is for the CONTROL condition (2nd half: 4 reps)
            caseNumber = 3;
            setNumber = controlConditionOrder2(controlIndex2);
            itemCode = Ncontrol2Set(controlConditionOrder2(controlIndex2));
            v1 = items{itemCode};
            v2 = items{itemCode};
            v3 = items{itemCode};
            v4 = items{itemCode};
            numberItems = 1; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            controlIndex2 = controlIndex2  + 1;

        case 4 %is for the SCALING by 2 condition
            caseNumber = 4;
            setNumber = scalingConditionOrder2(scalingIndex2);
            itemCode = Nscaling2Set(scalingConditionOrder2(scalingIndex2),1);
            v1 = items{itemCode};
            v2 = items{itemCode};
            v3 = items{itemCode};
            v4 = items{itemCode};
            numberItems = 2; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            scalingIndex2 = scalingIndex2  + 1;
        
        case 5 %is for the SCALING by 3 condition
            caseNumber = 5;
            setNumber = scalingConditionOrder3(scalingIndex3);
            itemCode = Nscaling3Set(scalingConditionOrder3(scalingIndex3),1);
            v1 = items{itemCode};
            v2 = items{itemCode};
            v3 = items{itemCode};
            v4 = items{itemCode};
            numberItems = 3; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            scalingIndex3 = scalingIndex3 + 1;
        
        case 6 %is for the SCALING by 4 condition
            caseNumber = 6;
            setNumber = scalingConditionOrder4(scalingIndex4);
            itemCode = Nscaling4Set(scalingConditionOrder4(scalingIndex4),1);
            v1 = items{itemCode};
            v2 = items{itemCode};
            v3 = items{itemCode};
            v4 = items{itemCode};
            numberItems = 4; r = 0; s = 0;
            [r,s] =fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            scalingIndex4 = scalingIndex4  + 1;
        
        case 7 %is for the BUNDLING by 2 condition
            caseNumber = 7;
            setNumber = bundlingConditionOrder2(bundlingIndex2);
            itemCode1 = Nbundling2Set(bundlingConditionOrder2(bundlingIndex2),1);
            itemCode2 = Nbundling2Set(bundlingConditionOrder2(bundlingIndex2),2);
            v1 = items{itemCode1};
            v2 = items{itemCode2};
            v3 = items{itemCode1};
            v4 = items{itemCode2};
            numberItems = 2; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            bundlingIndex2 = bundlingIndex2 + 1;
        
        case 8 %is for the BUNDLING by 3 condition
            caseNumber = 8;
            setNumber = bundlingConditionOrder3(bundlingIndex3);
            itemCode1 = Nbundling3Set(bundlingConditionOrder3(bundlingIndex3),1);
            itemCode2 = Nbundling3Set(bundlingConditionOrder3(bundlingIndex3),2);
            itemCode3 = Nbundling3Set(bundlingConditionOrder3(bundlingIndex3),3);
            v1 = items{itemCode1};
            v2 = items{itemCode2};
            v3 = items{itemCode3};
            v4 = items{itemCode1};
            numberItems = 3; r = 0; s = 0;
            [r,s] = fourSquaresLogic(numberItems,r,s, v1, v2, v3, v4, w);
            settings.itemLocation(i,1:4) = r;
            settings.cueLocation(i,1:2) = s;
            bundlingIndex3 = bundlingIndex3 + 1;
        
        case 9 %is for the BUNDLING by 4 condition
            caseNumber = 9;
            setNumber = bundlingConditionOrder4(bundlingIndex4);
            itemCode1 = Nbundling4Set(bundlingConditionOrder4(bundlingIndex4),1);
            itemCode2 = Nbundling4Set(bundlingConditionOrder4(bundlingIndex4),2);
            itemCode3 = Nbundling4Set(bundlingConditionOrder4(bundlingIndex4),3);
            itemCode4 = Nbundling4Set(bundlingConditionOrder4(bundlingIndex4),4);
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
    fprintf(fileID,'%d\t%d\t',caseNumber,setNumber);

    [VBLTimestamp, StimulusOnsetTime, FlipTimestamp] = Screen('Flip', w, whenTime(i,1));
    settings.VBLTimestamp(i) = VBLTimestamp;
    settings.StimulusOnsetTime(i) = StimulusOnsetTime;
    settings.FlipTimestamp(i) = FlipTimestamp;
    
    if trialOrder(i) == 1  % if the condition is the NULL condition (i.e. fixation cross), then show keep the fixation cross displayed for the amount of time, specified by variable "isi" -- an optseq output
        WaitSecs(isi(i))
        behavioral.secs(i) = whenTime(i,1)+isi(i);
    elseif trialOrder(i) > 1 % for all conditions except for the NULL, 
                             % keep display on screen until subject presses
                             % button or 4 seconds is up (whichever happens 
                             % first) and record button press in the former case   
        [behavioral.secs(i), keyCode, behavioral.deltaSecs(i)] = KbWait(-1,0,(whenTime(i,1)+4));
        if(strcmp(KbName(keyCode),'1!') || strcmp(KbName(keyCode),'2@')) && (s(1)==1);
            behavioral.key(i,1) = '1';
            behavioral.choice(i,1) = 'r';
            feedbackLogic('1',numberItems,r,s,v1,v2,v3,v4,w);
            Screen('Flip',w);
            drawFixation(w);
            Screen('Flip',w,behavioral.secs(i)+feedbackTime);
        elseif (strcmp(KbName(keyCode),'3#') || strcmp(KbName(keyCode),'4$')) && (s(1)==1);
            behavioral.key(i,1) = '3';
            behavioral.choice(i,1) = 'v';
            feedbackLogic('3',numberItems,r,s,v1,v2,v3,v4,w);            
            Screen('Flip',w);
            drawFixation(w);
            Screen('Flip',w,behavioral.secs(i)+feedbackTime);
        elseif (strcmp(KbName(keyCode),'1!') || strcmp(KbName(keyCode),'2@')) && (s(1)==2);
            behavioral.key(i,1) = '1';
            behavioral.choice(i,1) = 'v';
            feedbackLogic('1',numberItems,r,s,v1,v2,v3,v4,w);
            Screen('Flip',w);
            drawFixation(w);
            Screen('Flip',w,behavioral.secs(i)+feedbackTime);
        elseif (strcmp(KbName(keyCode),'3#') || strcmp(KbName(keyCode),'4$')) && (s(1)==2);
            behavioral.key(i,1) = '3';
            behavioral.choice(i,1) = 'r';
            feedbackLogic('3',numberItems,r,s,v1,v2,v3,v4,w);
            Screen('Flip',w);
            drawFixation(w);
            Screen('Flip',w,behavioral.secs(i)+feedbackTime);
        else
            drawFixation(w);
            Screen('Flip',w);
            behavioral.key(i,1) = 0;
            behavioral.choice(i,1) = 'n';
        end
        
    end
    fprintf(fileID,'%f\t%f\n',StimulusOnsetTime,behavioral.secs(i));
    
    
    i = i + 1;
    
end

%% at the end
drawStop(w);
Screen('Flip',w);
save (recordname, 'settings');
save (recordname, 'behavioral', '-append');
fclose(fileID);
Screen('CloseAll');
clear all;
end
