 ## run it by " source solvation.tcl " in tkconsole ##
 ## do remember to make the psf and filename to system_autopsf ##
 ## creating the logfile and an outfile to store box vectors ##
 ##logfile logfile.txt

 mol delete all
 puts "Enter the file name/DisprotID **do not include extension"
 set filex [gets stdin]
 #set filex DP01186
 set outfile [open "box_size${filex}.txt" w ]
 #puts "Enter Salt Concentration"
 #set salt [gets stdin]
 set salt 0
 ## solvating the file ##
 mol new ${filex}_alphafold_autopsf.psf
 mol addfile ${filex}_alphafold_autopsf.pdb
 set A [atomselect top all]
 #set minus_com [vecsub {0.0 0.0 0.0} [measure center $A]]
 #$A moveby $minus_com
 $A writepsf zerofile.psf
 $A writepdb zerofile.pdb
 mol delete all
 package require solvate
 solvate zerofile.psf zerofile.pdb -t 15 -o with_water
 ##use -t 15 for padding and -minmax {{0 0 0} {80 80 80}}
 mol delete all
 ## adding ions to neutralize the system ##
 package require autoionize
 if {$salt==0} {
 autoionize -psf with_water.psf -pdb with_water.pdb -cation SOD -anion CLA -seg ION -o ionize -neutralize
 } else {
 autoionize -psf with_water.psf -pdb with_water.pdb -sc ${salt} -cation SOD -anion CLA -seg ION -o ionize
 }
 # either use -> -sc ${salt} or -neutralize
 mol delete all
 ## setting up the box ##
 mol new ionize.psf
 mol addfile ionize.pdb
 set sel1 [atomselect top all]
 #$sel1 moveby {40 40 40}
 #pbc set {80 80 80} -all -molid top
 ##****Change below according to salt concentration (4places)**#
 $sel1 writepdb ${filex}_solvated_${salt}Mx.pdb
 $sel1 writepsf ${filex}_solvated_${salt}Mx.psf
 mol delete all
 ## moving box to zero center ##
 mol new ${filex}_solvated_${salt}Mx.psf
 mol addfile ${filex}_solvated_${salt}Mx.pdb
 set sel2x [atomselect top all]
 set minmaxx [measure minmax $sel2x]
 set vecx [vecsub [lindex $minmaxx 1] [lindex $minmaxx 0]]
 puts "CHECK"
 puts "cellBasisVector1 [lindex $vecx 0] 0 0"
 puts "cellBasisVector2 0 [lindex $vecx 1] 0"
 puts "cellBasisVector3 0 0 [lindex $vecx 2]"
 set centerx [measure center $sel2x]
 puts "cellOrigin $centerx"
 puts "##################"
 set minmaxx [measure minmax $sel2x]
 set index1 [lindex $minmaxx 0]
 set movex [lindex $index1 0]
 set movey [lindex $index1 1]
 set movez [lindex $index1 2]
 set move_coord [concat [expr -1*$movex] [expr -1*$movey] [expr -1*$movez]]
 #set a [expr -1*[lindex $centerx 0]]
 #set b [expr -1*[lindex $centerx 1]]
 #set c [expr -1*[lindex $centerx 2]]
 #set movex1 [concat $a 0 0]
# set movey1 [concat 0 $b 0]
 #set movez1 [concat 0 0 $c]
 #$sel2x moveby $movex1
 #$sel2x moveby $movey1
 #$sel2x moveby $movez1
 $sel2x moveby $move_coord
 $sel2x writepdb ${filex}_solvated_${salt}M.pdb
 $sel2x writepsf ${filex}_solvated_${salt}M.psf
 mol delete all
 ########
 ## Display of box vector parameters ##
 mol new ${filex}_solvated_${salt}M.psf
 mol addfile ${filex}_solvated_${salt}M.pdb
 set sel2 [atomselect top all]
 set minmax [measure minmax $sel2]
 set vec [vecsub [lindex $minmax 1] [lindex $minmax 0]]
 puts "cellBasisVector1 [lindex $vec 0] 0 0"
 puts "cellBasisVector2 0 [lindex $vec 1] 0"
 puts "cellBasisVector3 0 0 [lindex $vec 2]"
 set center [measure center $sel2]
 puts "cellOrigin $center"
 puts " Total Charge on System: [eval vecadd [$sel2 get charge]]"
 ##### The below part is written to copy the box vectors in the box_size.txt file ######
 set x [lindex $vec 0]
 set y [lindex $vec 1]
 set z [lindex $vec 2]
 set xcenter [lindex $center 0]
 set ycenter [lindex $center 1]
 set zcenter [lindex $center 2]
 puts $outfile [format "cellBasisVector1 %2.2f 0 0 "  $x ]
 puts $outfile [format "cellBasisVector2 0 %2.2f 0 "  $y ]
 puts $outfile [format "cellBasisVector3 0 0 %2.2f "  $z ]
 puts $outfile [format "cellorigin %2.2f %2.2f %2.2f\n\n ######compiled by Nitin Kumar Singh ###### \n ######report bugs at singh_nitin@iitgn.ac.in######"  $xcenter $ycenter $zcenter ]
 set x1 [expr $xcenter]
 set y1 [expr $ycenter]
 set z1 [expr $zcenter]
 set listy [concat $x1 $y1 $z1]
 set listx [concat $x $y $z]
 set listn1 [list $listx]
 #$sel2 moveby $listy}
 pbc set $listn1 -all -molid top
 ## deleting unnecessary files ##
 file delete ${filex}_solvated_${salt}Mx.pdb
 file delete ${filex}_solvated_${salt}Mx.psf
 file delete with_water.pdb
 file delete with_water.psf
 file delete with_water.log
 file delete ionize.pdb
 file delete ionize.psf
 file delete zerofile.psf
 file delete zerofile.pdb
 close $outfile
 pbc box -color red -style tubes -width 1
 unset minmax minmaxx
 puts "Compiled by NITIN KUMAR SINGH"
 puts "report bugs at singh_nitin@iitgn.ac.in"
