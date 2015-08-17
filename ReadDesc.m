function[set2Modify] = ReadDesc(fileName,set2Modify)

       [r sizeName] = size(fileName);
       traj = strcat(fileName(1:sizeName-3),'traj') ;
       hog = strcat(fileName(1:sizeName-3),'hog');
       hof = strcat(fileName(1:sizeName-3),'hof');
       mbh = strcat(fileName(1:sizeName-3),'mbh');
     
       emptySet = [];
       
       f1 = fopen(traj,'r');
       Tr = str2num(fgetl(f1));
       emptySet = horzcat(emptySet,Tr);
       fclose(f1);
       
       f2 = fopen(hog,'r');
       Hg = str2num(fgetl(f2));
       emptySet = horzcat(emptySet,Hg);
       fclose(f2);
       
       f3 = fopen(hof,'r');
       Hf = str2num(fgetl(f3));
       emptySet = horzcat(emptySet,Hf);
       fclose(f3);
       
       
       f4 = fopen(mbh,'r');
       Mb = str2num(fgetl(f4));
       emptySet = horzcat(emptySet,Mb);
       fclose(f4);
       
       set2Modify = horzcat(set2Modify,emptySet');
end