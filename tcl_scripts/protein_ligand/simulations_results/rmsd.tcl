cd ../
set folders {1 2}
foreach x $folders {
cd $x
 ## y is nptrun
mol delete all
 ##******************
 ##Remember to change name of psf file
mol new ../protein_ligand_solvated_0M.psf
mol addfile npt1.dcd waitfor all
mol addfile npt2.dcd waitfor all
set nframes [molinfo top get numframes]
puts "*********************************"
puts "Total number of frames is ${nframes}"
puts "*********************************"


 ##Fitting the protin molecule
 ###frane01 is defined for the rmsd calculation of ligand
set frame01 [atomselect top "resname HFU" frame 0]
for {set ix 1 } {$ix < $nframes } { incr ix } {
		set selx [atomselect top "(protein and name CA) or (resname HFU)" frame $ix]
		set all [atomselect top all frame $ix]
		$all move [measure fit $selx $frame0]
	}