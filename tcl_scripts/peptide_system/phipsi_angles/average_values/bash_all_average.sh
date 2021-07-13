#!/bin/bash
#a will be pattern name
read -p "Enter pattern: " a
rm all_dihedral_average_${a}.dat all_lysine_average_${a}.dat all_leucine_average_${a}.dat
paste ../dihedralsaverage_1.dat ../dihedralsaverage_2.dat ../dihedralsaverage_3.dat ../dihedralsaverage_4.dat > all_dihedral_average_${a}.dat
sed "s/XXX/${a}/g;s/YYY/dihedral/g" all_average.py > run.py
python3 run.py
rm run.py
#############################
paste ../lysine_leucine_separated/lysine_average_1.dat ../lysine_leucine_separated/lysine_average_2.dat ../lysine_leucine_separated/lysine_average_3.dat ../lysine_leucine_separated/lysine_average_4.dat > all_lysine_average_${a}.dat
sed "s/XXX/${a}/g;s/YYY/lysine/g" all_average.py > run.py
python3 run.py
rm run.py
#############################
paste ../lysine_leucine_separated/leucine_average_1.dat ../lysine_leucine_separated/leucine_average_2.dat ../lysine_leucine_separated/leucine_average_3.dat ../lysine_leucine_separated/leucine_average_4.dat > all_leucine_average_${a}.dat
sed "s/XXX/${a}/g;s/YYY/leucine/g" all_average.py > run.py
python3 run.py
rm run.py
echo "DONE1"
sed "s/XXX/${a}/g" simple.gnu > simple1.gnu
gnuplot simple1.gnu