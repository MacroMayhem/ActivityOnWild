
% % % % % %  READ THE BASE DATASET CLASSES 
function [TrainSet, TrainLabels] = readTrainingSet(UCFClass, vidJump)        
        
        TrainSet = [];
        TrainLabels = [];
        
        allowedClasses = containers.Map;
        allowedClasses('bowling') = 0;
        allowedClasses('drumming') = 0;
        allowedClasses('fencing') = 0;
        allowedClasses('horseriding') = 0;
        allowedClasses('surfing') = 0;
        allowedClasses(UCFClass) = 1;
        
        TrainDir='ucf_101_BOF/';
        UCFTrainList='ucfTrainList.txt';
        
        randomCount = 0;
        
        trainFileListID = fopen(UCFTrainList,'r');
        fileName = fgetl(trainFileListID);
        rand_nos = 0;
        
         while(ischar(fileName))
             
            [first second] = strtok(fileName,'_');
            [className second] = strtok(second,'_');
            if ~isKey(allowedClasses,lower(className))
                fileName = fgetl(trainFileListID);
                continue;
            end
            
            if mod(randomCount,5) ~= 0
                fileName = fgetl(trainFileListID);
                randomCount = randomCount + 1;
                continue;
            end
            randomCount = randomCount + 1;
            labelVal = allowedClasses(lower(className));
            fileName
            if labelVal == 1
                TrainSet = ReadDesc(strcat(TrainDir,fileName),TrainSet);
                TrainLabels = vertcat(TrainLabels, 1);
            else
                TrainSet = ReadDesc(strcat(TrainDir,fileName),TrainSet);
                TrainLabels = vertcat(TrainLabels, 0);
            end
                fileName = fgetl(trainFileListID);
         end
         fclose(trainFileListID);
end

