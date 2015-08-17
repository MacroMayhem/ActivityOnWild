function [allVine] = readVinePos(annDir,vinePosList,vinePosList2,vinePosList3)
allVine = containers.Map;
testFileListID = fopen(strcat(annDir,vinePosList),'r');
fileName = fgetl(testFileListID);

while(ischar(fileName))
        [first second] = strtok(fileName,'.');
        allVine(strcat(first,'.txt')) = 1;
        fileName = fgetl(testFileListID);
end
fclose(testFileListID);

testFileListID = fopen(strcat(annDir,vinePosList2),'r');
fileName = fgetl(testFileListID);

    while(ischar(fileName))
        [first second] = strtok(fileName,'.');
        allVine(strcat(first,'.txt')) = 1;
        fileName = fgetl(testFileListID);
    end
fclose(testFileListID);

testFileListID = fopen(strcat(annDir,vinePosList3),'r');
fileName = fgetl(testFileListID);

    while(ischar(fileName))
        [first second] = strtok(fileName,'.');
        allVine(strcat(first,'.txt')) = 1;
        fileName = fgetl(testFileListID);
    end
fclose(testFileListID);
end