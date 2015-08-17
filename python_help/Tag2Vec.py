import gensim
import numpy
import operator
from nltk.stem.snowball import SnowballStemmer

# CODE FOR INDIVIDUAL SIZE BASED DELETETION I.E. top 10% of each class
def full_exclusion_list(action_class_dict,exclusionTags):
    final_dict = sorted(action_class_dict.items(),key=operator.itemgetter(1))
    sz = len(final_dict) - 1
    prevCount = -1
    thresh = 0
    count = sz
    while 1:
        if final_dict[count][0] in exclusionTags:
            count = count - 1
            continue
        curr_word = final_dict[count][0]
        if prevCount == -1:
            prevCount = final_dict[count][1]
            thresh = thresh + 1
        else:
            if thresh == 20:
                if prevCount != final_dict[count][1]:
                    thresh = thresh + 1
            else:
                thresh = thresh + 1
                prevCount = final_dict[count][1]
        if thresh > 20:
            break
        count = count - 1
    
    while count > 0:
        if final_dict[count][0] not in exclusionTags:
                exclusionTags[final_dict[count][0]] = 1
        count = count - 1


def full_inclusion_list(action_class_dict, inclusionTags, exclusionTags):
    final_dict = sorted(action_class_dict.items(),key=operator.itemgetter(1))
    sz = len(final_dict) - 1
    prevCount = -1
    thresh = 0
    count = sz
    while 1:
        if final_dict[count][0] in exclusionTags:
            count = count - 1
            continue
        curr_word = final_dict[count][0]
        if prevCount == -1:
            prevCount = final_dict[count][1]
            thresh = thresh + 1
        else:
            if thresh == 20:
                if prevCount != final_dict[count][1]:
                    thresh = thresh + 1
            else:
                thresh = thresh + 1
                prevCount = final_dict[count][1]
        if thresh > 20:
            break
        print curr_word,thresh,final_dict[count]
        inclusionTags[curr_word] = 1
        count = count - 1
    


#GET THE FILES 2 DELETE (FILES NOT CONTAINING #CLASSNAME), TAGS TO DELETE(BASED ON TFIDF & LOWEST IN CLASS FREQ)
def processTags():
    i_dir = 'TAGS/'
    
    stemmer = SnowballStemmer('english')
    
    exclude_words = {}
    delete_files = {} 
    all_tags = {}

    surfing= {}
    bowling = {}
    drumming = {}
    horseriding = {}
    fencing = {}

    allFiles = open('tr_VineAllList.txt','r')
    train_dict = {}
    for line in allFiles.read().split('\n'):

        line_class = ''
        for c in line.split('.')[0]:
            if c.isdigit():
                break
            line_class  = line_class + c

        if len(line)>0:
            train_dict[line] = 1
            fid = open(i_dir+line,'r')
            deleteFile = 1
            for tags in fid.read().split('\n'):
                if len(tags)>0:
                    words = tags.split('#')
                    for word in words:
                        if len(word)>0:
                            
                            # CHECK IF IT HAS A #CLASSNAME OR NOT
                            if word.lower() == line_class:
                                deleteFile = 0
                            stem = stemmer.stem(word.lower())
                            
                        
                            #ADD IT TO CLASS SPECIFIC DICT FOR REMOVAL ACROSS CLASS
                            if line_class == 'bowling':
                                if stem not in bowling:
                                    bowling[stem] = 0   
                                    if stem not in all_tags:
                                        all_tags[stem] = 1
                                    else:
                                        all_tags[stem] = all_tags[stem] + 1
                                bowling[stem] = bowling[stem]+1
                            
                            if line_class == 'drumming':
                                if stem not in drumming:
                                    drumming[stem] = 0   
                                    if stem not in all_tags:
                                        all_tags[stem] = 1
                                    else:
                                        all_tags[stem] = all_tags[stem] + 1
                                drumming[stem] = drumming[stem]+1
                            
                            if line_class == 'fencing':
                                if stem not in fencing:
                                    fencing[stem] = 0   
                                    if stem not in all_tags:
                                        all_tags[stem] = 1
                                    else:
                                        all_tags[stem] = all_tags[stem] + 1
                                fencing[stem] = fencing[stem]+1


                            if line_class == 'horseriding':
                                if stem not in horseriding:
                                    horseriding[stem] = 0   
                                    if stem not in all_tags:
                                        all_tags[stem] = 1
                                    else:
                                        all_tags[stem] = all_tags[stem] + 1
                                horseriding[stem] = horseriding[stem]+1
                            
                            if line_class == 'surfing':
                                if stem not in surfing:
                                    surfing[stem] = 0
                                    if stem not in all_tags:
                                        all_tags[stem] = 1
                                    else:
                                        all_tags[stem] = all_tags[stem] + 1
                                surfing[stem] = surfing[stem]+1
            # REMOVE TO GET LIST OF FILES NOT WITH #CLASSNAME
            if deleteFile == 1:
                delete_files[line] = 1
                print line
            fid.close()
   
    allFiles.close()

    # CODE TO GET TAGS COMMON IN >=3 CLASSES 
    for tags in all_tags:
        if all_tags[tags] >= 3:
            exclude_words[tags] = 1

    # CODE FOR INDIVIDUAL SIZE BASED DELETETION I.E. top 10% of each class
    include_words = {}
    full_inclusion_list(surfing,include_words,exclude_words)
    form_new_TAGS(include_words,delete_files,train_dict)
    print len(include_words)
    include_words = {}
    #full_exclusion_list(bowling,exclude_words)
    #full_exclusion_list(drumming,exclude_words)
    #full_exclusion_list(horseriding,exclude_words)
    #full_exclusion_list(surfing,exclude_words)

    #form_new_TAGS(exclude_words,delete_files)
    #form_new_annotations(delete_files)

