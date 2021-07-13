import numpy as np
import statistics
data1=np.genfromtxt('hbonds_pnw_1_3.dat',delimiter='',comments='#',invalid_raise=False)
data2=np.genfromtxt('hbonds_pnw_2_3.dat',delimiter='',comments='#',invalid_raise=False)
data3=np.genfromtxt('hbonds_pnw_3_3.dat',delimiter='',comments='#',invalid_raise=False)
data4=np.genfromtxt('hbonds_pnw_4_3.dat',delimiter='',comments='#',invalid_raise=False)
file1=open('k2l6_hbonds_pnw_average_std.dat','a')
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
print("hbonds_pnw Average %.2f  Std %2f"%(average,std))
file1.write("hbonds_pnw  \t\t%.3f \t %0.3f \n"%(average,std))
file1.close()