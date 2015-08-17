function [Tr_v_Tr,Te_v_Tr] = genKernels(Orig_Tr_v_Tr, Orig_Te_v_Tr, Orig_Te_v_Te, TestOrder, VideoID, TopSelectedVids)
    [og_r, og_c] = size(Orig_Tr_v_Tr);
    add_r = size(keys(TopSelectedVids),2);
    topKeys = keys(TopSelectedVids);
    Te_v_Tr = [];
    Tr_v_Tr = Orig_Tr_v_Tr;
    
    for i=1:add_r
        Tr_v_Tr(og_r+i,1:og_c) = Orig_Te_v_Tr(VideoID(char(topKeys{i})),:);
        Tr_v_Tr(1:og_r,og_c+i) = Orig_Te_v_Tr(VideoID(char(topKeys{i})),:);
    end    
    
    for i=1:add_r
        for j=1:add_r
            Tr_v_Tr(og_r+i,og_c+j) =  Orig_Te_v_Te(VideoID(char(topKeys{i})),VideoID(char(topKeys{j})));
        end
    end
    
    for i=1:size(TestOrder)
        Te_v_Tr(i,1:og_c) = Orig_Te_v_Tr(VideoID(char(TestOrder{i})),:);
        for j=1:add_r
            Te_v_Tr(i,og_c+j) = Orig_Te_v_Te(VideoID(char(TestOrder{i})),VideoID(char(topKeys{j})));
        end
    end
end