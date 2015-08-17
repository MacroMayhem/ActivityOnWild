function [orig_train_kernel,orig_test_kernel, orig_test_v_test_kernel] = saveBaseKernels(TrainSet,TestSet,Ac)
            orig_train_kernel = chiKernel(TrainSet',TrainSet',Ac);
            save('orig_train_kernel');
            
            orig_test_kernel = chiKernel(TestSet',TrainSet',Ac);
            save('orig_test_kernel');
            
            orig_test_v_test_kernel = chiKernel(TestSet',TestSet',Ac);
            save('orig_test_v_test_kernel');
end