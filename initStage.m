function [Ac, iterations, vidJump, annDir, bofDir, tagDir, word2vecFile, vinePosList,vinePosList2,vinePosList3, tr_vineAllList,tr_AllTagList, stage_I_thresh] = initStage(UCFClass)

    nSamples = 13320;

    Ac = zeros(4);
    Ac(1) = (2.95936e+12)/(nSamples*nSamples/2);
    Ac(2) = (3.54467e+12)/(nSamples*nSamples/2);
    Ac(3) = (3.47236e+12)/(nSamples*nSamples/2);
    Ac(4) = (3.10282e+12)/(nSamples*nSamples/2);
 
    iterations =8;
    vidJump = 1;
    
    annDir = 'NewAnnotations/';
    bofDir = 'vineBOF/';
    tagDir = 'tr_TAGS/';
    word2vecFile = 'word2vec_mat.txt';
    
    vinePosList=strcat('annotation_',UCFClass,'_1_230');
    vinePosList2=strcat('annotation_',UCFClass,'_12_30');
    vinePosList3=strcat('annotation_',UCFClass,'_123_0');
    
    tr_vineAllList='tr_VineAllList.txt';
    tr_AllTagList='tr_AllTagList.txt';

    stage_I_thresh = 0.925;
end