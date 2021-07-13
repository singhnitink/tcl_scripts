#This is script for gnuplot#
#enter in gnuplot terminal, type gnuplot, press enter#
#load 'simple.gnu'#
set terminal pngcairo enhanced color font 'Helvetica,48' size 3600,3000
set output "protein_ligandenergy.png"
set border linewidth 10
#First plot***************
set xlabel "Frame" font 'Helvetica Bold ,56'
set ylabel "Energy (Kcal/mol)" font 'Helvetica Bold,56'
set title "Interaction energy" font 'Helvetica Bold,56'
set xrange [0:100]
#set yrange [0:1]
##set tics scale 2.5
#set ytics 0.1
set ytics font ',52'
set xtics font ',52' rotate 90
set xtics 5
#set xzeroaxis lt 1 dt 2 lw 1.5 lc rgb 'black'
set key box lw 5 width 1
set key left top
##set key at 110,0.95
set key font ',52'
pl 'protein_ligand_1.dat' u ($2):($6) title "Total-Energy" w l lw 8 lc rgb 'blue'
