#!/bin/bash
vmd -dispdev text -e sa.tcl
#a will be pattern name
#read -p "Enter pattern: " b
b="k2l6"
for a in water_data sasa radius_of_gyration rmsd hbonds_pnp hbonds_pnw
do
sed "s/PARAMETER/${a}/g;s/PATTERN/${b}/g" average_errorbars_new.py > run.py
python3 run.py
#rm run.py
done
echo "DONE"
