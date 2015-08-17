function[TopSelectedVids] = SelectPositives(decVals,Thresh,TopSelectedVids,TestOrder)
for i = 1:size(decVals,1)
    if decVals(i,1) > Thresh
        TopSelectedVids(char(TestOrder{i})) = 1;
    end
end
end