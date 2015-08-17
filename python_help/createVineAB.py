from random import randint

fid = open('New_AllFilesList.txt','r')
f1 = open('tr_VineAllList.txt','w')
f2 = open('te_VineAllList.txt','w') 
for line in fid.read().split('\n'):
    if len(line)> 0:
        a = randint(1,4)
        if a == 4:
            f2.write(line+'\n')
        else:
            f1.write(line+'\n')
