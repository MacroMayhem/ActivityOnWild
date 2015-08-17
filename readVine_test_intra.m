function [TestSet, TestMap, TestLabels,TestOrder] = readVine_test_intra(testFileName,bofDir,UCFClass)
    TestMap = containers.Map;
    TestSet = [];
    TestLabels = [];
    orderCount  = 1;
     allFileListID = fopen(testFileName,'r');
     
     TestOrder = {};
     
     line = fgetl(allFileListID);
     while(ischar(line))
        [fileName, second] = strtok(line,' ');

        line
        TestSet = ReadDesc(strcat(bofDir,fileName),TestSet);
        
        TestMap(fileName) = orderCount;
        TestOrder{orderCount} = fileName;
        trueList = isstrprop(fileName,'alpha');
        className ='';
        counter = 1;
        while trueList(counter) == 1
            className(counter) = fileName(counter);
            counter = counter + 1;
        end
        if strcmp(className,UCFClass)
                    label = str2num(second);
                    if label == 0
                        label = -1;
                    end
        else
                label = -1;
        end
        orderCount = orderCount + 1;
        TestLabels = vertcat(TestLabels, label);
        line = fgetl(allFileListID);
     end
     fclose(allFileListID);
     
end