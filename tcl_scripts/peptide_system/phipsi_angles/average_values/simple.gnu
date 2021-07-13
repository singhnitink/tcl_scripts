#This is script for gnuplot#
#enter in gnuplot terminal, type gnuplot, press enter#
#load 'simple.gnu'#
set terminal pngcairo enhanced color font 'Helvetica,48' size 3600,3000
set output "average_dihedrals_XXX.png"
set border linewidth 10
#First plot***************
set xlabel "Time(ns)" font 'Helvetica Bold ,56'
set ylabel "fraction of residues in helix" font 'Helvetica Bold,56'
set title "Temperature 300- (XXX) Sec. St. phipsi plot" font 'Helvetica Bold,56'
set xrange [0:1000]
set yrange [0:1]
##set tics scale 2.5
set ytics 0.1
set ytics font ',52'
set xtics font ',52' rotate 90
set xtics 25
#set xzeroaxis lt 1 dt 2 lw 1.5 lc rgb 'black'
set key box lw 5 width 1
set key right top
##set key at 110,0.95
set key font ',52'
pl 'all_average_dihedral_XXX.dat' u 1:2 title "Total" w l lw 8 lc rgb 'red' \
, 'all_average_lysine_XXX.dat' u 1:2 title "Lysine" w l lw 8 lc rgb 'green' \
, 'all_average_leucine_XXX.dat' u 1:2 title "Leucine" w l lw 8 lc rgb 'blue'