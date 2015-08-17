function [fileName,stage_II_Base_kernel,stage_II_Vine_kernel, Ac, vidJump, bofDir,tagDir, tr_vineAllList] = initStage_II_intra(UCFClass)
    
    fileName = 'testList.txt';
    stage_II_Base_kernel = strcat('intra_train_',UCFClass);
    stage_II_Vine_kernel = strcat('intra_vine_',UCFClass);
    
    tagDir = 'te_TAGS/'
    
    tr_vineAllList='tr_VineAllList.txt';
    
    nSamples = 13320;

    Ac = zeros(4);
    Ac(1) = (2.95936e+12)/(nSamples*nSamples/2);
    Ac(2) = (3.54467e+12)/(nSamples*nSamples/2);
    Ac(3) = (3.47236e+12)/(nSamples*nSamples/2);
    Ac(4) = (3.10282e+12)/(nSamples*nSamples/2);
    
    vidJump = 1;
    
    bofDir ='vineBOF/';
    
end