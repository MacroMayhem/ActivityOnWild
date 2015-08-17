function [TrainVineSet, vineTrainingMap] = readVineTrainingSet(vine_training_list, bofDir)
  TrainVineSet = [];
  vineTrainingMap = containers.Map;
  TestOrder = cell(0,0);
  orderCount = 1;

  allFileListID = fopen(vine_training_list,'r');
  
  fileName = fgetl(allFileListID);
  while(ischar(fileName))
      fileName
        TrainVineSet = ReadDesc(strcat(bofDir,fileName),TrainVineSet);
        vineTrainingMap(fileName) = orderCount;
        orderCount = orderCount + 1;
        fileName = fgetl(allFileListID);
  end
    fclose(allFileListID);
end