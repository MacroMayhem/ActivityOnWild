function[TopSelectedVids, avoidMap] = SelectPos_intrainter_Negatives(decVals,modVals,TopSelectedVids,avoidMap,TestOrder)
topK = 10;
correctCount = 0;

[sortvals, sortidx] = sort(modVals(:,3),'descend');
    for i = 1:topK/2
        avoidMap(char(TestOrder{sortidx(i)})) = 1;
    end

[sortvals, sortidx] = sort(modVals(:,2),'ascend');
    for i = 1:topK
        TopSelectedVids(char(TestOrder{sortidx(i)})) = -1;
    end
 
  count = 1;
 [sortvals, sortidx] = sort(modVals(:,1),'descend');
    for i = 1:3*topK
        if count == topK+1
            break;
        end
        if isKey(avoidMap,TestOrder{sortidx(i)})
            continue
        end
        TopSelectedVids(char(TestOrder{sortidx(i)})) = 1;
        count = count+1;
    end
end