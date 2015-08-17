    
function[] = UcfSvmVine()

    UCFClass = 'bowling';
%      Test_Stage_II_IntraClass(UCFClass,'','','','', '','');
%      return;
    [Ac, iterations, vidJump, annDir, bofDir, tagDir, word2vecFile, vinePosList,vinePosList2,vinePosList3, tr_vineAllList, tr_AllTagList, stage_I_thresh] = initStage(UCFClass);
    TopSelectedVids = containers.Map;
    avoidMap = containers.Map;
    [TrainSet, orgTrainLabels] = readTrainingSet(UCFClass,vidJump);
    [T2V, V2T, TagID, VideoID,word2VecMat] = createTagVideoCorrespondance(tr_vineAllList,tr_AllTagList,word2vecFile,tagDir);
    [vinePosMap] = readVinePos(annDir,vinePosList,vinePosList2,vinePosList3);
    
    for iter = 1:iterations
        iter
        [TestSet, TrainLabels, TrainSet, TestOrder, vinePosMap] = readVineSet(orgTrainLabels, TrainSet, TopSelectedVids,avoidMap,tr_vineAllList,vinePosMap,bofDir);
        [TestLabels] = genTestLabels(vinePosMap, TestOrder);
        if iter==1
%             [orig_train_kernel,orig_test_kernel, orig_test_v_test_kernel] = saveBaseKernels(TrainSet,TestSet,Ac);
            [orig_train_kernel,orig_test_kernel, orig_test_v_test_kernel] = loadBaseKernels();
            train_kernel = orig_train_kernel;
            test_kernel = orig_test_kernel;
        else
            [train_kernel test_kernel] = genKernels(orig_train_kernel, orig_test_kernel, orig_test_v_test_kernel, TestOrder, VideoID, TopSelectedVids);
        end
        [decVals] = train_stage_I(train_kernel, test_kernel,TrainLabels,TestLabels);
%         [TopSelectedVids] = SelectPositives(decVals,stage_I_thresh,TopSelectedVids,TestOrder);
%         [tp,fp,tn,fn] = analysePicks(TopSelectedVids, vinePosMap);
        [modVals] = train_stage_II(UCFClass,decVals,TopSelectedVids,word2VecMat,T2V, V2T, VideoID, TagID, TestOrder);
%         stage_II_thresh = max(decVals(:,1))*0.70;
        [TopSelectedVids, avoidMap] = SelectPos_intrainter_Negatives(decVals,modVals,TopSelectedVids,avoidMap,TestOrder)
        [tp,fp,tn,fn] = analysePicks(TopSelectedVids, vinePosMap)
        
        somecount = 0;
        something = keys(avoidMap);
        for i=1:size(something,2)
                if vinePosMap(something{i}) == -1
                        somecount = somecount + 1;
                end
        end
        somecount
    end
    [TestSet, TrainLabels, TrainSet, TestOrder, vinePosMap] = readVineSet(orgTrainLabels, TrainSet, TopSelectedVids,avoidMap,tr_vineAllList,vinePosMap,bofDir);
    [TestLabels] = genTestLabels(vinePosMap, TestOrder);
    [train_kernel test_kernel] = genKernels(orig_train_kernel, orig_test_kernel, orig_test_v_test_kernel, TestOrder, VideoID, TopSelectedVids);
    train_kernel = [(1:size(train_kernel,1))',train_kernel];
    svmModel = svmtrain(TrainLabels, train_kernel, '-t 4 -b 1');
    [tp,fp,tn,fn] = analysePicks(TopSelectedVids, vinePosMap)
    Test_Stage_II_IntraClass(UCFClass,svmModel,TopSelectedVids,VideoID,TagID, word2VecMat,V2T);
%     Test_Stage_II_InterClass(UCFClass,svmModel,TopSelectedVids);
    
end





