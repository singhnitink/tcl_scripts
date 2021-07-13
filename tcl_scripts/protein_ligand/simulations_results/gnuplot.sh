#!/bin/bash
#read -p 'Enter the protein and liand without space: ' pandl
#pandl="4ydq-HFU"
for a in sasa water_data radius_of_gyration hbonds_pnp rmsf hbonds_pnl rmsd_ligand
do
#sed "s/XXXXX/${pandl}/g;s/YYYYY/${a}/g" simple.gnu > ${a}.gnu
gnuplot ${a}.gnu
#rm ${a}.gnu
done
