import numpy as np
import statistics
data=np.genfromtxt('all_YYY_average_XXX.dat',dtype=None,encoding=None,delimiter='',comments='#',invalid_raise=False)
data=np.char.array(data,unicode=True)
file1=open('all_average_YYY_XXX.dat','w')
lines=data.shape[0]
#X=[] #creating an empty list to store fraction helix values
a=0
while a<lines:
    time=int(data[a,1])
    a1=float(data[a,2])
    a2=float(data[a,6])
    a3=float(data[a,10])
    a4=float(data[a,14])
    dataset=[a1,a2,a3,a4]
    average=statistics.mean(dataset)
    std=statistics.stdev(dataset)
    file1.write("%d\t%.2f\t%.2f\n"%(time,average,std))
    a=a+1
file1.close()
print('DONE')