function[decVals,modVals] = inter_intra_OverallScore(ucfClass,TopSelectedVids,decVals,V2T,VideoID,TagID,testOrder,word2vecMat,annDir)
    hypo_tags = {};
    hypo_tags(1,:) = {'bowling','','','','','','',''};
    hypo_tags(2,:) = {'fencing','fences','fence','','','','',''}; 
    hypo_tags(3,:) = {'horseriding','equestrianism','equestrian','','','','',''};
    hypo_tags(4,:) = {'drumming','drum','drummers','percussion','drums','drummer','guitar','drumset'};
    hypo_tags(5,:) = {'surfing','surf','surfers','surfer','longboarding','longboard','surfboard','surfboarding'};

    totalVids = size(testOrder,2);
    maxTags = size(V2T,2);
    maxAddTags = size(word2vecMat,2);
    baseList = keys(TopSelectedVids);
    baseSize = size(baseList,2);
    modVals = zeros(size(decVals,1),3);
    
    for ip_video=1:totalVids
        ip_tagMap = containers.Map;
        ip_allvidCount = zeros(1,maxTags);
        ip_posvidCount = zeros(1,maxTags);
        ip_negvidCount = zeros(1,maxTags);
        
        f = fopen(strcat(annDir,testOrder{ip_video}));
        
        tag = fgetl(f);
        while(ischar(tag))
            ip_tagMap(char(TagID(tag))) = 1;
            for addTag = 1:maxAddTags
                if word2vecMat(TagID(tag),addTag) == 0
                    break;
                end
                ip_tagMap(char(word2vecMat(TagID(tag),addTag))) = 1;
            end
            tag = fgetl(f);
        end
        
        for b_video = 1: baseSize
            rest_commonTags = 0;
            rest_ID = VideoID(baseList{b_video});
            for rest_tags = 1:maxTags
                if V2T(rest_ID,rest_tags) == 0
                    break;
                end
                if isKey(ip_tagMap,char(V2T(rest_ID,rest_tags)))
                    rest_commonTags = rest_commonTags + 1;
                end
            end
            if rest_commonTags == 0
                continue;
            end
            ip_allvidCount(1,rest_commonTags) = ip_allvidCount(1,rest_commonTags) + 1; 
            if TopSelectedVids(baseList{b_video}) == 1
                ip_posvidCount(1,rest_commonTags) = ip_posvidCount(1,rest_commonTags) + 1;
            else
                ip_negvidCount(1,rest_commonTags) = ip_negvidCount(1,rest_commonTags) + 1;    
            end
        end
        [c_row, c_col] = size(hypo_tags);
    
        for i=1:c_row
            tag_common = 0;
            for j=1:c_col
                if size(hypo_tags{i,j},2) == 0
                    break;
                end
                if isKey(ip_tagMap,char(TagID(hypo_tags{i,j})))
                        tag_common = tag_common + 1;
                end
            end
            if tag_common == 0
                continue
            end
            ip_allvidCount(1,tag_common) = ip_allvidCount(1,tag_common) + 1; 
            if strcmp(hypo_tags{i,1},ucfClass)
                ip_posvidCount(1,tag_common) = ip_posvidCount(1,tag_common) + 1;
            else
                ip_negvidCount(1,tag_common) = ip_negvidCount(1,tag_common) + 1;
            end
        end
    
        [value] = algo_II(decVals(ip_video),ip_posvidCount,ip_allvidCount,ip_negvidCount);

        a = 0.6;
        b = 0.4;
        modVals(ip_video,1) = (1+(1-decVals(ip_video,2)))*value;
        modVals(ip_video,2) = (1+(1-decVals(ip_video,2)))*value;
        modVals(ip_video,3) = (1+decVals(ip_video,2))*value;
    end
end

function [value] = algo_II(old_val,ip_posvidCount,ip_allvidCount,ip_negvidCount)
    sz = size(ip_allvidCount,2);
    
    second_val_pos = 0;
    second_val_neg = 0;
    
    for i=1:sz
        if ip_allvidCount(1,i) ~= 0
            second_val_pos = second_val_pos + (i/sz) * (ip_posvidCount(1,i)/ip_allvidCount(1,i));
            second_val_neg = second_val_neg + (i/sz) * (ip_negvidCount(1,i)/ip_allvidCount(1,i));
        end
    end
    value = (second_val_pos - second_val_neg);
end