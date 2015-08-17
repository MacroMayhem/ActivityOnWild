function  [decVals] = word2vec_pos_neg(ucfClass,TopSelectedVids,decVals,V2T,VideoID,TagID,TestOrder,word2vecMat)
    hypo_tags = {};
    hypo_tags(1,:) = {'bowling','','','','','','',''};
    hypo_tags(2,:) = {'fencing','fences','fence','','','','',''}; 
    hypo_tags(3,:) = {'horseriding','equestrianism','equestrian','','','','',''};
    hypo_tags(4,:) = {'drumming','drum','drummers','percussion','drums','drummer','guitar','drumset'};
    hypo_tags(5,:) = {'surfing','surf','surfers','surfer','longboarding','longboard','surfboard','surfboarding'};
    
     
    totalVids = size(TestOrder,1);
    maxTags = size(V2T,2);
    maxAddTags = size(word2vecMat,2);
    
    for ip_video=1:totalVids
        
        ip_tagMap = containers.Map;
        ip_allvidCount = zeros(1,maxTags);
        ip_posvidCount = zeros(1,maxTags);
        ip_ID = VideoID(TestOrder{ip_video});
        ip_negvidCount = zeros(1,maxTags);
        
        if isKey(TopSelectedVids,TestOrder{ip_video})
            decVals(ip_video,1) = 0;
            continue;
        end
% %         Make a map of tags and extended tags using word2vec for current video ip
        for ip_tags=1:maxTags
            if V2T(ip_ID,ip_tags) == 0
                break;
            end
            ip_tagMap(char(V2T(ip_ID,ip_tags))) = 1;
            for ip_addTags = 1:maxAddTags
                if word2vecMat(V2T(ip_ID,ip_tags),ip_addTags) == 0
                    break;
                end
                ip_tagMap(char(V2T(ip_ID,ip_tags),ip_addTags)) = 1;
            end
        end
        
% %      For rest of the videos check how many tags of it are common   
        for rest_video=1:totalVids
            if ip_video==rest_video
                continue
            end
            rest_commonTags = 0;
            rest_ID = VideoID(TestOrder{rest_video});
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
            if isKey(TopSelectedVids,TestOrder{rest_video})
                if TopSelectedVids(TestOrder{rest_video}) == 1
                    ip_posvidCount(1,rest_commonTags) = ip_posvidCount(1,rest_commonTags) + 1;
                else
                    ip_negvidCount(1,rest_commonTags) = ip_negvidCount(1,rest_commonTags) + 1;    
                end
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
        if strcmp(hypo_tags{i,1},ucfClass)
            ip_posvidCount(1,tag_common) = ip_posvidCount(1,tag_common) + 1;
        else
            ip_negvidCount(1,tag_common) = ip_negvidCount(1,tag_common) + 1;
        end
    end
    
    [value] = algo_II(decVals(ip_video),ip_posvidCount,ip_allvidCount,ip_negvidCount);
    decVals(ip_video,1) = value;
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
    value = (old_val+1) * (second_val_pos - second_val_neg);
end
