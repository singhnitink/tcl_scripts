#This is script for gnuplot#
#enter in gnuplot terminal, type gnuplot, press enter#
#load 'simple.gnu'#
unset xtics
unset ytics
set terminal pngcairo enhanced color font 'Helvetica,48' size 3600,3000
set output "4ydq-GLIQ_rmsd_ligand.png"
set border linewidth 10
#First plot***************
set xlabel "Time(ns)" font 'Helvetica Bold ,56'
set ylabel "rmsd(A)" font 'Helvetica Bold,56'
set title "4ydq-GLIQ Ligand-RMSD" font 'Helvetica Bold,56'
set xrange [0:100]
set yrange [*:*]
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
pl 'rmsd_ligand_1.dat' u ($1/10):($2) title "RUN1" w l lw 8 lc rgb 'red' \
, 'rmsd_ligand_2.dat' u ($1/10):($2) title "RUN2" w l lw 8 lc rgb 'blue'
