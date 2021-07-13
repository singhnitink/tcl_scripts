import numpy as np
import statistics
data1=np.genfromtxt('PARAMETER_1_3.dat',delimiter='',comments='#',invalid_raise=False)
data2=np.genfromtxt('PARAMETER_2_3.dat',delimiter='',comments='#',invalid_raise=False)
data3=np.genfromtxt('PARAMETER_3_3.dat',delimiter='',comments='#',invalid_raise=False)
data4=np.genfromtxt('PARAMETER_4_3.dat',delimiter='',comments='#',invalid_raise=False)
file1=open('PATTERN_PARAMETER_average_std.dat','a')
#count=data1.shape[0]
calc1=data1[1000:2000,1] ##rows to consider, column number
calc2=data2[1000:2000,1] ##rows to consider, column number
calc3=data3[1000:2000,1] ##rows to consider, column number
calc4=data4[1000:2000,1] ##rows to consider, column number
average1=calc1.mean()
average2=calc2.mean()
average3=calc3.mean()
average4=calc4.mean()
lines=data2.shape[0]
dataset=[average1,average2,average3,average4]
average=statistics.mean(dataset)
std=statistics.stdev(dataset)
print("PARAMETER Average %.2f  Std %2f"%(average,std))
file1.write("PARAMETER  \t\t%.3f \t %0.3f \n"%(average,std))
file1.close()