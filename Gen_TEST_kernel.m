function [test_kernel, model_kernel] = Gen_TEST_kernel(train_kernel,vine_kernel,vineTrainingMap,posSelectedVids)

    test_kernel = train_kernel;
    
    vids = keys(vineTrainingMap);
    
    cu_col = size(train_kernel,2);
    te_vine = size(vine_kernel,1);
    tr_vine = size(posSelectedVids,1);
    
    for i=1:te_vine
        for j=1:tr_vine
            test_kernel(i,cu_col+j) = vine_kernel(i,vineTrainingMap(vids{i}));
        end
    end
end