 ## x is folder
cd ../
set folders {1 2 3 4}
foreach x $folders {
cd $x
 ## y is nptrun
set nptrun {3}
foreach y $nptrun {
mol delete all
 ##******************
 ##Remember to change name of psf file
mol new ../../K2L6_solvated_0M.psf
mol addfile npt${y}.dcd first 1000 last 3000 waitfor all
set nframes [molinfo top get numframes]
puts "*********************************"
puts "Total number of frames is ${nframes}"
puts "*********************************"


 ##Fitting the protin molecule
set frame01 [atomselect top "protein and backbone" frame 0]
set frame0 [atomselect top "protein and name CA" frame 0]
for {set ix 1 } {$ix < $nframes } { incr ix } {
		set selx [atomselect top "protein and name CA" frame $ix]
		set all [atomselect top all frame $ix]
		$all move [measure fit $selx $frame0]
	}
	
 ######################################################
puts "Counting number of waters within 10A of protein"
set sel [atomselect top "protein"]
set waters [atomselect top "(resname TIP3 and name OH2) and (pbwithin 10 of protein)"]
#**Specifying file names to store data	
set outfile1 [open "../simulations_results/water_data_${x}_${y}.dat" w]
set outfile2 [open "../simulations_results/sasa_${x}_${y}.dat" w]
set outfile3 [open "../simulations_results/radius_of_gyration_${x}_${y}.dat" w]
set outfile4 [open "../simulations_results/rmsd_${x}_${y}.dat" w]
set outfile5 [open "../simulations_results/hbonds_pnp_${x}_${y}.dat" w]
set outfile6 [open "../simulations_results/rmsf_${x}_${y}.dat" w]
set outfile7 [open "../simulations_results/hbonds_pnw_${x}_${y}.dat" w]
#**
##**Calculation of waters, sasa, rog,rmsd

for {set i 0} {$i < $nframes} {incr i} {
		$waters frame $i
		$waters update
		$sel frame $i
		$sel update
		set waternumbers [$waters num]
	    set sasa [measure sasa 1.4 $sel]
		set rog [measure rgyr $sel]
		set selrms [atomselect top "protein and backbone" frame $i]
		set rms [measure rmsd $selrms $frame01]
		puts $outfile1 [format "%d %2.2f" $i $waternumbers]
		puts $outfile2 [format "%d %2.2f" $i $sasa]
		puts $outfile3 [format "%d %2.2f" $i $rog]
		puts $outfile4 [format "%d %2.2f" $i $rms]
		
	}

##**Calculation of h-bonds between peptide
set D [atomselect top "protein and name N"]
set A [atomselect top "protein and name O"]	
for {set j 0} {$j < $nframes} {incr j} {
		$D frame $j
		$A frame $j
		$A update
		$D update
		set hbondList [measure hbonds 3.0 20 $D $A]
		set hbondNumber [llength [lindex $hbondList 0]]
		puts $outfile5 [format "%d %d" $j $hbondNumber]
	}
	
##**Calculation of h-bonds between peptide and water
set D1 [atomselect top "resname TIP3"]
set A1 [atomselect top "protein"]	
for {set j 0} {$j < $nframes} {incr j} {
		$D1 frame $j
		$A1 frame $j
		$A1 update
		$D1 update
		set hbondList1 [measure hbonds 3.0 20 $D1 $A1]
		set hbondNumber1 [llength [lindex $hbondList1 0]]
		puts $outfile7 [format "%d %d" $j $hbondNumber1]
	}

##**Calculation of RMSF	
set sel1 [atomselect top "protein and name CA"]
 for {set k 0} {$k < [$sel1 num]} {incr k} {
 set rmsf [measure rmsf $sel1 ]
 puts $outfile6 "[expr {$k+1}] [lindex $rmsf $k]"
 }	
close $outfile1
close $outfile2
close $outfile3	
close $outfile4
close $outfile5
close $outfile6
close $outfile7
mol delete all
}
cd ..
}
puts "This script calculated SASA, waters within 10 A of protein, ROG, RMSD, RMSF and h-bonds"
puts "GREAT!! IT IS ALL-DONE"
exit