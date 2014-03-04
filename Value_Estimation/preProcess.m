function [ output_args ] = preProcess( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% cd ('/Users/Dalton/Documents/MATLAB/GARP/GARP/PrePilot/records');

% if running for YA
cd('C:/Users/Niree/Documents/GitHub/fMRI_Protocol/records');

subjects = dir;             % count all of the subjects in the folder
for i = 1:length(subjects)  %make sure that you're looking at a subject folder
    if subjects(i).name(1) == '.';
        continue
    end
    load(subjects(i).name);
    cd ('C:/Users/Niree/Documents/GitHub/fMRI_Protocol/preProcessed');
    R = rem(i-2,5);
    if R == 0
        runNumber = 5;
    elseif R > 0
        runNumber = R;
    end
    folderName = cat(2,num2str(settings.subjID),num2str(runNumber));
    if folderName
    switch length(folderName)
        case 1
            mkdir(['00' folderName]);
            cd(['00' folderName]);
        case 2
            mkdir(['0' folderName]);
            cd(['0' folderName])
        case 3
            mkdir(folderName);
            cd(folderName);
        case 4 
            mkdir(folderName);
            cd(folderName);
    end
    
    %% Unshuffle the choices, and corresponding response times, and make sure the that they get paired to the right trials
    c1Index=1; %control condition 1 (top half of list)
    c2Index=1; %control condition 2 (bottom half of list)
    s2Index=1; %scaling X 2
    s3Index=1; %scaling X 3
    s4Index=1; %scaling X 4
    
    for tn=1 : length(settings.trialOrder)
        switch settings.trialOrder(tn)
            case 1 %do nothing
                preProcessed.value(tn,1:3) = 0;
            case 2
                itemID = settings.controlConditionOrder1(c1Index);
                item = settings.controlSet(itemID);
                preProcessed.value(tn,1) = item;
                preProcessed.value(tn,2) = 1;
                if behavioral.choice(tn) == 'r'
                    preProcessed.value(tn,3) = 0;
                elseif behavioral.choice(tn) == 'v'
                    preProcessed.value(tn,3) = 1;
                end
                c1Index = c1Index + 1;
            case 3
                itemID = settings.controlConditionOrder2(c2Index);
                item = settings.control2Set(itemID);
                preProcessed.value(tn,1) = item;
                preProcessed.value(tn,2) = 1;
                if behavioral.choice(tn) == 'r'
                    preProcessed.value(tn,3) = 0;
                elseif behavioral.choice(tn) == 'v'
                    preProcessed.value(tn,3) = 1;
                end
                c2Index = c2Index + 1;
            case 4
                itemID = settings.scalingConditionOrder2(s2Index);
                item = settings.scaling2Set(itemID);
                preProcessed.value(tn,1) = item;
                preProcessed.value(tn,2) = 2;
                if behavioral.choice(tn) == 'r'
                    preProcessed.value(tn,3) = 0;
                elseif behavioral.choice(tn) == 'v'
                    preProcessed.value(tn,3) = 1;
                end
                s2Index = s2Index + 1;
            case 5
                itemID = settings.scalingConditionOrder3(s3Index);
                item = settings.scaling3Set(itemID);
                preProcessed.value(tn,1) = item;
                preProcessed.value(tn,2) = 3;
                if behavioral.choice(tn) == 'r'
                    preProcessed.value(tn,3) = 0;
                elseif behavioral.choice(tn) == 'v'
                    preProcessed.value(tn,3) = 1;
                end
                s3Index = s3Index + 1;
            case 6
                itemID = settings.scalingConditionOrder4(s4Index);
                item = settings.scaling4Set(itemID);
                preProcessed.value(tn,1) = item;
                preProcessed.value(tn,2) = 4;
                if behavioral.choice(tn) == 'r'
                    preProcessed.value(tn,3) = 0;
                elseif behavioral.choice(tn) == 'v'
                    preProcessed.value(tn,3) = 1;
                end
                s4Index = s4Index + 1;
            case 7 %do nothing
                preProcessed.value(tn,1:3) = 0;
                
            case 8 %do nothing
                preProcessed.value(tn,1:3) = 0;
                
            case 9 %do nothing
                preProcessed.value(tn,1:3) = 0;
                
        end
    end
    save('value.mat','preProcessed')
end



%Right before the end of the loop
cd('C:/Users/Niree/Documents/GitHub/fMRI_Protocol/records');
clearvars -except i subjects
%End of the loop

end



