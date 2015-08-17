function [] = Test_Stage_II_IntraClass(UCFClass,svmModel,topSelectedVids,VideoID,TagID, word2vecMat,V2T)
    
    [testFileName, train_kernel_name, vine_kernel_name, Ac, vidJump, bofDir,tagDir,tr_VineList] = initStage_II_intra(UCFClass);
    [TrainBaseSet,TrainLabels] = readTrainingSet(UCFClass,vidJump);
    [TrainVineSet, vineTrainingMap] = readVineTrainingSet(tr_VineList,bofDir);   
    [TestSet, TestMap, TestLabels, TestOrder] = readVine_test_intra(testFileName,bofDir,UCFClass);
    
    saveStageII_intra_kernels(TrainBaseSet, TrainVineSet,TestSet,Ac,UCFClass);
    [train_kernel, vine_kernel] = loadStageII_kernels(train_kernel_name,vine_kernel_name);
    [test_kernel] = Gen_TEST_kernel(train_kernel,vine_kernel,vineTrainingMap,topSelectedVids);
    
    test_kernel =  [(1:size(test_kernel,1))' ,test_kernel];
    [predClass, acc, decVals] = svmpredict(TestLabels, test_kernel, svmModel,'-b 1');
    [C, order] = confusionmat(TestLabels,predClass)
    
    [decVals,modVals] = inter_intra_OverallScore(UCFClass,topSelectedVids,decVals,V2T,VideoID,TagID,TestOrder,word2vecMat,tagDir)
    
    [Vals, idx] = sort(modVals(:,1),'descend');
    agg = zeros(size(modVals));
    agg(:,1) = Vals(:,1);
    minagg = min(agg(:,1));
    for i=1:size(idx,1)
        agg(i,2) = TestLabels(idx(i,1));
        if agg(i,1) > 2*minagg
            agg(i,1),agg(i,2)
        end
    end
    
    
end