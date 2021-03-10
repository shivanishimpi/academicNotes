import sys
import string
delim=['\t','\n',',',';','(',')','{','}','[',']','#','<','>']
oper=['+','-','*','/','%','=','!']
key=["int","float","char","double","bool","void","extern","unsigned","goto","static","class","struct","for","if","else","return","register","long","while","do"]
predirect=["include","define"]
header=["stdio.h","conio.h","malloc.h","process.h","string.h","ctype.h"]
word_list1=""
i=0
j=0
f=0
numflag=0
token=[0]*50


def isdelim(c):
    if c in delim:
        return 1
    return 0

def isop(c):
    for k in range(0,7):
        if c==oper[k]:
            ch=word_list1[i+1]
            i+=1
            for j in range(0,6):
                if ch==oper[j]:
                    fop=1
                    sop=ch
                    return 1
                #ungetc(ch,fp);
                return 1
                j+=1
        return 0;
        k+=1

def check(t):
    print(t)
    if numflag==1:
        print(f'\nnumber:{str(t)}')
        return
    for k in range(0,2):
        if strcmp(t,predirect[k])==0:
            print(f'\nPreprocessor directive: {str(t)}')
            return
    for k in range(0,6): 
        if strcmp(t,header[k])==0:
            print(f'\n header file: {str(t)}')
            return
    for k in range(0,21):
        if strcmp(key[k],t)==0:
            print(f'\n keyword: {str(key[k])}')
            return
        print(f'\nidentifier: {str(t)}')

def skipcomment():
    ch=word_list[i+1]
    i+=1
    if ch=='/':
        while word_list1[i]!='\0':
            i+=1#ch=getc(fp))!='\0':
    elif ch=='*':
        while f==0:
            ch=word_list1[i]
            i+=1
        if c=='/':
            f=1
    f=0



import glob
a = (glob.glob('*.c')[0])
s=open(a,"r")
str1=s.read()
word_list1=str1.split()




i=0
#print word_list1[i]
for word in word_list1 :
    print(word_list1[i])
    if word_list1[i]=="/":
        print(word_list1[i])
    elif word_list1[i]==" ":
        print(word_list1[i])
    elif word_list1[i].isalpha():
        if numflag!=1:
            token[j]=word_list1[i]
            j+=1
        if numflag==1:
            token[j]='\0'
            check(token)
            numflag=0
            j=0
            f=0
        if f==0:
            f=1
    elif word_list1[i].isalnum():
        if numflag==0:
            numflag=1
            token[j]=word_list1[i]
            j+=1
        else:
            if isdelim(word_list1[i]):
                if numflag==1:
                    token[j]='\0'
                    check(token)
                    numflag=0
                if f==1:
                    token[j]='\0'
                    numflag=0
                    check(token)
                j=0
                f=0
                print(f'\ndelimiters: {word_list1[i]}')
    elif isop(word_list1[i]):
        if numflag==1:
            token[j]='\0'
            check(token)
            numflag=0
            j=0
            f=0
        if f==1:
            token[j]='\0'
            j=0 
            f=0
            numflag=0
            check(token)    
        if fop==1:
            fop=0
            print(f'\n operator\t{str(word_list1[i])} {str(sop)}')
        else:
            print(f'\n operator \t {str(c)}')
    elif word_list1[i]=='.':
        token[j]=word_list1[i]
        j+=1
    i+=1
