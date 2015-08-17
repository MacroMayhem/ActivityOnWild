function [] = saveStageII_intra_kernels(TrainBaseSet, TrainVineSet,TestSet,Ac,ucfClass)

    train_kernel = strcat('intra_train_',ucfClass);
    vine_kernel = strcat('intra_vine_',ucfClass);

    orig_train_kernel = chiKernel(TestSet',TrainBaseSet',Ac);
    save(train_kernel,'orig_train_kernel');

    
    orig_vine_kernel = chiKernel(TestSet',TrainVineSet',Ac);
    save(vine_kernel,'orig_vine_kernel');
end