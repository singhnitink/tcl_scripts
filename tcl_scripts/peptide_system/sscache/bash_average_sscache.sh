#!/bin/sh
##intervals is required for taking the mean (in ns)
declare -i intervals=5
declare -i tx1=0
declare -i tx2=1000
for a in 1 2 3 4
do
sed "s/SEC_ST_FILE_SSCACHE/sec_st_${a}/g;s/AVERAGE_DATA/helixaverage_${a}/g;s/PER_FRAME/perframe_${a}/g;s/INTERVAL/$intervals/g;s/RUN/$a/g;s/STARTTIME/${tx1}/g" one.py > sec_st_averagex.py
python3 sec_st_averagex.py
rm sec_st_averagex.py
done
echo "PART1 is done"
python3 single_valuex.py