#!bin/bash
for a in rmsf hbonds_pnl hbonds_pnp water_data rmsd_ligand radius_of_gyration
do
gnuplot ${a}.gnu
done