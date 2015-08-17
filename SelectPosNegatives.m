function[TopSelectedVids] = SelectPosNegatives(decVals,TopSelectedVids,TestOrder)
topK = 7;
[sortvals, sortidx] = sort(decVals(:,1),'descend');
    for i = 1:topK
        TopSelectedVids(char(TestOrder{sortidx(i)})) = 1;
    end

[sortvals, sortidx] = sort(decVals(:,1),'ascend');
    for i = 1:topK
        TopSelectedVids(char(TestOrder{sortidx(i)})) = -1;
    end
    
end