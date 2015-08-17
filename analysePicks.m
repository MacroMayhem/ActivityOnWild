function [tp,fp,tn,fn] = analysePicks(TopSelectedVids, vinePosMap)
    picks = keys(TopSelectedVids);
    sz = size(picks,2);
    tp = 0;
    fp = 0;
    fn = 0;
    tn = 0;
    for i=1:sz
    if vinePosMap(char(picks(i))) == 1 && isKey(TopSelectedVids,char(picks(i)))
        if TopSelectedVids(char(picks(i))) == 1
            tp = tp + 1;
        else
            if TopSelectedVids(char(picks(i))) == -1
                fn = fn + 1;
                strcat('false NEG: ',picks(i))
            end
        end
    end
    
    
    if vinePosMap(char(picks(i))) == -1 && isKey(TopSelectedVids,char(picks(i)))
        if TopSelectedVids(char(picks(i))) == -1
            tn = tn + 1;
        else
            if TopSelectedVids(char(picks(i))) == 1
                fp = fp + 1;
                strcat('false POS:',picks(i))
            end
        end
    end
    end
end

