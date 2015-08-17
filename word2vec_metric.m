function  [decVals] = word2vec_metric(TopSelectedVids,decVals,V2T,VideoID,TestOrder,word2vecMat)
%  for every video v1 not in Positive videos
%       for every video v2 in all videos
%           compute(v1,v2) i.e assign v2 to either 1,2,3.. # matches
    
    totalVids = size(TestOrder,1);
    maxTags = size(V2T,2);
    maxAddTags = size(word2vecMat,2);
    
    for ip_video=1:totalVids
        
        ip_tagMap = containers.Map;
        ip_allvidCount = zeros(1,maxTags);
        ip_posvidCount = zeros(1,maxTags);
        ip_ID = VideoID(TestOrder{ip_video});
        
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
                ip_posvidCount(1,rest_commonTags) = ip_posvidCount(1,rest_commonTags) + 1;
            end
        end
        
        
    [value] = algo_I(decVals(ip_video),ip_posvidCount,ip_allvidCount);
    decVals(ip_video,1) = value;
    end
    

end



function [value] = algo_I(old_val,ip_posvidCount,ip_allvidCount,totalTags)
    sz = size(ip_allvidCount,2);
    
    second_val = 0;
    
    for i=1:sz
        if ip_allvidCount(1,i) ~= 0
            second_val = second_val + (i/sz) * (ip_posvidCount(1,i)/ip_allvidCount(1,i));
        end
    end
    value = old_val * second_val;
end
