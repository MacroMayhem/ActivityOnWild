
    UCFClass = 'bowling';
    [Ac, iterations, vidJump, annDir, bofDir, tagDir, word2vecFile, vinePosList,vinePosList2,vinePosList3, tr_vineAllList, tr_AllTagList, stage_I_thresh] = initStage(UCFClass);
    TopSelectedVids = containers.Map;
    avoidMap = containers.Map;
    [TrainSet, orgTrainLabels] = readTrainingSet(UCFClass,vidJump);
    [vinePosMap] = readVinePos(annDir,vinePosList,vinePosList2,vinePosList3);
    [TestSet, TrainLabels, TrainSet, TestOrder, vinePosMap] = readVineSet(orgTrainLabels, TrainSet, TopSelectedVids,avoidMap,tr_vineAllList,vinePosMap,bofDir);
    [TestLabels] = genTestLabels(vinePosMap, TestOrder);
    
%     X_2 = [];
     X_2 = horzcat(TrainSet,TestSet);
     X = X_2';
%     load('X_ITML','X_2');
    y = vertcat(TrainLabels,TestLabels);
    A_0 = eye(size(X, 2));
    if (~exist('params')),
    params = struct();
    end
    params = SetDefaultParams(params);   
    params.gamma = 0.01; 
     
    num_constraints = 200;
    m = length(y);

    number = 1;
    
    for (k=1:num_constraints),
        i = ceil(rand * m);
        j = ceil(rand * m);
        if (y(i) == y(j) && y(i)==1)
            C1(number,:) = [i j 1 0.1];
            number = number + 1;
        else
            if  y(i) ~= y(j)
                C1(number,:) = [i j -1 1.0];
                number = number + 1;
            end
        end
    end
    
    
    A = feval(@ItmlAlg, C1, X, A_0, params);
    save('A_gamma_001','A');
    
    num_folds = 2;
    knn_neighbor_size = 4;
    acc = CrossValidateKNN(y, X, @(y,X) MetricLearningAutotuneKnn(@ItmlAlg, y, X), num_folds, knn_neighbor_size);

    disp(sprintf('kNN cross-validated accuracy = %f', acc));
