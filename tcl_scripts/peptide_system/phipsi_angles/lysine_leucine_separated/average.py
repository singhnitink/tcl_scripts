import pandas as pd
import numpy as np
data=np.genfromtxt('FILE.dat')
file=open('OUTPUT.dat','w')
value=data[:,1]
size=value.size
print(size)
t1=STARTTIME #start time
interval=INTERVAL #interval
##**Change the value of interval for changing the time period of mean##
t2=t1+interval
m=0
mean_int=FREQ*interval #FREQ is here for 1ns
##10 frames in 1 ns simulation time
n=m+mean_int
file.write('#t1\tt2\tmean\tstd\n')
while n<=size:
    mean=np.mean(value[m:n])
    std=np.std(value[m:n])
    file.write('%d\t%d\t%.3f\t%.3f\n'%(t1,t2,mean,std))
    m+=mean_int
    n+=mean_int
    t1+=interval
    t2+=interval
file.close()
print("DONE")