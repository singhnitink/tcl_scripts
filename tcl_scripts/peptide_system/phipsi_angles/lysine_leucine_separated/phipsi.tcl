cd  ../../
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
set sel1 [atomselect top "resname LYS"]
set sel2 [atomselect top "resname LEU"]
set a [$sel1 num]
set b [$sel2 num]
puts "Total atoms in Lys: $a"
puts "Total atoms in Leu: $b"
set nframes [molinfo top get numframes]
puts "*********************************"
puts "Total frames for folder ${x} npt ${y} is ${nframes}"
puts "*********************************"
set nn1 [llength [$sel1 get {phi psi}]]
set nn2 [llength [$sel2 get {phi psi}]]
set totdih1 [expr $nn1*$nframes]
set totdih2 [expr $nn2*$nframes]
set totdih [expr $totdih1+$totdih2]
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
 ##Doing calculation for Lysine helix
set outfile1 [open "../phipsi_angles/lysine_leucine_separated/lysine_${x}_${ts1}_${ts2}.dat" w]
for {set i 0} {$i < $nframes} {incr i} {
	$sel1 frame $i
    $sel1 update
	set alpha 0
    foreach a [$sel1 get {phi psi}] {
        set phi [lindex $a 0]
        set psi [lindex $a 1]
# ##Ref.Nayar, Divya, and Charusita Chakravarty. "Free energy landscapes of alanine oligopeptides in rigid-body and hybrid water models." The Journal of Physical Chemistry B 119.34 (2015): 11106-11120.
		if { $phi >= -77.00 && $phi <= -37.00 } {
          if { $psi >= -67.00 && $psi <= -27.00 } {
			set alpha [expr $alpha +1]
}
}
	}
	set alpha_helix [expr double($alpha)/double($nn1)]
	puts $outfile1 [format "%d %2.3f" $i $alpha_helix]
}
close $outfile1
 ##Doing calculation for Leucine helix
set outfile2 [open "../phipsi_angles/lysine_leucine_separated/leucine_${x}_${ts1}_${ts2}.dat" w]
for {set i 0} {$i < $nframes} {incr i} {
	$sel2 frame $i
    $sel2 update
	set alpha 0
    foreach b [$sel2 get {phi psi}] {
        set phi [lindex $b 0]
        set psi [lindex $b 1]
# ##Ref.Nayar, Divya, and Charusita Chakravarty. "Free energy landscapes of alanine oligopeptides in rigid-body and hybrid water models." The Journal of Physical Chemistry B 119.34 (2015): 11106-11120.
		if { $phi >= -77.00 && $phi <= -37.00 } {
          if { $psi >= -67.00 && $psi <= -27.00 } {
			set alpha [expr $alpha +1]
}
}
	}
	set alpha_helix [expr double($alpha)/double($nn2)]
	puts $outfile2 [format "%d %2.3f" $i $alpha_helix]
}
close $outfile2
}
cd ..
mol delete all
}
puts "GREAT!! IT IS ALL-DONE"
