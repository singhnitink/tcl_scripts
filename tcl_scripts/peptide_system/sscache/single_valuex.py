import numpy as np
import statistics
##This is to get average of all four runs from stride value
name = input("Enter the pattern: ")
data1=np.genfromtxt('helixaverage_1.dat',delimiter='',comments='#',invalid_raise=False)
data2=np.genfromtxt('helixaverage_2.dat',delimiter='',comments='#',invalid_raise=False)
data3=np.genfromtxt('helixaverage_3.dat',delimiter='',comments='#',invalid_raise=False)
data4=np.genfromtxt('helixaverage_4.dat',delimiter='',comments='#',invalid_raise=False)
file1=open(name+'_helix_average_std.dat','w')
#count=data1.shape[0]
calc1=data1[159:198,3] ##rows to consider, column number
calc2=data2[159:198,3] ##rows to consider, column number
calc3=data3[159:198,3] ##rows to consider, column number
print(data3[159,3],data3[198,3])
calc4=data4[159:198,3] ##rows to consider, column number
average1=calc1.mean()
average2=calc2.mean()
average3=calc3.mean()
average4=calc4.mean()
lines=data2.shape[0]
dataset=[average1,average2,average3,average4]
average=statistics.mean(dataset)
std=statistics.stdev(dataset)
print(average1,average2,average3,average4)
print("PARAMETER Average %.2f  Std %2f"%(average,std))
file1.write("%s  \t\t%.3f \t %0.3f \n"%(name,average,std))
file1.close()
