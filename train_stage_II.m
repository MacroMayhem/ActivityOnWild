function [decVals] = train_stage_II(ucfClass,decVals,TopSelectedVids,word2vecMat,T2V, V2T, VideoID, TagID, TestOrder)
%        [decVals] = word2vec_metric(TopSelectedVids,decVals,V2T,VideoID,TestOrder,word2vecMat);
%          [decVals] = word2vec_pos_neg(ucfClass,TopSelectedVids,decVals,V2T,VideoID,TagID,TestOrder,word2vecMat);
         [decVals] = word2vec_pos_intrainter_neg(ucfClass,TopSelectedVids,decVals,V2T,VideoID,TagID,TestOrder,word2vecMat);
end