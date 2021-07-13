#!/bin/sh
##parameter="leucine"
read -p 'Enter the parameter for averaging (filename): ' parameter
declare -i intervals=5
declare -i startt=0
declare -i endt=350
#n will define the frequency frames
# n is number of frames in 1 ns
declare -i n=10
for a in 1 2 3 4
do
sed "s/FILE/${parameter}_${a}_${startt}_${endt}/g;s/OUTPUT/${parameter}_average_${startt}_${endt}ns_${a}/g;s/INTERVAL/$intervals/g;s/STARTTIME/$startt/g;s/FREQ/${n}/g" average.py > averagex.py
python3 averagex.py
rm averagex.py
done
echo "PART 1 is done"
declare -i startt=350
declare -i endt=700
#n will define the frequency frames
# n is number of frames in 1 ns
declare -i n=10
for a in 1 2 3 4
do
sed "s/FILE/${parameter}_${a}_${startt}_${endt}/g;s/OUTPUT/${parameter}_average_${startt}_${endt}ns_${a}/g;s/INTERVAL/$intervals/g;s/STARTTIME/$startt/g;s/FREQ/${n}/g" average.py > averagex.py
python3 averagex.py
rm averagex.py
done
echo "PART 2 is done"
declare -i startt=700
declare -i endt=1000
#n will define the frequency frames
# n is number of frames in 1 ns
declare -i n=10
for a in 1 2 3 4
do
sed "s/FILE/${parameter}_${a}_${startt}_${endt}/g;s/OUTPUT/${parameter}_average_${startt}_${endt}ns_${a}/g;s/INTERVAL/$intervals/g;s/STARTTIME/$startt/g;s/FREQ/${n#}/g" average.py > averagex.py
python3 averagex.py
rm averagex.py
done
echo "PART 3 is done"
echo "Concatenating files"
for xx in 1 2 3 4
do
rm ${parameter}_average_${xx}.dat
cat ${parameter}_average_0_350ns_${xx}.dat ${parameter}_average_350_700ns_${xx}.dat ${parameter}_average_700_1000ns_${xx}.dat > ${parameter}_average_${xx}.dat
done
echo "Concatenation of files finished"