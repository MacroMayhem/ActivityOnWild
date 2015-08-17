function[TestSet, TrainLabels, TrainSet, TestOrder, allVine] = readVineSet(orgTrainLabels, TrainSet, TopSelectedVids,avoidMap,vineAllList,allVine,bofDir)
% %  Read Test Labels. Positives&Negatives
  TrainLabels = orgTrainLabels;
  TestSet = [];

  TestOrder = cell(0,0);
  orderCount = 1;
  randomCount = 1;

  allFileListID = fopen(vineAllList,'r');
  fileName = fgetl(allFileListID);
  while(ischar(fileName))
    if ~isKey(allVine,fileName)
       allVine(fileName) = 0; 
    end
    if isKey(avoidMap,fileName)
        fileName = fgetl(allFileListID);
        continue;
    end
    
    if(mod(randomCount,25)~=0)
        randomCount = randomCount + 1;
        fileName = fgetl(allFileListID);
        continue;
    end
    
        randomCount = randomCount + 1;
    if isKey(TopSelectedVids,fileName)
         TrainSet = ReadDesc(strcat(bofDir,fileName),TrainSet);
         TrainLabels = vertcat(TrainLabels, TopSelectedVids(fileName));
    else
        TestSet = ReadDesc(strcat(bofDir,fileName),TestSet);
%         currVidID(fileName) = orderCount;
        TestOrder{orderCount,1} = fileName;
        orderCount = orderCount + 1;
    end
        fileName = fgetl(allFileListID);
  end
    fclose(allFileListID);
end