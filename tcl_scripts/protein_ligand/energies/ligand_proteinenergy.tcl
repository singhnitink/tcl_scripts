###This script is used to calculate the protein eergies only
###Removed the water and ions from the trajectory file
mol delete all
mol new ../protein_ligand_solvated_0M.psf
mol addfile ../2/npt1.dcd step 5 waitfor all
mol addfile ../2/npt2.dcd waitfor all
#mol addfile ../1/npt3.dcd waitfor all
set sel1 [atomselect top "protein"]
set sel2 [atomselect top "resname LIG"]
 ##set sel2 [atomselect top " ATOM SELECTION 2 "]
##exec = namd2
set prmx "../lig.prm"
set prmy "par_all36_cgenff.prm"
set prm "/home/singh_nitin/Documents/charmm_topology/par_all36_prot.prm"
set prm1 "/home/singh_nitin/Documents/charmm_topology/toppar_water_ions_namd.str"
set prm2 "/home/singh_nitin/Documents/charmm_topology/par_all36_lipid.prm"
set prm3 "/home/singh_nitin/Documents/charmm_topology/par_all36_carb.prm"
set prm4 "/home/singh_nitin/Documents/charmm_topology/par_all36_cgenff.prm"
set prm5 "/home/singh_nitin/Documents/charmm_topology/par_all36_na.prm"
set tempfile "temp.log"
set outfile "protein_ligandenergy.dat"
 ###*******Important Command********************########
package require namdenergy
##namdenergy -sel $sel1 $sel2 -exe $exec - par $prm -all -tempname ${tempfile} -ofile ${outfile}
namdenergy -sel $sel1 $sel2 -exe namd2 -elec -nonb -par $prmx -par $prmy -par $prm -par $prm1 -par $prm2 -par $prm3 -par $prm4 -par $prm5 -tempname ${tempfile} -ofile ${outfile}
mol delete all
puts "GREAT!! IT IS ALL-DONE"
exit
