

f_name = 'te_intra_bowling.txt'

f = open(f_name,'r')

for line in f.read().split('\n'):
    if len(line) > 0:
        words = line.split(' ')
        print 'bowling'+words[0]+'.txt',words[1]
