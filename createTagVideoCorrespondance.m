function [T2V, V2T, TagID, VideoID,word2VecMat] = createTagVideoCorrespondance(allVineList,allTagList,word2vecFile,TagDir)

    [VideoID] = assignVineID(allVineList);
    [TagID] = assignVineID(allTagList);
    
    [word2VecMat] = create_word2vec_Mat(word2vecFile,TagID);
    
    T2V = zeros(size(TagID,1),1);
    V2T = zeros(size(VideoID,1),1);
    T2V(:) = -1;
    V2T(:) = -1; 
    
    TagCount4Video = containers.Map;
    VideoCount4Tag = containers.Map;
    
    VineAllID = fopen(allVineList,'r');
    fileName = fgetl(VineAllID);
    
    videoNos = 1;
    tagNos = 1;
    
    while(ischar(fileName))
        currFileID = fopen(strcat(TagDir,fileName),'r');
        currTag = fgetl(currFileID);
        if ~isKey(TagCount4Video,fileName)
            TagCount4Video(fileName) = 0;
        end
        while(ischar(currTag))
            if ~isKey(VideoCount4Tag,currTag)
                VideoCount4Tag(currTag) = 0;
            end
            VideoCount4Tag(currTag) = VideoCount4Tag(currTag) + 1;
            T2V(TagID(currTag),VideoCount4Tag(currTag)) = VideoID(fileName);
            
            TagCount4Video(fileName) = TagCount4Video(fileName) + 1;
            V2T(VideoID(fileName),TagCount4Video(fileName)) = TagID(currTag);
            currTag = fgetl(currFileID);
        end
        fclose(currFileID);
        fileName = fgetl(VineAllID);
    end
  fclose(VineAllID);
end
function [someID] = assignVineID(fileName)
    someID = containers.Map;
    fileID = fopen(fileName,'r');
    line = fgetl(fileID);
    idNos = 1;
    while(ischar(line))
        someID(line) = idNos;
        idNos = idNos + 1;
        line = fgetl(fileID);
    end
end

function [word2vecMat] = create_word2vec_Mat(word2vecFile,TagID)
    word2vecMat = [];
    
    fileID = fopen(word2vecFile,'r');
    line = fgetl(fileID);
    
    while(ischar(line))
        [first line] = strtok(line,' ');
        rowNos = TagID(first);
        colNos = 1;
        while ~isempty(line) && ~strcmp(line,' ')
            [first line] = strtok(line,' ');
            colVal = TagID(first);
            word2vecMat(rowNos,colNos) = colVal;
            colNos = colNos + 1;
        end
        line = fgetl(fileID);
    end
    
    
end