def form_new_TAGS(include_words,delete_files,train_dict):
    i_dir = 'TAGS/'
    f_dir = 'te_TAGS/'
    allFiles = open('surfing.txt','r')
    
    stemmer = SnowballStemmer('english')
    for line in allFiles.read().split('\n'):
        if len(line)>0: 
            if line in delete_files:
                continue
            if line in train_dict:
                continue

            fid = open(i_dir+line,'r')
            fod = open(f_dir+line,'w')
            for tags in fid.read().split('\n'):
                if len(tags)>0:
                    words = tags.split('#')
                    for word in words:
                        if len(word)>0:
                            stem = stemmer.stem(word.lower())
                            if stem in include_words:
                                fod.write(word.lower()+'\n')
            fod.close()
    allFiles.close()

def form_new_annotations(delete_files):
    i_dir = 'Annotations/'
    f_dir = 'NewAnnotations/'
    allFiles = open('AnnotationFiles.txt','r')

    for line in allFiles.read().split('\n'):
        if len(line) > 0:
            fid = open(i_dir+line,'r')
            fod = open(f_dir+line,'w')
            for video in fid.read().split('\n'):
                if len(video)>0:
                    if video.split('.')[0]+'.txt'not in delete_files:
                        fod.write(video+'\n')
            fid.close()
            fod.close()
    allFiles.close()
    
def word2vec():
    i_dir = 'tr_TAGS/'
    f_list = 'tr_VineAllList.txt'
    
    tag_dict = {}
    tag_list = []
    tag_k = 100
    tid = 0

    fid = open(f_list,'r')
    
    for line in fid.read().split('\n'):
        if len(line)>0:
            f1 = open(i_dir+line,'r')
            for words in f1.read().split('\n'):
                if len(words) > 0:
                    if words not in tag_dict:
                        tag_dict[words] = tid
                        tag_list.append(words)
                        tid = tid+1
    ## FOR UNIQUE TAGS
    for keys in tag_dict:
        print keys
    return
    model = gensim.models.Word2Vec.load_word2vec_format('./GoogleNews.bin', binary=True)
    for tags in tag_list:
        curr_list = []
        curr_list.append(tags)
        try:
            for words in model.most_similar(tags,topn=100):
                try :
                    if words[0] in tag_dict:
                        curr_list.append(words[0])
                except KeyError:
                    continue
        except KeyError:
            b = 1
        for item in curr_list:
            print item,
        print

if __name__=="__main__":
    processTags()
    #word2vec()
    #test_word2vec()
