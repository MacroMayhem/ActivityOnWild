function [train_kernel, vine_kernel] = loadStageII_kernels(train_kernel_name,vine_kernel_name)
    tr_struct = load(train_kernel_name);
    train_kernel = tr_struct.orig_train_kernel;
    
    vine_struct = load(vine_kernel_name);
    vine_kernel = vine_struct.orig_vine_kernel;
    
end