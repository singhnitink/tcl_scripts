'''This file will be used to  calculate the secondary stucture content
... generated from the sscache script'''
import pandas as pd
import numpy as np
data=np.genfromtxt('SEC_ST_FILE_SSCACHE.dat',dtype=None,encoding=None,delimiter='')
file1=open('PER_FRAME.dat','w') #contains helixaverage of 5ns 250 frames
data=np.char.array(data,unicode=True)
lines=data.shape[0]
nres=24 #number of residues in peptide chain
X=[] #creating an empty list to store fraction helix values
a=0
while a<lines:
    b=1
    helix=0
    while b<25: 
        #25 => is number of residues+1
        #a is line b is column
        if data[a,b]=='H':
            helix+=1
        b+=1
    #print(a,helix/nres)
    X.append(helix/nres)
    file1.write("%d\t%.2f\n"%(a,helix/nres))
    a+=1
X.append(helix/nres)
file1.write("%d\t%.2f\n"%(a,helix/nres))
file1.close()
#******* averaging the data stored in list X
t1=STARTTIME #start time
interval=INTERVAL #interval
##**Change the value of interval for changing the time period of mean##
file2=open('AVERAGE_DATA.dat','w') #contains helixaverage every 5ns ie. 250 frames
t2=t1+interval
m=0
mean_int=(1000//100)*interval
#40 is time in ps at which you are writing the dcd file
n=mean_int 
file2.write('#t1\tt2\t run \tmean\t std \t median\n')
while n<=len(X):
    mean=np.mean(X[m:n])
    std=np.std(X[m:n])
    median=np.median(X[m:n])
    file2.write('%d\t%d\t RUN \t%.2f\t%.4f\t%.4f\n'%(t1,t2,mean,std,median))
    ##print(m,n)
    m+=mean_int
    n+=mean_int
    t1+=interval
    t2+=interval
file2.close()
print(len(X))
print('DONE')
