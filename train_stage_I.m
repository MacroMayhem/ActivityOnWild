function [decVals,acc] = train_stage_I(train_kernel,test_kernel,TrainLabels,TestLabels)
            train_kernel = [(1:size(train_kernel,1))',train_kernel];
            test_kernel =  [(1:size(test_kernel,1))' ,test_kernel];
            model = svmtrain(TrainLabels, train_kernel, '-t 4 -b 1');
            [predClass, acc, decVals] = svmpredict(TestLabels, test_kernel, model,'-b 1');
            [C, order] = confusionmat(TestLabels,predClass)
end