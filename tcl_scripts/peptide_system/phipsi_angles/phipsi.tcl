cd  ..
set folders {1 2 3 4}
foreach x $folders {
cd $x
 ## y is nptrun
set nptrun {1 2 3}
foreach y $nptrun {
mol delete all
 ##******************
 ##Remember to change name of psf file
mol new ../../K2L6_solvated_0M.psf
mol addfile npt${y}.dcd waitfor all
set sel [atomselect top "resname LYS LEU"]
set a [$sel num]
puts "Total atoms in peptide: $a"
set nframes [molinfo top get numframes]
puts "*********************************"
puts "Total frames for folder ${x} npt ${y} is ${nframes}"
puts "*********************************"
set nn [llength [$sel get {phi psi}]]
set totdih [expr $nn*$nframes]
puts "Total dihedrals: $totdih"
if { $y==1 } {
            set ts1 0
            set ts2 350
   } elseif { $y==2 } {
            set ts1 350
            set ts2 700
   } elseif { $y==3 } {
            set ts1 700
            set ts2 1000
   } else {
         puts "CHECK the value of ${y}"
               }
set outfile [open "../phipsi_angles/dihedrals_${x}_${ts1}_${ts2}.dat" w]
for {set i 0} {$i < $nframes} {incr i} {
	$sel frame $i
    $sel update
	set alpha 0
    foreach a [$sel get {phi psi}] {
        set phi [lindex $a 0]
        set psi [lindex $a 1]
# ##Ref.Nayar, Divya, and Charusita Chakravarty. "Free energy landscapes of alanine oligopeptides in rigid-body and hybrid water models." The Journal of Physical Chemistry B 119.34 (2015): 11106-11120.
		if { $phi >= -77.00 && $phi <= -37.00 } {
          if { $psi >= -67.00 && $psi <= -27.00 } {
			set alpha [expr $alpha +1]
}
}
	}
	set alpha_helix [expr double($alpha)/double($nn)]
	puts $outfile [format "%d %2.3f" $i $alpha_helix]
}
close $outfile
}
cd ..
mol delete all
}
puts "GREAT!! IT IS ALL-DONE"
exit
